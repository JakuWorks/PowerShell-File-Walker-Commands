<img
  align="center"
  src=".\GitHub-Assets\Banner.webp"
  alt="Banner With 'PowerShell File Walker' Text"
/>

$${\Large \color{White}File \space Navigation \space Made \color{Green} \space Easy }$$

<p align="center">

  <a href="https://github.com/JakuWorks/Powershell-File-Walker/releases">
    <img src="https://img.shields.io/github/v/release/JakuWorks/PowerShell-File-Walker" width="1200" height="250" alt="Latest Release Download" />
  </a>

  <a href="https://github.com/JakuWorks/Powershell-File-Walker/commits/main">
    <img src="https://img.shields.io/github/last-commit/JakuWorks/PowerShell-File-Walker/main" alt="View Latest Commits" />
  </a>

  <a href="https://hanadigital.github.io/grev/?user=jakuworks&repo=powershell-file-walker">
    <img src="https://img.shields.io/github/downloads/JakuWorks/PowerShell-File-Walker/total" alt="View Download Statistics" />
  </a>

  <a href="https://github.com/JakuWorks/Powershell-File-Walker/pulls">
    <img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" alt="View Pull Requests" />
  </a>

  <a href="https://github.com/JakuWorks/Powershell-File-Walker/blob/main/LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-blue" alt="View License File" />
  </a>

</p>

---

The project is functional on a standard Windows 11 PC, but there is ongoing work on the documentation!

Everything will change...

Brief install guide:

1. Download the newest [PowerShell-File-Walker.ps1 release](https://github.com/JakuWorks/Powershell-File-Walker/releases/tag/v1.0.0)
2. Make the `PowerShell-File-Walker.ps1` file run itself every time You launch
   PowerShell. [Tip: Use a PowerShell Profile](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles)
3. That's all! :tada:

# Temporary Functionality

! Read the introduction after applying the script

- 'cda' - Displays a list of current directory's files
- 'cda 1' - Goes to the first item on the list
- 'cda '0,1,2,0,1,8+10,l' '1,2,0,1,1+1,badword' - Support for crazy movements - more on that later.

# Public TODO

## Software

- [x] PowerShell File Walker

## Testing

- [x] Windows 11 PowerShell 5.1 (The Default Windows Version)
- [ ] Windows 11 PowerShell 7.3 (Often named `PowerShell Core`)
- [ ] Windows 10 PowerShell 5.1 (The Default Windows Version)
- [ ] Windows 10 PowerShell 7.3 (Often named `PowerShell Core`)
- [ ] Ubuntu 22.04.2 Desktop
- [ ] MacOs _(I will gladly accept MacOs testers)_

## Documentation

- [ ] README
- [ ] GitHub Wiki

## Other

- [ ] A way of Gathering feedback
- [ ] GitHub Discussions
- [ ] Documentation for Contributors

## Overview Video Notes

- Apply Command `. "$( $PROFILE.CurrentUserAllHosts )\..\PowerShell-File-Walker.ps1"`
