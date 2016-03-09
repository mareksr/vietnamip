#!/usr/local/bin/perl


#skrypt usuwa IP ktore sa przypisane do domen z whitelisty

open F, "domains.txt";
@bdomains=<F>;
close F;

open FILE, "/usr/local/assp/files/whitedomains.txt";

my @wd;

#oczysc liste ze standardowych domen hurtowych
while(<FILE>){
	/.*@(.*)/;

next if ( grep( /^$1$/, @bdomains ) ) ;
	push(@wd,$1) if ($1 ne "");
}
close FILE;

# w wd mamy juz tylko wazne white domeny

# jezeli ip jest na white to go usun z blacklisty

open FILE, "/tmp/miki.txt";

while(<FILE>){
	foreach $domain (@wd){
		if (/\@$domain/) {
 			($ip) = split;
			 print "$ip\n"; 
			 last; 
		}
	}	
}

close FILE;

