package Amazon::MWS::XML::Response::FeedSubmissionResult;

use strict;
use warnings;
use XML::LibXML::Simple qw/XMLin/;
use Data::Dumper;

use Moo;
use namespace::clean;

=head1 NAME

Amazon::MWS::XML::Response::FeedSubmissionResult -- response parser

=head1 SYNOPSIS

  my $res = Amazon::MWS::XML::Response::FeedSubmissionResult->new(xml => $xml);
  if ($res->is_success) { ... };

=head1 ACCESSOR

=head2 xml

The xml string

=head2 structure

Lazy attribute built via parsing the xml string passed at the constructor.

=head1 METHODS

=head2 is_success

=head2 errors

=cut

has xml => (is => 'ro', required => '1');

has structure => (is => 'lazy');

sub _build_structure {
    my $self = shift;
    my $struct = XMLin($self->xml);
    return $struct->{Message}->{ProcessingReport};
}

sub is_success {
    my $self = shift;
    my $struct = $self->structure;
    if ($struct->{StatusCode} eq 'Complete' and
        $struct->{ProcessingSummary}->{MessagesSuccessful} and
        !$struct->{ProcessingSummary}->{MessagesWithError} and
        !$struct->{ProcessingSummary}->{MessagesWithWarning}) {
        return 1;
    }
    else {
        return;
    }
}

sub errors {
    my $self = shift;
    my $struct = $self->structure;
    # this shouldn't happen, we already checked if complete or not
    if ($struct->{Result} and ref($struct->{Result}) eq 'ARRAY') {
        my @errors;
        foreach my $res (@{ $struct->{Result} }) {
            push @errors, $self->_parse_result_errors($res);
        }
        return join(' ', @errors);
    }
    elsif ($struct->{Result} and ref($struct->{Result}) eq 'HASH') {
        return $self->_parse_result_errors($struct->{Result});
    }
    else {
        # so just dump the structure
        return Dumper($struct);
    }
}

sub _parse_result_errors {
    my ($self, $res) = @_;
    my $msg = 'ERROR: ';
    if ($res->{AdditionalInfo} && $res->{AdditionalInfo}->{SKU}) {
        $msg = $res->{AdditionalInfo}->{SKU} . ' ';
    }

    if (my $code = $res->{ResultMessageCode}) {
        $msg .= "(errcode $code) ";
    }

    if (my $desc = $res->{ResultDescription}) {
        $msg .= $desc;
    }
    return $msg;
}

1;