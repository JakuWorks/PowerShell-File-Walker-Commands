# --------------------------------> USER ZONE <--------------------------------
# BY USING THIS SOFTWARE, YOU AGREE TO THE MIT LICENSE AT THE END OF THIS FILE.


# This file contains the cda and cdf functions that make changing paths in PowerShell a piece of cake!


# Written by: https://github.com/JakuWorks/
$script:uProductName = [string] 'Powershell-File-Walker'
$script:uCurrentVersion = [string] '1.0.0'

# Suggestions, error reports, reviews, and feedback are really appreciated! This software is for You after all!


# Note: Due to the single-file nature of this product - all the documentation, functionality, licenses are placed in
#       this single file.

# ---------------------------------- SETTINGS ---------------------------------
# Feedback about the default settings configuration is welcome!

# ------------ Basic Settings -----------
$script:uIntroduction_Toggle = [bool] $true
$script:uList_FileAttributes_Toggle = [bool] $true
$script:uList_Colors_Toggle = [bool] $true

$script:uIntroduction_Greeting_CurrentTimeText_Toggle = [bool] $true
$script:uIntroduction_Greeting_CurrentTimeText_Format = [int] '24' # Available options: '24', '12', 'Both'.

$script:uList_NegativeValues_Toggle = [bool] $false
$script:uList_NegativeValues_ShowEveryXthListing = [int] 5
$script:uList_BeforeDisplay_SoftCleanTerminal = [bool] $true
$script:uList_Stick_MoveTerminalAfterCorrectAnswer = [bool] $true
$script:uList_Attributes_FirstDash_Character = [string] '>'
$script:uList_Attributes_ClosingNumberPrefix = [string] ''
$script:uList_Attributes_ClosingNumberSuffix = [string] '' # If You have very long file names or very little screen
# space, to the point, where one file name takes over one terminal line - I recommend setting this setting
# to the ' apostrophe character.

$script:uElev_Default_ExitCurrentTerminal = [bool] $false
$script:uNoElev_Default_ExitCurrentTerminal = [bool] $false

$script:uIntroduction_ScrollUpMessage_DoDisplay = [bool] $true
$script:uIntroduction_DoClearTerminalBeforeIntroduction = [bool] $false # Turning this ON may hide errors that occurred
# during setup.

# From the advanced settings You may be interested in:
#   - Changing the colors for attributes on the cda/cdf lists.
#     For example making the listings with the attribute 'System' be Dark Blue. ( This is already the default
#     behaviour )
#   - Changing the aliases for commands.
#     For example adding an alias for 'noelev' named 'nudo'. ( This is already the default behaviour )


# ---------- Advanced Settings ----------
#
# Note: To further understand the settings, please acknowledge:
#       - this script dynamically makes use of the current terminal window size and changes some of it's text,
#         responses, etc. accordingly
#       - You can pass a negative value as the stick option or to the cda/cdf functions - it will select the item but
#         from the end. e.g. 'cda -1' will select the last value on the list.

#       - The Before Attributes zone refers to for example:
#           [1] SomeFileName
#       - The Attributes zone refers to for example:
#                            >  -  -> System, Readonly
#       - The After Attributes zone refers to for example:
#                                                      [1]
#       - Combined they give:
#           [1] SomeFileName >  -  -> System, Readonly [1]

#       - Do not enter stupid values. Try to avoid decimals, values of an another type than default
#

$script:uAlways_Write_Approximate_Loading_Time = [bool] $false # This itself extends the loading time by a few
# milliseconds.

if ( $script:uAlways_Write_Approximate_Loading_Time ) { $script:uLoadingStartTime = ( Get-Date ) } # Do not mind this line. Counting the approximate loading time starts here.

$script:uList_Attributes_MinCharactersOffset_Right = [int] 30
$script:uList_Attributes_MinCharactersOffset_Left1 = [int] 300 # A high number here ( i.e. 300 ) makes attributes
# stretch to the left as far as they can whilst respecting the offset from the right.
$script:uList_Attributes_MinCharactersOffset_Left2 = [int] 7
$script:uList_Attributes_MinCharactersOffset_Left3 = [int] 3
$script:uList_Attributes_SpacesBetweenDashes = [int] 35
$script:uList_Attributes_Character_Dash = [string] '-'
$script:uList_Attributes_Character_Space = [string] ' '
$script:uList_Attributes_Character_Arrow = [string] '->'
$script:uList_Attributes_ExclusionList = [string[]] @( 'Directory', 'NotContentIndexed', 'ReparsePoint' )
$script:uList_Attributes_PriorityList = [string[]] @( 'System' )
$script:uList_Attributes_FirstDash_SpacesBefore = [int] 4

$script:uList_Attributes_Colors_Default_Priority = [int] 10
$script:uList_Attributes_Colors = [hashtable] @{
    # Note: To get a colorized list with all valid color combinations use 'Write-uColorCombinations' <- Epilepsy warning
    #       The default order is - for each foreground color, all background colors are displayed.
    #       Use '-Swap' to flip the sorting to - For each background color, all foreground colors are displayed.
    #
    # Note: To get a raw list of Available Colors use: 'Write-uColors'.

    # Note: If many match - the one with the __ LOWEST __ priority will be applied.

    # Here is an example of one full entry:
    # 'The attribute name displayed on the list ( Case Does Not Matter )' = @{
    #     'BackgroundColor_Priority' = 1
    #     'BackgroundColor'          = 'Red'
    #     'ForegroundColor_Priority' = 1
    #     'ForegroundColor'          = 'Blue'
    # }
    # Another Example:
    # 'Hidden' = @{
    #     'ForegroundColor_Priority' = 6
    #     'ForegroundColor' = 'DarkGray'
    # }

    'System' = @{
        'ForegroundColor_Priority' = 4
        'ForegroundColor'          = 'Blue'
    }

    'Hidden' = @{
        'ForegroundColor_Priority' = 6
        'ForegroundColor'          = 'DarkGray'
    }

    # Advanced configuration:

    # Attribute Name:
    #  - 'Any' - Will always be applied

    # Color Name:
    #  - 'Default' - You can explicitly use the default color chosen by the console.
}

$script:uList_Stick_BadInput_Sleep_Milliseconds_FirstTime = [int] 1000
$script:uList_Stick_BadInput_Sleep_Milliseconds_NotFirstTime = [int] 300
$script:uList_Stick_BadInput_MaxErrorRetries = [int] 4
$script:uList_Stick_BadInput_FirstTime = [bool] $true # If set to true - the first time an incorrect stick option is
# passed - an alternative message will be displayed.

$script:uList_Character_DisplayList_DoDisplayOnList = [bool] $false # Controls if the 'DisplayList' character will
# itself be displayed on the list.
$script:uList_Character_DisplayList = [string] 'l'
$script:uList_Character_Zero = [string] '0'
$script:uList_Character_ExitStick = [string] 'q'
$script:uList_Character_AccessDenied = [string] '!'
$script:uList_Character_Bracket_BeforeAttributes_Opening = [string] '['
$script:uList_Character_Bracket_BeforeAttributes_Closing = [string] ']'
$script:uList_Character_Bracket_AfterAttributes_Opening = [string] '['
$script:uList_Character_Bracket_AfterAttributes_Closing = [string] ']'

$script:uList_BeforeCounterText_Character_Space = [string] ' '
$script:uList_BeforeCounterText_SpacesIfOneDigit = [int] 3

$script:uList_Title_Processing = [string] 'Processing...'
$script:uList_NegativeValues_Separator = [string] ','
$script:uList_BoundaryArrowBody_RightOffsetMultiplier = [int] 0.3 # The "RightOffset" means the MinCharactersOffset_Right
$script:uList_Input_Padding_Times = [int] 1
$script:uList_Input_MathCharactersToFilter = [string[]] @( '*', '/', '%', '+', '-', '(', ')', '.' ) # These characters
# are filtered during the first cda/cdf/stick call. If any of these characters is a powershell command/alias, then it's
# removed from the list. E.x. '%' is an alias for ForEach-Object by default, so it's removed from the list later on.

$script:uIntroduction_Greeting_StartHour_Morning = [int] 5
$script:uIntroduction_Greeting_StartHour_Afternoon = [int] 12
$script:uIntroduction_Greeting_StartHour_Evening = [int] 17
$script:uIntroduction_Greeting_Text_Morning = [string] 'Good Morning'
$script:uIntroduction_Greeting_Text_Afternoon = [string] 'Good Afternoon'
$script:uIntroduction_Greeting_Text_Evening = [string] 'Good Evening'
$script:uIntroduction_Greeting_Text_Fallback = [string] 'Greetings'
$script:uIntroduction_Greeting_Text_Symbol = [String ]'!'

$script:uBoundary_Character_Body = [string] '-'
$script:uBoundary_Character_RightTip = [string] '>'
$script:uBoundary_Character_LeftTip = [string] '<'
$script:uBoundary_Length_Full = [int] 1 # Changing this multiplier affects every other Length by default
$script:uBoundary_Length_Max = [int] 1 # Same as full, but doesn't affect other other Lengths
$script:uBoundary_Length_Long = [int] 0.95
$script:uBoundary_Length_Medium = [int] 0.65
$script:uBoundary_Length_Short = [int] 0.45

$script:uIntroduction_ScrollUpMessage_NewlinesAbove = [int] 5

$script:uTaskbarFlashing_OneFlashDurationMilliseconds = [int] 1500
$script:uTaskbarFlashing_FlashTimes = [int] 100

$script:uElev_NewTerminalTitle = [string] 'Windows PowerShell'
$script:uNoElev_NewTerminalTitle = [string] 'Windows PowerShell'
$script:uNoElev_ScheduledTaskName_DeleteMePrefix = [string] '(DELETE ME)'
$script:uNoElev_WindowsTerminalProcessName = [string] 'WindowsTerminal'

$script:uSetOperatingPath_DefaultSilent_IfUsedBy_Script = [bool] $true
$script:uSetOperatingPath_DefaultSilent_IfUsedBy_User = [bool] $false

$script:uCdaLikeInputCharactersPattern_SeparatorCharacter = [string] ','

$script:uGet_Color_Combinations_Characters_PaddingToMiddle = [string] ' '

# A big amount of aliases can noticeably decrease the loading times - some options are commented out.
$script:uAliases_cda = [string[]] @(
    'Set-DirectoryAlphabetically'
)

$script:uAliases_cdf = [string[]] @(
    'Get-CurrentDirectoryFile'
)

$script:uAliases_elev = [string[]] @(
    # 'Elevate'
    # 'ElevateTerminal'
    # 'ElevatePowerShellTerminal'
    # 'OpenElevatedTerminal'
    # 'OpenElevatedPowerShellTerminal'

    # 'Elevate-Terminal'
    # 'Elevate-PowerShellTerminal'
    # 'Open-ElevatedTerminal'
    'Open-ElevatedPowerShellTerminal'

    # 'wsudo' # Short for 'Windows Sudo'
    # 'wudo'
    'sudo' # The 'elev' command works only on Windows machines, therefore - this alias won't overwrite
    #        the built-in 'sudo' command in Unix systems ( Linux, MacOS, etc. ).
)

$script:uAliases_noelev = [string[]] @(
    # 'Unelevate'

    # 'UnelevateTerminal'
    # 'UnelevatePowerShellTerminal'
    # 'OpenUnelevatedTerminal'
    # 'OpenUnelevatedPowerShellTerminal'

    # 'Unelevate-Terminal'
    # 'Unelevate-PowerShellTerminal'
    # 'Open-UnelevatedTerminal'
    'Open-UnelevatedPowerShellTerminal'

    'unsudo'
    # 'usudo'
    # 'uudo'
    # 'udo'

    # 'unwudo'
    # 'uwudo'

    # 'nowudo'
    # 'nwudo'

    # 'unwsudo'
    # 'uwsudo'

    # 'nowsudo'
    # 'nwsudo'

    # 'nosudo'
    # 'nsudo'
    'nudo'
)

# Indentation for messages.
$s1 = [string] ' '
$s2 = [string] '  '
$s3 = [string] '   '
$s4 = [string] '      '
$s5 = [string] '        '
$s6 = [string] '          '

# ---------------------------------> DEV ZONE <--------------------------------

# IMPORTANT NOTE: The license is at the end of the file. It's MIT.
#
#                 I'd appreciate a notice of the The Original Project
#                 in Your edit/fork READMEs - https://github.com/JakuWorks/PowerShell-Directory-Walker
#                 I'm no lawyer, so make sure the MIT doesn't require that as well.

# Note: Most script-scope variable/function names are prefixed, not to risk the user overriding them/using them by
#       mistake. Most helper functions from this script were not designed to be reusable outside this script, so they
#       are also prefixed.

# Note: In many cases, $false, $null, and any other negative values were replaced with $script:uSentinelValue_String,
#       because it's easier to compare and evaluate a sentinel string than a $null.

# Note: If You wish to edit this code while keeping its length style - The Rulers/Line Length Guides are:
#       - after 79'th character - section headers
#       - after 120'th character - everything else.
#       There are a few places where the limit was ignored to enhance readability.

# Note: Since You can clearly see that the cade has almost every bracket separated by a space, and all functions
#       have a 'u' prefix after the dash - here are some useful RegExes to help find overlooks:

#       - Find Bad () brackets -  (?:(?<! |\(|\n)\))|(?:\((?! |\)|\n))

#       - Find Bad {} brackets -  (?:(?<! |\(|\n)\})|(?:\{(?! |\)|\n))

#       - Find Bad [] brackets -  (?:(?:\[ )|(?: \]))

#       - Find Functions without 'u' - (?:function \w+-[^u]\w*)

#       - Find script-scope variables without 'u' - (?:\$script:[^u]\w*)

#       - Find script-scope variables that were referenced without '$script:' (Some code editors might not support
#         this regex) - Use RegExr! When a script-scope variable was defined with '$script:' but later the variable
#         was referenced without '$script:' - the bad reference should be matched by this regex.
#         I also recommend testing it - \$(?!script:)(\w+(?!\w))(?<=\$script:\1[\S\s]*)

# Tool: There are lots of settings - use this. You may find the code You want by doing Ctrl+F on a setting that may be
#       used by the code You're looking for.
#       e.x. To find where the 'Default' abstract color is handled - You may
#       simply Ctrl+F on $script:uList_Attributes_Colors_Name_DefaultColor.

# Improvement Ideas - these are ideas - feedback is needed - some of these might actually decrease the value
#                     of this product:

#       - Use lists instead of arrays when applicable to improve performance

#       - Use hash tables where applicable to improve performance

#       - Format the code to better fit the PowerShell script style

#       - Further break down the parts of larger functions into smaller 'tools'

#       - Support attribute colors for the Zero on the files list.

#       - Support multiple attribute combinations in attribute colors.
#         For example:
#            $TheColorsSetting = @{
#                'Hidden, System' = @{  # <---- LOOK HERE
#                    'ForegroundColor_Priority' = 1
#                    'ForegroundColor'          = 'DarkBlue'
#                }
#                 'System'         = @{
#                    'ForegroundColor_Priority' = 2
#                    'ForegroundColor'          = 'Blue'
#                }
#                 'Hidden'         = @{
#                    'ForegroundColor_Priority' = 3
#                    'ForegroundColor'          = 'DarkGray'
#                }
#            }

#       - A setting to enable deeper zero listings in cda. For example:
#          [0] C:/Current/Working/Directory
#         [0a] C:/Current/Working
#         [0b] C:/Current
#         [0c] C:/

