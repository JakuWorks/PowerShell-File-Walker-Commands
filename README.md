# Project Summary


## Short Description
A suite of four commands `cda`, `cdf`, `elev`, `unelev` that help with common PowerShell shell tasks

cda - Change Directory Alphabetically
- `cda` - Display a nice list of all directories in your current path
- `cda n` - Go to the n'th directory from the list  

[READ MORE ABOUT CDA](https://github.com/JakuWorks/PowerShell-File-Walker-Commands/blob/main/GitHub-Assets/cda-guide.txt)

cdf - Current Directory File
- `cdf` - Display a nice list of all files and directories in your current path
- `cdf n` - Get the path of the n'th file from the list  

[READ MORE ABOUT CDF](https://github.com/JakuWorks/PowerShell-File-Walker-Commands/blob/main/GitHub-Assets/cdf-guide.txt)

elev - Elevate:
- `elev` - Asks for admin permission and opens a new elevated PowerShell prompt at your current directory  

[READ MORE ABOUT ELEV](https://github.com/JakuWorks/PowerShell-File-Walker-Commands/blob/main/GitHub-Assets/elev-guide.txt)

unelev - Unelevate:
- `unelev` - Opens a new normal PowerShell prompt at your current directory  

[READ MORE ABOUT UNELEV](https://github.com/JakuWorks/PowerShell-File-Walker-Commands/blob/main/GitHub-Assets/unelev-guide.txt)


## Used Languages
- PowerShell (with a few C# imports)


## Learnt Skills
- Basics of programming in PowerShell
- Basics of Windows' inner systems  


## Time
- 2023 - 4 months during and after summer - main working period
- 2025 - 03.03.2025 (1 day) (DD.MM.YYYY) - updating the README, changing a few comments and tiny improvements


## Usage
1. Download the repository (click the green "Code" button; click "Download ZIP")
2. Set execution policy to "Bypass"
```
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
```
[READ ABOUT THE RISKS OF CHANGING THE EXECUTION POLICY](https://github.com/JakuWorks/PowerShell-File-Walker-Commands/blob/main/GitHub-Assets/Risks-Of-Changing-Execution-Policy.md)

3. Run the `PowerShell-File-Walker.ps1` file in your current context. Template:
```
. ./path/to/PowerShell-File-Walker.ps1`
```

You can also use [PowerShell Profiles](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.5) to run the command for you every time you start PowerShell