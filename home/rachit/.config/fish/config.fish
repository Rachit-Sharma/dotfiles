# Set the default editor
set -x EDITOR nvim

# set ANDROID_SDK environment variable
set -x ANDROID_SDK $HOME/Android/Sdk
# set PATH to include Android studio platform tools
set -x PATH $PATH $ANDROID_SDK/platform-tools

# add flutter to Path
set -x PATH $PATH $HOME/flutter/bin
# Flutter needs chrome executable to debug web apps
set -x CHROME_EXECUTABLE /usr/bin/brave-browser

# add java to Path
set -x PATH $PATH $HOME/java/jdk-11.0.12+7/bin
# add mvn to Path
set -x PATH $PATH $HOME/java/apache-maven-3.8.2/bin

# add go to Path
set -x PATH $PATH /usr/local/go/bin
set -x PATH $PATH $HOME/go/bin

# add cargo to Path
set -x PATH $PATH $HOME/.cargo/bin
