# Useful scripts and configs for WSL

A collection of useful scripts and configs I created for the WSL2 system.

## Usage

1. Start WSL by typing `wsl` from within a Windows shell. For the installation, refer to the [official documentation](https://learn.microsoft.com/en-us/windows/wsl/install).

2. Download this repository. For example:

    ```bash
    cd ~
    sudo apt install wget
    wget https://github.com/bertan-karacora/useful-scripts-and-configs-for-wsl/archive/refs/heads/main.zip
    unzip main.zip
    rm main.zip
    mv useful-scripts-and-configs-for-wsl-main useful-scripts-and-configs-for-wsl
    ```

3. Make sure to give execution permission for setup script using

    ```bash
    cd useful-scripts-and-configs-for-wsl
    chmod +x setup.sh
    ```

4. Run it with sudo.

    ```bash
    sudo ./setup.sh
    ```
