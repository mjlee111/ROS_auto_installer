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
    custom_echo "ROS Melodic available!" "green"
    custom_echo "### ROS Melodic is the twelfth release of the Robot Operating System (ROS). ###" "yellow"
    custom_echo "### It is designed for Ubuntu 18.04 and provides a stable and reliable platform for robotic application development. ###" "yellow"
    custom_echo "### Melodic is widely adopted and offers long-term support (LTS) for developers and users. ###" "yellow"

    read -n 1 -p "Press Enter to start ROS Melodic installation, or any other key to exit..."

    if [[ $REPLY == "" ]]; then
      custom_echo "Installing ROS Melodic" "green"
      loading_animation
      sudo apt install curl
      curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
      sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

      sudo apt update
      sudo apt install ros-melodic-desktop-full

      echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
      source ~/.bashrc
      sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
      sudo rosdep init
      rosdep update

      end_msg="ROS ${ros_version} Installed!"
      custom_echo "${end_msg}" "green"

    else
      custom_echo "Installation Canceled" "red"
    fi
    ;;
  "20.04")
    custom_echo "ROS Noetic, ROS2 Foxy available!" "green"
    custom_echo "### ROS Noetic is the thirteenth release of the Robot Operating System (ROS). ###" "yellow"
    custom_echo "### It is intended for Ubuntu 20.04 and brings numerous improvements and new features for robotics development. ###" "yellow"
    custom_echo "### Noetic emphasizes compatibility and provides a solid foundation for building complex robotic systems. ###" "yellow"
    echo " "
    custom_echo "### ROS2 Foxy is the latest major release of the Robot Operating System 2 (ROS2). ###" "yellow"
    custom_echo "### It is designed to work with Ubuntu 20.04 and offers significant advancements in terms of performance, reliability, and flexibility. ###" "yellow"
    custom_echo "### Foxy introduces new capabilities for distributed systems, real-time control, and enhanced security. ###" "yellow"

    read -n 1 -p "Press Enter to start ROS installation, or any other key to exit..."

    if [[ $REPLY == "" ]]; then
      read -p "Enter the ROS version you want to install (noetic/foxy): " ros_version

      if [[ $ros_version == "noetic" ]]; then
        custom_echo "Installing ROS Noetic" "green"
        loading_animation
        sudo apt install curl
        curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
        sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

        sudo apt update
        sudo apt install ros-noetic-desktop-full

        echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
        source ~/.bashrc
        sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
        sudo rosdep init
        rosdep update
        
        end_msg="ROS ${ros_version} Installed!"
        custom_echo "${end_msg}" "green"

      elif [[ $ros_version == "foxy" ]]; then
        custom_echo "Installing ROS Foxy" "green"
        loading_animation
        sudo apt update
        sudo apt install curl gnupg2 lsb-release
        curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
        sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

        sudo apt update
        sudo apt install ros-foxy-desktop

        echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
        source ~/.bashrc
        sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
        sudo rosdep init
        rosdep update

        
        end_msg="ROS ${ros_version} Installed!"
        custom_echo "${end_msg}" "green"

      else
        custom_echo "Invalid ROS version. Please enter either 'noetic' or 'foxy'." "red"
      fi
    else
      custom_echo "Installation Canceled" "red"
    fi
    ;;
  "22.04")
    custom_echo "ROS Humble available!" "green"
    custom_echo "### ROS Humble is an upcoming release of the Robot Operating System (ROS). ###" "yellow"
    custom_echo "### It is being developed for Ubuntu 22.04 and aims to further expand the capabilities of ROS for robotics applications. ###" "yellow"

    read -n 1 -p "Press Enter to start ROS Humble installation, or any other key to exit..."

    if [[ $REPLY == "" ]]; then
      custom_echo "Installing ROS Humble" "green"
      loading_animation
      sudo apt install curl
      curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
      sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

      sudo apt update
      sudo apt install ros-humble-desktop-full

      echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
      source ~/.bashrc
      sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
      sudo rosdep init
      rosdep update

      end_msg="ROS ${ros_version} Installed!"
      custom_echo "${end_msg}" "green"
      
    else
      custom_echo "Installation Canceled" "red"
    fi
    ;;
  *)
    custom_echo "ROS version not available or out of distribution for this Ubuntu version. You might need to upgrade Ubuntu." "red"
    exit 1
    ;;
esac
