# Provisioning Compute Resources

Kubernetes requires a set of machines to host the Kubernetes control plane and the worker nodes where containers are ultimately run. In this lab you will provision the compute resources required for running a secure and highly available Kubernetes cluster using Vagrant.

> Ensure you have Vagrant and VirtualBox installed as described in the [Prerequisites](01-prerequisites.md) lab.

## Networking

The Kubernetes [networking model](https://kubernetes.io/docs/concepts/cluster-administration/networking/#kubernetes-model) assumes a flat network in which containers and nodes can communicate with each other. In cases where this is not desired [network policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) can limit how groups of containers are allowed to communicate with each other and external network endpoints.

> Setting up network policies is out of scope for this tutorial.

### Kubernetes IP Address

Later in this guide you will allocate a static IP address that will be attached to the external load balancer fronting the Kubernetes API Servers:

## Virtual Machines

The virtual machines in this lab will be provisioned using [Ubuntu Server](https://www.ubuntu.com/server) 18.04. Each virtual machine will be provisioned with a fixed private IP address to simplify the Kubernetes bootstrapping process.

### Kubernetes Controllers

Vagrant will create two virtual machines which will host the Kubernetes control plane.

### Kubernetes Workers

Each worker instance requires a pod subnet allocation from the Kubernetes cluster CIDR range. The pod subnet allocation will be used to configure container networking in a later exercise.

> The Kubernetes cluster CIDR range is defined by the Controller Manager's `--cluster-cidr` flag. In this tutorial the cluster CIDR range will be set to `10.200.0.0/16`, which supports 254 subnets.

Vagrant will create three three virtual machines which will host the Kubernetes worker nodes.

### Provision virtual machines
Run the following command to provision the virtual machines described above:
```
vagrant up
```

> The process can take some time to download Vagrant box and provision virtual machines.

### Verification

List the virtual machines in your Vagrant project:

```
vagrant status
```

> output

```
TODO: add output here
```

## Configuring SSH Access

SSH will be used to configure the controller and worker instances. When Vagrant provision resources it uses helper script to push public SSH key to each virtual machine.

> You can specify which public key you want to use with a parameter to helper function:
```
authorize_key_for_root config,'~/.ssh/id_rsa.pub'
```

You will use root account to ssh into virtual machine. Additional ssh client configuration can be used to ommit username field every time when connecting to lab virtual machines. Put the following configuration in your `~/.ssh/config` file:
```
Host *.k8s.local
  StrictHostKeyChecking no
	UserKnownHostsFile /dev/null
	IdentitiesOnly yes
	PasswordAuthentication no
	User root
	ForwardAgent yes
```

You will use SSH Agent to connect to lab virtual machines. This is achived with the following configuration in Vagrantfile:
```
config.ssh.forward_agent = true
```
Configure the SSH Agent accordingly to your Vagrant SSH configuration.

Test SSH access to the `controller-0` virtual machine:

```
ssh controller-0
```

You'll be logged into the `controller-0` virtual machine:

```
Welcome to Ubuntu 18.04.3 LTS (GNU/Linux 4.15.0-1042-gcp x86_64)
...

Last login: Sun Sept 14 14:34:27 2019 from XX.XXX.XXX.XX
```

Type `exit` at the prompt to exit the `controller-0` virtual machine:

```
$USER@controller-0:~$ exit
```
> output

```
logout
Connection to XX.XXX.XXX.XXX closed
```

Next: [Provisioning a CA and Generating TLS Certificates](04-certificate-authority.md)
