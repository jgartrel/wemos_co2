# Mac Setup for Vagrant

This install is done with El Capitan: 10.11.3 and should get a clean install up and running with the tools necessary to work with this repo.

1. Install Xcode (>= 7.2.1):
  * https://itunes.apple.com/us/app/xcode/id497799835?mt=12

2. Install Xcode Command Line tools:

    ```  
    xcode-select --install
    ```  

3. Install Homebrew:

    ```  
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ```  

4. Update Homebrew and check if all is well:

    ```  
    brew update
    brew update
    brew doctor
    ```  

5. Install Homebrew cask:

    ```  
    brew tap caskroom/cask
    ```  

6. Install VirtualBox(>= 5.2.22-126460):

    ```  
    brew cask install virtualbox
    brew cask install virtualbox-extension-pack
    ```  

7. Install Vagrant (>= 2.2.2):

    ```  
    brew cask install vagrant
    vagrant plugin install vagrant-vbguest
    ```  
