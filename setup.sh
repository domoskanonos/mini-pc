sudo apt update
sudo apt upgrade -y


# Install Google Chrome
if ! command -v google-chrome &> /dev/null; then
    wget -P ~/Downloads/ https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ~/Downloads/google-chrome-stable_current_amd64.deb
else
    echo "Google Chrome ist bereits installiert, wird übersprungen."
fi

# Install SSH Server
if ! systemctl is-active --quiet ssh; then
    sudo apt install -y openssh-server
    sudo systemctl enable ssh
    sudo systemctl start ssh
else
    echo "SSH Server läuft bereits, wird übersprungen."
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


# Podman
sudo apt install -y podman
if ! grep -q 'alias docker=podman' ~/.bashrc; then
    echo "alias docker=podman" >> ~/.bashrc
    echo "Alias 'docker=podman' wurde zu ~/.bashrc hinzugefügt."
else
    echo "Alias 'docker=podman' ist bereits in ~/.bashrc vorhanden."
fi