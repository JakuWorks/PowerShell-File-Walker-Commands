
$${\Large \color{#f0b501}File \space Navigation \color{#3b7ded} \space Made \space Easy }$$

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
  <!-- Todo: Add a wiki link once I create a wiki -->
  <a href="TODO">Installation Guide</a> •
  <a href="https://github.com/JakuWorks/PowerShell-File-Walker-Commands/releases">Releases</a>
</p>

---

# PowerShell-File-Walker Commands Bundle

A set of powerful commands for changing directories written in pure PowerShell Script (with a few C# imports)

The description is W.I.P. but here is a summary:

The `cda` command (without any arguments) will write a simple message somewhat like this:
```
------------>
[1] Folder1
[2] Folder2
<------------
```
If you use the command like this `cda 1` - you will be moved to Folder1.
If you want to - you can chain these: `cda 1,2`
Or you can go in -stick mode that will recursively call the `cda` command and ask you to choose a directory to go there. And you can exit outta stick mode by passing q as your answer

There are also:
- `cdf` - a version of cda but for selecting files (obviously does not support stick mode)
- `wudo` - starts a new Elevated PowerShell Terminal in the same location you are in
- `nudo` - starts a new Not-Elevated PowerShell Terminal

Since there is no fully finished installation guide, you will need knowledge of PowerShell (or a stable WiFi connection) to understand topics touched in this very short installation summary:
1. Download the latest release .zip file  
2. Extract this file from the .zip `PowerShell-File-Walker.ps1`  
3. Here you have 2 options  
  a) Add this file to your PowerShell Profile (loads in about 300ms)  
  b) Manually run the file  
  `psst: you need to run the file IN YOUR SCOPE, so you can actually use the commands. To do that use the '.' dot operator. Example of running the file:` `. "C:\PowerShell-File-Walker.ps1"`
4. If everything worked you should get an introductionary message (it will only display three times)

### Note
This project IS functional if set up correctly.
However is old. It was rushed too. And bad programming practices were applied tp it.
It's state does not reflect my current abilities
