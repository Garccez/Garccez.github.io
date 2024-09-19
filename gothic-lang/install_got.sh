#!/bin/bash

# Script path
# Absolute path to this script, e.g. /home/user/bin/install_got.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

# Colors
RED='\033[0;31m'
BLUE='\033[0;34m'
LCY='\033[0;96m' # Light Cyan
LGR='\033[0;92m' # Light Green
NC='\033[0m' # No Color

# DISTRO=$(lsb_release -i | cut -f 2-)
# echo -e "${DISTRO}"

# Initial checks

if [ "$EUID" -ne 0 ]
  then echo -e "${RED}[WARNING]${NC} Please run this script as root."
  exit
fi

# Check if user has package wget
if ! command -v wget &> /dev/null
then
	if [ "$DISTRO" == "Arch" ]
	then
		echo -e "${RED}[ERROR]${NC} wget could not be found. Please install it."
		sudo pacman -S wget
		exit
	fi
	if [ "$DISTRO" == "Ubuntu" ]
	then
    	echo -e "${RED}[ERROR]${NC} wget could not be found. Please install it."
    	sudo apt install wget
    	exit
    fi
    echo -e "${RED}[ERROR]${NC} wget could not be found. Please install it."
    sudo apt install wget
    exit
fi

# Check if user has ibus
if ! command -v ibus &> /dev/null
then
	if [ "$DISTRO" == "Arch" ]
	then
		echo -e "${RED}[ERROR]${NC} ibus could not be found. Please install it."
		sudo pacman -S ibus ibus-rime
		exit
	fi
	if [ "$DISTRO" == "Ubuntu" ]
	then
    	echo -e "${RED}[ERROR]${NC} ibus could not be found. Please install it."
    	sudo apt install ibus ibus-rime
    	exit
    fi
    echo -e "${RED}[ERROR]${NC} ibus could not be found. Please install it."
    sudo apt install ibus ibus-rime
    exit
fi

# If there aren't errors, start downloading

echo -e "${LGR}[START]${NC} Starting..."
echo -e "${LGR}[START]${NC} Creating files/ folder..."
FILES=$SCRIPTPATH/files/
if [ -d "$FILES" ]; then
     echo -e "${BLUE}[FILE]${NC} files/ folder already exists. Proceeding..."
else
     mkdir files/
     echo -e "${BLUE}[FILE]${NC} files/ folder created. Proceeding..."
fi
echo -e "${BLUE}[FILE]${NC} Entering files/ folder."
cd files/

# Checks, folders and Backup
echo -e "${LCY}[BACKUP]${NC} Creating backup for important files."
echo -e "${LCY}[BACKUP]${NC} Creating backup folder..."
BACKUP=$SCRIPTPATH/files/backup/
if [ -d "$BACKUP" ]; then
     echo -e "${LCY}[BACKUP]${NC} backup/ folder already exists. Proceeding..."
else
     mkdir backup/
     echo -e "${LCY}[BACKUP]${NC} backup/ folder created. Proceeding..."
fi
echo -e "${LCY}[BACKUP]${NC} Entering backup/ folder."
cd backup/
echo -e "${LCY}[BACKUP]${NC} Copying files..."

EVDEV=$SCRIPTPATH/files/backup/evdev.xml
EVDEV2=$SCRIPTPATH/files/backup/evdev.lst
XORG=$SCRIPTPATH/files/backup/xorg.lst
BASE=$SCRIPTPATH/files/backup/base.xml
BASE2=$SCRIPTPATH/files/backup/base.lst
SIMPLE=$SCRIPTPATH/files/backup/simple.xml

if [ -f "$EVDEV" ]; then
     echo -e "${LCY}[BACKUP]${NC} evdev.xml already exists."
else
     echo -e "${LCY}[BACKUP]${NC} Copying evdev.xml..."
     cp /usr/share/X11/xkb/rules/evdev.xml evdev.xml
