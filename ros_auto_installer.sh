function custom_echo() {
  text=$1
  color=$2
  terminal_width=$(tput cols)

  case $color in
    "green")
      echo -e "\033[32m[RO:BIT] $text\033[0m"
      ;;
    "red")
      echo -e "\033[31m [RO:BIT] $text\033[0m"
      ;;
    "yellow")
      padding_length_left=$(( (terminal_width - ${#text} - 20) / 2 ))
      padding_length_right=$(( terminal_width - ${#text} - 20 - padding_length_left ))
      padding_left=$(printf "%*s" $padding_length_left "")
      padding_right=$(printf "%*s" $padding_length_right "")
      echo -e "\033[33m[RO:BIT] $padding_left$text$padding_right\033[0m"
      ;;
    *)
      echo "$text"
      ;;
  esac
}

loading_animation() {
  local interval=1
  local duration=30
  local bar_length=$(tput cols)  # 터미널 창의 너비를 가져옴
  local total_frames=$((duration * interval))
  local frame_chars=("█" "▉" "▊" "▋" "▌" "▍" "▎" "▏")

  for ((i = 0; i <= total_frames; i++)); do
    local frame_index=$((i % ${#frame_chars[@]}))
    local progress=$((i * bar_length / total_frames))
    local bar=""
    for ((j = 0; j < bar_length; j++)); do
      if ((j <= progress)); then
        bar+="${frame_chars[frame_index]}"
      else
        bar+=" "
      fi
    done
    printf "\r\033[32m%s\033[0m" "$bar"  # 초록색으로 출력
    sleep 0.$interval
  done

  printf "\n"
}

text_art="

██████╗░░█████╗░██╗██████╗░██╗████████╗  ███╗░░░███╗░░░░░██╗  ██╗░░░░░███████╗███████╗
██╔══██╗██╔══██╗╚═╝██╔══██╗██║╚══██╔══╝  ████╗░████║░░░░░██║  ██║░░░░░██╔════╝██╔════╝
██████╔╝██║░░██║░░░██████╦╝██║░░░██║░░░  ██╔████╔██║░░░░░██║  ██║░░░░░█████╗░░█████╗░░
██╔══██╗██║░░██║░░░██╔══██╗██║░░░██║░░░  ██║╚██╔╝██║██╗░░██║  ██║░░░░░██╔══╝░░██╔══╝░░
██║░░██║╚█████╔╝██╗██████╦╝██║░░░██║░░░  ██║░╚═╝░██║╚█████╔╝  ███████╗███████╗███████╗
╚═╝░░╚═╝░╚════╝░╚═╝╚═════╝░╚═╝░░░╚═╝░░░  ╚═╝░░░░░╚═╝░╚════╝░  ╚══════╝╚══════╝╚══════╝

██████╗░░█████╗░░██████╗
██╔══██╗██╔══██╗██╔════╝
██████╔╝██║░░██║╚█████╗░
██╔══██╗██║░░██║░╚═══██╗
██║░░██║╚█████╔╝██████╔╝
╚═╝░░╚═╝░╚════╝░╚═════╝░
"

terminal_width=$(tput cols)
padding_length=$(( (terminal_width - ${#text_art}) / 2 ))
padding=$(printf "%*s" $padding_length "")

echo -e "\033[38;5;208m$padding$text_art\033[0m"


custom_echo "RO:BIT 17th Myeungjin Lee" "green"
custom_echo "ROS Auto Installer" "green"

loading_animation
source /etc/os-release
ubuntu=$VERSION_ID

cv="Current Version Of Ubuntu Is : ${ubuntu}"
custom_echo "${cv}" "green"

case $ubuntu in
  "18.04")
    custom_echo "ROS melodic available!" "green"
    custom_echo "### ROS Melodic is the twelfth release of the Robot Operating System (ROS). ###" "yellow"
    custom_echo "### It is designed for Ubuntu 18.04 and provides a stable and reliable platform for robotic application development. ###" "yellow"
    custom_echo "### Melodic is widely adopted and offers long-term support (LTS) for developers and users. ###" "yellow"
    ;;
  "20.04")
    custom_echo "ROS noetic, ROS2 foxy available!" "green"
    custom_echo "### ROS Noetic is the thirteenth release of the Robot Operating System (ROS). ###" "yellow"
    custom_echo "### It is intended for Ubuntu 20.04 and brings numerous improvements and new features for robotics development. ###" "yellow"
    custom_echo "### Noetic emphasizes compatibility and provides a solid foundation for building complex robotic systems. ###" "yellow"
    echo " "
    custom_echo "### ROS2 Foxy is the latest major release of the Robot Operating System 2 (ROS2). ###" "yellow"
    custom_echo "### It is designed to work with Ubuntu 20.04 and offers significant advancements in terms of performance, reliability, and flexibility. ###" "yellow"
    custom_echo "### Foxy introduces new capabilities for distributed systems, real-time control, and enhanced security. ###" "yellow"

    ;;
  "22.04")
    custom_echo "ROS humble available!" "green"
    custom_echo "### ROS Humble is an upcoming release of the Robot Operating System (ROS). ###" "yellow"
    custom_echo "### It is being developed for Ubuntu 22.04 and aims to further expand the capabilities of ROS for robotics applications. ###" "yellow"
    custom_echo "### Humble is expected to bring innovative features, improved integration, and enhanced support for diverse robotic platforms. ###" "yellow"
    ;;
  *)
    custom_echo "ROS version not available or out of distro for this Ubuntu version. Might need to upgrade ubuntu" "red"
    exit 1
    ;;
esac