#!/usr/bin/perl
#
# Combine text template and attrib template to create VRAM Memory Initialazation file.
# Electronica y ciencia 09/11/2021
#
use strict;
use warnings;

# Screen visible text
my $screen_rows = 17;
my $screen_cols = 30;

# Memory address lines (bits)
my $ram_row_bits = 5;
my $ram_col_bits = 5;

# Defaults
my $default_text = 0x00;
my $default_attr = 0x07;

# Main array
my @ram_content = ();

sub usage() {
	print("Usage: $0 <text> <attr>\n");
	exit;
}


# Open files
my $tmpl_text = $ARGV[0] or usage();
my $tmpl_attr = $ARGV[1] or usage();

open(my $text_fh, "< $tmpl_text") or die;
open(my $attr_fh, "< $tmpl_attr") or die;

my $counter = 0;

my $t;
while ($t = <$text_fh>) {
	$t =~ s/\s+$//;
	my $attr = <$attr_fh> || "";
	
	my $l = length($t);
	
	for (my $i = 0; $i < 2**$ram_col_bits; $i++) {
		if ($i < $l) {
			
			# CHARACTER
			my $numchar = ord(substr($t, $i, 1));
			# Replace template characters
			# @ => incremental 1 to 128
			if ($numchar == ord('@')) {
				$numchar = $counter++;
			}
			# ~ => 0x01
			elsif ($numchar == ord('~')) {
				$numchar = 0x01;
			}
			
			# ATTRIBUTE
			my $attrnum = $default_attr;
			my $attrchr = ord(substr($attr, $i, 1)) || $default_attr;
			# Foreground color is simple 0~F
			if ($attrchr >= ord('0') and $attrchr <= ord('9')) {
				$attrnum = $attrchr - ord('0');
			}
			elsif ($attrchr >= ord('A') and $attrchr <= ord('F')) {
				$attrnum = $attrchr - ord('A') + 10;
			}
			# G
			elsif ($attrchr == ord('G')) {
				$attrnum = 11;
			}# H
			elsif ($attrchr == ord('H')) {
				$attrnum = 10;
			}
			# Space is default attr
			elsif ($attrchr == ord(' ')) {
				$attrnum = $default_attr;
			}
			else {
				printf(STDERR "Unkown attribute character: %c\n", $attrchr);
				$attrnum = $default_attr;
			}
				
			push @ram_content, $attrnum * 256 + $numchar;
		}
		
		# All default
		else {
			push @ram_content, $default_attr * 256 + $default_text;
		}
	}
}

close $text_fh;
close $attr_fh;




my $address_depth = 2**$ram_row_bits * 2**$ram_col_bits;

print "#File_format=Hex\n";
print "#Address_depth=$address_depth\n";
print "#Data_width=16\n";

for (my $addr = 0; $addr < $address_depth; $addr++) {
	printf("%04x\n",
		defined $ram_content[$addr] ? $ram_content[$addr] : 0);
}


