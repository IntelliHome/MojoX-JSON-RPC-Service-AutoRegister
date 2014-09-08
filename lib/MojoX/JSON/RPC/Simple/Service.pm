package MojoX::JSON::RPC::Simple::Service;
use Mojo::Base 'MojoX::JSON::RPC::Service';

=head1 NAME

MojoX::JSON::RPC::Simple::Service - Base class for RPC Services

=head1 DESCRIPTION

This object represent a base class for RPC Services.
It only ovverides the C<new> to inject C<'with_mojo_tx'=1> option by default.
For more information on how services work, have a look at
L<MojoX::JSON::RPC::Service>.

Every function that starts with C<rpc_> it's automatically registered as an
rpc service, this means that on your service file you must only add git remote
add origin https://github.com/IntelliHome/MojoX-JSON-RPC-Simple.git
C<__PACKAGE__->register_rpc;> at the bottom of the code.

=head1 SEE ALSO

L<MojoX::JSON::RPC::Simple>, L<MojoX::JSON::RPC::Service>

=cut

sub new {
    my ( $self, @params ) = @_;

    $self = $self->SUPER::new(@params);

    foreach my $method ( keys %{ $self->{'_rpcs'} } ) {
        $self->{'_rpcs'}->{$method}->{'with_mojo_tx'} = 1;
        $self->{'_rpcs'}->{$method}->{'with_svc_obj'} = 1;
        $self->{'_rpcs'}->{$method}->{'with_self'}    = 1;
    }

    return $self;
}

sub register_rpc {
    my $caller_package_name = caller;

    MojoX::JSON::RPC::Simple::Service->register_rpc_regex(
            qr/^ rpc _ /x,
            $caller_package_name,
        );
}

sub register_rpc_suffix {
    my ( undef, $suffix ) = @_;

    my $caller_package_name = caller;

    MojoX::JSON::RPC::Simple::Service->register_rpc_regex(
            qr/^ $suffix _ /x,
            $caller_package_name,
        );
}

sub register_rpc_regex {
    my ( undef, $regex, $package ) = @_;
    $package = caller if (! defined($package) );

    my @methods = ();
    my $symbols = {
        eval( '%' . $package . '::' )
    };

    foreach my $entry ( keys %{ $symbols } ) {
        # this allows functions that match the regex to be automatically
        # exported as rpc public services
        if ( defined($package->can($entry)) && ($entry =~ $regex) ) {
            push( @methods, $entry );
        }
    }

    $package->register_rpc_method_names(@methods);
}

1;
