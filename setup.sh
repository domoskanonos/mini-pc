sudo apt update
sudo apt upgrade -y


# Install Google Chrome
if ! command -v google-chrome &> /dev/null; then
    wget -P ~/Downloads/ https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ~/Downloads/google-chrome-stable_current_amd64.deb
else
    echo "Google Chrome ist bereits installiert, wird übersprungen."
fi

# Install SSH Client
if ! command -v ssh &> /dev/null; then
    sudo apt install -y openssh-client
else
    echo "SSH Client ist bereits installiert, wird übersprungen."
fi

# Install Visual Studio Code
if ! command -v git &> /dev/null; then
    sudo apt install -y git
else
    echo "Git ist bereits installiert, wird übersprungen."
fi
git --version
git config --global user.name "Dominik Bruhn"
git config --global user.email "domoskanonos@googlemail.com"
echo "Bitte legen Sie Ihren SSH-Schlüssel (id_ed25519) in ~/.ssh ab, bevor Sie fortfahren."
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
ssh-add ~/.ssh/id_ed25519


#Podmam
sudo apt install -y podman
alias docker=podman