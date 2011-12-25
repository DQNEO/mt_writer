#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use CGI::Carp;
use File::Slurp;
use Encode;
use FindBin;
use lib $FindBin::Bin;
use MovableType;

print "Content-type: text/html; charset=utf8\n\n";

my $q = CGI->new;
my $mt = MovableType->new;

my $file = $q->param('file') ? $q->param('file') : 'contents.txt';
my ($title, $body) = $mt->parse_content_file($file);

my $tplFile = 'entry.tpl';
my $tpl = decode('utf8',read_file($FindBin::Bin . '/' . $tplFile));

$tpl =~ s/{{\$title}}/$title/;
$tpl =~ s/{{\$body}}/$body/;
$tpl =~ s/{{\$file}}/$file/;

print encode('utf8', $tpl);
exit;