fi
if [ -f "$EVDEV2" ]; then
     echo -e "${LCY}[BACKUP]${NC} evdev.lst already exists."
else
     echo -e "${LCY}[BACKUP]${NC} Copying evdev.lst..."
     cp /usr/share/X11/xkb/rules/evdev.lst evdev.lst
fi
if [ -f "$XORG" ]; then
     echo -e "${LCY}[BACKUP]${NC} xorg.lst already exists."
else
     echo -e "${LCY}[BACKUP]${NC} Copying xorg.lst..."
     cp /usr/share/X11/xkb/rules/xorg.lst xorg.lst
fi
if [ -f "$BASE" ]; then
     echo -e "${LCY}[BACKUP]${NC} base.xml already exists."
else
     echo -e "${LCY}[BACKUP]${NC} Copying base.xml..."
     cp /usr/share/X11/xkb/rules/base.xml base.xml
fi
if [ -f "$BASE2" ]; then
     echo -e "${LCY}[BACKUP]${NC} base.lst already exists."
else
     echo -e "${LCY}[BACKUP]${NC} Copying base.lst..."
     cp /usr/share/X11/xkb/rules/base.lst base.lst
fi
if [ -f "$SIMPLE" ]; then
     echo -e "${LCY}[BACKUP]${NC} simple.xml already exists."
else
     echo -e "${LCY}[BACKUP]${NC} Copying simple.xml..."
     cp /usr/share/ibus/component/simple.xml simple.xml
fi
echo -e "${LCY}[BACKUP]${NC} All files copied. Returning..."
echo -e "${RED}[WARNING]${NC} Note that this backs up YOUR files, even if they're modified."

cd ..
echo -e "${LGR}[START]${NC} Let's start downloading!"

FILE_GOT=$SCRIPTPATH/files/got
echo -e "${BLUE}[FILE]${NC} Checking if 'got' already exists..."
if [ -f "$FILE_GOT" ]; then
     echo -e "${BLUE}[FILE]${NC} 'got' exists. Proceeding..."
else
     echo -e "${BLUE}[FILE]${NC} 'got' doesn't exist. Downloading..."
     wget http://garccez.github.io/gothic-lang/got
     echo -e "${BLUE}[FILE]${NC} 'got' succesfully downloaded. Proceeding..."
fi
FILE_EVDEV=$SCRIPTPATH/files/evdev.xml
echo -e "${BLUE}[FILE]${NC} Checking if 'evdev.xml' already exists..."
if [ -f "$FILE_EVDEV" ]; then
     echo -e "${BLUE}[FILE]${NC} 'evdev.xml' exists. Proceeding..."
else
     echo -e "${BLUE}[FILE]${NC} 'evdev.xml' doesn't exist. Downloading..."
     wget http://garccez.github.io/gothic-lang/evdev.xml
     echo -e "${BLUE}[FILE]${NC} 'evdev.xml' succesfully downloaded. Proceeding..."
fi
FILE_EVDEV2=$SCRIPTPATH/files/evdev.lst
echo -e "${BLUE}[FILE]${NC} Checking if 'evdev.lst' already exists..."
if [ -f "$FILE_EVDEV2" ]; then
     echo -e "${BLUE}[FILE]${NC} 'evdev.lst' exists. Proceeding..."
else
     echo -e "${BLUE}[FILE]${NC} 'evdev.lst' doesn't exist. Downloading..."
     wget http://garccez.github.io/gothic-lang/evdev.lst
     echo -e "${BLUE}[FILE]${NC} 'evdev.lst' succesfully downloaded. Proceeding..."
fi
FILE_XORG=$SCRIPTPATH/files/xorg.lst
echo -e "${BLUE}[FILE]${NC} Checking if 'xorg.lst' already exists..."
if [ -f "$FILE_XORG" ]; then
     echo -e "${BLUE}[FILE]${NC} 'xorg.lst' exists. Proceeding..."