#       - A way to search/ fuzzy search by name in cda/cdf.
#           _This would be really rewarding - Who wouldn't want this feature? - but troublesome to implement correctly._
#             Tl;DR - Unless this product is going to be viral, and this feature will be requested - implementing
#                      this feature would consume a lot of time, and require to undo many design choices.
#                      It lays in the "High Effort, High Reward" category.
#           Brainstorm:
#             - Cross-Platform? - Not all consoles may support 'undoing' line writes.
#               The "`r" and "`b" may be useful. There are also .NET functions to change the cursor position.
#               But then there's also a need to undo line breaks.
#             - Time and effort? - The script was not created with an idea of searching through the list. It would
#               probably require huge a amount of time to 'undo' all the design choices.
#             - If this was ever implemented - the vision is that the list would update during typing. Maybe storing
#               the list lines variable for later use ( instead of just writing it ). Maybe using a variable that has
#               a list of the original non formatted current directory children result - filtering through that list -
#               saving the indexes of the matched items from the list - writing the lines of the __ formatted list __
#               that have the same index as the matched items from the unformatted list.
#               Then some computer wizardry function that will simply write the list in the same place, and delete
#               the previous one - put these lines in, and that's all the job for writing.
#             - How would the input be supported? An input box below the list that ( with some wizardry ) would update
#               the list every time something is written - would require tremendous care to optimize such a thing.
#             - Ok but what about selecting the file? I have no idea.
#               Maybe using the Up and Down arrows, and Enter.
#               Maybe the user would write the name until only one result is left. Fuzzy name searching would be pretty
#               neat here, because it does not require to write the entire name to select between 'MyLongFileName_1' and
#               'MyLongFileName_2'.
#
#       - Simplify The Installation - the vision is to be able to install this product with a PowerShell command, while
#         keeping the ease of configuration and portability. A PowerShell module might be the solution if We do it
#         correctly.
#
#       - Convert the script to a powershell module
#          Current User Feedback:
#           - None
#          Notes:
#             - This would destroy the single-file nature of this product.
#             - Maybe make two versions - single-file and module.
#             - The installation would be easier ( simply use 'Install-Module' )
#             - The configuration would be harder to learn, and less portable compared to one file. Instead of just
#               changing a variable in a dedicated zone __in one file__, You'd have to learn where is the configuration
#               file, and use a new format ( JSON )
#             - The code would be cleaner ( probably ) because 'splitting' the code into small modules would force
#               the functions to be more reusable, and 'detached' ( less global variables ) . This is harder when using
#               a single file.
#          Would Require:
#             - Handling settings with a JSON file and verifying it with a JSON schema.
#               Note: Most users of this product probably understand how to edit JSONs.
#             - Moving all documentation to GitHub since accessing this single file would become harder.
#             - Splitting the script into smaller modules - since a PowerShell module is no longer a single file - it
#               would be beneficial to use the new 'space'.
#               Splitting into smaller modules would force Us to write better, more portable, maintainable code.

# ------------------------------ HELPER FUNCTIONS -----------------------------


function Get-uValueOrFallback {
    param(
        [Parameter( Mandatory = $false )] [Object] $ToReturn,
        [Parameter( Mandatory = $false )] [Object] $Fallback,
        [Parameter( Mandatory = $false )] [Object] $BlacklistOneItem = $script:uSentinelValue_String2,
        [Parameter( Mandatory = $false )] [Object] $BlacklistMultipleItems = $script:uSentinelValue_String2,
        [Parameter( Mandatory = $false )] [Object] $PrependIfCorrect = '',
        [Parameter( Mandatory = $false )] [Object] $AppendIfCorrect = '',
        [Parameter( Mandatory = $false )] [Object] $AppendAfterComparison = '',
        [Parameter( Mandatory = $false )] [Object] $PrependAfterComparison = '',
        [Switch] $IsMultiInputBlacklistOneItem
    )

    $isToReturnEqualToBlacklist = ( ( $script:uSentinelValue_String2 -ne $BlacklistOneItem ) `
            -and ( ( $ToReturn -eq $BlacklistOneItem ) `
                -or ( Get-uIsEqualByCompareObject -ItemOne $ToReturn -ItemTwo $BlacklistOneItem ) ) )

    $isToReturnInBlacklist = ( ( $script:uSentinelValue_String2 -ne $BlacklistMultipleItems ) `
            -and ( ( $toReturn -in $BlacklistMultipleItems ) ) )

    if ( $isToReturnEqualToBlacklist -or $isToReturnInBlacklist ) {
        $toReturnRaw = "$( $Fallback )"
    }
    else {
        $toReturnRaw = "$( $PrependIfCorrect )$( $ToReturn )$( $AppendIfCorrect )"
    }

    return "$( $PrependAfterComparison )$( $toReturnRaw )$( $AppendAfterComparison )"
}


function Get-uKernelName {
    try {
        return ( uname --kernel-name )
    }
    catch {
        return $script:uSentinelValue_String
    }
    # Improvement idea: Be more explicit with error catching here.
}


function Get-uUnixOSType {
    param(
        [Parameter( Mandatory = $false )] [String] $KernelName = $script:uSentinelValue_String
    )

    try {
        if ( $script:uSentinelValue_String -eq $KernelName ) {
            return $script:uSentinelValue_String
        }

        $KernelName = $KernelName.ToLower().Trim()

        if ( $KernelName -match 'linux' ) {
            return $script:uOSType_Return_Linux
        }

        if ( $KernelName -match 'darwin' ) {
            return $script:uOSType_Return_MaxOS
        }

        return $script:uSentinelValue_String
    }
    catch {
        return $script:uSentinelValue_String
    }
    # Improvement idea: Be more explicit with error catching here.

}


function Get-uOSType {

    try {
        $OSType = ( [System.Environment]::OSVersion.Platform )

        if ( $OSType -eq 'Win32NT' ) {
            return $script:uOSType_Return_Windows
        }

        if ( $OSType -eq 'Unix' ) {
            return Get-uUnixOSType -KernelName ( Get-uKernelName )
        }

        return $script:uSentinelValue_String
    }
    catch {
        return $script:uSentinelValue_String
    }
    # Improvement idea: Be more explicit with error catching here.

}


function Set-uNewWindowSizeVariables {
    $script:uRawUIWindowSize = ( $host.UI.RawUI.WindowSize )
    $script:uWindow_Height = ( [Math]::Floor( $script:uRawUIWindowSize.Height + 0.5 ) )
    $script:uWindow_Width = ( [Math]::Floor( $script:uRawUIWindowSize.Width + 0.5 ) )
}


function ConvertTo-uDoubleDirectly {
    param(
        [Parameter( Mandatory = $true )] [ref] $ValueReference
    )

    try {
        $ValueReference.Value = ( [double] ( $ValueReference.Value ) )
        return $true
    }
    catch {
        return $false
    }
}


function ConvertTo-uStringDirectly {
    param(
        [Parameter( Mandatory = $true )] [ref] $ValueReference
    )

    try {
        $ValueReference.Value = ( [String] ( $ValueReference.Value ) )
        return $true
    }
    catch {
        return $false
    }
}


function Write-uHostIfIsNotAnEmptyString {
    param(
        [Parameter( Mandatory = $false )] [Object] $Message
    )

    if ( ( $script:uSentinelValue_String -ne $Message ) `
            -and ( ConvertTo-uStringDirectly -ValueReference ( [ref] $Message ) ) `
            -and ( '' -ne $Message ) ) {
        Write-Host $Message
    }
}


function Debug-uGetErrorObject {
    try {
        1 / 0
    }
    catch {
        return $_
    }
}


function Get-uIsEqualByCompareObject {
    param(
        [Parameter( Mandatory = $false )] [Object] $ItemOne,
        [Parameter( Mandatory = $false )] [Object] $ItemTwo
    )

    $negativeValues = @( $script:uSentinelValue_String, $script:uSentinelValue_Int32,
        $script:uSentinelValue_Scriptblock, '', $null )

    $itemOne_IsNull = ( $ItemOne -in $negativeValues )
    $itemTwo_IsNull = ( $ItemTwo -in $negativeValues )

    if ( $itemOne_IsNull -and $itemTwo_IsNull ) {
        return $true
    }
    elseif ( $itemOne_IsNull -or $itemTwo_IsNull ) {
        return $false
    }

    $comparison = ( Compare-Object -ReferenceObject $ItemOne -DifferenceObject $ItemTwo )

    if ( $null -eq $comparison ) {
        return $true
    }
    return $false
}


function Write-uShortErrorCatchMessage {
    param(
        [Parameter( Mandatory = $false )] [String] $Introduction = $script:uSentinelValue_String,

        [Parameter( Mandatory = $false, ParameterSetName = 'ErrorObject' )] [Object] $ErrorObject = $script:uSentinelValue_String,

        [Parameter( Mandatory = $false, ParameterSetName = 'CustomDetails' )] [Object] $CustomExceptionMessage = $script:uSentinelValue_String,
        [Parameter( Mandatory = $false, ParameterSetName = 'CustomDetails' )] [Object] $CustomExceptionLine = $script:uSentinelValue_Int32,
        [Parameter( Mandatory = $false, ParameterSetName = 'CustomDetails' )] [Switch] $NoErrorDetails,

        [Parameter( Mandatory = $false )] [String] $ExceptionMessageIntroduction = '  Exception Message: ',
        [Parameter( Mandatory = $false )] [String] $ExceptionLineIntroduction = 'Exception Line: '
    )

    $commonBadArgumentValues = @( $null, $script:uSentinelValue_String, $script:uSentinelValue_Int32, '' )

    $Introduction = ( Get-uValueOrFallback `
            -ToReturn $Introduction `
            -Fallback 'An Exception Has Been Caught!' `
            -BlacklistMultipleItems $commonBadArgumentValues )

    if ( $NoErrorDetails ) {
        Write-Host ''
        Write-Host $Introduction
        Write-Host ''

        return
    }

    $ExceptionMessage = ( Get-uValueOrFallback `
            -ToReturn $CustomExceptionMessage `
            -Fallback ( $ErrorObject.Exception.Message ) `
            -BlacklistMultipleItems $commonBadArgumentValues )

    $ExceptionMessage = ( Get-uValueOrFallback `
            -ToReturn $ExceptionMessage `
            -Fallback '' `
            -PrependIfCorrect $ExceptionMessageIntroduction `
            -BlacklistMultipleItems $commonBadArgumentValues )

    $ExceptionLineMessage = ( Get-uValueOrFallback `
            -ToReturn $CustomExceptionLine `
            -Fallback ( $ErrorObject.InvocationInfo.ScriptLineNumber ) `
            -BlacklistMultipleItems $commonBadArgumentValues )

    $ExceptionLineMessage = ( Get-uValueOrFallback `
            -ToReturn $ExceptionLineMessage `
            -Fallback '' `
            -PrependIfCorrect $ExceptionLineIntroduction `
            -BlacklistMultipleItems $commonBadArgumentValues )

    Write-Host ''
    Write-Host $Introduction
    Write-uHostIfIsNotAnEmptyString -Message $ExceptionMessage
    Write-uHostIfIsNotAnEmptyString -Message $ExceptionLineMessage
    Write-Host ''
}


function Get-uPathWithAddedBackslashIfNecessary {
    param(
        [Parameter( Mandatory = $true )] [Object] $Path
    )

    if ( ( [System.Text.RegularExpressions.Regex]::Matches( $Path, '\\|/' ).Count ) -eq 0 ) {
        return "$Path\"
    }
    return "$Path"
}


