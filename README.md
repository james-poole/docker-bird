Docker container running bird.

Designed to run as daemonset on openshift.
Will require privileged as needs to edit network configuration.

As bird configuration contains sensitive passwords probably want to avoid storing it in etcd even as a secret? Better to host mount said config?
