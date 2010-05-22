package Net::Wigle;

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
our $url_query_base = 'http://www.wigle.net/gps/gps/GPSDB/confirmquery';

sub new {
  my $proto = shift;
  my $class = ref $proto || $proto;
  my $self = {};
  bless $self, $class;
  return $self;
}

# purpose  : returns a parsed/scraped version of query_raw

sub query {
  my $self = shift;
  my %args = @_;
  my $response = $self->query_raw(%args); 
}

# purpose  : query wigle, trying to keep this simple
# usage    : args are optional, just provided for informational purposes
# comments : returns an HTTP::Response

sub query_raw {
  my $self = shift;
  my %args = @_;
  #my %args = validate @_, {
  #  latrange1 => 0,
  #  latrange2 => 0,
  #  longrange1 => 0,
  #  longrange2 => 0,
  #  addresscode => 0,
  #  statecode => 0,
  #  zipcode => 0,
  #  variance => 0,
  #  pagestart => 0,
  #  lastupdt => 0,
  #  netid => 0,
  #  ssid => 0,
  #  freenet => 0,
  #  paynet => 0,
  #  dhcp => 0,
  #  onlymine => 0,
  #}; 
  #my $string_query = '?' . join '&', map { "$_=$args{$_}" } keys %args;
  return $self->post($url_query_base, %args);
}

1;
__END__

=head1 NAME 

Net::Wigle - Perl extension for querying wigle.net 

=head1 SYNOPSIS

  use Net::Wigle;
  my $wigle = Net::Wigle->new; 

=head1 DESCRIPTION

For your health.

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
