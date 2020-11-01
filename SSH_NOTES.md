#### ~cakewalker/.ssh/authorized_keys
```
no-X11-forwarding,no-agent-forwarding,command="cakewalk new-tunnel" ssh-rsa <KEY-COMMON>

no-X11-forwarding,no-agent-forwarding,command="echo 'Cakewalk Tunnel Open on 28001!'",permitopen="localhost:28001" ssh-rsa <KEY-1>
no-X11-forwarding,no-agent-forwarding,command="echo 'Cakewalk Tunnel Open on 28002!'",permitopen="localhost:28002" ssh-rsa <KEY-2>
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
   ForceCommand echo 'Invalid Cakewalk Usage'
```

#### Registering new key tunnel
```
$ ssh-keygen -f ~/.cakewalk/keys/tunnel1

$ ssh cakewalker@cakewalk.example.org -i ~/.cakewalk/keys/user < ~/.cakewalk/keys/tunnel1.pub
```


#### Opening tunnel (Tunnel 1)
```
$ ssh cakewalker@cakewalk.example.org -i ~/.cakewalk/keys/tunnel1 -N -R 28001:localhost:3000
```
