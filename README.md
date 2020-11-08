# Cakeway

Simple TCP tunneling using SSH

## MVP
Initial prototype version is simply some shell scripts that together create a way to dynamically allocate ports for allowing a server to be hosted behind a NATed connection.
This is in no way suitable for production use, use at your own risk.

### Setup
On your publicly accessable server, checkout repo and run:
```
sudo make install
```
In your SSH configuration (often `/etc/ssh/sshd_config`), enable `PermitUserEnvironment`:
```conf
PermitUserEnvironment yes
```


### Usage
Set up tunnel using `cakewalk new`:
```
$ ./cakewalk new example-server-1
Creating new cakeway tunnel example-server-1
Generating key... OK

Connecting to cakeway daemon... OK

Retrieving tunnel configuration...
Version: Cakewalker v0.1.1
Tunnel: cakewalker@example-server-1
Port: 28001

Done! Use "./cakewalk connect example-server-1 <LOCAL PORT>" to connect!
```

Connect tunnel using `cakewalk connect`:
```
$ ./cakewalk connect example-server-1 3000
Connecting cakeway tunnel example-server-1 to local port 3000...
Use Ctrl-C to exit
```

