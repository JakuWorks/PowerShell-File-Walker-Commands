# How this file works is very simple:
# 1. The PowerShell-File-Walker Commands Bundle has settings that change its behaviour
# 2. These settings are stored in variables
# 3. When the PowerShell-File-Walker Commands Bundle is loading, it saves all of its default settings into variables
# 4. After saving the default settings into variables, the PowerShell-File-Walker Commands Bundle will check if a file named "PowerShell-File-Walker-Config.ps1" Exists
# 5. If it exists - the File Walker will run the file
# If you set any variables here that have the same name as some settings THEN YOU CAN OVERRIDE THESE SETTING!
# Example: There is a setting called $script:w6_Boundary_Character_Body
# If you put exactly this line of code in this file:  $script:w6_Boundary_Character_Body = [string] '='
# You will change the body character of the list boundaries to the = equals sign
# TODO MOVE THIS EXPLAINATION SOMEWHERE BETTER AND ADD A LINK TO THE WIKI HERE
