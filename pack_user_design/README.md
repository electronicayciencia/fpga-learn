# Descifrar *protected IP data*

Archivo `and_gate.v` empaquetado usando la opción *Pack User Design* en la pestaña *Hierarchy*.

Los datos se cifran usando la clave pública del vendor a quien le licenciamos el módulo para que él la pueda descifrar con su privada.

*Envelope encryption*: Datos cifrados con una clave de sesión aleatoria y esta con la clave RSA.

## Empaquetado

Empaquetamos un proyecto muy sencillo, *and_gate*:

```verilog
module and_gate (
    input a, b,
    output o
);

assign o = a & b;

endmodule
```

Dos ficheros:

- `and_gate_gowin.vp` protegido, para distribuirlo e insertarlo en los diseños
- `and_gate_sim.v` en claro, para simulación

## Clave privada

Buscarla en:

```console
$ grep encryptP1735 *
Binary file gwsyn.dll matches
```

Copiar clave privada a `private.pem`.

## Descifrar clave de sesión

### Keyblock

Separar a un fichero el keyblock cifrado con la clave `key_keyname="GoWin001"`.

    `pragma protect encoding=(enctype="base64", line_length=76, bytes=256)
    `pragma protect key_keyowner="GoWin",key_keyname="GoWin001",key_method="rsa"
    `pragma protect key_block
    tQMwMVRBKDRrs3aXCUTuRwPNVwzoJ6XBD6W0HJ6XGMnX0Z8OWAFVnK10WTTgjCqP2VftkxMY8bv6
    Ip/42OC1Y1eUim3kC3WtWpczyFF6VRxHa6giP4pZaV3s10HgQxtB52snm5VWgS6kEOwaTsnjYIu6
    mhv6+4CmcPDW9JuZP2InbaOPCT1+7A5ZAPLxcA1jQ4dzVjcGKscLsiZUlV/g2KBUFcxTprQTGBaG
    HMaj7ENjKZME+NZwoR0bQkfUV6mZL8gxrUaIlkJeSKWTCzsJQOuW559dCmHMEGM+jSN6cujxaSQa
    bZLi4e0qMytuBhlSb8+nTNb93Y8dKhASBLIKbQ==

Pasarlo a binario:

    $ base64 -d < keyblock.b64 > keyblock.bin

Tamaño 256 porque está cifrado con una clave RSA de 2048 bits.

### Descifrado

Se descifra usando la clave privada. Y lo pasamos a hex:

```console
$ openssl rsautl -decrypt -in keyblock.bin -inkey private.pem | hd | cut -c 9-59 | tr -d ' '
f54b99318ff27d32c3f0fd8a7ad575f0
```


    Key: f54b99318ff27d32c3f0fd8a7ad575f0

El algoritmo de cifrado es aes-128 por tanto la clave son 128 bits (16 bytes).

## Descifrar datos

### Datablock


    `pragma protect encoding=(enctype="base64", line_length=76, bytes=336)
    `pragma protect data_keyowner="default-ip-vendor"
    `pragma protect data_keyname="default-ip-key"
    `pragma protect data_method="aes128-cbc"
    `pragma protect data_block
    8FPDWssID3LSSZNWFe+P1/dXNzu+Dt9nJVV8MOPa1JhGHmL7x3UszS84WP9/k0jqxIFGn4pGzSxJ
    dqMnMdkZ+CiXRQtKq7DlGPEMoc2Jwf8lKCWuTHQd6Ks0wQ0dWCKYgZ++ODz88YL8rUAAE2T7gKO7
    WefkI+H553XfRQ7jbpgLXqfUvsCT2X2jTDMj5ihiB3hM3guKfofkX75tOqDmIMB7gvRc1i3zsp05
    snXPhm5aSrrWBIZAd+zwZOX3mpL+HkzSUWFLT54hG83eY9m5Y+wGux1jIKtmF7U4ToalQBgUq7IH
    EOugCHZk31NCUC+ou0zemLcErmEHfQ/rFqROhgUBtNZivaFCQT1Zea1Vd1CTQYsMMKQJjI9jciCU
    2PIUMRaYnfkfYxNgdQU0WLiN9wsDMGlBsdX2+5lviqE3s6VvWHHF6lUEUcc/3r9gODrt
    `pragma protect end_protected

Extraer el datablock en base64:

    $ cat and_gate_gowin.vp | grep data_block -A 9999 | grep -v '^`pragma' > datablock.b64

Pasarlo a binario (hay que quitar los \r si es formato windows):

    $ base64 -id < datablock.b64 > datablock.bin

Tamaño de `datablock.bin` 336.


### Initialization Vector

IV = Primeros bytes del datablock. AES tiene tamaño de bloque 128. IV son 16 bytes.

Separar IV de los datos. Los primeros 16 bytes son el IV.

```console
$ head -c 16 datablock.bin | hd | cut -c 9-59 | tr -d ' '
f053c35acb080f72d249935615ef8fd7
```


    IV: f053c35acb080f72d249935615ef8fd7

### Descifrar datos

El resto del 17 en adelante son datos:

    $ tail -c+17 datablock.bin > cipherdata.bin

Desencriptar:

    $ openssl enc -d -aes-128-cbc -in cipherdata.bin -iv f053c35acb080f72d249935615ef8fd7 -K f54b99318ff27d32c3f0fd8a7ad575f0

El fichero descifrado sería este:

```verilog
`timescale 100 ps/100 ps
module and_gate (
  a,
  b,
  o
)
;
input a;
input b;
output o;
wire VCC;
wire GND;
  LUT2 o_d_s (
    .F(o),
    .I0(a),
    .I1(b) 
);
defparam o_d_s.INIT=4'h8;
  VCC VCC_cZ (
    .V(VCC)
);
  GND GND_cZ (
    .G(GND)
);
  GSR GSR (
    .GSRI(VCC) 
);
endmodule /* and_gate */
```
