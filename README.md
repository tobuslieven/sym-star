# sym-star

## How To Use Sym-Star As A Base For Your Own Projects

### Table Of Contents
**[Install Vagrant and VirtualBox](#install-vagrant-and-virtualbox)**

**[Get The Sym Star Repository](#get-the-sym-star-repository)**

**[Launch The Virtual Machine](#launch-the-virtual-machine)**

**[First Test Of Virtual Machine](#first-test-of-virtual-machine)**

**[Use The Proper Website Name](#use-the-proper-website-name)**

**[Log Into The Virtual Machine](#log-into-the-virtual-machine)**

**[Setting Up The Symfony Demo](#setting-up-the-symfony-demo)**

**[Sym Star Tutorial List](#sym-star-tutorial-list)**

### Install Vagrant and VirtualBox
Download and install VirtualBox from [here](https://www.virtualbox.org/).

Download and install Vagrant from [here](https://www.vagrantup.com/).

### Get The Sym Star Repository
Change directory to where you want your project folder to be.
```
cd ~/MyWebsitesFolder
```
Git clone this repo to a new 'MyProjecName' folder, ignoring the history of the sym-star repository because you won't need it.
```
git clone --depth=1 MyProjectName
```
Now you want to remove any connection between your new project and the sym-star repository.
Change directory into your new project.
```
cd MyProjectName
```
Remove your new project's link to the sym-star repository that it's based on.
```
git remote rm origin
```

This will give you a folder structure like:
```
/MyWebsitesFolder
    /MyProjectName
        ...The contents of your nice new base project are here...
```

### Launch The Virtual Machine
To launch the vagrant box, go to your directory (you'll already be there if you're following along) and at the terminal type the following command. This will download the linux operating system image, boot up the virtual machine and run the provisioning script called bootstrap.sh that's referenced in the Vagrant file that you downloaded as part sym-star. The bootstrap script will install and launch all the packages that are needed for a full web development server to build a nice Symfony app with. This process will take some time and there may be alot of red ink but don't worry! Usually the red output is actually fine. So read the next instructions to check for sure once the process has completed.
```
vagrant up
```

### First Test Of Virtual Machine
To test your virtual machine, go to your favorite web browser and type 192.168.50.4 into the address bar. This is the ip address that the virtual machine is given in the Vagrantfile you downloaded as part of sym-star. If you see the symfony test page, then it's all working so far. If you see anything else, try checking out the troubleshooting section at the end of this page.

### Use The Proper Website Name
To allow you to use the website's real name in the browser, rather than typing in the ip address each time, you need to edit the 'host' file on your main machine. This is standard practice for web development.
Change to the folder where the hosts file is.
```
cd /etc
```
Launch a text editor called vi. It's a decent editor but if you prefer another and know how to use it, feel free.
```
sudo vi hosts
```
This is the vi command to go to the last line of the file.
```
G
```
This is the vi command to open a new line below the current one.
```
o
```
This is the line that you actually want to enter to tell your computer to go to the right address when you type your project name into a browser.
```
192.168.50.4    myprojectname.dev
```
When you're done typing, press Esc.
```
Esc
```
Type the following then hit the enter key. The colon tells vi you want to enter command mode. The w tells vi to write the file to disk. The q tells vi to quit because we're done with this text editing malarky for now.
```
:wq
```
When resolving website names into ip addresses, your computer looks in the hosts file first. So now when you type myprojectname.dev into a web browser, your computer will resolve that name to 192.168.50.4, which is the address that your vagrant virtual machine has been assigned in its Vagrantfile. Web developers usually use the .dev suffix instead of .com or whatever the real site uses so that they can still visit the live site at myprojectname.com without confusing their computer or getting confused themselves about which site they're visiting.

### Log Into The Virtual Machine
Change directory to your project's folder.
```
cd MyProjectName
```
Vagrant has a special ssh command to make it easy to log into your vitual machine.
```
vagrant ssh
```
You are now logged into the virtual machine. If you like you can do all of your development right here. There's a really nice version of vi (vim) installed with loads of cool plugins for navigation, code highlighting, opening and searching files, debugging php and stuff like that. Check out the youtube tutorials for more details of how to use it.

### Setting Up The Symfony Demo
The Symfony project provides a demo site that can be used to learn a lot of their weird and wonderful ways of doing things. To install this you will have to log into the vagrant virtual machine, change directory to the sites directory, type a command to install the Symfony demo, enable the vhost which has already been set up. The details follow.
Log into the vagrant machine.
```
cd /PathTo/MyProjectName
vagrant ssh
```
Change to the sites directory.
```
cd /vagrant/sites
```
Install the Symfony demo.
```
symfony demo 2.7
```
Enable the site.
```
a2ensite symfony_demo.dev
```
To access the site from your main machine's browser as symfony_demo.dev, you'll have to edit your main machine's hosts file again. As follows.
Log out of vagrant virtual machine.
```
exit
```
The details of the following commands are explained [here](#use-the-proper-website-name).
```
cd /etc
sudo vi hosts
G
o
192.168.50.4    symfony_demo.dev
Esc
:wq
```

### Sym Star Tutorial List
To do...

