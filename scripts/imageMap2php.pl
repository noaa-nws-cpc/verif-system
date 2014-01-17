#!/usr/bin/perl

$numArgs = $#ARGV+1;
if ($numArgs < 2) {
	print "Usage: imageMap2php.pl imageMapFile phpFile\n";
	exit;
}
$imageMapFile = $ARGV[0];
$phpFile      = $ARGV[1];

$command = qq{sed -e "s/<area shape='poly' /array(/" -e "s/ id='/, id=>'/" -e "s/ coords='/, coords=>'/" -e "s/(name='/(name=>'/" -e "s/\\/>/),/"};
system "$command $imageMapFile >$phpFile";
