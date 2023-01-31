clear
echo -e "\e[31m ________    _____   ______       __    __     __    __   __     __  " 
echo -e "\e[31m(___  ___)  / ___/  (   __ \      \ \  / /     ) )  ( (  (_ \   / _) " 
echo -e "\e[96m    ) )    ( (__     ) (__) )     () \/ ()    ( (    ) )   \ \_/ /   " 
echo -e "\e[96m   ( (      ) __)   (    __/      / _  _ \     ) )  ( (     \   /   "  
echo -e "\e[94m    ) )    ( (       ) \ \  _    / / \/ \ \   ( (    ) )    / _ \    " 
echo -e "\e[94m   ( (      \ \___  ( ( \ \_))  /_/      \_\   ) \__/ (   _/ / \ \_  " 
echo -e "\e[92m   /__\      \____\  )_) \__/  (/          \)  \______/  (__/   \__)" 
                    
 
echo -e " \e[91m                                                   ____      _____  " 
echo -e " \e[91m                                                  / __ \    / ____\ " 
echo -e " \e[96m                                                 / /  \ \  ( (___   " 
echo -e " \e[96m                                                ( ()  () )  \___ \  " 
echo -e " \e[1;91m Youtube\e[96m / \e[100;97myoutube.com/h4ck3r0\e[0;31m                  ( ()  () )      ) )" 
echo -e " \e[1;91m Github\e[96m /\e[1;93m H4Ck3R0                                \ \__/ /   ___/ /"  
echo -e " \e[1;91m Telegram\e[1;96m /\e[1;92m H4Ck3R_0                              \____/   /____/"    
echo ""

banner ( ) {
                  
                  
                  printf ""
                  echo -e "\e[1;31m  [\e[32m√\e[31m] \e[1;91m by \e[1;36mRaj Aryan \e[93m/ \e[100;92myoutube.com/h4ck3r0\e[0m"
                  }

                  wr  ( )  {
                               printf "\033[1;91m Invalid input!!!\n"
                               selection
                               }
                               1line() {
                                                         apt update && apt upgrade
                                                         pkg install zsh -y
                                                         pkg install git -y
                                                         pkg install figlet toilet -y
                                                         pkg install ruby  -y
                                                         pkg install wget  -y
                                                       
                                                         gem install lolcat 
                                                         pkg install curl -y
                                                         pkg install zsh -y
                                                         
                                                         clear
                                                         cd ~/Termux-os/.object/ && cp -r 'ANSI Shadow.flf'  $PREFIX/share/figlet/ASCII-Shadow.flf 
                                                         git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
                                                       
                                                         pkg install toilet figlet exa -y
                                                         cd ~/Termux-os/.object
                                                         rm -rf ~/.termux/colors.properties
                                                         rm -rf /data/data/com.termux/files/usr/etc/motd
                                                         cp -r .colors.properties ~/.termux/colors.properties
                                                         cp -r .termux.properties ~/.termux/termux.properties
                                                         clear
                                                         cd ~/Termux-os ; bash os.sh
                                                         termux-open-url h4ck3r.me
                                                         
                                                         }
                                                         2line() {
                                                                               rm -rf ~/.zshrc
                                                                               git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
                                                                               cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
                                                                               cd ~/Termux-os ; bash os.sh
                                                                                }
                                                                               3line() {
                                                                                                 pkg install zsh
                                                                                                 chsh -s zsh
                                                                                                 cd ~/Termux-os ; bash os.sh
                                                                                                  }
                                                                                                   4line() {
                                                                                                                         chsh -s bash
                                                                                                                         cd  ~/Termux-os ; bash os.sh
                                                                                                                         }
                                                                                                                         5line() {
                                                                                                                                              rm -rf ~/.zshrc
                                                                                                                                              cd ~/Termux-os/.object
                                                                                                                                              bash  .2.sh
                                                                                                                                              clear ; cd ~/Termux-os ; bash os.sh
                                                                                                                                                  }
                                                                                                                                                 
                                                                                                                                                6line() {
                                                                                                                                                                         cd ~/Termux-os/.object
                                                                                                                                                                         bash .1.sh
                                                                                                                                                                         clear ; cd ~/Termux-os ; bash os.sh
                                                                                                                                                                       }
                                                                                                                                                                       7line() {
                                                                                                                                                                                                                    cd ~/Termux-os/.object
                                                                                                                                                                                                                    rm -rf ~/.zshrc
                                                                                                                                                                                                                    chsh -s zsh
                                                                                                                                                                                                                    bash .3.sh
                                                                                                                                                                                                                    clear ; cd ~/Termux-os ; bash os.sh
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                     8line() {
                                                                                                                                                                                                                                  rm -rf ~/Termux-os
                                                                                                                                                                                                                                  cd
                                                                                                                                                                                                                                  git clone https://github.com/h4ck3r0/Termux-os
                                                                                                                                                                                                                                  cd ~/Termux-os ; bash os.sh
                                                                                                                                                                                                                                  }
    
                                 selection () {
                                            cd ~/Termux-os
                                            echo -e -n "\e[1;96m Choose\e[1;96m Option : \e[0m"
                                            read a
                                            case $a in
                                            1) 1line ;;
                                            2) 2line ;;
                                            3) 3line ;;
                                            4) 4line ;;
                                            5) 5line ;;
                                            6) 6line ;;
                                            7) 7line ;;
                                            8) 8line ;;
                                            9) exit ;;
                                            *) wr ;;
                                            esac
                                            }

                  menu () {
                                  banner
                                  printf "\n\033[1;91m[\033[0m1\033[1;91m]\033[1;92m Necessary Setup \n"
                                  printf "\033[1;91m[\033[0m2\033[1;91m]\033[1;92m Zsh Setup\n"
                                  printf "\033[1;91m[\033[0m3\033[1;91m]\033[1;92m Zsh Shell\n"
                                  printf "\033[1;91m[\033[0m4\033[1;91m]\033[1;92m Bash Shell\n"
                                  printf "\033[1;91m[\033[0m5\033[1;91m]\033[1;92m Zsh Banner\n"
                                  printf "\033[1;91m[\033[0m6\033[1;91m]\033[1;92m Zsh Theme\n"
                                  printf "\033[1;91m[\033[0m7\033[1;91m]\033[1;92m Highlight / AutoSuggest\n"
                                  printf "\033[1;91m[\033[0m8\033[1;91m]\033[1;92m Update\n"
                                  printf "\033[1;91m[\033[0m9\033[1;91m]\033[1;92m Exit\n\n\n"
                                  
                                  selection
                                  }
                  menu
