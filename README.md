# Project Summary


## Short Description
A suite of four commands (cda, cdf, elev, unelev) that assist in common PowerShell interactive shell tasks

cda - `change directory alphabetically`:
- `cda` - display a nicely formatted list of all dirs in your cwd
- `cda n` - go to the n'th directory from the list  
[READ MORE ABOUT CDA](https://example.com)

cdf - `current directory file`:
- `cdf` - display a nice formatted list of all files and directories in your cwd
- `cdf n` - get the path of the n'th file from the list
[READ MORE ABOUT CDF](https://example.com)

elev - `elevate`:
- `elev` - asks for admin permission and opens an elevated PowerShell prompt at your current directory
[READ MORE ABOUT ELEV](https://example.com)

unelev - `unelevate`:
- `unelev` - simply opens a non-elevated PowerShell prompt at your current directory
[READ MORE ABOUT UNELEV](https://example.com)


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
[READ ABOUT THE RISKS OF CHANGING THE EXECUTION POLICY](https://example.com)

3. Run the `PowerShell-File-Walker.ps1` file in your current context. Template:
```
. ./path/to/PowerShell-File-Walker.ps1`
```

You can also use [PowerShell Profiles](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.5) to run the command for you every time you start PowerShell