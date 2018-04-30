use utf8;
use Encode;
use strict;
use warnings;
use URI::Escape;
use Time::HiRes qw(sleep);
use LWP::Simple;
use LWP::UserAgent;
use Mozilla::CA;
use Term::ANSIColor qw(:constants);
$Term::ANSIColor::AUTORESET = 1;
use Term::ANSIColor 2.00 qw(:pushpop);

open(F, "name_list.txt");
open(W, "> suggest.txt");

my $suggest;

while(my $keyword = <F>){
	chomp($keyword);
	$keyword = $keyword." ";
	my $URL = "https://goodkeyword.net/search.php?type=&formquery=".$keyword."&x=0&y=0\n";
	#print $URL;
	my $html = get($URL);
	#print $html;
	print "\n";
	if($html =~ '                        <textarea onclick="this.select\(\)">'){
		my @n1 = split(/                        <textarea onclick="this.select\(\)">\n/,$html,2);
		my $n2 = $n1[1];
		my @n3 = split(/<\/textarea>/,$n2,2);
		$suggest = $n3[0];
		#$suggest =~ s/\n/,/g;	
		print encode('utf-8',$suggest);
		print W encode('utf-8',$suggest)."\n\n";
	}else{
		print "ERROR\n";
	}
	print "\n";
	sleep(1);

}



close(F);
close(W);
