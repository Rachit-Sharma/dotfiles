# set ANDROID_SDK environment variable
set -x ANDROID_SDK $HOME/Android/Sdk
# set PATH to include Android studio platform tools
set -x PATH $PATH $ANDROID_SDK/platform-tools

# add flutter to Path
set -x PATH $PATH $HOME/flutter/bin
# Flutter needs chrome executable to debug web apps
set -x CHROME_EXECUTABLE /usr/bin/brave-browser
