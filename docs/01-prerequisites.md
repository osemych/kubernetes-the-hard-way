# Prerequisites

## Hardware Requirements
8 GB of RAM (Preferebly 16 GB) 50 GB Disk space

## Virtual Box
[Download](https://www.virtualbox.org/wiki/Downloads) and install VirtualBox on any one of the supported platforms.

Check out VirtualBox [User Manual](https://www.virtualbox.org/manual/) if you need help installing it.

## Vagrant
Vagrant provides an easier way to deploy multiple virtual machines on VirtualBox or other providers.

[Download](https://www.vagrantup.com/downloads.html) and install Vagrant on your host machine. Check out Vagrant documentation if you need help [installing](https://www.vagrantup.com/docs/installation/) it or this is your [first time using Vagrant](https://www.vagrantup.com/intro/getting-started/index.html).

## Vagrant Plugins
This guide uses the following Vagrant plugin to ease infrastructure provision:
* [Vagrant Host Manager](https://github.com/devopsgroup-io/vagrant-hostmanager)

See the Vagrant documentation on [Plugins Usage](https://www.vagrantup.com/docs/plugins/usage.html).

## Running Commands in Parallel with tmux

[tmux](https://github.com/tmux/tmux/wiki) can be used to run commands on multiple compute instances at the same time. Labs in this tutorial may require running the same commands across multiple compute instances, in those cases consider using tmux and splitting a window into multiple panes with synchronize-panes enabled to speed up the provisioning process.

> The use of tmux is optional and not required to complete this tutorial.

![tmux screenshot](images/tmux-screenshot.png)

> Enable synchronize-panes by pressing `ctrl+b` followed by `shift+:`. Next type `set synchronize-panes on` at the prompt. To disable synchronization: `set synchronize-panes off`.

Next: [Installing the Client Tools](02-client-tools.md)
