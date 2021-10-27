#! /bin/sh

# set hostname
read -p "Enter long form Computer Name: " comp_name
read -p "Enter hostname: " hostname
sudo scutil --set ComputerName comp_name
sudo scutil --set LocalHostName hostname 

# set filevault on
echo "Turning on FileVault"
sudo fdesetup enable

# firewall
echo "Configuring Firewall"
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
sudo pkill -HUP socketfilterfw

# keyboard
echo "Making keyboard usable again"
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

# security/screen locking
echo "Adjusting password delay"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# file system
echo "Making all files visible"
defaults write com.apple.finder AppleShowAllFiles -bool true
echo "Making Library folder visible"
chflags nohidden ~/Library
echo "Making all file extensions visible"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
echo "Disabling iCloud default save location"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# command line utils
echo "Installing XCode Command Line Tools"
xcode-select --install

# install homebrew
echo "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# update homebrew
echo "Updating Homebrew"
brew update-reset && brew update

# tap from additional sources
brew tap homebrew/cask-versions
brew tap homebrew/cask-fonts

# install applications
brew install coreutils binutils
brew install zsh git htop
brew install python python@2
brew install wireshark

# install casked applications
brew cask install appcleaner
brew cask install cmake dropbox iterm
brew cask install cutter dash etcher
brew cask install firefox-developer-version google-chrome-dev vivaldi
brew cask install gpg-suite
brew cask install istat-menus bartender
brew cask install rocket
brew cask install steam
brew cask install transmission tunnelblick
brew cask install wireshark parallels13
brew cask install zoomus
brew cask install xquartz
brew cask install spotify spotify-notifications
brew cask install font-fira-sans
brew cask install font-source-code-pro