function Get-uUniversalPath {
    param(
        [Parameter( Mandatory = $false )] [String] $Path = $script:uSentinelValue_String
    )

    if ( $Path | Select-String -Pattern $script:uSentinelValue_String -SimpleMatch ) {
        return $script:uSentinelValue_String
    }

    $Path = "$Path".Trim()

    if ( 0 -eq "$Path".Length ) {
        return $script:uSentinelValue_String
    }

    $Path = ( Get-uPathWithAddedBackslashIfNecessary -Path $Path )

    try {
        return ( ( ( Convert-Path -Path $Path -ErrorAction Stop ) -replace '\\\\', '\' ) -replace '\/\/', '/' )
    }
    catch {
        return $script:uSentinelValue_String
    }

    return $script:uSentinelValue_String
}


function Set-uOperatingPathIfValid {
    param(
        [Parameter( Mandatory = $false )] [String] $Path = $script:uSentinelValue_String,
        [Switch] $Silent = $script:uSetOperatingPath_DefaultSilent_IfUsedBy_User
    )

    $universalFailureIntroduction = "Failed to set the Operating Path to '$Path'"

    function Write-uShortCustomFailureMessageIfNotSilent {
        param(
            [Parameter( Mandatory = $true )] [String] $CustomExceptionMessage
        )

        if ( -not $Silent ) {
            Write-uShortErrorCatchMessage `
                -Introduction $universalFailureIntroduction `
                -CustomExceptionMessage:$CustomExceptionMessage
        }
    }

    try {
        if ( $script:uSentinelValue_String -eq $Path ) {
            Write-uShortCustomFailureMessageIfNotSilent -CustomExceptionMessage 'No Path Received!'
            return
        }

        $pathUniversal = ( Get-uUniversalPath -Path $Path )

        if ( -not ( Test-Path -Path $pathUniversal -PathType Container -ErrorAction Stop ) ) {
            Write-uShortCustomFailureMessageIfNotSilent -CustomExceptionMessage 'The passed Path is not a valid Folder!'
            return
        }

        $script:uOperatingPath = $pathUniversal

        if ( -not $Silent ) {
            Write-Host ''
            Write-Host "Successfully set the Operating Path to '$pathUniversal'"
            Write-Host ''
        }

        return
    }
    catch {
        Write-uShortErrorCatchMessage -Introduction $universalFailureIntroduction -ErrorObject $_
    }
}


function Get-uWindowsIsUserAdmin {
    try {
        $currentUser = ( [System.Security.Principal.WindowsIdentity]::GetCurrent() )
        $windowsPrincipal = ( New-Object System.Security.Principal.WindowsPrincipal( $currentUser ) )
        return ( $windowsPrincipal.IsInRole( [System.Security.Principal.WindowsBuiltInRole]::Administrator ) )
    }
    catch {
        return $script:uSentinelValue_String
    }
    # Improvement idea: Be more explicit with error catching here.
}


# ------------------ Globals, Constants & Developer Settings ------------------

$script:uOSType_Return_Windows = 'Windows'
$script:uOSType_Return_Linux = 'Linux'
$script:uOSType_Return_MacOS = 'MacOS'
$script:uOSType_Return_Unknown = 'Unknown'

$script:uSentinelValue_String = [String] '_1_SENTINEL_VALUE_1_wP7,2.@yu~ B>4''CT""RW\4`eid[$ir(];I-\ }NK<mFfl""""6UWapsNgbO3VQ~ } )D-*Pqd%3@"L )K$Ga,RZv`c''''ASh M1x { L!GYjx5|2zgzY+8s''+?]el";IM#( S%B<HD 1?C/""""9{ E.QfJ7n[Uk^q8p|u0XH&F=b!''*_/65r0yAkJVm&jtwc9o=tX Zo''#_:nOh:^Ev_1_SENTINEL_VALUE_1_'
$script:uSentinelValue_String2 = [String] '_2_SENTINEL_VALUE_2_DefZ''P"&F"S!v>s6J~fvZM''k~.92c|!C<~@t6Fwz\Re3U~4^$4RJ@#p%",`E$H2mNJyIbo6""""/U*nfp5W?`9m%/UL/e"^C\/''''&`V*Mr;$zDPn''L/8*:9P""q*Gc;$|#&( 8p7Wk&M )9\Bic%-#H!aC@=T4F_n"""fE*j5S }P=DEFnUA]C{ 8L]Y$^CQ_2_SENTINEL_VALUE_2_'
$script:uSentinelValue_Int32 = [int32] 1986515346 # This cannot be larger than 2^31-1
$script:uSentinelValue_Scriptblock = [scriptblock] { $null = $script:uSentinelValue_String }

$script:uBoundary_Direction_Name_Left = 'Left'
$script:uBoundary_Direction_Name_Right = 'Right'

$script:uList_Attributes_Colors_Default_Priority = ( [double] $script:uList_Attributes_Colors_Default_Priority )

$script:uList_Attributes_Colors_ValidColors = ( [enum]::GetNames( [System.ConsoleColor] ) )
$script:uList_Attributes_Colors_Name_BackgroundColor = 'BackgroundColor'
$script:uList_Attributes_Colors_Name_BackgroundColor_Priority = 'BackgroundColor_Priority'
$script:uList_Attributes_Colors_Name_ForegroundColor = 'ForegroundColor'
$script:uList_Attributes_Colors_Name_ForegroundColor_Priority = 'ForegroundColor_Priority'
$script:uList_Attributes_Colors_Name_DefaultColor = 'Default'
$script:uList_Attributes_Colors_Name_Any = 'Any'

$script:uList_Raw_Names_Line = 'Line'
$script:uList_Raw_Names_Colors = 'Colors'

$script:uIntroduction_Greeting_CurrentTimeText_Name_Both = 'both'
$script:uIntroduction_Greeting_CurrentTimeText_Name_24 = '24'
$script:uIntroduction_Greeting_CurrentTimeText_Name_12 = '12'


$script:uUnixEpochDate = ( Get-Date -Year 1970 -Month 1 -Day 1 -Hour 0 -Minute 0 -Second 0 )
$script:uTime_Format_24 = 'HH:mm'

$script:uCurrentOSType = ( Get-uOSType )

$script:uIsWindows = ( $script:uOSType_Return_Windows -eq $script:uCurrentOSType )

$script:uLastWindowTitle = $script:uSentinelValue_String

if ( $script:uIsWindows ) {
    $script:uWindowsTerminalIsAdmin = ( Get-uWindowsIsUserAdmin )

    # If possible - keep Your class imports here for organization

    Add-Type -TypeDefinition @'
    // Modified from this source:
    // https://learn-powershell.net/2013/08/26/make-a-window-flash-in-taskbar-using-powershell-and-pinvoke/

    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Runtime.InteropServices;

    public class uTaskbarFlasher
    {
        [StructLayout( LayoutKind.Sequential )]
        public struct FLASHWINFO
        {
            public UInt32 cbSize;
            public IntPtr hwnd;
            public UInt32 dwFlags;
            public UInt32 uCount;
            public UInt32 dwTimeout;
        }

        //Flags:

            // Stop flashing. The system restores the window to its original state.
        const UInt32 FLASHW_STOP = 0;

            // Flash the window caption.
        const UInt32 FLASHW_CAPTION = 1;

            // Flash the taskbar button.
        const UInt32 FLASHW_TRAY = 2;

            // Flash both the window caption and taskbar button.
            // This is equivalent to setting the FLASHW_CAPTION | FLASHW_TRAY flags.
        const UInt32 FLASHW_ALL = 3;

            // Flash continuously, until the FLASHW_STOP flag is set.
        const UInt32 FLASHW_TIMER = 4;

            // Flash continuously until the window comes to the foreground.
        const UInt32 FLASHW_TIMERNOFG = 12;

        [DllImport( "kernel32.dll" )]
        public static extern IntPtr GetConsoleWindow();

        [DllImport( "user32.dll" )]
        [return: MarshalAs( UnmanagedType.Bool )]
        private static extern bool FlashWindowEx( ref FLASHWINFO pwfi );

        public static bool FlashWindow( IntPtr handle, UInt32 timeout, UInt32 count )
        {
            IntPtr hWnd = handle;
            FLASHWINFO fInfo = new FLASHWINFO();

            fInfo.cbSize = Convert.ToUInt32( Marshal.SizeOf( fInfo ) );
            fInfo.hwnd = hWnd;
            fInfo.dwFlags = FLASHW_ALL | FLASHW_TIMERNOFG;
            fInfo.uCount = count;
            fInfo.dwTimeout = timeout;

            return FlashWindowEx( ref fInfo );
        }

    }
'@

}

$script:f = ''

$script:uOperatingPath = $script:uSentinelValue_String
Set-uOperatingPathIfValid `
    -Path '.\' `
    -Silent:$script:uSetOperatingPath_DefaultSilent_IfUsedBy_Script

$script:uWhichByAlphabet = $script:uSentinelValue_String

$script:uRawUIWindowSize = $script:uSentinelValue_String
$script:uWindow_Height = $script:uSentinelValue_String
$script:uWindow_Width = $script:uSentinelValue_String
Set-uNewWindowSizeVariables

$script:uBoundary_Character_RightTip_Length = $script:uBoundary_Character_RightTip.Length
$script:uBoundary_Character_LeftTip_Length = $script:uBoundary_Character_LeftTip.Length

try {
    $script:uIntroduction_Greeting_CurrentTimeText_Format = ( [String] $script:uIntroduction_Greeting_CurrentTimeText_Format ).ToLower()
}
catch {
    $script:uIntroduction_Greeting_CurrentTimeText_Format = $script:uIntroduction_Greeting_CurrentTimeText_Name_Both
}
# Improvement idea: Be more explicit with error catching here.

if ( ( $script:uIntroduction_Greeting_CurrentTimeText_Format -ne $script:uIntroduction_Greeting_CurrentTimeText_Name_Both ) `
        -and ( $script:uIntroduction_Greeting_CurrentTimeText_Format -ne $script:uIntroduction_Greeting_CurrentTimeText_Name_24 ) `
        -and ( $script:uIntroduction_Greeting_CurrentTimeText_Format -ne $script:uIntroduction_Greeting_CurrentTimeText_Name_12 ) ) {
    $script:uIntroduction_Greeting_CurrentTimeText_Format = $script:uIntroduction_Greeting_CurrentTimeText_Name_Both
}

if ( $script:uList_NegativeValues_ShowEveryXthListing -le 0 ) {
    $script:uList_NegativeValues_ShowEveryXthListing = 1
}

$script:uCdaLikeInputCharacters_Filtered = $script:uSentinelValue_String # Lazy Loaded due to performance

$script:uGetUniversalPath_AllowedEndCharacters = @( '/', '\' )
$script:uGetUniversalPath_DefaultEndCharacter = '\'

$script:uSystemIOAllDefaultFileAttributes = @( [Enum]::GetValues( [System.IO.FileAttributes] ) )


# ----------------------------- HELPER FUNCTIONS 2 ----------------------------


function Get-uPaddedTextToConsoleMiddle {
    param(
        [Parameter( Mandatory = $false )] [String] $Text = '',
        [Parameter( Mandatory = $false )] [String] $Padding = ' ',
        [Parameter( Mandatory = $false )] [String] $Prepend = '',
        [Parameter( Mandatory = $false )] [String] $Append = ''
    )

    Set-uNewWindowSizeVariables

    $nonPaddingLength = $Prepend.Length + $text.Length + $Append.Length
    $neededPaddingTotal = ( $script:uWindow_Width - $nonPaddingLength ) / $Padding.Length
    $neededPaddingEven = $neededPaddingTotal / 2

    $paddingLeftAmount = [Math]::Max( [Math]::Ceiling( $neededPaddingEven ), 1 )
    $paddingRightAmount = [Math]::Max( [Math]::Floor( $neededPaddingEven ), 1 )

    $paddingLeft = $Padding * $paddingLeftAmount
    $paddingRight = $Padding * $paddingRightAmount

    return "$( $Prepend )$( $paddingLeft )$( $Text )$( $paddingRight )$( $Append )"
}


function Write-uColorCombination {
    param(
        [Parameter( Mandatory = $true )] [Object] $BackgroundColor,
        [Parameter( Mandatory = $true )] [Object] $ForegroundColor,
        [Parameter( Mandatory = $false )] [Object] $CustomText = $script:uSentinelValue_String,
        [Switch] $Swap
    )

    if ( $Swap ) {
        $BackgroundColor, $ForegroundColor = $ForegroundColor, $BackgroundColor
    }

    if ( $script:uSentinelValue_String -eq $CustomText ) {
        $textRaw = "This is $ForegroundColor Text on a $BackgroundColor Background."
    }
    else {
        $textRaw = $CustomText
    }

    $text = ( Get-uPaddedTextToConsoleMiddle `
            -Text $textRaw `
            -Padding $script:uGet_Color_Combinations_Characters_PaddingToMiddle )

    Write-Host `
        -Object $text `
        -BackgroundColor $BackgroundColor `
        -ForegroundColor $ForegroundColor

    return
}


function Write-uColorCombinations {
    param(
        [Parameter( Mandatory = $false )] [Object] $CustomText = $script:uSentinelValue_String,
        [Switch] $Swap
    )

    Write-Host ''

    foreach ( $foregroundColor in $script:uList_Attributes_Colors_ValidColors ) {
        foreach ( $backgroundColor in $script:uList_Attributes_Colors_ValidColors ) {

            Write-uColorCombination `
                -CustomText:$CustomText `
                -BackgroundColor $backgroundColor `
                -ForegroundColor $foregroundColor `
                -Swap:$Swap `

        }
        Write-Host ''
    }
}


function Write-uColors {
    Write-Host ''
    Write-Host $script:uList_Attributes_Colors_ValidColors -Separator "`n"
    Write-Host ''
}


function Get-uFlattenedArray {
    param(
        [Parameter( Mandatory = $false )] [Object] $Array = $script:uSentinelValue_String
    )

    $flattenedArray = @()

    foreach ( $item in $Array ) {
        if ( $item -is [array] ) {
            $flattenedArray += ( Get-uFlattenedArray -Array $item )
        }
        else {
            $flattenedArray += $item
        }
    }

    return $flattenedArray
}


function Set-uAliasBulk {
    param(
        [Parameter( Mandatory = $true )] $Value,
        [Parameter( Mandatory = $true )] $Aliases,
        [Parameter( Mandatory = $false )] $Scope = 'Script'
    )

    foreach ( $alias in $Aliases ) {
        New-Alias -Value $Value -Name $alias -Scope $Scope -Force
    }
}


function Get-uBoundary {
    param(
        [Parameter( Mandatory = $true )] [String] $Direction,
        [Parameter( Mandatory = $false, ParameterSetName = 'LengthMultiplier' )] [int] `
            $LengthMultiplier = $script:uSentinelValue_Int32,
        [Parameter( Mandatory = $true, ParameterSetName = 'RawLength' )] [int] $RawLength = $script:uSentinelValue_Int32
    )

    Set-uNewWindowSizeVariables
    $RawLength = ( [Math]::Max( 1, $RawLength ) )
    $isRightDirection = ( $Direction -eq $script:uBoundary_Direction_Name_Right )
    $isLeftDirection = ( $Direction -eq $script:uBoundary_Direction_Name_Left )

    function Get-uArrowBody {
        param(
            [Parameter( Mandatory = $true )] $Length # Any Rational Number
        )

        $Length = [Math]::Max( $Length, 0 )
        $Length = [Math]::Floor( $Length + 0.5 )

        return "$( $script:uBoundary_Character_Body * [Math]::Floor( $Length + 0.5 ) )"
    }

    if ( $script:uSentinelValue_Int32 -ne $LengthMultiplier ) {

        if ( $isRightDirection ) {
            $length = $LengthMultiplier * ( $script:uWindow_Width - $script:uBoundary_Character_RightTip_Length )
            $arrowBody = ( Get-uArrowBody -Length $Length )

            return "$( $arrowBody )$( $script:uBoundary_Character_RightTip )"
        }

        if ( $isLeftDirection ) {
            $length = $LengthMultiplier * ( $script:uWindow_Width - $script:uBoundary_Character_LeftTip_Length )
            $arrowBody = ( Get-uArrowBody -Length $length )

            return "$( $script:uBoundary_Character_LeftTip )$( $arrowBody )"
        }
    }

    if ( $script:uSentinelValue_Int32 -ne $RawLength ) {

        if ( $isRightDirection ) {
            $length = ( $RawLength - $script:uBoundary_Character_RightTip_Length )
            $arrowBody = ( Get-uArrowBody -Length $length )

            return "$( $arrowBody )$( $script:uBoundary_Character_RightTip )"
        }

        if ( $isLeftDirection ) {
            $length = $RawLength - $script:uBoundary_Character_LeftTip_Length
            $arrowBody = ( Get-uArrowBody -Length $length )

            return "$( $script:uBoundary_Character_LeftTip )$( $arrowBody )"
        }
    }

    return ''
}


function Set-uWindowTitleToBringBack {
    param(
        [Parameter( Mandatory = $false )] $Title = $script:uSentinelValue_String
    )

    if ( $script:uSentinelValue_String -eq $Title ) {
        return $True
    }

    try {
        $script:uLastWindowTitle = $host.UI.RawUI.WindowTitle
    }
    catch {
        return $false
    }

    try {
        $host.UI.RawUI.WindowTitle = $script:uLastWindowTitle
    }
    catch {
        return $false
    }

    try {
        $host.UI.RawUI.WindowTitle = $Title
    }
    catch {

        try {
            $host.UI.RawUI.WindowTitle = $script:uLastWindowTitle
        }
        catch {
            return $false
        }

        return $false
    }

    return $true
}


function Set-uLastWindowTitle {

    function Invoke-uSuccessSequence {
        $script:uLastWindowTitle = $script:uSentinelValue_String
        return $true
    }

    function Invoke-uFailureSequence {

        if ( $script:uLastWindowTitle -eq $host.UI.RawUI.WindowTitle ) {
            return ( Invoke-uSuccessSequence )
        }

        try {
            $host.UI.RawUI.WindowTitle = $script:uLastWindowTitle # A retry
            return ( Invoke-uSuccessSequence )
        }
        catch { }

        Write-Host ( Get-uBoundary -Direction $script:uBoundary_Direction_Name_Right -LengthMultiplier $script:uBoundary_Length_Long )
        Write-Host " !!! Failed to set the window title back to:`n$script:uLastWindowTitle"
        Write-Host ( Get-uBoundary -Direction $script:uBoundary_Direction_Name_Left -LengthMultiplier $script:uBoundary_Length_Long )

        return $false
    }

    if ( $script:uSentinelValue_String -eq $script:uLastWindowTitle ) {
        return ( Invoke-uSuccessSequence )
    }

    try {
        $host.UI.RawUI.WindowTitle = $host.UI.RawUI.WindowTitle
    }
    catch {
        return ( Invoke-uFailureSequence )
    }

    try {
        $host.UI.RawUI.WindowTitle = $script:uLastWindowTitle
        return ( Invoke-uSuccessSequence )
    }
    catch {
        return ( Invoke-uFailureSequence )
    }
}


function Add-uDirectlyToArrayIfBoolTrue {
    param(
        [Parameter( Mandatory = $true )] [ref] $ArrayReference,
        [Parameter( Mandatory = $false )] [Object] $ToAdd,
        [Switch] $Prepend,
        [Switch] $Bool
    )

    if ( -not $Bool ) {
        return
    }

    if ( $Prepend ) {
        $ArrayReference.Value = @( @( $ToAdd ) + @( $ArrayReference.Value ) )
        return
    }

    $ArrayReference.Value = @( @( $ArrayReference.Value ) + @( $ToAdd ) )
}


function Get-uPaddedArrayToLength {
    param(
        [Parameter( Mandatory = $false )] [Object] $ArrayToPad,
        [Parameter( Mandatory = $false )] [int] $Length,
        [Parameter( Mandatory = $false )] [Object] $PaddingObject
    )

    $paddingLength = ( $Length - $ArrayToPad.Length )

    if ( $paddingLength -le 0 ) {
        return $ArrayToPad
    }

    $padding = @( @( $PaddingObject ) * $paddingLength )

    return @( @( $ArrayToPad ) + @( $padding ) )
}


function Get-uPrioritizedArrayOfStrings {
    param(
        [Parameter( Mandatory = $false )] [Object] $Array = $script:uSentinelValue_String,
        [Parameter( Mandatory = $false )] [Object] $Priorities = $script:uSentinelValue_String,
        [Switch] $Capitalize,
        [Switch] $CaseSensitiveComparison,
        [Switch] $DoNotRemoveEmptyStrings
    )

    if ( $script:uSentinelValue_String -eq $Array ) {
        return @()
    }

    if ( $script:uSentinelValue_String -eq $Priorities ) {
        return $Array
    }

    $arrayLength = $Array.Length

    if ( $arrayLength -eq 0 ) {
        return $Array
    }

    $newArray = @()

    function Add-uPrioritized {
        param(
            [Parameter( Mandatory = $false )] [String] $Item = $script:uSentinelValue_String
        )

        if ( $script:uSentinelValue_String -eq $Item ) {
            return @( $newArray )
        }

        if ( $Capitalize ) {
            $Item = $Item.ToUpper()
        }

        return @( @( $Item ) + @( $newArray ) )
    }

    function Add-uNormal {
        param(
            [Parameter( Mandatory = $false )] [String] $Item = $script:uSentinelValue_String
        )

        if ( $script:uSentinelValue_String -eq $Item ) {
            return @( $newArray )
        }

        return @( @( $newArray ) + @( $Item ) )
    }

    function Get-uIsValueAPriority {
        param(
            [Parameter( Mandatory = $false )] [String] $Item = $script:uSentinelValue_String
        )

        if ( $script:uSentinelValue_String -eq $Item ) {
            return $false
        }

        if ( $CaseSensitiveComparison ) {
            return ( $Item -cin $Priorities )
        }
        return ( $Item -in $Priorities )
    }

    for ( $i = 0; $i -lt $arrayLength; $i++ ) {

        $Item = ( $Array[$i] )

        if ( Get-uIsValueAPriority -Item $Item ) {
            $newArray = @( Add-uPrioritized -Item $Item )
        }
        else {
            $newArray = @( Add-uNormal -Item $Item )
        }

    }

    if ( -not $DoNotRemoveEmptyStrings ) {
        $emptyStringValues = @( $null, '' )
        $newArray = @( @( $newArray ) | Where-Object -FilterScript { $_ -notin $emptyStringValues } )
    }

    return @( $newArray )
}


function Set-uNewColorVariableIfCandidateBetter {
    param(
        [Parameter( Mandatory = $true )] [ref] $CurrentColorReference,
        [Parameter( Mandatory = $true )] [ref] $CurrentColorPriorityReference,
        [Parameter( Mandatory = $false )] [Object] $CandidateColor = $script:uSentinelValue_String,
        [Parameter( Mandatory = $false )] [Object] $CandidatePriority = $script:uSentinelValue_String
    )

    if ( $null -eq $CandidateColor ) {
        return
    }

    if ( ( $null -eq $CandidatePriority ) -or `
        ( -not ( ConvertTo-uDoubleDirectly -ValueReference ( [ref] $CandidatePriority ) ) ) ) {
        $CandidatePriority = $script:uList_Attributes_Colors_Default_Priority
    }

    if ( -not ( ConvertTo-uDoubleDirectly -ValueReference $CurrentColorPriorityReference ) ) {
        $CurrentColorPriorityReference.Value = $script:uList_Attributes_Colors_Default_Priority
    }

    if ( $script:uList_Attributes_Colors_Name_DefaultColor -eq $CandidateColor ) {
        $CandidateColor = $script:uSentinelValue_String
    }

    if ( $CandidatePriority -le $CurrentColorPriorityReference.Value ) {
        $CurrentColorReference.Value = $CandidateColor
        $CurrentColorPriorityReference.Value = $CandidatePriority
    }
}


function Set-uNeWColorVariablesFromAttributeName {
    param(
        [Parameter( Mandatory = $true )] [ref] $CurrentBackgroundColorReference,
        [Parameter( Mandatory = $true )] [ref] $CurrentBackgroundColorPriorityReference,
        [Parameter( Mandatory = $true )] [ref] $CurrentForegroundColorReference,
        [Parameter( Mandatory = $true )] [ref] $CurrentForegroundColorPriorityReference,
        [Parameter( Mandatory = $false )] [Object] $AttributeName = $script:uSentinelValue_String
    )

    if ( $script:uSentinelValue_String -eq $AttributeName ) {
        return
    }

    $candidate = $script:uList_Attributes_Colors[$AttributeName]
    $badCandidates = @( $null, '', '0', $script:uSentinelValue_String )

    if ( $candidate -in @( $badCandidates ) ) {
        continue
    }

    $candidateBackgroundColor = $candidate[$script:uList_Attributes_Colors_Name_BackgroundColor]
    $candidateBackgroundColorPriority = $candidate[$script:uList_Attributes_Colors_Name_BackgroundColor_Priority]

    $candidateForegroundColor = $candidate[$script:uList_Attributes_Colors_Name_ForegroundColor]
    $candidateForegroundColorPriority = $candidate[$script:uList_Attributes_Colors_Name_ForegroundColor_Priority]

    Set-uNewColorVariableIfCandidateBetter `
        -CurrentColorReference $CurrentBackgroundColorReference `
        -CurrentColorPriorityReference $CurrentBackgroundColorPriorityReference `
        -CandidateColor $candidateBackgroundColor `
        -CandidatePriority $candidateBackgroundColorPriority

    Set-uNewColorVariableIfCandidateBetter `
        -CurrentColorReference $CurrentForegroundColorReference `
        -CurrentColorPriorityReference $CurrentForegroundColorPriorityReference `
        -CandidateColor $candidateForegroundColor `
        -CandidatePriority $candidateForegroundColorPriority
}


function Get-uColorsFromFileAttributesNames {
    param(
        [Parameter( Mandatory = $false )] [Object] $FileAttributesNames = $script:uSentinelValue_String
    )

    if ( $script:uSentinelValue_String -eq $FileAttributesNames ) {
        return $script:uSentinelValue_String
    }

    $FileAttributesNames = @( @( $FileAttributesNames ) + @( $script:uList_Attributes_Colors_Name_Any ) )

    $backgroundColor = $script:uSentinelValue_String
    $backgroundColorPriority = $script:uList_Attributes_Colors_Default_Priority
    $foregroundColor = $script:uSentinelValue_String
    $foregroundColorPriority = $script:uList_Attributes_Colors_Default_Priority


    foreach ( $attributeName in $FileAttributesNames ) {

        Set-uNeWColorVariablesFromAttributeName `
            -CurrentBackgroundColorReference ( [ref] $backgroundColor ) `
            -CurrentBackgroundColorPriorityReference ( [ref] $backgroundColorPriority ) `
            -CurrentForegroundColorReference ( [ref] $foregroundColor ) `
            -CurrentForegroundColorPriorityReference ( [ref] $foregroundColorPriority ) `
            -AttributeName $attributeName
    }

    return @{
        $script:uList_Attributes_Colors_Name_BackgroundColor = $backgroundColor
        $script:uList_Attributes_Colors_Name_ForegroundColor = $foregroundColor
    }
}


function Get-uNamesListFromFileAttributes {
    param(
        [Parameter( Mandatory = $false )] [Object] $fileAttributesParameter = $script:uSentinelValue_String
    )

    if ( $script:uSentinelValue_String -eq $fileAttributesParameter ) {
        return @()
    }

    $attributesArray = @()

    foreach ( $attribute in $script:uSystemIOAllDefaultFileAttributes ) {
        if ( ( $fileAttributesParameter -band $attribute ) -eq $attribute ) {
            $attributesArray = @( @( $attributesArray ) + @( $attribute ) )
        }
    }

    return @( $attributesArray )
}


function Get-uFileAttributesNamesList {
    param(
        [Parameter( Mandatory = $false )] [String] $FileName = $script:uSentinelValue_String
    )

    $permissionDenied = $false
    $otherError = $false

    try {
        $Path = ( Get-uPathWithAddedBackslashIfNecessary -Path "$( $script:uOperatingPath )\$( $FileName )" )
        $file = ( Get-Item -Path $Path -Force -ErrorAction Stop )
        $fileAttributesParameter = $file.Attributes
    }
    catch [System.UnauthorizedAccessException] {
        $permissionDenied = $true
    }
    catch [System.IO.FileNotFoundException] {
        $fileNotFound = $true
    }
    catch {
        $otherError = $true
    }
    # Improvement idea: Be more explicit with error catching here.

    if ( ( -not $permissionDenied ) -and ( -not $fileNotFound ) -and ( -not $otherError ) ) {
        $fileAttributesNames = @( Get-uNamesListFromFileAttributes -FileAttributesParameter:$fileAttributesParameter )
    }

    if ( $permissionDenied ) {
        $fileAttributesNames = @( @( $fileAttributesNames ) + @( 'Permission Denied!' ) )
    }

    if ( $fileNotFound ) {
        $fileAttributesNames = @( @( $fileAttributesNames ) + @( 'File Not Found!' ) )
    }

    if ( $otherError ) {
        $fileAttributesNames = @( @( $fileAttributesNames ) + @( 'ERROR!' ) )
    }

    $fileAttributesNames = @( @( $fileAttributesNames ) | Where-Object -FilterScript {
            ( $_ -notin $script:uList_Attributes_ExclusionList ) }
    )

    $fileAttributesNames = @( Get-uPrioritizedArrayOfStrings `
            -Array $fileAttributesNames `
            -Priorities $script:uList_Attributes_PriorityList `
            -Capitalize )

    $emptyStringValues = @( '', $null, ' ' )

    $fileAttributesNames = @( @( $fileAttributesNames ) | Where-Object -FilterScript {
            $_ -notin @( $emptyStringValues ) } )

    return @( $fileAttributesNames )
}


function Get-uFileAttributesStringRaw {
    param(
        [Parameter( Mandatory = $false )] [Object] $FileAttributesNames
    )

    if ( $FileAttributesNames.Length -gt 0 ) {
        $FileAttributesStringRaw = " $script:uList_Attributes_Character_Arrow $( $FileAttributesNames -join  ', ' )"
    }
    else {
        $FileAttributesStringRaw = ''
    }

    return $FileAttributesStringRaw
}


function Get-uFileAttributesString {
    param(
        [Parameter( Mandatory = $false )] [Object] $FileAttributesNamesList,
        [Parameter( Mandatory = $false )] [String] $BeforeAttributesString = $script:uSentinelValue_String,
        [Parameter( Mandatory = $false )] [String] $AfterAttributesString = $script:uSentinelValue_String
    )

    $fileAttributesStringRaw = ( Get-uFileAttributesStringRaw -FileAttributesNames @( $FileAttributesNamesList ) )

    function Get-uAttributesStringSpacesLength {
        $rawLineLength = ( "$( $BeforeAttributesString )$( $fileAttributesStringRaw )$( $AfterAttributesString )" ).Length

        Set-uNewWindowSizeVariables
        $newLength = $rawLineLength + $script:uList_Attributes_MinCharactersOffset_Left1
        $newMax = $script:uWindow_Width - $script:uList_Attributes_MinCharactersOffset_Right

        if ( $newLength -lt $newMax ) {
            return $script:uList_Attributes_MinCharactersOffset_Left1
        }

        $newRange = $script:uList_Attributes_MinCharactersOffset_Left1 - $script:uList_Attributes_MinCharactersOffset_Left2
        $newMax = $script:uWindow_Width - $script:uList_Attributes_MinCharactersOffset_Right

        $firstMatchingSubtraction = $rawLineLength + $script:uList_Attributes_MinCharactersOffset_Left1 - $newMax

        if ( ( $firstMatchingSubtraction -ge 0 ) -and ( $firstMatchingSubtraction -le $newRange ) ) {
            return $script:uList_Attributes_MinCharactersOffset_Left1 - $firstMatchingSubtraction
        }

        if ( $rawLineLength + $script:uList_Attributes_MinCharactersOffset_Left2 -lt $newMax ) {
            return $script:uList_Attributes_MinCharactersOffset_Left2
        }

        # The two above if statements are the optimized version of this the below for loop. I left it, because it may
        # be easier to understand te more verbose for loop, than the math.
        # IF ANY EDIT IN THE IFs WAS PERFORMED - IT'S LIKELY THAT THIS ARCHIVE CODE IS IRRELEVANT
        # for ( $i = 0; $i -le $newRange; $i++ ) {
        #     $newOffsetFromLeft = [Math]::Max( ( $script:uList_Attributes_MinCharactersOffset_Left1 - $i ), `
        #             $script:uList_Attributes_MinCharactersOffset_Left2 )
        #     $newLength = $rawLineLength + $newOffsetFromLeft

        #     if ( $newLength -lt $newMax ) {
        #         return $newOffsetFromLeft
        #     }
        # }

        $newRange = [Math]::Max( $script:uList_Attributes_MinCharactersOffset_Left3, `
                $script:uList_Attributes_MinCharactersOffset_Right )

        for ( $i = 0; $i -le $newRange; $i++ ) {

            $newOffsetFromLeft = [Math]::Max( ( $script:uList_Attributes_MinCharactersOffset_Left2 - $i ), `
                    $script:uList_Attributes_MinCharactersOffset_Left3 )
            $newLength = $rawLineLength + $newOffsetFromLeft

            if ( 0 -eq $i ) {
                $newOffsetFromRight = $script:uList_Attributes_MinCharactersOffset_Right
            }
            else {
                $newOffsetFromRight = [Math]::Max( ( $script:uList_Attributes_MinCharactersOffset_Right - $i + 1 ), 0 )
            }

            $newMax = $script:uWindow_Width - $newOffsetFromRight

            if ( $newLength -lt $newMax ) {
                return $newOffsetFromLeft
            }

            $newOffsetFromRight = [Math]::Max( ( $script:uList_Attributes_MinCharactersOffset_Right - $i ), 0 )
            $newMax = $script:uWindow_Width - $newOffsetFromRight

            if ( $newLength -lt $newMax ) {
                return $newOffsetFromLeft
            }

        }

        return $script:uList_Attributes_MinCharactersOffset_Left3
    }

    function Get-uAttributesStringSpaces {
        $spacesAmount = ( Get-uAttributesStringSpacesLength )
        $spacesWithDashes = $()

        $spacesAmountAfterFirstDash = $spacesAmount - $script:uList_Attributes_FirstDash_SpacesBefore - `
            $script:uList_Attributes_FirstDash_Character.Length

        if ( ( $spacesAmountAfterFirstDash -le 0 ) -or ( '' -eq $fileAttributesStringRaw ) ) {
            return ( $script:uList_Attributes_Character_Space * $spacesAmount )
        }

        $spacesAmount = $spacesAmountAfterFirstDash
        $spacesWithDashes += ( `
                "$( $script:uList_Attributes_Character_Space * $script:uList_Attributes_FirstDash_SpacesBefore )", `
                "$script:uList_Attributes_FirstDash_Character" -join '' )

        $range = $spacesAmount + 1

        for ( $i = 1; $i -lt $range; ) {

            if ( 0 -eq ( $i % $script:uList_Attributes_SpacesBetweenDashes ) ) {
                $spacesWithDashes += $script:uList_Attributes_Character_Dash
                $i += $script:uList_Attributes_Character_Dash.Length
                continue
            }

            $spacesWithDashes += $script:uList_Attributes_Character_Space
            $i += $script:uList_Attributes_Character_Space.Length

        }

        return $spacesWithDashes

    }

    return "$( Get-uAttributesStringSpaces )$( $fileAttributesStringRaw )$( $AfterAttributesString )"
}


function Get-uChildItems {
    param(
        [Switch] $IsDir
    )

    try {
        return @( Get-ChildItem -Path $script:uOperatingPath -ErrorAction Stop -Name -Directory:$IsDir -Force )
    }
    catch [System.UnauthorizedAccessException] {
        return $script:uSentinelValue_String # When You have an access denied error here, You cannot access the entire
        #                                     folder ( not a single file ). Therefore no handling is needed to 'try'
        #                                     accessing these files without -Force.
    }
}


function Get-uListOneLineLeftSideSpaces {
    param(
        [Parameter( Mandatory = $false )] [String] $CounterText = $script:uSentinelValue_String
    )

    if ( $script:uSentinelValue_String -eq $CounterText ) {
        return ''
    }

    return ( $script:uList_BeforeCounterText_Character_Space * [Math]::Max( `
            ( $script:uList_BeforeCounterText_SpacesIfOneDigit + 1 - "$CounterText".Length ), 0 ) )
}


