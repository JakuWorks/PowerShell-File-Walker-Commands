Here are a few facts:

- The simplified purpose of the execution policies is this: To stop PowerShell scripts (.ps1 files, etc.) from working

- A PowerShell script is a file that contains PowerShell commands that PowerShell can run.

- PowerShell scripts usually have these extensions: `.ps1` *powershell script*, `.psm1` *powershell module*, `.psd1` *powershell data file*

- Setting the Execution Policy to `Bypass` will allow you to run PowerShell scripts

## Two main dangers of using the Bypass execution policy

### 1. A non-technical user mistakenly running a PowerShell script downloaded from the internet (more common)

Example: a non-technical person receives an e-mail with a virus that is a PowerShell script. They download it and try to run it.

   - If the execution policy was `Restricted` - they couldn't run the virus. Their PC is saved

   - If the execution policy was `Bypass`, they would (unaware of the danger) run the virus and destroy their PC

### 2. A virus that uses a PowerShell script to do its malicious stuff **will not be blocked** (less common)

PowerShell scripts are VERY RARELY used by malware. So if you would get a virus on your PC, then there is a super small chance that virus uses a PowerShell script to do a certain action. The virus itself may not be written in PowerShell entirely, but it may use a PowerShell script to do something.

   - If you had a `Restricted` execution policy - the virus could not do its action

   - If you had a `Bypass` execution policy - the virus would do the action

However this is very rare. On top of that there are many ways to bypass PowerShell's execution policy that a malicious program could exploit. This is why this arguments is very weak

### Afterword

Execution policies do NOT stop malware from using PowerShell commands. They are just a restriction for YOU not to shoot yourself in the foot
