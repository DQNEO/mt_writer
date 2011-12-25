package MovableType;

use strict;
use warnings;
use FindBin;
use lib $FindBin::Bin;
use Class::Accessor;
use base qw(Class::Accessor);
use XMLRPC::Lite;
use RPC::XML::Client;
use Encode;
use Data::Dumper;

sub post_from_file {
    my $self = shift;
    my $file = shift;

    my ($title, $body) = $self->parse_content_file($file);

    my $entry = {
        title => $title,
        description => $body,
    };

    return $self->_post($entry);
}

sub _post {
    my $self = shift;
    my $struct = shift;

    return XMLRPC::Lite
        ->proxy($self->{url})
        ->call('metaWeblog.newPost', $self->{blog_id}, $self->{user}, $self->{pass}, $struct, $self->{publish})
        ->result;
}

sub parse_content_file {
    my  $self = shift;
    my  $file = shift;

    my $file_path = $FindBin::Bin . '/' . $file;
    open my $fh , '<:utf8' , $file_path or die "cannot open file $file_path";

    my @lines = <$fh> or die 'no data from stdin';
    my $title = shift @lines;
    chomp $title;
    shift @lines;

    my $body = join '', @lines;

    return ($title, $body);
}

# 何をどうやっても動かない。
sub _post2 {
    my $self = shift;
    my $struct = shift;
    my $client = RPC::XML::Client->new($self->{url});
    
    #$struct->{title} = encode('utf8' ,($struct->{title}));
    #$struct->{description} = encode('utf8' ,($struct->{description}));
    print Dumper $struct->{title};
    $struct->{title} =  Encode::encode("utf8", $struct->{title});
    print Dumper $struct->{title};

    #utf8::downgrade($struct->{title});
    #utf8::downgrade($struct->{description});

    print ' title is ' , utf8::is_utf8($struct->{title}) ? 'flagged' : ' no flagged', "\n";
    
    #exit;
    
    my $res = $client->send_request('metaWeblog.newPost', $self->{blog_id}, $self->{user}, $self->{pass}, $struct, $self->{publish});

    print Dumper $res;
    return $res->value;
}


1;
