package Net::Wigle;

use Data::Dumper;
use LWP::UserAgent;
use Params::Validate qw(:all);
use 5.010000;
use strict;
use warnings;

require Exporter;

our @ISA = qw(
  Exporter
  LWP::UserAgent
);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Net::Wigle ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
);

our $VERSION = '0.01';
our $url_query_base = 'http://www.wigle.net/gps/gps/main/confirmquery/';

sub new {
  my $proto = shift;
  my $class = ref $proto || $proto;
  my $self = {};
  bless $self, $class;
  return $self;
}

# purpose  : login to wigle.net

sub log_in {
  my $self = shift;
  my %args = validate @_, {
    user => { type => SCALAR, },
    pass => { type => SCALAR, },
  };
  my $url_login = "http://wigle.net/gps/gps/main/login";
  unless ($self->cookie_jar) {
    $self->cookie_jar({});
  }
  my $form = {
    credential_0 => $args{user},
    credential_1 => $args{pass},
    noexpire => 'checked',
  };
  my $response = $self->post($url_login, $form);
  unless ($response->is_success) {
    return undef;
  }
  return $self->cookie_jar;
}

# purpose  : returns a parsed/scraped version of query_raw

sub query {
  my $self = shift;
  #my %args = validate @_, {
  #}; 

  my %args = validate @_, {
    user => {
      type => SCALAR,
    },
    pass => {
      type => SCALAR,
    },
    variance => {
      default => '0.010',
      optional => 1,
    },
    latrange1 => {
      optional => 1,
    },
    latrange2 => {
      optional => 1,
    },
    longrange1 => {
      optional => 1,
    },
    longrange2 => {
      optional => 1,
    },
    addresscode => {
      optional => 1,
    },
    statecode => {
      optional => 1,
    },
    zipcode => {
      optional => 1,
    },
    pagestart => {
      optional => 1,
    },
    lastupdt => {
      optional => 1,
    },
    netid => {
      optional => 1,
    },
    ssid => {
      optional => 1,
    },
    freenet => {
      optional => 1,
    },
    paynet => {
		  optional => 1,
    },
    dhcp => {
		  optional => 1,
    },
    onlymine => {
		  optional => 1,
    },
  };
  my $cookie_jar = $self->log_in(
    user => $args{user},
    pass => $args{pass},
  ); 
  unless ($cookie_jar) {
    return undef;
  }
  my $response = $self->query_raw(%{$args{form}}); 
  unless ($response->is_success) {
    return undef;
  }
  return $response->as_string;
}

# purpose  : query wigle, trying to keep this simple
# usage    : args are optional, just provided for informational purposes
# comments : returns an HTTP::Response

sub query_raw {
  my $self = shift;
  my %args = @_;
  #my $string_query = '?' . join '&', map { "$_=$args{$_}" } keys %args;
  return $self->post($url_query_base, %args);
}

1;
__END__

=head1 NAME 

Net::Wigle - Perl extension for querying wigle.net 

=head1 SYNOPSIS

  use Net::Wigle;
  use Data::Dumper;
  my $wigle = Net::Wigle->new; 
  print $wigle->query(
    user => 'insertYourWigleUserNameHere',
    pass => 'insertYourWiglePasswordHere',
    ssid => 'insertAnSsidHere',
  );

=head1 DESCRIPTION

"For your health." --Steve Brule

=head2 EXPORT

None by default.

=head1 SEE ALSO

Forums at http://wigle.net

=head1 AUTHOR

Mike Allred, E<lt>mikejallred@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by Mike Allred

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