function Set-uVariableFToPath {
    param(
        [Parameter( Mandatory = $false )] [Object] $Path = $script:uSentinelValue_String
    )

    if ( $script:uSentinelValue_String -eq $Path ) {
        return
    }
    $script:f = ( Convert-Path -Path ( Get-uUniversalPath -Path $Path ) ) # The $script:f is supposed to be used by the user! Is is __not__ unused!
}


function Get-uBeforeAttributesString {
    param(
        [Parameter( Mandatory = $true )] [Object] $FileName,
        [Parameter( Mandatory = $true )] [int] $PositiveCounter,
        [Parameter( Mandatory = $true )] [int] $ListLength
    )

    $negativeNumberModulo = ( $PositiveCounter % $script:uList_NegativeValues_ShowEveryXthListing )
    $shouldNegativeCounterBeDisplayed = ( 0 -eq $negativeNumberModulo )

    if ( $script:uList_NegativeValues_Toggle -and $shouldNegativeCounterBeDisplayed ) {
        $negativeCounterText = "-$( $ListLength - $PositiveCounter + 1 )$( $script:uList_NegativeValues_Separator )"
    }
    else {
        $negativeCounterText = ''
    }

    $beforeAttributesString_Spaces = ( Get-uListOneLineLeftSideSpaces `
            -CounterText "$( $negativeCounterText )$( $PositiveCounter )" )

    return (
        "$beforeAttributesString_Spaces",
        "$script:uList_Character_Bracket_BeforeAttributes_Opening",
        "$negativeCounterText",
        "$PositiveCounter",
        "$script:uList_Character_Bracket_BeforeAttributes_Closing",
        ' ',
        "$FileName" -join ''
    )
}


function Get-uListLineFromFile {
    param(
        [Parameter( Mandatory = $true )] [Object] $FileName,
        [Parameter( Mandatory = $true )] [int] $PositiveCounter,
        [Parameter( Mandatory = $true )] [int] $ListLength
    )

    $beforeAttributesString = ( Get-uBeforeAttributesString `
            -FileName $FileName `
            -PositiveCounter $PositiveCounter `
            -ListLength $ListLength )

    if ( -not $script:uList_FileAttributes_Toggle ) {
        return $beforeAttributesString
    }

    $afterAttributesString = (
        " $script:uList_Character_Bracket_AfterAttributes_Opening",
        "$( $script:uList_Attributes_ClosingNumberPrefix )",
        "$( $PositiveCounter )",
        "$( $script:uList_Attributes_ClosingNumberSuffix )",
        "$script:uList_Character_Bracket_AfterAttributes_Closing" -join ''
    )

    $fileAttributesNamesList = @( Get-uFileAttributesNamesList -FileName $FileName )

    $fileAttributesString = ( Get-uFileAttributesString `
            -BeforeAttributesString $beforeAttributesString `
            -AfterAttributesString $afterAttributesString `
            -FileAttributesNamesList $fileAttributesNamesList )

    if ( $script:uList_Colors_Toggle ) {
        # The lack of '@' is not a mistype. Colors are passed as a table.
        $colors = ( Get-uColorsFromFileAttributesNames -FileAttributesNames $fileAttributesNamesList )
    }
    else {
        $colors = $script:uSentinelValue_String
    }

    return @{
        $script:uList_Raw_Names_Line   = "$( $beforeAttributesString )$( $fileAttributesString )"
        $script:uList_Raw_Names_Colors = $colors
    }


}


function Get-uRawEnumeratedFilesList {
    param(
        [Parameter( Mandatory = $false )] [Object] $ListToEnumerate = $script:uSentinelValue_String
    )

    if ( ( ( $script:uSentinelValue_String -eq $ListToEnumerate )  ) ) {
        return
    }

    $listLength = $ListToEnumerate.Length

    if ( 0 -eq $ListToEnumerate.Length ) {
        return
    }

    $positiveCounter = 1

    $lines = @( @( $ListToEnumerate ) | ForEach-Object -Process {
            Get-uListLineFromFile `
                -FileName $_ `
                -PositiveCounter $positiveCounter `
                -ListLength $listLength

            $positiveCounter++ }
    )

    return $lines
}


