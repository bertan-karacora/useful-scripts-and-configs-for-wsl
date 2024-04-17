# Useful scripts and configs for WSL

A collection of useful scripts and configs I made for the default WSL2 system.

## Usage

1. Start WSL by typing `wsl` from within a Windows shell. For the installation, refer to the [official documentation](https://learn.microsoft.com/en-us/windows/wsl/install).

2. Download the setup script. Alternatively, you can also copy its content to a new file (but mind the CRLF conversion). For example:

    ```bash
    cd ~
    sudo apt install wget
    wget https://raw.githubusercontent.com/bertan-karacora/useful-scripts-and-configs-for-wsl/main/setup.sh
    ```

3. Make sure to give execution permission using

    ```bash
    chmod +x ./setup.sh
    ```

4. Run it.

    ```bash
    ./setup.sh
    ```

5. Cleanup.

    ```bash
    rm ./setup.sh
    ```
