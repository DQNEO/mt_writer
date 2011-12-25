#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use FindBin;
use lib $FindBin::Bin;
use MovableType;

print "Content-type: text/html; charset=utf-8\n\n";

my $config = {
    url => 'http://example.com/mt/mt-xmlrpc.cgi',
    blog_id => 5,
    user => 'userhoge',
    pass  => 'password',
    publish => 1,         # 0:再構築しない, 1:再構築する
    };

my $q = CGI->new;
my $file = $q->param('file') ? $q->param('file') : 'test.txt';

my $mt = MovableType->new($config);
my $new_id = $mt->post_from_file($file) or die "failed $!";

print "entry_id:$new_id\n";

