<img
  align="center"
  src=".\GitHub-Assets\Banner.webp"
  width="1200"
  height="250"
  alt="Banner With 'PowerShell File Walker' Text"
/>

$${\Large \color{White}File \space Navigation \space Made \color{Green} \space Easy }$$

<p align="center">
  <a href="https://github.com/JakuWorks/Powershell-File-Walker/releases">
    <img
      src="https://img.shields.io/github/v/release/JakuWorks/PowerShell-File-Walker"
      alt="Download Latest Release"
    />
  </a>

  <a href="https://github.com/JakuWorks/Powershell-File-Walker/commits/main">
    <img
      src="https://img.shields.io/github/last-commit/JakuWorks/PowerShell-File-Walker/main"
      alt="View Latest Commits"
    />
  </a>

  <a href="https://hanadigital.github.io/grev/?user=jakuworks&repo=powershell-file-walker">
    <img
      src="https://img.shields.io/github/downloads/JakuWorks/PowerShell-File-Walker/total"
      alt="View Download Statistics"
    />
  </a>

  <a href="https://github.com/JakuWorks/Powershell-File-Walker/pulls">
    <img
      src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg"
      alt="View Pull Requests"
    />
  </a>

  <a href="https://github.com/JakuWorks/Powershell-File-Walker/blob/main/LICENSE">
    <img
      src=".\GitHub-Assets\license-MIT-blue.svg"
      width="78"
      height="20s"
      alt="View License File"
    />
  </a>

  <!-- TODO ADD A MEANINGFUL HREF -->
  <a>
    <img
      src=".\GitHub-Assets\platform-Windows_Linux_MacOS-008080.svg"
      width="194"
      height="20"
      alt="Supported Platforms: Windows, Linux, MacOs"
    />
  </a>
</p>

<p align="center">
  <a href="TODO">W.I.P.</a> •
  <a href="TODO2">W.I.P.</a>
</p>

---

Before proceeding to read the below information please acknowledge.
- The script is currently unstable

---


### A fatal flaw was found in the design choices of the script - the settings are directly inside the script - this means that with every update, the User's settings would have to be manually moved. Luckily there is ongoing work to fix this :tada:.

*The current solution idea*

A brave engineer as stood up to fill the need - the settings will be moved to a separate config.ps1 file *(name may change)* - the User will overwrite the default configuration there - the config.ps1 will be directly loaded with the . *dot* operator, overriding the default configuration included in the main file.

This solution may add just a few ms to the loading time - but no noticeable changes.

A throughout online documentation will be absolutely necessary - the config.ps1 contains the overrides defined by the Users, so it's blank by default.

A GitHub wiki is planned.

---

Everything will change...

# Functionality

- 'cda' - Displays a list of current directory's files
- 'cda 1' - Goes to the first item on the list
- 'cda '0,1,2,0,1,8+10,l' '1,2,0,1,1+1,badword' - Support for crazy movements - more on that later.

# Public TODO

## Software

- [x] PowerShell File Walker Base
- [ ] Fix the script
- [ ] Create a new way for managing settings

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