function Get-uIsConsoleColorValid {
    param(
        [Parameter( Mandatory = $false )] [Object] $Color = $script:uSentinelValue_String
    )

    return ( ( $Color -ne $script:uSentinelValue_String ) `
            -and ( $Color -in $script:uList_Attributes_Colors_ValidColors ) )
}


function Write-uHostColorsCushion {
    param(
        [Parameter( Mandatory = $false )] [Object] $Object,
        [Parameter( Mandatory = $false )] [Object] $BackgroundColor = $script:uSentinelValue_String,
        [Parameter( Mandatory = $false )] [Object] $ForegroundColor = $script:uSentinelValue_String
    )

    $backgroundColor_IsValid = ( Get-uIsConsoleColorValid -Color $BackgroundColor )
    $foregroundColor_IsValid = ( Get-uIsConsoleColorValid -Color $ForegroundColor )

    if ( $backgroundColor_IsValid -and $foregroundColor_IsValid ) {
        Write-Host `
            -Object $Object `
            -BackgroundColor $BackgroundColor `
            -ForegroundColor $ForegroundColor

        return
    }

    if ( $backgroundColor_IsValid ) {
        Write-Host `
            -Object $Object `
            -BackgroundColor $BackgroundColor

        return
    }

    if ( $foregroundColor_IsValid ) {
        Write-Host `
            -Object $Object `
            -ForegroundColor $ForegroundColor

        return
    }

    Write-Host $Object

}


