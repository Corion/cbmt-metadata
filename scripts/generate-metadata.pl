#!/bin/perl
use 5.020;
use JSON::Tiny 'encode_json';

our %bank = (
    1 => 'UniCredit',
    2 => 'DZ BANK',
    3 => '???',
    4 => '???',
    5 => '???',
    6 => 'Commerzbank'
);

our @currencies = (
    [978, 'EUR'],
    [840, 'USD'],
);

for my $curr (@currencies) {
    for my $bank_id (sort keys %bank) {
        my $token_id = $bank_id * 1000 + $curr->[0];
        my $token_name = "$curr->[1] ($bank{ $bank_id })";
        my $filename = sprintf 'metadata/%04x.json', $token_id;

        open my $fh, '>:encoding(UTF-8)', $filename
            or die "Couldn't create '$filename': $!";
        print $fh encode_json(
            {
              "title" => "$token_name",
              "type" => "object",
              "properties" => {
                decimalPlaces => 2,
                "name" => "$token_name",
                "description" => "CBMT issued by $bank{ $bank_id }",
                #"image" => "https://image-uri/rareskills-car1.png",
                #"year" => 2024,
              }
            }
        );
    }
}
