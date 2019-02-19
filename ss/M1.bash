#!/bin/bash

yt_filename(){
youtube-dl $1 | grep .mp4 | sed 's/[][]//g; s/Destination: //; s/download//; s/ has already been downloaded//;s/ and merged// ; s/ //;'
}

ytsave(){
OLD=$(yt_filename "$2");
NEW=$1;
if [  -d "$NEW"  ]; then
echo "${bold}$NEW${normal} is already a directory.";
echo "file saved in working directory as ${bold}$OLD${normal}.";
elif [  -f "$NEW"  ]; then
echo "${bold}$NEW${normal} is already a file.";
echo "file saved in working directory as ${bold}$OLD${normal}.";
else
mv "$OLD" "$NEW";
echo "file saved in working directory as ${bold}$NEW${normal}."
fi
}

ytplay(){
if [ $# -eq 2 ]; then
OLD=$(yt_filename "$2");
NEW=$1;
if [  -d "$NEW"  ]; then
echo "${bold}$NEW${normal} is already a directory.";
echo "file saved in working directory as ${bold}$OLD${normal}.";
mpv "$OLD";
elif [  -f "$NEW"  ]; then
echo "${bold}$NEW${normal} is already a file.";
echo "file saved in working directory as ${bold}$OLD${normal}.";
mpv "$OLD";
else
mv "$OLD" "$NEW";
echo "file saved in working directory as ${bold}$NEW${normal}."
mpv "$NEW";
fi
else
VFILE=$(yt_filename "$1");
mv "$VFILE" "~~temp~~"
mpv "~~temp~~";
fi
}

vplay(){
osascript -e [ tell application "iTerm2" create window with default profile end tell ]
mpv $1;
}

start(){
if [ $# -eq 1 ]; then
if [  -d "$1"  ]; then
echo "${bold}$1${normal} already exists.";
elif [  -f "$1"  ]; then
echo "${bold}$1${normal} already exists.";
else
if [[ $1 == *"."* ]]; then
touch "$1"
echo "${bold}$1${normal} saved as file in working directory."
else
mkdir "$1"
echo "${bold}$1${normal} saved as directory in working directory."
fi

fi

elif [ $# -eq 2 ]; then
if [[ $1 == *"-f"* ]]; then
if [  -d "$2"  ]; then
echo "${bold}$2${normal} already exists.";
elif [  -f "$2"  ]; then
echo "${bold}$2${normal} already exists.";
else
touch "$2"
echo "${bold}$2${normal} saved as extensionless file in working directory."
fi

elif [[ $1 == *"-o"* ]]; then
if [  -d "$2"  ]; then
echo "${bold}$2${normal} already exists.";
cd "$2";
elif [  -f "$2"  ]; then
echo "${bold}$2${normal} already exists.";
open "$2";
else
if [[ $2 == *"."* ]]; then
touch "$2"
open "$2"
echo "${bold}$2${normal} saved as file in working directory."
echo "opened file ${bold}$2${normal}"
else
mkdir "$2"
cd "$2"
echo "${bold}$2${normal} saved as directory in working directory."
echo "in new directory ${bold}$2${normal}"
fi

fi
fi

elif [ $# -eq 3 ]; then
if [[ ( $1 == *"-f"*  &&  $2 == *"-o"* ) || ( $1 == *"-o"*  &&  $2 == *"-f"*  ) ]]; then
if [  -d "$3"  ]; then
echo "${bold}$3${normal} already exists.";
cd "$3";
elif [  -f "$3"  ]; then
echo "${bold}$3${normal} already exists.";
open "$3";
else
touch "$3"
open "$3"
echo "${bold}$3${normal} saved as extensionless file in working directory."
echo "opened file ${bold}$3${normal}"
fi
fi
fi
}

sb(){
cd ~/sandbox;
}

ytmusic(){
mpsyt "$1";
}

setsc(){
if grep -q "~$1:" ~/.shortcuts; then
echo "$1 is already a shortcut";
while true; do
read -p "replace shortcut? " yn
case $yn in
[Yy]* ) LINE=$( grep "~$1:" ~/.shortcuts ); sed -i ".bck"  "s#$LINE#~$1:$2#g" ~/.shortcuts ; echo "${bold}$1${normal} now points to ${bold}$2${normal}" ;break;;
[Nn]* ) echo "did nothing."; break;;
* ) echo "Please answer yes or no.";;
esac
done
else
if [ -d "$2" ]; then
echo "~$1:$2" >> ~/.shortcuts
elif [ "$2" == "" ]; then
echo "~$1:$PWD" >> ~/.shortcuts;
else
echo "${bold}$2${normal} is not a directory.";
fi
fi
}

sc(){
cd $( grep "~$1:" ~/.shortcuts | cut -d":" -f 2 );
}
