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


# Docker & Docker Compose
if ! command -v docker &> /dev/null; then
    # Docker GPG Key & Repository hinzufügen
    sudo apt install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    # Aktuellen Benutzer zur docker-Gruppe hinzufügen (kein sudo nötig)
    sudo usermod -aG docker $USER
    echo "Docker wurde installiert. Bitte neu einloggen, damit die Gruppenänderung wirkt."
else
    echo "Docker ist bereits installiert, wird übersprungen."
fi
