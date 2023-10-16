# Useful scripts and configs for WSL

A collection of useful scripts and configs I made for the default WSL system. Since the repeated setup (on each new machine or WSL instance) becomes tedious at some point, I decided to create this collection and automate the most important steps.

Works with default WSL distribution (Ubuntu 22.04). There are some requirements of the Windows host system (e.g. ssh already configured there) which I did not include here.

## Usage

1. Start WSL by typing `wsl` from within a Windows shell. For the installation, refer to the [official documentation](https://learn.microsoft.com/en-us/windows/wsl/install).

2. Download the setup script. Alternatively, you can also copy its content to a new file (mind CRLF conversion!). For example:

```bash
cd ~
sudo apt install wget
wget https://raw.githubusercontent.com/bertan-karacora/useful-script-and-configs-for-wsl/main/setup
```

3. Make sure to give execution permission using

```bash
chmod +x ./setup
```

4. Run it.

```bash
./setup
```
