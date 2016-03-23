#!/usr/local/bin/perl


#skrypt usuwa IP ktore sa przypisane do domen z whitelisty
$DIR='/opt/megaspam/vietnamip';

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
$lines++ while (<FILE>);
close FILE;

open WFILE, ">$DIR/whitelist";
open FILE, "/tmp/miki.txt";
$l=0;
while(<FILE>){
	$l++;
	printf ("%.2f %% %c", ($l / $lines)*100,13);			
	foreach $domain (@wd){
		if (/\@$domain/) {
 			($ip) = split;
			 print WFILE "$ip\n"; 
			 last; 
		}
	}	
}

close FILE;
close WFILE;

