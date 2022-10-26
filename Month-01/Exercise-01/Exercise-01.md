## Exercise-01

## Task: 
* Setup Ubuntu 20.04 LTS on your local machine using Vagrant

## Instruction: 
- [ ] Customize your Vagrant file as necessary with private_network set to DHCP.
- [ ] Once the machine is up, run ifconfig and share the output in your submission along with your Vagrant file in a folder for this exercise.
<br><br>

## Procedure:

Head over to vagrants website and downloaded the right version for your local machine. Also get a virtual machine software or provider as it is referred to on the vagrant webpage.

`Note` I had to install docker as my provider since virtualbox doesn't provide support for `m1 macbooks` as at the moment of this writing, which I happen to own.

After having vagrant and a provider `docker in my case` running on your host machine, proceed to create an Ubuntu OS

1. Create a directory for hosting my vagrant project I will call mine ubuntu
```
mkdir ubuntu
```

2. Switch to the ubuntu directory that you created in the previous step
```
cd ubuntu
```

3. Now create an empty vagrantfile by running the 
```
touch vagrantfile
```

Add the following lines of code to your vagrant file. It should now look like the file below
```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.hostname = "ubuntu"
  # Provider-specific configuration so you can fine-tune various backing providers for Vagrant
  # Custom configuration for docker
  config.vm.provider :docker do |docker|
    # this is where your Dockerfile lives
    docker.image = "philemonnwanne/vagrant-provider:20.04"
    # Make sure it sets up ssh with the Dockerfile Vagrant is pretty dependent on ssh
    docker.has_ssh = true
    # Configure Docker to allow access to more resources
    docker.privileged = true
    docker.volumes = ["/sys/fs/cgroup:/sys/fs/cgroup:rw"]
    docker.create_args = ["--cgroupns=host"]    
  end
end
```

4. Proceed to configure a private network for your virtual machine in your vagrantfile. Your vagrant file should now look like what I have below
```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.hostname = "ubuntu"
  # Create a private network
  config.vm.network "private_network", type: "dhcp"
  # Provider-specific configuration so you can fine-tune various backing providers for Vagrant
  # Custom configuration for docker
  config.vm.provider :docker do |docker|
    # this is where your Dockerfile lives
    docker.image = "philemonnwanne/vagrant-provider:20.04"
    # Make sure it sets up ssh with the Dockerfile Vagrant is pretty dependent on ssh
    docker.has_ssh = true
    # Configure Docker to allow access to more resources
    docker.privileged = true
    docker.volumes = ["/sys/fs/cgroup:/sys/fs/cgroup:rw"]
    docker.create_args = ["--cgroupns=host"]    
  end
end
```


5. Make sure your are in the directory where your vagrant file is located and run the following command
```
vagrant up
```

> This will create and start up your ubuntu virtual machine


6. Now run the next command below in order to access your newly created linux virtual machine
```
vagrant ssh
```

That's it we can now use our newly created vm. Proceed to the following steps to find out your virtual machines IP address


### Confirm your virtual machines IP address

You can check your virtual machines IP address by running the following command
```
ifconfig
```
> You might notice that you get a `ifconfig: command not found` error, proceed to the next step in order to fix this

<br>

While in the linux virtual machine, run the below commands to update your ubuntu OS apt repository and install the `ifconfig` command
```
sudo apt update
sudo apt install net-tools
```

Now run the `ifconfig` command again and you should be able to see your virtual machines IP address. See my output below;
![ifconfig output](images/ifconfig.png)

That's all for now and if you want to exit your virtual machine, you can issue the following command
```
exit
```

Then to stop the virtual machine from running issue the `vagrant halt` command


### Other Useful commands
```php
vagrant status - This will tell you the state of the machines Vagrant is managing

vagrant suspend - This suspends the guest machine Vagrant is managing, rather than fully shutting it down or destroying it

vagrant destroy - This command stops the virtual machine from running, and destroys all resources that were created for the machine

vagrant reload - This is used to restart the virtual machine after making changes to the vagrantfile
```