function Write-uEnumeratedFileList {
    param(
        [Parameter( Mandatory = $false )] [Object] $ListToEnumerate = $script:uSentinelValue_String,
        [Switch] $AddDisplayList,
        [Switch] $AddZero,
        [Switch] $AddQuitStick,
        [Switch] $AddAccessDenied
    )

    if ( $script:uSentinelValue_String -eq $ListToEnumerate ) {
        $ListToEnumerate = @()
    }

    if ( $AddDisplayList ) {
        Write-Host ( "$( Get-uListOneLineLeftSideSpaces -CounterText $script:uList_Character_DisplayList )",
            "[$script:uList_Character_DisplayList] ",
            'Force Write List' -join '' )
    }

    if ( $AddZero ) {
        Write-Host ( "$( Get-uListOneLineLeftSideSpaces -CounterText $script:uList_Character_Zero )",
            "[$script:uList_Character_Zero] ",
            "Select the Parent Directory - '$( Convert-Path "$script:uOperatingPath\.." )'" -join '' )
    }

    if ( $AddQuitStick ) {
        Write-Host ( "$( Get-uListOneLineLeftSideSpaces -CounterText $script:uList_Character_ExitStick )",
            "[$script:uList_Character_ExitStick] ",
            'Exit Stick Mode.' -join '' )

    }

    if ( $AddAccessDenied ) {
        Write-Host ( "$( Get-uListOneLineLeftSideSpaces -CounterText $script:uList_Character_AccessDenied )",
            "[$script:uList_Character_AccessDenied] ",
            'Access Denied!' -join '' )
    }

    $enumeratedFilesWithLineInfo = ( Get-uRawEnumeratedFilesList -ListToEnumerate @( $ListToEnumerate ) )

    if ( -not $script:uList_FileAttributes_Toggle ) {
        foreach ( $line in $enumeratedFilesWithLineInfo ) {
            Write-Host $line
        }
        return
    }

    if ( $enumeratedItemsList.Length -lt 0 ) {
        return
    }

    foreach ( $lineInfo in $enumeratedFilesWithLineInfo ) {
        $line = $lineInfo[$script:uList_Raw_Names_Line]
        $colors = $lineInfo[$script:uList_Raw_Names_Colors]

        if ( $script:uSentinelValue_String -eq $colors ) {
            Write-Host $line
            continue
        }

        $backgroundColor = $colors[$script:uList_Attributes_Colors_Name_BackgroundColor]
        $foregroundColor = $colors[$script:uList_Attributes_Colors_Name_ForegroundColor]

        Write-uHostColorsCushion `
            -Object $line `
            -BackgroundColor $backgroundColor `
            -ForegroundColor $foregroundColor
    }
}


function Write-uFullItemList {
    param(
        [Parameter( Mandatory = $false )] [Object] $ChildrenItems = $script:uSentinelValue_String,
        [Switch] $IsDir,
        [Switch] $IsStick,
        [Switch] $NoNewlineUnderList
    )

    $setWindowTitleSuccess = ( Set-uWindowTitleToBringBack -Title $script:uList_Title_Processing )

    if ( $IsDir ) {
        $header = 'Found Directories:'
    }
    else {
        $header = 'Found Items:'
    }

    $addAccessDenied = $false

    if ( $script:uSentinelValue_String -eq $ChildrenItems ) {
        $ChildrenItems = @()
        $addAccessDenied = $true
    }

    $ChildrenItems = @( @( $ChildrenItems ) | Where-Object { $_ -ne $script:uSentinelValue_String } )

    Set-uNewWindowSizeVariables

    $arrowLength = ( [Math]::Min( [Math]::Floor( $script:uWindow_Width - `
                    $script:uList_Attributes_MinCharactersOffset_Right * `
                    $script:uList_BoundaryArrowBody_RightOffsetMultiplier + 0.5 ), ( $script:uWindow_Width ) ) )

    if ( $script:uList_BeforeDisplay_SoftCleanTerminal ) {
        Write-uSoftCleanTerminal
    }

    Write-Host ''
    Write-Host "$( Get-uBoundary -RawLength $arrowLength -Direction $script:uBoundary_Direction_Name_Right )"
    Write-Host "$( ' ' * $script:uList_BeforeCounterText_SpacesIfOneDigit  ) You're at: $( $script:uOperatingPath )"
    Write-Host ''
    Write-Host "$header"

    Write-uEnumeratedFileList `
        -ListToEnumerate $ChildrenItems `
        -AddDisplayList:$script:uList_Character_DisplayList_DoDisplayOnList `
        -AddZero `
        -AddQuitStick:$IsStick `
        -AddAccessDenied:$addAccessDenied

    Write-Host ''
    Write-Host "$( ' ' * $script:uList_BeforeCounterText_SpacesIfOneDigit  ) You're at: $( $script:uOperatingPath )"
    Write-Host "$( Get-uBoundary -RawLength $arrowLength -Direction $script:uBoundary_Direction_Name_Left )"

    if ( -not $NoNewlineUnderList ) {
        Write-Host ''
    }

    if ( $setWindowTitleSuccess ) {
        $null = ( Set-uLastWindowTitle )
    }
}


function Get-uCorrect12HourFormatTime {
    try {
        $currentHour = ( Get-Date -Format 'HH' )
        $currentMinute = ( Get-Date -Format 'mm' )

        if ( $currentHour -le 12 ) {
            $current12HourFormatTime = "$( $currentHour ):$currentMinute am"
        }
        else {
            $current12HourFormatTime = "$( $currentHour - 12 ):$currentMinute pm"
        }

        return "$current12HourFormatTime"
    }
    catch {
        return $script:uSentinelValue_String
    }
    # Improvement idea: Be more explicit with error catching here.

}


function Get-uCurrentTimeString {
    try {
        $current24HourFormatTime = ( Get-Date -Format $script:uTime_Format_24 )
        $current12HourFormatTime = ( Get-uCorrect12HourFormatTime )

        if ( "$script:uIntroduction_Greeting_CurrentTimeText_Format" -eq "$script:uIntroduction_Greeting_CurrentTimeText_Name_24" ) {
            $currentTimeTextRaw = $current24HourFormatTime
        }
        elseif ( "$script:uIntroduction_Greeting_CurrentTimeText_Format" -eq "$script:uIntroduction_Greeting_CurrentTimeText_Name_12" ) {
            $currentTimeTextRaw = ( Get-uValueOrFallback `
                    -ToReturn $current12HourFormatTime `
                    -Fallback $current24HourFormatTime `
                    -BlacklistOneItem $script:uSentinelValue_String )
        }
        else {
            $currentTimeTextRaw24 = $current24HourFormatTime

            $currentTimeTextRaw12 = ( Get-uValueOrFallback `
                    -ToReturn $current12HourFormatTime `
                    -Fallback '' `
                    -BlacklistOneItem "$script:uSentinelValue_String" `
                    -PrependIfCorrect ' (' `
                    -AppendIfCorrect ')' )

            $currentTimeTextRaw = "$( $currentTimeTextRaw24 )$( $currentTimeTextRaw12 )"
        }

        return "It's $( $currentTimeTextRaw )!"
    }
    catch {
        return ''
    }
    # Improvement idea: Be more explicit with error catching here.

}


function Get-uIsHourBetween {
    # This function _does_ support wrapping at midnight, and wraps 'forward'
    param(
        [Parameter( Mandatory = $true )] [int] $Hour,
        [Parameter( Mandatory = $true )] [int] $MoreThan,
        [Parameter( Mandatory = $true )] [int] $LessThan
    )

    if ( $MoreThan -gt $LessThan ) {
        return ( ( $Hour -ge $MoreThan ) -or ( $Hour -le $LessThan ) )
    }
    return ( ( $Hour -ge $MoreThan ) -and ( $Hour -le $LessThan ) )
}


function Get-uGreeting {

    try {
        $userHour = ( Get-Date -Format 'HH' )
        $currentTimeString = " $( Get-uCurrentTimeString )"

        if ( Get-uIsHourBetween `
                -Hour $userHour `
                -MoreThan $script:uIntroduction_Greeting_StartHour_Morning `
                -LessThan $script:uIntroduction_Greeting_StartHour_Afternoon ) {

            $greetingString = $script:uIntroduction_Greeting_Text_Morning
        }
        elseif ( Get-uIsHourBetween `
                -Hour $userHour `
                -MoreThan $script:uIntroduction_Greeting_StartHour_Afternoon `
                -LessThan $script:uIntroduction_Greeting_StartHour_Evening ) {

            $greetingString = $script:uIntroduction_Greeting_Text_Afternoon
        }
        elseif ( Get-uIsHourBetween `
                -Hour $userHour `
                -MoreThan $script:uIntroduction_Greeting_StartHour_Evening `
                -LessThan $script:uIntroduction_Greeting_StartHour_Morning ) {

            $greetingString = $script:uIntroduction_Greeting_Text_Evening
        }
        else {
            $greetingString = $script:uIntroduction_Greeting_Text_Fallback
        }

        return "$greetingString$script:uIntroduction_Greeting_Text_Symbol$currentTimeString"
    }
    catch {
        return $script:uSentinelValue_String
    }
    # Improvement idea: Be more explicit with error catching here.

}


function Get-uDoesValueFitInRange {
    param(
        [Parameter( Mandatory = $false )] [Object] $Value = $script:uSentinelValue_String,
        [Parameter( Mandatory = $false )] [int] $ListLength = $script:uSentinelValue_String,
        [Switch] $AllowNegative
    )

    if ( $script:uSentinelValue_String -eq $Value ) {
        return $false
    }

    if ( $script:uSentinelValue_String -eq $ListLength ) {
        return $false
    }

    try {
        $null = [int]::TryParse( $Value, [ref] $Value )
    }
    catch [System.InvalidCastException] {
        return $false
    }

    if ( ( ( $AllowNegative ) -or ( $Value -ge 0 ) ) -and ( $Value -le $ListLength ) ) {
        return $true
    }

    return $false

}


function Write-uSoftCleanTerminal {
    Set-uNewWindowSizeVariables
    Write-Host -NoNewline "$( "`n" * $script:uWindow_Height )"
}


function Get-uCorrectedWhichByAlphabet {
    param(
        [Parameter( Mandatory = $true )] [int] $ListLength,
        [Switch] $AllowDisplayListCharacter,
        [Switch] $AllowZeroCharacter,
        [Switch] $AllowQuitStickCharacter,
        [Switch] $AllowNegative
    )

    if ( $script:uSentinelValue_String -eq $script:uWhichByAlphabet ) {
        return $script:uSentinelValue_String
    }

    if ( ( $AllowDisplayListCharacter ) `
            -and ( $script:uList_Character_DisplayList -eq $script:uWhichByAlphabet  ) ) {
        return $script:uWhichByAlphabet
    }

    if ( ( $AllowZeroCharacter ) `
            -and ( $script:uList_Character_Zero -eq $script:uWhichByAlphabet ) ) {
        return $script:uWhichByAlphabet
    }

    if ( ( $AllowQuitStickCharacter ) `
            -and ( $script:uList_Character_ExitStick -eq $script:uWhichByAlphabet ) ) {
        return $script:uWhichByAlphabet
    }

    try {
        $whichByAlphabetInt = ( [int] $script:uWhichByAlphabet )
    }
    catch {
        return $script:uSentinelValue_String
    }

    $isCorrectWhichByAlphabet = ( Get-uDoesValueFitInRange -Value $whichByAlphabetInt -ListLength $ListLength `
            -AllowNegative:$AllowNegative )

    if ( ( $isCorrectWhichByAlphabet ) -and ( $script:uSentinelValue_String -ne $isCorrectWhichByAlphabet ) ) {
        return $whichByAlphabetInt
    }

    return $script:uSentinelValue_String
}


function Get-uNearestAvailableLocationFromPath {
    param(
        [Parameter( Mandatory = $true )] [String] $AbsolutePath
    )

    $absolutePathSplit = $AbsolutePath.Split( '\' )
    $absolutePathDepth = $absolutePathSplit.Length

    $currentLocationSnapshot = "$( Get-Location )\"

    for ( $i = 0; $i -lt $absolutePathDepth; $i++ ) {
        try {
            $depth = $absolutePathDepth - $i
            $depths = ( 0..( $depth - 1 ) )
            $pathRaw = ( ( $absolutePathSplit[$depths] ) -join '\' )
            $path = "$PathRaw\"

            Set-Location -Path $path -ErrorAction Stop
            Set-Location -Path $currentLocationSnapshot

            return $path
        }
        catch [System.UnauthorizedAccessException] {
            continue
        }
    }

    Set-Location -Path $currentLocationSnapshot

    Write-Host "Couldn't find a location near '$AbsolutePath'."
    return $script:uSentinelValue_String
}


function Set-uNearestAvailableLocationFromPath {
    param(
        [Parameter( Mandatory = $true )] [String] $AbsolutePath
    )

    $nearestAvailableLocation = ( Get-uNearestAvailableLocationFromPath -AbsolutePath $AbsolutePath )

    if ( $script:uSentinelValue_String -ne $nearestAvailableLocation ) {
        Set-Location -Path ( Get-uNearestAvailableLocationFromPath -AbsolutePath $AbsolutePath )
    }
}


function Start-uTaskbarFlashing {
    param(
        [Parameter( Mandatory = $true, ValueFromPipeline = $true )] [Object] $Hwid,
        [Parameter( Mandatory = $false )] [int] $OneFlashDurationMilliseconds = $script:uTaskbarFlashing_OneFlashDurationMilliseconds,
        [Parameter( Mandatory = $false )] [int] $FlashTimes = $script:uTaskbarFlashing_FlashTimes
    )

    $null = ( [uTaskbarFlasher]::FlashWindow( $Hwid, $OneFlashDurationMilliseconds, $FlashTimes ) )
}


function Start-uTaskbarFlashingForConsoleWindow {
    param(
        [Parameter( Mandatory = $false )] [int] $OneFlashDurationMilliseconds = `
            $script:uTaskbarFlashing_OneFlashDurationMilliseconds,
        [Parameter( Mandatory = $false )] [int] $FlashCount = $script:uTaskbarFlashing_FlashTimes
    )

    Start-uTaskbarFlashing `
        -Hwid ( [uTaskbarFlasher]::GetConsoleWindow() ) `
        -OneFlashDurationMilliseconds $script:uTaskbarFlashing_OneFlashDurationMilliseconds `
        -FlashTimes $script:uTaskbarFlashing_FlashTimes
}


function Start-uTaskbarFlashingForProcess {
    param(
        [Parameter( Mandatory = $true, ValueFromPipeline = $true )] $Process
    )

    Start-uTaskbarFlashing -Hwid:( $Process.MainWindowHandle )
}


function Get-uWindowsTerminalProcesses {
    return @( Get-Process -Name $script:uNoElev_WindowsTerminalProcessName -ErrorAction SilentlyContinue )
}


function Unregister-uDeleteMeTasks {
    @( @( Get-ScheduledTask ) | Where-Object -FilterScript {
            $_.TaskName.StartsWith( $script:uNoElev_ScheduledTaskName_DeleteMePrefix )
        } ) | ForEach-Object -Process { `
            Unregister-ScheduledTask -InputObject $_ -Confirm:$false -ErrorAction SilentlyContinue
    }
}


function Get-uCdaLikeInputPattern {
    param(
        [Switch] $TolerateDisplayListCharacter,
        [Switch] $TolerateZeroCharacter,
        [Switch] $TolerateQuitStickCharacter,
        [Switch] $TolerateSeparatorCharacter
    )

    if ( $script:uSentinelValue_String -eq $script:uCdaLikeInputCharacters_Filtered ) {
        $allCommandsAndAliasesNames = ( [String[]] ( Get-Command -All ).Name )
        $allCommandsAndAliasesNamesHashSet = ( [System.Collections.Generic.HashSet[String]]::new(
                $allCommandsAndAliasesNames ) )

        $script:uCdaLikeInputCharacters_Filtered = @( @( $script:uList_Input_MathCharactersToFilter ) | Where-Object {
                $_ -notin $allCommandsAndAliasesNamesHashSet }
        )

        # These two above expressions can take >100ms ( very long ). Optimize them further if possible.
    }

    $CdaLikeInputCharacters = $script:uCdaLikeInputCharacters_Filtered

    Add-uDirectlyToArrayIfBoolTrue `
        -ArrayReference ( [ref] $CdaLikeInputCharacters ) `
        -Bool:$TolerateDisplayListCharacter `
        -ToAdd $script:uList_Character_DisplayList

    Add-uDirectlyToArrayIfBoolTrue `
        -ArrayReference ( [ref] $CdaLikeInputCharacters ) `
        -Bool:$TolerateZeroCharacter `
        -ToAdd $script:uList_Character_Zero

    Add-uDirectlyToArrayIfBoolTrue `
        -ArrayReference ( [ref] $CdaLikeInputCharacters ) `
        -Bool:$TolerateQuitStickCharacter `
        -ToAdd $script:uList_Character_ExitStick

    Add-uDirectlyToArrayIfBoolTrue `
        -ArrayReference ( [ref] $CdaLikeInputCharacters ) `
        -Bool:$TolerateSeparatorCharacter `
        -ToAdd $script:uCdaLikeInputCharactersPattern_SeparatorCharacter

    $CdaLikeInputCharacters = @( @( $CdaLikeInputCharacters ) | ForEach-Object -Process { [Regex]::Escape( $_ ) } )

    $CdaLikeInputCharacters = @( @( $CdaLikeInputCharacters ) + @( '\d' ) )

    $CdaLikeInputCharactersPattern = "($( @( $CdaLikeInputCharacters ) -join '|' ))+"

    return $CdaLikeInputCharactersPattern
}


function Get-uProcessedExpressionOrFallback {
    param(
        [Parameter( Mandatory = $false, ValueFromPipeline = $true )] [Object] $Expression,
        [Parameter( Mandatory = $false )] [Object] $Fallback = $script:uSentinelValue_String,
        [Switch] $TolerateDisplayListCharacter,
        [Switch] $TolerateZeroCharacter,
        [Switch] $TolerateQuitStickCharacter
    )

    if ( $TolerateDisplayListCharacter -and ( $script:uList_Character_DisplayList -eq $Expression ) ) {
        return $Expression
    }

    if ( $TolerateZeroCharacter -and ( $script:uList_Character_Zero -eq $Expression ) ) {
        return $Expression
    }

    if ( $TolerateQuitStickCharacter -and ( $script:uList_Character_ExitStick -eq $Expression ) ) {
        return $Expression
    }

    try {
        return ( [int] ( Invoke-Expression $Expression ) )
    }
    catch {
        return $Fallback
    }
    # Improvement idea: Be more explicit with error catching here.
}


function Get-uEvaluatedExpressionsFromTextAsNestedArray {
    param(
        [Parameter( Mandatory = $false )] [Object] $Text = $script:uSentinelValue_String,
        [Switch] $TolerateDisplayListCharacter,
        [Switch] $TolerateZeroCharacter,
        [Switch] $TolerateQuitStickCharacter
    )

    function Get-uFallbackReturn {
        return , @( , @( $script:uSentinelValue_String ) )
    }

    $Text = "$Text"

    if ( ( '' -eq $Text ) -or ( $script:uSentinelValue_String -eq $Text ) ) {
        return @( Get-uFallbackReturn )
    }

    $pattern = ( Get-uCdaLikeInputPattern `
            -TolerateDisplayListCharacter:$TolerateDisplayListCharacter `
            -TolerateZeroCharacter:$TolerateZeroCharacter `
            -TolerateQuitStickCharacter:$TolerateQuitStickCharacter `
            -TolerateSeparatorCharacter )

    $foundExpressionsRaw = $Text | Select-String -AllMatches -Pattern $pattern

    $foundExpressions = @( $foundExpressionsRaw.Matches.Value )

    $foundExpressionsEmptyFiltered = @( @( $foundExpressions ) | Where-Object -FilterScript {
        ( $null -ne $_ ) -and ( $script:uCdaLikeInputCharactersPattern_SeparatorCharacter -ne $_ ) }
    )

    if ( 0 -eq $foundExpressionsEmptyFiltered.Length ) {
        return @( Get-uFallbackReturn )
    }

    $slicedExpressions = @( @( $foundExpressionsEmptyFiltered ) | ForEach-Object -Process {
            , @( $_.Split( $script:uCdaLikeInputCharactersPattern_SeparatorCharacter ) ) }
    )

    $slicedExpressionsFiltered = @( @( $slicedExpressions ) | Where-Object -FilterScript {
            $null -ne $_ }
    )

    $slicedExpressionsFilteredTwice = @( @( $slicedExpressionsFiltered ) | ForEach-Object -Process {
            , @( $_ | Where-Object -FilterScript { ( $null -ne $_ ) -and ( '' -ne $_ ) } ) }
    )

    $slicedExpressionsFilteredThrice = @( @( $slicedExpressionsFilteredTwice ) | Where-Object -FilterScript {
            -not ( Get-uIsEqualByCompareObject -ItemOne @() -ItemTwo $_ ) }
    )

    if ( 0 -eq $slicedExpressionsFilteredThrice.Length ) {
        return @( Get-uFallbackReturn )
    }

    function Get-uProcessedExpressions {
        param(
            [Parameter( Mandatory = $false )] [Object] $Expressions
        )

        $processedExpressions = @( @( $Expressions ) | ForEach-Object -Process {
                Get-uProcessedExpressionOrFallback `
                    -Expression $_ `
                    -Fallback $script:uSentinelValue_String `
                    -TolerateDisplayListCharacter:$TolerateDisplayListCharacter `
                    -TolerateZeroCharacter:$TolerateZeroCharacter `
                    -TolerateQuitStickCharacter:$TolerateQuitStickCharacter }
        )

        $processedExpressionsFiltered = @( @( $processedExpressions ) | Where-Object -FilterScript {
                $_ -ne $script:uSentinelValue_String }
        )

        return $processedExpressionsFiltered
    }

    $processedExpressionsTwoDimensionalFiltered = @( @( $slicedExpressionsFilteredThrice ) | ForEach-Object -Process {
            , @( Get-uProcessedExpressions -Expressions $_ ) }
    )

    $processedExpressionsTwoDimensionalFilteredTwice = @( @( $processedExpressionsTwoDimensionalFiltered ) | `
                Where-Object -FilterScript { $_.Length -gt 0 }
    )

    if ( 0 -eq $processedExpressionsTwoDimensionalFilteredTwice.Length ) {
        return @( Get-uFallbackReturn )
    }

    return @( $processedExpressionsTwoDimensionalFilteredTwice )
}


function Get-uTwoDimensionalExtractedAndEvaluatedExpressionsFromObject {
    param(
        [Parameter( Mandatory = $false )] [Object] $Object,
        [Parameter( Mandatory = $false )] [Object] $Padding,
        [Switch] $TolerateDisplayListCharacter,
        [Switch] $TolerateZeroCharacter,
        [Switch] $TolerateQuitStickCharacter
    )

    if ( ( $null -ne $Object ) -and ( $Object.GetType().IsArray ) ) {

        $evaluatedExpressions = @( @( $Object ) | ForEach-Object -Process {
                Get-uProcessedExpressionOrFallback `
                    -Expression $_ `
                    -Fallback $script:uSentinelValue_String `
                    -TolerateDisplayListCharacter:$TolerateDisplayListCharacter `
                    -TolerateZeroCharacter:$TolerateZeroCharacter `
                    -TolerateQuitStickCharacter:$TolerateQuitStickCharacter }
        )

        $filteredExpressions = @( @( $evaluatedExpressions ) | Where-Object -FilterScript {
                $script:uSentinelValue_String -ne $_ }
        )

        $processedExpressions = @( @( $filteredExpressions ) | ForEach-Object -Process { , @( $_ ) } )

        return @( $processedExpressions )
    }

    if ( ConvertTo-uStringDirectly -ValueReference ( [ref] $Object ) ) {

        return @( Get-uEvaluatedExpressionsFromTextAsNestedArray `
                -Text $Object `
                -TolerateDisplayListCharacter:$TolerateDisplayListCharacter `
                -TolerateZeroCharacter:$TolerateZeroCharacter `
                -TolerateQuitStickCharacter:$TolerateQuitStickCharacter )

    }

    return @( , @( $Padding ) )
}

function Get-uWhichByAlphabetTimesQueue {
    param(
        [Parameter( Mandatory = $false, ParameterSetName = 'TwoStringInputMode' )] [Object] $WhichByAlphabet,
        [Parameter( Mandatory = $false, ParameterSetName = 'TwoStringInputMode'  )] [Object] $Times,
        [Parameter( Mandatory = $false, ParameterSetName = 'OneStringInputMode' )] [Object] `
            $OneString = $script:uSentinelValue_String,
        [Switch] $TolerateDisplayListCharacter,
        [Switch] $TolerateZeroCharacter,
        [Switch] $TolerateQuitStickCharacter
    )

    if ( $script:uSentinelValue_String -ne $OneString ) {
        $oneStringExtract = @( Get-uTwoDimensionalExtractedAndEvaluatedExpressionsFromObject `
                -Object:$OneString `
                -Padding:$script:uSentinelValue_String `
                -TolerateQuitStickCharacter:$TolerateQuitStickCharacter `
                -TolerateDisplayListCharacter:$TolerateDisplayListCharacter `
                -TolerateZeroCharacter:$TolerateZeroCharacter )

        $whichByAlphabetExtract = @( $oneStringExtract[0] )
        $timesExtract = @( $oneStringExtract[1] )
    }
    else {
        $whichByAlphabetExtract = @( Get-uTwoDimensionalExtractedAndEvaluatedExpressionsFromObject `
                -Object:$WhichByAlphabet `
                -Padding:$script:uSentinelValue_String `
                -TolerateDisplayListCharacter:$TolerateDisplayListCharacter `
                -TolerateZeroCharacter:$TolerateZeroCharacter `
                -TolerateQuitStickCharacter:$TolerateQuitStickCharacter )

        $timesExtract = @( Get-uTwoDimensionalExtractedAndEvaluatedExpressionsFromObject `
                -Object:$Times `
                -Padding:$script:uList_Input_Padding_Times `
                -TolerateDisplayListCharacter:$false `
                -TolerateZeroCharacter:$false `
                -TolerateQuitStickCharacter:$false )
    }

    $whichByAlphabetExtract_Flattened = @( Get-uFlattenedArray -Array @( $whichByAlphabetExtract ) )

    $timesExtract_Flattened = @( Get-uFlattenedArray -Array @( $timesExtract ) )

    $whichByAlphabet_Times_Queue_Length = ( [Math]::Max( $whichByAlphabetExtract_Flattened.Length,
            $timesExtract_Flattened.Length ) )

    $whichByAlphabetQueue = @( Get-uPaddedArrayToLength `
            -ArrayToPad $whichByAlphabetExtract_Flattened `
            -PaddingObject $script:uSentinelValue_String `
            -Length $whichByAlphabet_Times_Queue_Length )

    $timesQueue = @( Get-uPaddedArrayToLength `
            -ArrayToPad $timesExtract_Flattened `
            -PaddingObject $script:uList_Input_Padding_Times `
            -Length $whichByAlphabet_Times_Queue_Length )

    $timesQueue = @( @( $timesQueue ) | ForEach-Object -Process {
            if ( ( $script:uSentinelValue_String -eq $_ ) -or ( $null -eq $_ ) ) {
                $script:uList_Input_Padding_Times
            }
            else {
                [int] $_
            }
        }
    )

    $whichByAlphabet_Times_Queue = , @()

    for ( $i = 0; $i -lt $whichByAlphabet_Times_Queue_Length; $i++ ) {
        $whichByAlphabet_Times_Queue += , @( $whichByAlphabetQueue[$i], $timesQueue[$i] )
    }

    $whichByAlphabet_Times_Queue = @( $whichByAlphabet_Times_Queue[1..$whichByAlphabet_Times_Queue_Length] )

    return @( $whichByAlphabet_Times_Queue )
}


function Invoke-uSelectFileFromList {
    param(
        [Switch] $UseDirectories,
        [Switch] $Stick,
        [Switch] $WriteSelectedFile,
        [Switch] $NoList
    )

    $script:uSelectFileFromList_IsStick = $Stick

    if ( $UseDirectories ) {

        function Get-uChildren {
            return @( Get-uChildItems -IsDir )
        }

    }
    else {

        function Get-uChildren {
            return @( Get-uChildItems )
        }

    }

    Set-uNewWindowSizeVariables
    $script:uStickLoopDoBreak = $false
    $script:uChildren = @( Get-uChildren )
    $ListLength = $script:uChildren.Length

    function Invoke-uWhichByDirectoryCorrectFormatAction {
        if ( $script:uList_Character_Zero -eq $script:uWhichByAlphabet ) {
            $selectedFile = "$script:uOperatingPath\.."
        }
        elseif ( $script:uList_Character_DisplayList -eq $script:uWhichByAlphabet ) {
            Write-uFullItemList -ChildrenItems $script:uChildren -IsDir:$UseDirectories
            return
        }
        else {
            if ( ( [int] $script:uWhichByAlphabet ) -le 0 ) {
                $selectedFile = "$script:uOperatingPath\$( $script:uChildren[$script:uWhichByAlphabet] )"
            }
            else {
                $selectedFile = "$script:uOperatingPath\$( $script:uChildren[$script:uWhichByAlphabet - 1] )"
            }
        }

        $universalSelectedFile = ( Get-uUniversalPath -Path $selectedFile )

        $isUniversalSelectedFileSentinel = ( $script:uSentinelValue_String -eq $universalSelectedFile )
        $isUniversalSelectedFileValid = ( Test-Path -Path $universalSelectedFile )

        if ( $isUniversalSelectedFileSentinel -or ( -not $isUniversalSelectedFileValid ) ) {

            if ( ( -not $script:uSelectFileFromList_IsStick ) -and ( -not $NoList ) ) {
                Write-uFullItemList -ChildrenItems $script:uChildren -IsDir:$UseDirectories
            }

            return
        }

        Set-uVariableFToPath -Path $universalSelectedFile

        if ( $WriteSelectedFile ) {
            $selectedFileToWrite = $universalSelectedFile
            $selectedFile_LastCharacter = ( $selectedFileToWrite[-1] )

            if ( $selectedFile_LastCharacter -in @( '\', '/' ) ) {
                $selectedFileToWrite = $universalSelectedFile.Substring( 0, ( $universalSelectedFile.Length - 1 ) )
                $selectedFileToWrite = ( Get-uPathWithAddedBackslashIfNecessary -Path $selectedFileToWrite )
            }

            Write-Host "$( $script:uList_WriteSelectedFile_Prefix )$( $selectedFileToWrite )"
        }

        if ( $UseDirectories ) {
            Set-Location -Path $universalSelectedFile

            Set-uOperatingPathIfValid `
                -Path $universalSelectedFile `
                -Silent:$script:uSetOperatingPath_DefaultSilent_IfUsedBy_Script
        }
        else {
            return $universalSelectedFile
        }
    }

    function Invoke-uStickBadInputAction {
        Set-uNewWindowSizeVariables

        $boundaryOpening = ( Get-uBoundary `
                -LengthMultiplier $script:uBoundary_Length_Medium `
                -Direction $script:uBoundary_Direction_Name_Left )
        $boundaryClosing = ( Get-uBoundary `
                -LengthMultiplier $script:uBoundary_Length_Medium `
                -Direction $script:uBoundary_Direction_Name_Right )

        if ( $script:uList_Stick_BadInput_FirstTime -eq $true ) {
            $script:uList_Stick_BadInput_FirstTime = $false

            $secondsToWaitSuffix = 'seconds'

            $isSleepSecondsMoreThan2 = ( $script:uList_Stick_BadInput_Sleep_Milliseconds_FirstTime -lt 2000 )
            $isSleepSecondsLessOrEqual1 = ( $script:uList_Stick_BadInput_Sleep_Milliseconds_FirstTime -ge 1000 )

            if ( $isSleepSecondsMoreThan2 -and $isSleepSecondsLessOrEqual1 ) {
                $secondsToWaitSuffix = 'second'
            }

            $secondsToWait = $script:uList_Stick_BadInput_Sleep_Milliseconds_FirstTime / 1000

            Write-Host ''
            Write-Host "$boundaryOpening"
            Write-Host "Bad Input! Repeating in $( $secondsToWait ) $secondsToWaitSuffix..."
            Write-Host "$boundaryClosing"
            Write-Host ''

            Start-Sleep -Milliseconds $script:uList_Stick_BadInput_Sleep_Milliseconds_FirstTime
            return
        }

        Write-Host ''
        Write-Host "$boundaryOpening"
        Write-Host 'Bad Input! Repeating...'
        Write-Host "$boundaryClosing"
        Write-Host ''

        Start-Sleep -Milliseconds $script:uList_Stick_BadInput_Sleep_Milliseconds_NotFirstTime
    }

    function Invoke-uOneStickRepetition {
        $letAnswerPass = $false
        $errorTimes = 0
        $exceptionMessages = @()

        while ( -not $letAnswerPass ) {

            try {
                $beginningLocation = ( Get-Location )
                $script:uChildren = @( Get-uChildren )
                Write-uFullItemList -ChildrenItems $script:uChildren -IsDir:$UseDirectories -IsStick -NoNewlineUnderList

                $stickOption = ( Read-Host 'Option' )

                $whichByAlphabet_Times_Queue = @( Get-uWhichByAlphabetTimesQueue `
                        -OneString $stickOption `
                        -TolerateDisplayListCharacter `
                        -TolerateZeroCharacter `
                        -TolerateQuitStickCharacter
                )

                foreach ( $whichByAlphabetTimes_Pair in $whichByAlphabet_Times_Queue ) {
                    $script:uWhichByAlphabet = $whichByAlphabetTimes_Pair[0]

                    if ( $script:uList_Character_ExitStick -eq $script:uWhichByAlphabet ) {
                        $script:uStickLoopDoBreak = $true
                        return
                    }

                    $times = $whichByAlphabetTimes_Pair[1]

                    for ( $i = 0; $i -lt $times; $i++ ) {
                        $script:uChildren = @( Get-uChildren )
                        $ListLength = $script:uChildren.Length

                        Use-uWhichByAlphabet -ListLength $ListLength
                    }
                }

                $letAnswerPass = $true
            }
            catch {
                Invoke-uStickBadInputAction

                if ( $beginningLocation -eq ( Get-Location ) ) {
                    $errorTimes += 1
                }
                else {
                    $errorTimes = 0
                }

                $exceptionMessage = ( $_.Exception.Message )

                if ( $exceptionMessage -notin $exceptionMessages ) {
                    $exceptionMessages += $exceptionMessage
                }

                if ( $errorTimes -gt $script:uList_Stick_BadInput_MaxErrorRetries ) {

                    Write-Host ''

                    Write-Host "$( Get-uBoundary `
                        -LengthMultiplier $script:uBoundary_Length_Long `
                        -Direction $script:uBoundary_Direction_Name_Right )"

                    Write-Host "An Exception/s have Occurred Repeatedly ( $errorTimes times )"
                    Write-Host 'Exceptions:'

                    $exceptionWriteCount = 0

                    foreach ( $exceptionMessage in $exceptionMessages ) {
                        $exceptionWriteCount++

                        Write-Host ''
                        Write-Host "Exception $( $exceptionWriteCount ):"

                        $exceptionMessage = ( $_.Exception.Message )

                        if ( $exceptionMessage -ne '' ) {
                            Write-Host ( $exceptionMessage )
                        }
                        else {
                            Write-Host " ( The Exception's Message Property is Empty )"
                        }
                    }

                    Write-Host "$( Get-uBoundary `
                        -LengthMultiplier $script:uBoundary_Length_Long `
                        -Direction $script:uBoundary_Direction_Name_Right )"

                    Write-Host ''

                    $errorTimes = 0
                    Set-Location -Path '.\..'

                    $letAnswerPass = $true
                }

            }
            # Improvement idea: Be more explicit with error catching here.

        }

        if ( $script:uList_Stick_MoveTerminalAfterCorrectAnswer ) {
            Write-uSoftCleanTerminal
        }

    }

    function Invoke-uStickFunction {
        $script:uSelectFileFromList_IsStick = $false
        $script:uStickLoopDoBreak = $false

        while ( -not $script:uStickLoopDoBreak ) {
            Invoke-uOneStickRepetition
        }

        Write-Host ''
        Write-Host 'Exited The Stick Mode!'
        Write-Host ''

    }

    function Use-uWhichByAlphabet {
        param(
            [Parameter( Mandatory = $true )] [int] $ListLength
        )

        $script:uWhichByAlphabet = ( Get-uCorrectedWhichByAlphabet `
                -ListLength $ListLength `
                -AllowDisplayListCharacter `
                -AllowZeroCharacter `
                -AllowNegative )

        if ( $script:uSelectFileFromList_IsStick ) {
            if ( -not $UseDirectories ) {
                Write-Host ( "The '-UseDirectories' Parameter has to be True in order to use the '-Stick' Parameter",
                    "with 'Invoke-uSelectFileFromList'" -join '' )
                return
            }

            Invoke-uStickFunction
            return
        }

        if ( $script:uSentinelValue_String -eq $script:uWhichByAlphabet ) {
            if ( $NoList ) {
                return
            }

            Write-uFullItemList -ChildrenItems $script:uChildren -IsDir
            return
        }

        Invoke-uWhichByDirectoryCorrectFormatAction
    }

    Use-uWhichByAlphabet -ListLength $ListLength
}



function Invoke-uCdaLikeFunction {
    param(
        [Parameter( Mandatory = $false )] [String] $OperatingPath,
        [Parameter( Mandatory = $false )] [Object] $WhichByAlphabet,
        [Parameter( Mandatory = $false )] [Object] $Times,
        [Parameter( Mandatory = $false )] [scriptblock] $HelpFunction = $script:uSentinelValue_Scriptblock,
        [Switch] $Stick,
        [Switch] $Help,
        [Switch] $UseDirectories,
        [Switch] $ListForce,
        [Switch] $NoList,
        [Switch] $WriteSelectedFile
    )

    function Write-uListIfForce {
        if ( $ListForce ) {
            $script:uWhichByAlphabet = $script:uSentinelValue_String
            Invoke-uSelectFileFromList -UseDirectories:$UseDirectories
        }
    }

    if ( $Stick ) {
        $NoList = $true
    }

    Set-uOperatingPathIfValid -Path:$OperatingPath -Silent:$script:uSetOperatingPath_DefaultSilent_IfUsedBy_Script

    $whichByAlphabet_Times_Queue = @( Get-uWhichByAlphabetTimesQueue `
            -WhichByAlphabet:$WhichByAlphabet `
            -Times:$Times `
            -TolerateZeroCharacter `
            -TolerateDisplayListCharacter )

    if ( $Help ) {
        $null = ( & $HelpFunction )
        Write-uListIfForce
        return
    }

    foreach ( $whichByAlphabetTimes_Pair in $whichByAlphabet_Times_Queue ) {
        $script:uWhichByAlphabet = $whichByAlphabetTimes_Pair[0]

        for ( $i = 0; $i -lt $whichByAlphabetTimes_Pair[1]; $i++ ) {

            Invoke-uSelectFileFromList `
                -UseDirectories:$UseDirectories `
                -WriteSelectedFile:$WriteSelectedFile `
                -NoList:$NoList
        }
    }

    if ( $Stick ) {
        Invoke-uSelectFileFromList -Stick:$Stick -UseDirectories -WriteSelectedFile:$WriteSelectedFile
    }

    Write-uListIfForce
}


function Write-uApproximateTimeSinceScriptStart {
    $script:uLoadingEndTime = ( Get-Date )
    $script:uLoadTimeMillisecondsRounded = [Math]::Floor( ( $script:uLoadingEndTime - $script:uLoadingStartTime ).TotalMilliseconds + 0.5 )

    Write-Host "The $script:uProductName loaded in approximately $script:uLoadTimeMillisecondsRounded ms."
    Write-Host ''
}


# ------------------------------- MAIN FUNCTIONS ------------------------------


function Write-uFileIntroduction {
    if ( $script:uIntroduction_DoClearTerminalBeforeIntroduction ) {
        Clear-Host
    }

    $Message = @()

    # ------------------------- INTRODUCTION BEGINNING ------------------------

    $Message += @(
        "$( Get-uBoundary -LengthMultiplier $script:uBoundary_Length_Long -Direction $script:uBoundary_Direction_Name_Right )" )

    if ( $script:uIntroduction_Greeting_CurrentTimeText_Toggle -and ( $script:uSentinelValue_String -ne $greetingString ) ) {

        $Message += @(
            "$( $s1 )$( Get-uGreeting )"
            '' )
    }

    $Message += @(
        "$( $s1 )The $script:uProductName Has Been Applied!"
        "$( $s4 )- Version $script:uCurrentVersion"
        "$( $s4 )- Detected Operating System: $script:uCurrentOSType" )

    if ( ( $script:uIsWindows ) -and ( $script:uSentinelValue_String -ne $script:uWindowsTerminalIsAdmin ) ) {
        $Message += "$( $s4 )- IsAdmin - $script:uWindowsTerminalIsAdmin"
    }

    $Message += @(
        ''
        "$( $s1 )Features:"
        "$( $s2 )'cda' ( Change Directory Alphabetically ) -> Changing Directory without having to write filenames ( upgraded 'cd' )"
        "$( $s4 )Usage:"
        "$( $s6 )-> 'cda' -> Displays a list of directories that You can jump to"
        "$( $s6 )-> 'cda -Help' -> more information"
        "$( $s6 )-> 'cda directory_number_from_list' -> jump to a directory"
        "$( $s6 )-> 'cda 1' -> go to the first directory from the list"
        "$( $s6 )-> 'cda 2*4 -> jump to the 8'th directory from the list"
        "$( $s6 )-> 'cda 2,3,4 -> jump to the 2'nd directory, then to the 3'rd, and then to the 4'th"
        "$( $s6 )   This is the same as writing 'cda 2; cda 3; cda 4'"
        "$( $s6 )-> 'cda 0 3' -> jump to the 0'th directory 3 times."
        "$( $s6 )   This is the same as writing 'cda 0; cda 0; cda 0'"
        "$( $s6 )-> 'cda 1,2 3,4' -> Jump to the 1'st directory 3 times, and to the 2'nd directory 4 times."
        "$( $s6 )   This is the same as writing 'cda 1; cda 1; cda 1; cda 2; cda 2; cda 2; cda 2"
        "$( $s6 )   This is also the same as writing 'cda 1 3; cda 2 4'"
        "$( $s6 )-> 'cda' -Stick -> Makes the 'cda' command - makes You a real directory walker - displays a list and instantly prompts You for the answer - when You answer - a new list is displayed - repeated infinitely until You answer with the Quit character."
        "$( $s6 )   The stick parameter is pretty close to a file explorer, but not quite - it does not directly support file management - it makes You 'walk' the files"
        "$( $s5 )Note: The selected directory is also saved as '`$f'"
        ''
        "$( $s2 )'cdf' ( Current Directory File ) -> Selecting a file from the current Directory."
        "$( $s4 )Usage:"
        "$( $s6 ) Documentation in progress - this command is pretty similar to 'cda'."
        "$( $s6 )-> 'cdf -Path [your_path]' -> use 'cda' but from a path that's not the current working directory."
        "$( $s6 )-> 'cdf -Help' -> more information"
        "$( $s6 )-> 'cdf -Path [your_path]' -> use 'cdf' but from a path that's not the current working directory."
        "$( $s5 )Note: The selected file is also saved as '`$f'" )

    if ( $script:uIsWindows ) {

        $Message += @(
            "`n"
            "$( $s2 )'elev' ( Elevate Terminal ) - Starts a new powershell prompt with admin permissions in the same directory."
            "$( $s4 )Usage:"
            "$( $s6 )-> 'elev' -> Elevates the terminal to admin"
            "$( $s6 )-> 'sudo' -> An Alias for 'elev'"
            "$( $s5 )Note: This function is for Windows machines only." )
    }

    $Message += @(
        "`n"
        "$( Get-uBoundary -LengthMultiplier $script:uBoundary_Length_Long -Direction $script:uBoundary_Direction_Name_Left )" )

    if ( $script:uIntroduction_ScrollUpMessage_DoDisplay ) {

        $Message += @(
            "$( "`n" * ( $script:uIntroduction_ScrollUpMessage_NewlinesAbove - 1 ) )"
            "Scroll up for information about the applied $script:uProductName..."
            '...' )

        Set-uNewWindowSizeVariables
        $newLinesAmount = $script:uWindow_Height - 5
        if ( $script:uAlways_Write_Approximate_Loading_Time ) {
            $newLinesAmount -= 2
        }
        $newLines = ( "`n" * [Math]::Max( $newLinesAmount, 0 ) )

        $Message += "$newLines"
    }
    else {
        $Message += "`n"
    }

    Write-Host -Object ( $Message -join "`n" )
}


function cdf {
    param(
        [Parameter( Mandatory = $false, ValueFromPipeline = $true )] [Alias( 'w', 'i', 'n', 'number' )] [Object] `
            $WhichByAlphabet = $script:uSentinelValue_String,

        [Parameter( Mandatory = $false )] [Alias( 'o', 'p', 'path' )] [String] $OperatingPath = '.\',

        [Alias( 'h' )] [Switch] $Help,

        [Alias( 'l' )] [Switch] $ListForce,

        [Alias( 'nl' )] [Switch] $NoList,

        [Alias( 'ws' )] [Switch] $WriteSelectedFile
    )

    Invoke-uCdaLikeFunction -WhichByAlphabet:$WhichByAlphabet -Times '1' -OperatingPath:$OperatingPath `
        -HelpFunction { 'hello!' } -Stick:$false -Help:$Help -UseDirectories:$false -ListForce:$ListForce `
        -WriteSelectedFile:$WriteSelectedFile -NoList:$NoList
}


function cda {
    param(
        [Parameter( Mandatory = $false, ValueFromPipeline = $true )] [Alias( 'i', 'n', 'number' )] [Object] `
            $WhichByAlphabet = $script:uSentinelValue_String,

        [Parameter( Mandatory = $false )] [Alias( 't', 'r', 'repeat' )] [Object] $Times = 1,

        [Parameter( Mandatory = $false )] [Alias( 'o', 'p', 'path' )] [String] $OperatingPath = '.\',

        [Alias( 's' )] [Switch] $Stick,

        [Alias( 'h' )] [Switch] $Help,

        [Alias( 'l' )] [Switch] $ListForce,

        [Alias( 'nl' )] [Switch] $NoList,

        [Alias( 'w' )] [Switch] $WriteSelectedFile

    )

    function Write-uHelp {

        Write-Host -Object ( @(
                ''
                "$( Get-uBoundary -LengthMultiplier $script:uBoundary_Length_Long -Direction $script:uBoundary_Direction_Name_Right )"
                'cda - Command Help:'
                ''
                'Description:'
                "$( $s2 )'cda' in an abbreviation for 'Change Directory Alphabetically'"
                "$( $s2 )This function is an alternative to writing the directory names manually with the 'cd' command."
                "$( $s2 )It allows the user to change the directory simply by writing the number of that directory from a displayed list."
                ''
                'Possible Usage:'
                "$( $s2 )+ cda -> Get list of all directories in Your current working directory numbered and sorted alphabetically. ( Use this to check where You can Go )"
                "$( $s2 )+ cda [some number] -> Use this to go to a directory"
                "$( $s2 )+ cda 0 -> A special number -> This is the same as doing 'cd .\..` - Going back one directory level"
                "$( $s2 )+ cda -Path -> Use a custom path with cda"
                "$( $s2 )+ cda -Stick -> Enter stick mode -> This function will be called repeatedly until You quit it with '-1'"
                ''
                "For More Specific Argument Help and Available Aliases, do - 'help cda'"
                "$( Get-uBoundary -LengthMultiplier $script:uBoundary_Length_Long -Direction $script:uBoundary_Direction_Name_Left )"
                ''
            ) -join "`n" )
    }

    Invoke-uCdaLikeFunction -WhichByAlphabet:$WhichByAlphabet -Times:$Times -OperatingPath:$OperatingPath `
        -HelpFunction { Write-uHelp } -Stick:$Stick -Help:$Help -UseDirectories -ListForce:$ListForce `
        -WriteSelectedFile:$WriteSelectedFile -NoList:$NoList

}
Set-uAliasBulk -Value 'cdf' -Aliases $script:uAliases_cdf -Scope 'Script'
Set-uAliasBulk -Value 'cda' -Aliases $script:uAliases_cda -Scope 'Script'


if ( $script:uIsWindows ) {


    function elev {
        param(
            [Alias( 'e', 'q', 'ex', 'qu', 'exit', 'quit' )] [Switch] $ExitCurrentTerminal = `
                $script:uElev_Default_ExitCurrentTerminal
        )

        try {
            $currentAbsoluteLocation = ( Convert-Path -Path ( Get-Location ) )

            Start-Process -FilePath 'powershell.exe' -Verb RunAs -ArgumentList (
                '-NoExit',
                '-Command',
                '( $host.UI.RawUI.WindowTitle = $script:uElev_NewTerminalTitle );',
                '( Start-uTaskbarFlashingForConsoleWindow );',
                "( Set-uNearestAvailableLocationFromPath -AbsolutePath '$currentAbsoluteLocation' );",
                "( Set-uOperatingPathIfValid -Path ( Get-uNearestAvailableLocationFromPath -AbsolutePath '$currentAbsoluteLocation' ) -Silent:`$script:uSetOperatingPath_DefaultSilent_IfUsedBy_Script );",
                ( 'Write-Host """You''ve Launched An Elevated PowerShell Prompt! ( IsAdmin ', `
                    '$( $script:uWindowsTerminalIsAdmin ) )."""' -join '' ) -join ' ' )

            if ( $ExitCurrentTerminal ) {
                Exit
            }
            else {
                Write-Host 'Launching an elevated PowerShell terminal...'
            }
        }
        catch {
            $Introduction = 'Something went wrong while launching a new elevated terminal.'
            Write-uShortErrorCatchMessage -Introduction $Introduction -ErrorObject $_
        }
        # Improvement idea: Be more explicit with error catching here.

    }

    Set-uAliasBulk -Value 'elev' -Aliases $script:uAliases_elev -Scope 'Script'


    function noelev {
        param(
            [Alias( 'e', 'q', 'ex', 'qu', 'exit', 'quit' )] [Switch] $ExitCurrentTerminal = `
                $script:uNoElev_Default_ExitCurrentTerminal
        )

        $currentAbsoluteLocation = ( Convert-Path -Path ( Get-Location ) )

        function Get-uNoElevScheduledTaskName {
            $scheduledTasksNames = ( [String[]] ( Get-ScheduledTask ).TaskName )
            $scheduledTasksNamesHashSet = ( [System.Collections.Generic.HashSet[String]]::new(
                    $scheduledTasksNames ) )

            $taskNameIndex = 0

            while ( $true ) {
                $taskNameIndex++

                $taskNameCandidate = ( "$script:uNoElev_ScheduledTaskName_DeleteMePrefix noelev - Start New ",
                    "Terminal ( $taskNameIndex )" -join '' )

                if ( $taskNameCandidate -notin ( $scheduledTasksNamesHashSet ) ) {
                    return $taskNameCandidate
                }
            }
        }

        try {
            Unregister-uDeleteMeTasks

            $action = ( New-ScheduledTaskAction -Execute 'powershell.exe' -Argument (
                    '-NoExit',
                    '-Command',
                    '( $host.UI.RawUI.WindowTitle = $script:uNoElev_NewTerminalTitle );',
                    "( Set-uNearestAvailableLocationFromPath -AbsolutePath '$currentAbsoluteLocation' );",
                    "( Set-uOperatingPathIfValid -Path ( Get-uNearestAvailableLocationFromPath -AbsolutePath '$currentAbsoluteLocation' ) -Silent:`$script:uSetOperatingPath_DefaultSilent_IfUsedBy_Script );",
                    '( Write-Host """You''ve Launched a Normal PowerShell Prompt! ( IsAdmin $( $script:uWindowsTerminalIsAdmin ) ).""" )' `
                        -join ' ' )
            )
            $trigger = ( New-ScheduledTaskTrigger -Once -At ( $script:uUnixEpochDate ) )
            $taskName = ( Get-uNoElevScheduledTaskName )
            $settings = ( New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries ) # Do not forget the crucial
            # -AllowStartIfOnBatteries when editing this area.

            $windowsTerminalProcessesSnapshot = @( Get-uWindowsTerminalProcesses )

            Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $taskName -Settings $settings -Force | `
                    Start-ScheduledTask

            Unregister-uDeleteMeTasks

            $windowsTerminalProcessesSnapshot_New = ( Get-uWindowsTerminalProcesses )
            $newWindowsTerminalProcesses = @( @( $windowsTerminalProcessesSnapshot_New ) | Where-Object -FilterScript {
                    $_ -notin $windowsTerminalProcessesSnapshot }
            )

            if ( 0 -eq $newWindowsTerminalProcesses.Length ) {
                @( @( $windowsTerminalProcessesSnapshot_New ) | ForEach-Object -Process {
                        Start-uTaskbarFlashingForProcess -Process $_ }
                )
            }
            else {
                @( @( $newWindowsTerminalProcesses ) | ForEach-Object -Process {
                        Start-uTaskbarFlashingForProcess -Process $_ }
                )
            }

            if ( $ExitCurrentTerminal ) {
                Exit
            }

        }
        catch {
            $Introduction = 'Something went wrong while opening a new normal terminal.'
            Write-uShortErrorCatchMessage -Introduction $Introduction -ErrorObject $_
        }
        # Improvement idea: Be more explicit with error catching here.

    }

    Set-uAliasBulk -Value 'noelev' -Aliases $script:uAliases_noelev -Scope 'Script'
}


# --------------------------- INTRODUCTION AND SETUP --------------------------

if ( $script:uIntroduction_Toggle ) {
    Write-uFileIntroduction
}

if ( $script:uAlways_Write_Approximate_Loading_Time ) {
    Write-uApproximateTimeSinceScriptStart
}

# ---------------------------------> LICENSE <---------------------------------
# MIT License

# Copyright (c) 2023 Jakub Wojnowski

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# in the Software without restriction, including without limitation the rights
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
