package MojoX::JSON::RPC::Simple::Service;
use Mojo::Base 'MojoX::JSON::RPC::Service';

=head1 NAME

MojoX::JSON::RPC::Simple::Service - Base class for RPC Services

=head1 DESCRIPTION

This object represent a base class for RPC Services.
It only ovverides the C<new> to inject C<'with_mojo_tx'=1> option by default.
For more information on how services work, have a look at L<MojoX::JSON::RPC::Service>.
Every function that starts with C<rpc_> it's automatically registered as an rpc service, this means that on your service file you must only add git remote add origin https://github.com/IntelliHome/MojoX-JSON-RPC-Simple.gitC<__PACKAGE__->register_rpc;> at the bottom of the code.

=head1 SEE ALSO

L<MojoX::JSON::RPC::Simple>, L<MojoX::JSON::RPC::Service>

=cut

sub new {
    my $self = shift;
    $self = $self->SUPER::new(@_);
    $self->{'_rpcs'}->{$_}->{'with_mojo_tx'}  = $self->{'_rpcs'}->{$_}->{'with_svc_obj'} =$self->{'_rpcs'}->{$_}->{'with_self'} = 1
        for ( keys %{ $self->{'_rpcs'} } );
    return $self;
}

sub register_rpc {
    my $symbol = { eval( '%' . caller . "::" ) };
    local @_;
    foreach my $entry ( keys %{$symbol} ) {
        no strict 'refs';
        if ( defined &{ caller . "::$entry" } ) {
            push( @_, $entry ) if $entry =~ /^rpc\_/; # this allows method suffixed by rpc_ to be automatically exported as rpc public services
        }
    }
    use strict 'refs';
    caller->register_rpc_method_names(@_);
}

sub register_rpc_regex {
    shift;
    my $r=shift;
    my $symbol = { eval( '%' . caller . "::" ) };
    local @_;
    foreach my $entry ( keys %{$symbol} ) {
        no strict 'refs';
        if ( defined &{ caller . "::$entry" } ) {
            push( @_, $entry ) if $entry =~ $r; # this allows functions that match the regex to be automatically exported as rpc public services
        }
    }
    use strict 'refs';
    caller->register_rpc_method_names(@_);
}

1;
