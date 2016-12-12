#!/usr/local/bin/perl

use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
my $req = HTTP::Request->new(GET => 'https://raw.githubusercontent.com/mareksr/vietnamip/master/geoblock.list');
my $res = $ua->request($req);
if ($res->is_success) {
 @answer = split('\n', $res->as_string);
}
else {
  print "Failed: ", $res->status_line, "\n";
}

foreach (@answer){
        if($_ eq ""){
                $k=1;
                next;
        }
        push(@countries,$_) if($k==1);
}


#tworzymy mapowanie skrot panstwa na ilosc ip
open F, "countries.txt";
while (<F>){
        ($a,$b,$c)=split;
        $panstwa{$a}=$c;

}
close F;

open F, "l.txt";

while(<F>){
        ($a,$b,$c,$d)=split;
        if($a>=$panstwa{$c}){
                next if(&check($c,@countries));
                print "$b #$c\n";
        }

}
close F;


sub check(){
        my ($country,@countries)= @_;
        $tick=0;
        foreach (@countries){
                 if($_ eq $country){
                        $tick=1;
                        next;
                }
        }
        return $tick;
}


