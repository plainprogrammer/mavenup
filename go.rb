#!/usr/bin/env ruby

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

puts <<EOS
#########################
# Installing Ansible... #
#########################
EOS
`curl https://bootstrap.pypa.io/get-pip.py -o $HOME/Downloads/get-pip.py`
`python $HOME/Downloads/get-pip.py --user`
python_user_path = `printf "import site\\nprint(site.USER_BASE)" | python`.chomp
`#{python_user_path}/bin/pip install --user ansible`

puts "Done!"
