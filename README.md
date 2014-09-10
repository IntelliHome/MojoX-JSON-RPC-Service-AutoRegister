[![Build Status](https://travis-ci.org/IntelliHome/MojoX-JSON-RPC-Simple.png?branch=master)](https://travis-ci.org/IntelliHome/MojoX-JSON-RPC-Simple)
# NAME

MojoX::JSON::RPC::Service::AutoRegister - Base class for RPC Services

# DESCRIPTION

This object represent a base class for RPC Services.
It only ovverides the `new` to inject `'with_mojo_tx'=1`, `'with_svc_obj'=1` and `'with_self'=1`  options by default.
For more information on how services work, have a look at
[MojoX::JSON::RPC::Service](https://metacpan.org/pod/MojoX::JSON::RPC::Service).

Every function that starts with `rpc_` it's automatically registered as an
rpc service, this means that on your service file you must only add
`__PACKAGE__-`register\_rpc;> at the bottom of the code.
You can also defines your suffix or your regex to match the functions to being automatically registered.

# METHODS

Inherits all methods from [MojoX::JSON::RPC::Service](https://metacpan.org/pod/MojoX::JSON::RPC::Service) and adds the following new ones:

## register\_rpc

## register\_rpc\_suffix

## register\_rpc\_regex

# AUTHOR

mudler <mudler@dark-lab.net>, vytas <vytas@cpan.org>

# COPYRIGHT

Copyright 2014- mudler, vytas

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

# SEE ALSO

[MojoX::JSON::RPC::Service](https://metacpan.org/pod/MojoX::JSON::RPC::Service)
