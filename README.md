# Useful scripts and configs for WSL

A collection of useful scripts and configs I made for the default WSL system. Since the repeated setup (on each new machine or WSL instance) becomes tedious at some point, I decided to create this collection and automate the most important steps.

Works with default WSL distribution (Ubuntu 22.04). There are some requirements of the Windows host system (e.g. ssh already configured there) which I did not include here.

## Usage

1. Start WSL by typing `wsl` from within a Windows shell. For the installation, refer to the [official documentation](https://learn.microsoft.com/en-us/windows/wsl/install).

2. Open the [setup script](https://github.com/bertan-karacora/useful-script-and-configs-for-wsl/blob/main/setup) of this repository and copy its contents to your clipboard.

3. Create a new file, name it as you wish (e.g. "setup"), and copy the contents from the setup script into it:

```bash
cd ~
touch setup
powershell.exe Get-Clipboard >> setup
```

4. Make sure to give execution permission using

```bash
chmod +x ./setup
```

5. Run it.

```bash
./setup
```
