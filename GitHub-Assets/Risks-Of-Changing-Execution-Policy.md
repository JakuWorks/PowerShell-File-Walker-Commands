Here are a few facts:

- The simplified purpose of the execution policies is this: To stop PowerShell scripts from working

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

However this should be really rare. Because why would they use a PowerShell script (which must be a file) to run PowerShell commands? There is a dozen other ways do run PowerShell code ignoring the execution policy. Why would they do that?

### Afterword

Execution policies do not stop malware developers from using PowerShell code. It is pretty easy to work around them. It does not matter for them do you have a `Restricted` or a `Bypass` policy too much.
