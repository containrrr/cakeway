#### ~cakewalker/.ssh/authorized_keys
```
no-X11-forwarding,no-agent-forwarding,command="cakeway new-tunnel" ssh-rsa <KEY-COMMON>

no-X11-forwarding,no-agent-forwarding,command="echo 'Cakeway Tunnel Open on 28001!'",permitopen="localhost:28001" ssh-rsa <KEY-1>
no-X11-forwarding,no-agent-forwarding,command="echo 'Cakeway Tunnel Open on 28002!'",permitopen="localhost:28002" ssh-rsa <KEY-2>
# [...]
```


#### /etc/ssh/sshd_config
```
Match User cakewalker
   AllowTcpForwarding no
   X11Forwarding no
   PermitTunnel no
   GatewayPorts no
   AllowAgentForwarding no
   ForceCommand echo 'Invalid Cakeway Usage'
```

#### Registering new key tunnel
```
$ ssh-keygen -f ~/.cakeway/keys/tunnel1

$ ssh cakewalker@cakeway.example.org -i ~/.cakeway/keys/user < ~/.cakeway/keys/tunnel1.pub
```


#### Opening tunnel (Tunnel 1)
```
$ ssh cakewalker@cakeway.example.org -i ~/.cakeway/keys/tunnel1 -N -R 28001:localhost:3000
```
