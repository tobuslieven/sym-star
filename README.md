# sym-star

## How To Use Sym-Star As A Base For Your Own Projects

### Table Of Contents
**[Install Vagrant and VirtualBox](#install-vagrant-and-virtualbox)**
**[Launch The Virtual Machine](#launch-the-virtual-machine)**
**[Use The Proper Website Name](#use-the-proper-website-name)**


### Install Vagrant and VirtualBox

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
        ...The contents of sym-star are here...
```

### Launch The Virtual Machine
To launch the vagrant box go to your directory (you'll already be there if you're following along) and at the terminal type the following command. This will download the linux image, boot up the virtual machine and provision it, installing and launching all the packages that are needed for a full web development server to build a nice Symfony app with. It may take some time and there may be alot or red ink. Usually the red output is actually fine.
```
vagrant up
```
To test your virtual machine, go to your favorite web browser and type 192.168.50.4 into the address bar. If you see the symfony test page, then it's all working so far. If you see anything else, try checking out the troubleshooting section at the end of this page.

### Use The Proper Website Name
To allow you to use the website's real name in the browser, rather than typing in the ip address each time, you need to edit the 'host' file on your main machine. This is standard practice for web development.
```
cd /etc
sudo vim hosts
G
A
192.168.50.4    myprojectname.dev
```
When resolving website names into ip addresses, your computer looks in the hosts file first. So now when you type myprojectname.dev into a web browser, your computer will resolve that name to 192.168.50.4, which is the address that your vagrant virtual machine has been assigned in its Vagrantfile. Web developers usually use the .dev suffix instead of .com or whatever the real site uses so that they can still visit the live site at myprojectname.com without getting confusing their computer or getting confused themselves about which site they're visiting.