else
     echo -e "${BLUE}[FILE]${NC} 'xorg.lst' doesn't exist. Downloading..."
     wget http://garccez.github.io/gothic-lang/xorg.lst
     echo -e "${BLUE}[FILE]${NC} 'xorg.lst' succesfully downloaded. Proceeding..."
fi
FILE_BASE=$SCRIPTPATH/files/base.xml
echo -e "${BLUE}[FILE]${NC} Checking if 'base.xml' already exists..."
if [ -f "$FILE_BASE" ]; then
     echo -e "${BLUE}[FILE]${NC} 'base.xml' exists. Proceeding..."
else
     echo -e "${BLUE}[FILE]${NC} 'base.xml' doesn't exist. Downloading..."
     wget http://garccez.github.io/gothic-lang/base.xml
     echo -e "${BLUE}[FILE]${NC} 'base.xml' succesfully downloaded. Proceeding..."
fi
FILE_BASE2=$SCRIPTPATH/files/base.lst
echo -e "${BLUE}[FILE]${NC} Checking if 'base.lst' already exists..."
if [ -f "$FILE_BASE2" ]; then
     echo -e "${BLUE}[FILE]${NC} 'base.lst' exists. Proceeding..."
else
     echo -e "${BLUE}[FILE]${NC} 'base.lst' doesn't exist. Downloading..."
     wget http://garccez.github.io/gothic-lang/base.lst
     echo -e "${BLUE}[FILE]${NC} 'base.lst' succesfully downloaded. Proceeding..."
fi
FILE_SIMPLE=$SCRIPTPATH/files/simple.xml
echo -e "${BLUE}[FILE]${NC} Checking if 'simple.xml' already exists..."
if [ -f "$FILE_SIMPLE" ]; then
     echo -e "${BLUE}[FILE]${NC} 'simple.xml' exists. Proceeding..."
else
     echo -e "${BLUE}[FILE]${NC} 'simple.xml' doesn't exist. Downloading..."
     wget http://garccez.github.io/gothic-lang/simple.xml
     echo -e "${BLUE}[FILE]${NC} 'simple.xml' succesfully downloaded. Proceeding..."
fi
echo -e "${BLUE}[FILE]${NC} All files downloaded. Let's move them to their right place."
echo -e "${BLUE}[FILE]${NC} Moving got..."
cp got /usr/share/X11/xkb/symbols/
echo -e "${BLUE}[FILE]${NC} Moving evdev.xml..."
cp evdev.xml /usr/share/X11/xkb/rules/evdev.xml
echo -e "${BLUE}[FILE]${NC} Moving evdev.lst..."
cp evdev.lst /usr/share/X11/xkb/rules/evdev.lst
echo -e "${BLUE}[FILE]${NC} Moving xorg.lst..."
cp xorg.lst /usr/share/X11/xkb/rules/xorg.lst
echo -e "${BLUE}[FILE]${NC} Moving base.xml..."
cp base.xml /usr/share/X11/xkb/rules/base.xml
echo -e "${BLUE}[FILE]${NC} Moving base.lst..."
cp base.lst /usr/share/X11/xkb/rules/base.lst
echo -e "${BLUE}[FILE]${NC} Moving simple.xml..."
cp simple.xml /usr/share/ibus/component/simple.xml
echo -e "${BLUE}[FILE]${NC} All files have been succesfully moved."
read -p "Do you want to delete the files (this doesn't includes backup)? (Y/n) " -n 2 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
     echo -e "${RED}[DELETE]${NC} Deleting all keyboard files..."
     rm -r got evdev.xml evdev.lst xorg.lst base.xml base.lst simple.xml
     echo -e "${RED}[DELETE]${NC} Files deleted."
fi
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
     echo -e "${BLUE}[CONFIRMATION]${NC} Sure!"
fi
echo -e "${LGR}[FINISH]${NC} Now everything should work. You just need to add Gothic to your input methods on you Distro settings and log off/log in."
exit

