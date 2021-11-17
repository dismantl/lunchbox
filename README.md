# Lunchbox

Lunchbox lets you create a physical penetration testing drop box using a Raspberry Pi running Ubuntu Server 21.10. The device is meant to be plugged into a target network via ethernet (preferrably with power-over-ethernet). It will then provide SSH and OpenVPN remote access via [Pagekite](https://pagekite.net) tunneling, and a hidden-SSID access point for local wireless access.

## Installation

First, replace `roles/base/files/lunchbox.pub` with your own SSH public key, ideally not the same one you use for normal daily work. Next, copy `host_vars/lunchbox.yml.example` to `host_vars/lunchbox.yml` and fill in the variables with your chosen passphrases:

```yaml
pagekite_username: myname
pagekite_secret: supersecret
loot_size_mbs: 8192  # 8GB
loot_passphrase: correct horse battery staple
ap_password: correct horse battery staple
vpn_domain: "vpn.{{ pagekite_username }}.pagekite.me"
```

Finally, update the local IP address of the Raspberry Pi in the `hosts` file and then run the Ansible installation playbook:

```
$ ./setup.sh
```

Individual sections of the `setup.yml` playbook can be run on their own by specifying the tag name:

```
$ ./setup.sh --tags pagekite
```

To create a OpenVPN client, you'll need to specify the `vpn_client_name` variable:

```
$ ./setup.sh --tags vpn --extra-vars "vpn_client_name=admin"
```