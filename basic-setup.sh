#!/bin/bash

## set location
while true
do
  read -p "Are you in China? (y/n) "
  if [[ $REPLY == "y" ]]
  then
    echo "set location to China"
    AREA="cn"
    break
  elif [[ $REPLY == "n" ]]
  then
    echo "set location to other"
    AREA="other"
    break
  else
    echo "invalid answer"
    continue
  fi
done

## Change default shell to /bin/zsh
if [[ $SHELL == "/bin/zsh" ]]
then
  echo "Check Complete"
else
  echo $SHELL
  echo "Change to zsh shell"
  chsh -s /bin/zsh
  if [[ $? == 0 ]]
  then
    echo "Change shell sucessfully"
  else
    echo "Unsucessful"
  fi
fi

## install apple command line tool
xcode-select --install

## Install package manager home brew
if [[ $(command -v brew) == "" ]]
then
  echo "installing homebrew"
  if [[ $AREA == "cn" ]]
  then
    echo "install homebrew from china mirror repo"
    /bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
  elif [[ $AREA == "other" ]]
   then
    echo "install homebrew from origin repo"
    /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  echo "home brew is installed"
else
  echo "homebrew is installed"
fi

## Install oh-my-zsh


## change shell to dafault to zsh


## Install useful software
# jump: fast navigation of file
