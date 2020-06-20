#!/usr/bin/ruby -w

puts <<'EOS'
################################################################################
#                                                                              #
#     WELCOME TO                                                               #
#             __  __                            _  _         _                 #
#            |  \/  |                          | |(_)       | |                #
#            | \  / |  __ _ __   __ ___  _ __  | | _  _ __  | | __             #
#            | |\/| | / _` |\ \ / // _ \| '_ \ | || || '_ \ | |/ /             #
#            | |  | || (_| | \ V /|  __/| | | || || || | | ||   <              # 
#            |_|  |_| \__,_|  \_/  \___||_| |_||_||_||_| |_||_|\_\             #
#                                                                              #                                            
################################################################################

This script will take care of getting a minimal setup installed for you with the
tools necessary to start working on Mavenlink projects. This initial bootstrap
is intended to be minimal. Additional commands will become available after this
initial setup is done to help you get working with specific Mavenlink projects.

Are you ready to continue (Y, n)
EOS

unless gets(1) =~ /^Y$/i
  puts "Hopefully you'll be ready soon!"
  exit(1)
end

puts
puts "Caching password..."
`sudo -K`
`sudo true;`

puts
puts "Ensuring full disk encryption is active..."
`sudo fdesetup isactive > /dev/null || sudo fdesetup enable -norecoverykey`

current_developer_tools_path = `xcode-select --print-path`

if current_developer_tools_path.empty?
  puts
  puts "*** YOU ARE ABOUT TO BE ASKED TO INSTALL DEVELOPER TOOLS ***"
  puts "*** PLEASE CONFIRM YOUR DESIRE TO INSTALL THEM OR THIS INSTALLER WILL HANG INDEFINITELY ***"
  puts
  `xcode-select --install`

  loop do
    sleep(5)
    current_developer_tools_path = `xcode-select --print-path`
    break unless current_developer_tools_path.empty?
  end
end

puts "Installing Homebrew package manager..."
`which brew > /dev/null || CI=true /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

puts
puts "Installing Ansible..."
`brew install ansible 2> /dev/null`

puts
puts "Cloning MavenUp Git Repository..."
`git clone https://github.com/plainprogrammer/mavenup.git $HOME/.mavenup 2> /dev/null`

puts
puts "Symlinking maven command into PATH..."
`mkdir -p $HOME/bin 2> /dev/null`
`ln -s $HOME/.mavenup/bin/maven $HOME/bin/maven 2> /dev/null`
`grep -qxF 'export PATH=$HOME/bin:$PATH' $HOME/.zprofile || echo 'export PATH=$HOME/bin:$PATH' >> $HOME/.zprofile`
`source $HOME/.zprofile 2> /dev/null`

puts
puts "Initial bootstrapping is complete!"
puts
puts "To continue setup, you can now use the `maven` command."
puts "Try running `maven help` and `maven firstday` to learn more."
