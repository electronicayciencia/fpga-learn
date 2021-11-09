#!/usr/bin/perl
#
use strict;
use warnings;

my $visible_screen_rows = 17;
my $visible_screen_cols = 30;

my $ram_row_lines = 5; # 5 bits address line
my $ram_col_lines = 5; # 5 bits

my $fill_char_on_scr = '.';
my $fill_char_outside = '-';

my $default_attr = 0x07;

my $address_depth = 2**$ram_col_lines * 2**$ram_row_lines;
my @ram_content = ();



for(my $row = 0; $row < 2**$ram_row_lines; $row++) {
	for(my $col = 0; $col < 2**$ram_col_lines; $col++) {
		
		my $addr = $row * 2**$ram_col_lines + $col;

		if ($col < $visible_screen_cols and $row < $visible_screen_rows) {
			print(STDERR $fill_char_on_scr);
			$ram_content[$addr] = ($default_attr << 8) + ord($fill_char_on_scr);
		}
		else {
			print(STDERR $fill_char_outside);
			$ram_content[$addr] = ($default_attr << 8) + ord($fill_char_outside);
		}

	}
	print(STDERR "\n");
}

print "#File_format=Hex\n";
print "#Address_depth=$address_depth\n";
print "#Data_width=16\n";

for (my $addr = 0; $addr < $address_depth; $addr++) {
	printf("%04x\n",
		defined $ram_content[$addr] ? $ram_content[$addr] : 0);
}


