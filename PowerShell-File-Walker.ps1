if ( $script:w6_AlreadyLoaded ) { continue }
( $script:w6_LoadingTimeStopwatch = [System.Diagnostics.Stopwatch]::new() ).Start()
$script:w6_AlreadyLoaded = $true
$script:w6_StartingWindowTitle = [string] $host.UI.RawUI.WindowTitle
$script:w6_Product_Name = [string] 'PowerShell-File-Walker Commands Bundle'
$script:w6_Product_Version = [string] 'v1.0.0'

# UPDATE 2025 - LOADING USER CONFIGURATION HAS BEEN DEPRECATED
# UPDATE 2025 - WIKI HAS BEEN CANCELLED

# BY USING/MODIFYING/SHARING/DEALING WITH THIS SOFTWARE, YOU AGREE TO ITS LICENSE!

# ---------------------------------- LICENSE ----------------------------------
# MIT License

# Copyright (c) 2023 Jakub Wojnowski

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
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
# -------------------------------- Introduction -------------------------------

# This file contains cda and cdf functions that make file navigation in PowerShell a piece of cake!
# It also contains the elev and unelev functions as bonuses

# Note about prefixes:
#       Most variables and functions are prefixed (currently with "w6_") to avoid the user/other PowerShell scripts from overriding them them by mistake

#                 I'd appreciate a notice of the The Original Project in Your edits/forks
#                 I'm no lawyer, so make sure the MIT doesn't ask for that already

# Note about the data file:
#       The script creates a .dotfile at the user's home directory. It is used to store persistent data
#       Currently the .dotfile has only one thing to store - the loads count
#       To store more than one piece of information you'd have to upgrade this script

# Helpful RegExes to make code formatting easier:

#    These RegExes should work with VSCode's Ctrl+F feature:

#       - Find () brackets without spaces -  (?:(?<! |\(|\n)\))|(?:\((?! |\)|\n))

#       - Find {} brackets without spaces -  (?:(?<! |\{|\n)\})|(?:\{(?! |\}|\n))

#       - Find [] brackets with spaces -  (?:\[(?= )|(?<= )\])

#       - Find function definitions without 'w6_' -  (?:function \w+-[^w][^6][^_]\w*)

#       - Find script-scope variables without 'w6_' -  (?:\$script:[^w][^6][^_]\w*)

#    These RegExes do not work with VSCode's Ctrl+F feature - use an alternative tool:

#       - Find variables with missing '$script:' (experimental)
#           \$(?!script:)(\w+(?!\w))(?<=\$script:\1[\S\s]*)
#         Works on https://regex101.com with the ECMAScript (JavaScript) flavour
#         Explanation: If a script-scope variable is defined with '$script:' - BUT LATER the variable is referenced WITHOUT '$script:' - the reference WITHOUT '$script' should be found by this regex
#         e.g.:
#         $RegexTest_Hello        <- doesn't match, because this regex does not match backwards BEFORE a definition with '$script'
#         $script:RegexTest_Hello <- doesn't match. A reference with '$script:' tells the regex that this is a script-scope variable
#         $RegexTest_Hello        <- should match, because there is missing '$script' text


# -------------------------------------- Settings -----------------------------

# This is an important section where all settings are stored
$script:w6_Boundary_Character_Body = [string] '-'
$script:w6_Boundary_Character_LeftTip = [string] '<'
$script:w6_Boundary_Character_RightTip = [string] '>'
$script:w6_Boundary_Length_Full = [double] 1 # Changing this multiplier affects every other Length
$script:w6_Boundary_Length_Long = [double] 0.95
$script:w6_Boundary_Length_Max = [double] 1 # Same as full, but doesn't affect other other Lengths
$script:w6_Boundary_Length_Medium = [double] 0.65
$script:w6_Boundary_Length_Short = [double] 0.45
$script:w6_CdaLikeCommands_InputCharactersPattern_SeparatorCharacter = [string] ','
$script:w6_Elev_Default_ExitCurrentSession = [bool] $false
$script:w6_Elev_NewConsoleTitle = [string] $script:w6_StartingWindowTitle
$script:w6_Get_Color_Combinations_Characters_PaddingToMiddle = [string] ' '
$script:w6_Introduction_DoClearConsoleBeforeIntroduction = [bool] $true # Turning this ON may hide errors that occurred during setup
$script:w6_Introduction_Greeting_CurrentTimeText_Format = [int] 'Both' # Available options: 24, 12, 'Both'
$script:w6_Introduction_Greeting_StartHour_Afternoon = [int] 12
$script:w6_Introduction_Greeting_StartHour_Evening = [int] 17
$script:w6_Introduction_Greeting_StartHour_Morning = [int] 5
$script:w6_Introduction_Greeting_Text_Afternoon = [string] 'Good Afternoon!'
$script:w6_Introduction_Greeting_Text_Evening = [string] 'Good Evening!'
$script:w6_Introduction_Greeting_Text_Fallback = [string] 'Greetings!'
$script:w6_Introduction_Greeting_Text_Morning = [string] 'Good Morning!'
$script:w6_Introduction_MaxTotalAutomaticWrites = [int] 3
$script:w6_Introduction_ScrollUpMessage_DoDisplay = [bool] $true
$script:w6_Introduction_ScrollUpMessage_NewlinesAbove = [int] 5
$script:w6_Introduction_Toggle = [bool] $false
$script:w6_Introduction_Toggle_CommandsHelp = [bool] $true
# $script:w6_Introduction_Toggle_ConfigStats = [bool] $true
$script:w6_Introduction_Toggle_DetectedOS = [bool] $true
$script:w6_Introduction_Toggle_Greeting = [bool] $true
$script:w6_List_AfterAttributesListNumber_ListNumber_Visible = [bool] $true # Turning this off may be useful if you want to have custom "frame" for cda - you can change the afterattributes
$script:w6_List_AfterAttributesListNumber_ToggleFullDisplay = [bool] $true
$script:w6_List_Attributes_BlackList_cda = [string[]] @( 'Directory', 'NotContentIndexed', 'ReparsePoint', 'Normal', 'Archive' )
$script:w6_List_Attributes_BlackList_cdf = [string[]] @( 'NotContentIndexed', 'ReparsePoint', 'Normal', 'Archive' )
$script:w6_List_Attributes_Character_Arrow = [string] ' -> '
$script:w6_List_Attributes_Character_AttributeSeparator = [string] ', '
$script:w6_List_Attributes_Character_Dash = [string] '-'
$script:w6_List_Attributes_Character_Space = [string] ' '
$script:w6_List_Attributes_ClosingNumberPrefix = [string] ''
$script:w6_List_Attributes_ClosingNumberSuffix = [string] '' # If you have very long file names or very little screen space, to the point, where one file name takes over one console line - I recommend setting this setting to the ' apostrophe character.
$script:w6_List_Attributes_Colors_Default_Priority = [double] 10
$script:w6_List_Attributes_FirstDash_Character = [string] '>'
$script:w6_List_Attributes_FirstDash_SpacesBefore = [int] 4
$script:w6_List_Attributes_MinCharactersSeparating_Left1 = [int] 3000 # A high number here makes attributes stretch to the left as far as they can whilst respecting the Separation from the right # Preferred amount of spaces
$script:w6_List_Attributes_MinCharactersSeparating_Left2 = [int] 7 # The minimum amount of spaces before starting to decrease Right
$script:w6_List_Attributes_MinCharactersSeparating_Left3 = [int] 3  # The absolute minimum amount of spaces
$script:w6_List_Attributes_MinCharactersSeparating_Right = [int] 30
$script:w6_List_Attributes_PriorityList_cda = [string[]] @( 'System' )
$script:w6_List_Attributes_PriorityList_cdf = [string[]] @( 'System' )
$script:w6_List_Attributes_SpacesBetweenDashes = [int] 35
$script:w6_List_BeforeCounterText_Character_Space = [string] ' '
$script:w6_List_BeforeCounterText_SpacesIfOneDigit = [int] 3
$script:w6_List_BeforeDisplay_SoftClearConsole = [bool] $true
$script:w6_List_Boundary_LengthEquation_WindowWidthSubtracting_MinCharactersSeparatingRightMultiplier = [double] 0.9
$script:w6_List_Character_AccessDenied = [string] '!'
$script:w6_List_Character_Bracket_ListNumber_AfterAttributes_Closing = [string] ']'
$script:w6_List_Character_Bracket_ListNumber_AfterAttributes_Opening = [string] ' ['
$script:w6_List_Character_Bracket_ListNumber_BeforeAttributes_Closing = [string] ']'
$script:w6_List_Character_Bracket_ListNumber_BeforeAttributes_Opening = [string] '['
$script:w6_List_Character_DisplayList = [string] 'l'
$script:w6_List_Character_DisplayList_DoDisplayOnList = [bool] $false # Controls if the 'DisplayList' character will itself be displayed on the list.
$script:w6_List_Character_ExitStick = [string] 'q'
$script:w6_List_Character_Zero = [string] '0'
$script:w6_List_Colors_Toggle = [bool] $true
$script:w6_List_FileAttributes_Toggle = [bool] $true
$script:w6_List_ForceFiles_DefaultValue = [bool] $true
$script:w6_List_Input_MathCharacters = [string[]] @( '*', '/', '%', '+', '-', '(', ')', '.' ) # During the first cda/cdf/stick call, the script filters these characters. If any of these characters is a PowerShell command/alias, then it's removed from the list. E.g. '%' is an alias for ForEach-Object by default, so it's removed from the list later on.
$script:w6_List_NegativeValues_Display_Separator = [string] ','
$script:w6_List_NegativeValues_Display_ShowEveryXthListing = [int] 5
$script:w6_List_NegativeValues_Display_Toggle = [bool] $false
$script:w6_List_Stick_BadInput_FirstTime = [bool] $true # If set to true - the first time an incorrect stick option is passed - an alternative (longer) message will be displayed
$script:w6_List_Stick_BadInput_MaxErrorRetries = [int] 4
$script:w6_List_Stick_BadInput_Sleep_Milliseconds_FirstTime = [int] 1000
$script:w6_List_Stick_BadInput_Sleep_Milliseconds_NotFirstTime = [int] 300
$script:w6_List_WindowTitle_Processing = [string] 'Processing...'
$script:w6_List_WriteSelectedFiles_DefaultValue_cda = [bool] $false
$script:w6_List_WriteSelectedFiles_DefaultValue_cdf = [bool] $false
$script:w6_SetOperatingPath_DefaultParameterValue_Silent_IfUsedBy_Script = [bool] $true
$script:w6_SetOperatingPath_DefaultParameterValue_Silent_IfUsedBy_User = [bool] $false
$script:w6_TaskbarFlashing_FlashTimes = [int] 100
$script:w6_TaskbarFlashing_OneFlashDurationMilliseconds = [int] 1500
$script:w6_Unelev_Default_ExitCurrentSession = [bool] $false
$script:w6_Unelev_NewConsoleTitle = [string] $script:w6_StartingWindowTitle
$script:w6_Unelev_ScheduledTaskName_RemoveMeNamedPrefix = [string] '(REMOVE ME)'
$script:w6_Write_Approximate_Loading_Time = [bool] $true

$script:w6_List_Attributes_RenameTable = [hashtable] @{
    # 'ReadOnly'   = 'R'
    # 'Hidden'     = 'H'
    # 'System'     = 'S'
    # 'Directory'  = 'D'
    # 'Archive'    = 'A'
    # 'Normal'     = 'N'
    # 'Temporary'  = 'T'
    # 'Compressed' = 'C'
    # 'Offline'    = 'O'
    # 'Encrypted'  = 'E'
    # 'ReparsePoint' = 'RP'
    # 'NotContentIndexed' = 'NCI'

    # 'ReadOnly'          = [char]::ConvertFromUtf32( 0x1F635 )
    # 'Hidden'            = [char]::ConvertFromUtf32( 0x1F648 )
    # 'System'            = [char]::ConvertFromUtf32( 0x1F976 )
    # 'Directory'         = [char]::ConvertFromUtf32( 0x1F4C1 )
    # 'Archive'           = [char]::ConvertFromUtf32( 0x1F60E )
    # 'Normal'            = [char]::ConvertFromUtf32( 0x1F610 )
    # 'Temporary'         = [char]::ConvertFromUtf32( 0x1F605 )
    # 'Compressed'        = [char]::ConvertFromUtf32( 0x1F4A9 )
    # 'Offline'           = [char]::ConvertFromUtf32( 0x1F47E )
    # 'Encrypted'         = [char]::ConvertFromUtf32( 0x1F47B )
    # 'ReparsePoint'      = [char]::ConvertFromUtf32( 0x1F517 )
    # 'NotContentIndexed' = [char]::ConvertFromUtf32( 0x1F4A1 )
}

$script:w6_List_Attributes_Colors = [hashtable] @{
    # Use 'Write-w6_ColorCombinations' to get a colored list with all valid color combinations <- Epilepsy warning
    # The default order is - for each foreground color, all background colors are displayed.
    # Use '-Swap' to flip the sorting to - For each background color, all foreground colors are displayed.
    #
    # To get a raw list of Available Colors use: 'Write-w6_Colors'.

    # If many match - the one with the __ LOWEST __ priority will be applied.

    # # Example of one full entry:
    # 'The attribute name displayed on the list' = @{
    #     'BackgroundColor_Priority' = 1
    #     'BackgroundColor'          = 'Red'
    #     'ForegroundColor_Priority' = 1
    #     'ForegroundColor'          = 'Blue'
    # }
    # # Second example:
    # 'Hidden' = @{
    #     'ForegroundColor_Priority' = 6
    #     'ForegroundColor'          = 'DarkGray'
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
    #  - 'Default' - you can explicitly say to use the default color chosen by the console
}

# Aliases Notes:
# A big amount of aliases can noticeably decrease the loading times - thus many are commented out
# Double ## means that the alias is considered better than others

$script:w6_Aliases_cda = [string[]] @(
    ## 'Set-DirectoryAlphabetically'
)

$script:w6_Aliases_cdf = [string[]] @(
    ## 'Get-CurrentDirectoryFile'
)

$script:w6_Aliases_elev = [string[]] @(
    ## 'Elevate'

    # 'Elevate-Terminal'
    # 'Elevate-PowerShellTerminal'
    # 'Open-ElevatedTerminal'
    ## 'Open-ElevatedPowerShellTerminal'

    ## 'wsudo' # Short for 'Windows Sudo'
    'wudo' # Short for 'wsudo'
    # 'sudo' # The 'elev' command works only on Windows machines, therefore - this alias WON'T overwrite
    #        the built-in 'sudo' command in Unix systems ( Linux, MacOS, etc. )
)

$script:w6_Aliases_unelev = [string[]] @(
    ## 'Unelevate'

    # 'Unelevate-Terminal'
    # 'Unelevate-PowerShellTerminal'
    # 'Open-UnelevatedTerminal'
    ## 'Open-UnelevatedPowerShellTerminal'

    ## 'unsudo'
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
    # 'wnudo'
)

# Indentation for messages.
$w6_s1 = [string] ' '
$w6_s2 = [string] '  '
# $w6_s3 = [string] '   ' # Unused
$w6_s4 = [string] '      '
# $w6_s5 = [string] '        ' # Unused
$w6_s6 = [string] '          '

# ---------------------------- PRIVATE FUNCTIONS 1 ----------------------------

# These two commands have proven to be very valuable for profiling this script
# ms means "measure script"
# mss means "measure script sort" - because mss sorts the output
# IMPORTANT: YOU MUST HAVE THE PSPROFILER MODULE INSTALLED `Install-Module PSProfiler`
# function ms {
#     pwsh -NoProfile -Command {
#         $FilePath = 'PATH TO YOUR POWERSHELL-FILE-WALKER COMMANDS BUNDLE SCRIPT HERE'
#         $scriptContent = Get-Content -Path $FilePath -Raw
#         $scriptBlock = [scriptblock]::Create( $scriptContent )
#         Clear-Host
#         Measure-Script -ScriptBlock $scriptBlock -Top 120
#     }
# }
# function mss {
#     pwsh -NoProfile -Command {
#         $FilePath = 'PATH TO YOUR POWERSHELL-FILE-WALKER COMMANDS BUNDLE SCRIPT HERE'
#         $scriptContent = Get-Content -Path $FilePath -Raw
#         $scriptBlock = [scriptblock]::Create( $scriptContent )
#         Clear-Host
#         Measure-Script -ScriptBlock $scriptBlock -Top 120 | Sort-Object -Property ExecutionTime
#     }
# }


function Get-w6_StringSplitWithArray {
    param(
        [Parameter( Mandatory = $true )] [object] $String,
        [Parameter( Mandatory = $true )] [object] $Array
    )

    $Array = @( $Array )

    $stringSplit = @( $String )

    foreach ( $Item in $Array ) {
        $stringSplit = @( @( $stringSplit ).Split( $Item ) )
    }

    return @( $stringSplit )
}


function Get-w6_ValueOrFallback {
    param(
        [Parameter( Mandatory = $false )] [object] $ToReturn,
        [Parameter( Mandatory = $false )] [object] $Fallback,
        [Parameter( Mandatory = $false )] [object] $BlacklistOneItem = $script:w6_SentinelValue_String2,
        [Parameter( Mandatory = $false )] [object] $BlacklistMultipleItems = $script:w6_SentinelValue_String2,
        [Parameter( Mandatory = $false )] [object] $PrependIfCorrect = '',
        [Parameter( Mandatory = $false )] [object] $AppendIfCorrect = '',
        [Parameter( Mandatory = $false )] [object] $AppendAfterComparison = '',
        [Parameter( Mandatory = $false )] [object] $PrependAfterComparison = '',
        [switch] $IsMultiInputBlacklistOneItem
    )

    $isToReturnEqualToBlacklist = ( ( $script:w6_SentinelValue_String2 -ne $BlacklistOneItem ) `
            -and ( ( $ToReturn -eq $BlacklistOneItem ) `
                -or ( Get-w6_IsEqualByCompareObject -ItemOne $ToReturn -ItemTwo $BlacklistOneItem ) ) )

    $isToReturnInBlacklist = ( ( $script:w6_SentinelValue_String2 -ne $BlacklistMultipleItems ) `
            -and ( ( $toReturn -in $BlacklistMultipleItems ) ) )

    if ( $isToReturnEqualToBlacklist -or $isToReturnInBlacklist ) {
        $toReturnRaw = "$( $Fallback )"
    }
    else {
        $toReturnRaw = "$( $PrependIfCorrect )$( $ToReturn )$( $AppendIfCorrect )"
    }

    return "$( $PrependAfterComparison )$( $toReturnRaw )$( $AppendAfterComparison )"
}


function Get-w6_StringWithoutDoubleSlashes {
    param(
        [Parameter( Mandatory = $true )] [string] $String
    )

    return ( ( $String -replace ( '\\\\', '\' ) ) -replace ( '//', '/' ) )
}


function Get-w6_KernelName {
    try {
        return ( uname --kernel-name )
    }
    catch {
        return $script:w6_SentinelValue_Unknown
    }
    # Improvement idea: Be more explicit with error catching here.
}


function Get-w6_UnixOSType {
    param(
        [Parameter( Mandatory = $false )] [string] $KernelName = $script:w6_SentinelValue_String
    )

    $KernelName = $KernelName.ToLower().Trim()

    if ( $KernelName -match 'linux' ) {
        return $script:w6_OSType_Return_Linux
    }

    if ( $KernelName -match 'darwin' ) {
        return $script:w6_OSType_Return_MaxOS
    }

    return $script:w6_SentinelValue_Unknown
    # Improvement idea: Be more explicit with error catching here.

}


function Get-w6_OSType {

    try {
        $OSType = ( [System.Environment]::OSVersion.Platform )

        if ( $OSType -eq 'Win32NT' ) {
            return $script:w6_OSType_Return_Windows
        }

        if ( $OSType -eq 'Unix' ) {
            return ( Get-w6_UnixOSType -KernelName ( Get-w6_KernelName ) )
        }
    }
    catch {
        continue
    }
    # Improvement idea: Be more explicit with error catching here.

    return $script:w6_OSType_Return_Unknown

}


function Set-w6_NewWindowSizeVariables {
    param(
        [switch] $Height,
        [switch] $Width
    )

    $rawUIWindowSize = ( $host.UI.RawUI.WindowSize )

    if ( $Height ) {
        $script:w6_Window_Height = ( [Math]::Floor( $rawUIWindowSize.Height + 0.5 ) )
    }

    if ( $Width ) {
        $script:w6_Window_Width = ( [Math]::Floor( $rawUIWindowSize.Width + 0.5 ) )
    }
}


function ConvertTo-w6_DoubleDirectly {
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


function ConvertTo-w6_StringDirectly {
    param(
        [Parameter( Mandatory = $true )] [ref] $ValueReference
    )

    try {
        $ValueReference.Value = ( [string] ( $ValueReference.Value ) )
        return $true
    }
    catch {
        return $false
    }
}


function Write-w6_HostIfIsNotAnEmptyString {
    param(
        [Parameter( Mandatory = $false )] [object] $Message
    )

    if ( ( $script:w6_SentinelValue_String -ne $Message ) `
            -and ( ConvertTo-w6_StringDirectly -ValueReference ( [ref] $Message ) ) `
            -and ( '' -ne $Message ) ) {
        Write-Host $Message
    }
}


function Get-w6_IsEqualByCompareObject {
    param(
        [Parameter( Mandatory = $false )] [object] $ItemOne,
        [Parameter( Mandatory = $false )] [object] $ItemTwo
    )

    $comparison = ( Compare-Object -ReferenceObject $ItemOne -DifferenceObject $ItemTwo )

    if ( $null -eq $comparison ) {
        return $true
    }
    return $false
}


function Write-w6_ShortErrorCatchMessage {
    param(
        [Parameter( Mandatory = $false )] [string] $Introduction = $script:w6_SentinelValue_String,
        [Parameter( Mandatory = $false )] [string] $SuspectedReason = $script:w6_SentinelValue_String,

        [Parameter( Mandatory = $false )] [string] $IntroductionIntroduction = '',
        [Parameter( Mandatory = $false )] [string] $ExceptionMessageIntroduction = '  Exception Message: ',
        [Parameter( Mandatory = $false )] [string] $SuspectedReasonIntroduction = '  Suspected Reason: ',
        [Parameter( Mandatory = $false )] [string] $ExceptionLineIntroduction = 'Exception Line: ',

        [Parameter( Mandatory = $false )] [string] $UpperBoundary = '',
        [Parameter( Mandatory = $false )] [string] $LowerBoundary = '',

        [Parameter( Mandatory = $false, ParameterSetName = 'ErrorObject' )] [object] $ErrorObject = $script:w6_SentinelValue_String,

        [Parameter( Mandatory = $false, ParameterSetName = 'CustomDetails' )] [object] $CustomExceptionMessage = $script:w6_SentinelValue_String,

        [Parameter( Mandatory = $false, ParameterSetName = 'CustomDetails' )] [object] $CustomExceptionLine = $script:w6_SentinelValue_String,

        [Parameter( Mandatory = $false, ParameterSetName = 'CustomDetails' )] [switch] $NoErrorDetails
    )

    $commonBadArgumentValues = @( $null, $script:w6_SentinelValue_String )

    $IntroductionMessage = ( Get-w6_ValueOrFallback `
            -ToReturn $Introduction `
            -Fallback 'An Exception Has Been Caught!' `
            -PrependIfCorrect $IntroductionIntroduction `
            -BlacklistMultipleItems $commonBadArgumentValues )

    $ExceptionMessage = ( Get-w6_ValueOrFallback `
            -ToReturn $CustomExceptionMessage `
            -Fallback ( $ErrorObject.Exception.Message ) `
            -BlacklistMultipleItems $commonBadArgumentValues )

    $SuspectedReasonMessage = ( Get-w6_ValueOrFallback `
            -ToReturn $SuspectedReason `
            -Fallback '' `
            -PrependIfCorrect $SuspectedReasonIntroduction `
            -BlacklistMultipleItems $commonBadArgumentValues )

    $ExceptionLineMessage = ( Get-w6_ValueOrFallback `
            -ToReturn $CustomExceptionLine `
            -Fallback ( $ErrorObject.InvocationInfo.ScriptLineNumber ) `
            -BlacklistMultipleItems $commonBadArgumentValues )

    if ( $NoErrorDetails ) {
        Write-Host $UpperBoundary
        Write-Host $IntroductionMessage
        Write-Host $LowerBoundary

        return
    }

    Write-Host $UpperBoundary
    Write-w6_HostIfIsNotAnEmptyString -Message $IntroductionMessage
    Write-w6_HostIfIsNotAnEmptyString -Message $ExceptionMessage
    Write-w6_HostIfIsNotAnEmptyString -Message $SuspectedReasonMessage
    Write-w6_HostIfIsNotAnEmptyString -Message $ExceptionLineMessage
    Write-Host $LowerBoundary
}


function Get-w6_PathWithAddedSlashIfNecessary {
    param(
        [Parameter( Mandatory = $true )] [object] $Path
    )

    if ( ( [System.Text.RegularExpressions.Regex]::Matches( $Path, $script:w6_PathSlashes_Any_Regex ).Count ) -eq 0 ) {
        return "$( $Path )$( $script:w6_PathSlash )"
    }
    return ( [string] "$Path" )
}


function Get-w6_UniversalPath {
    param(
        [Parameter( Mandatory = $false )] [string] $Path = $script:w6_SentinelValue_String
    )

    if ( $Path.Length -ge $script:w6_SentinelValue_String.Length ) {
        if ( $Path.Contains( $script:w6_SentinelValue_String ) ) {
            return $script:w6_SentinelValue_String
        }
    }

    $Path = $Path.Trim()

    if ( 0 -eq $Path.Length ) {
        return $script:w6_SentinelValue_String
    }

    $Path = ( Get-w6_PathWithAddedSlashIfNecessary -Path $Path )
    $Path = ( Get-w6_StringWithoutDoubleSlashes -String $Path )

    try {
        return ( Convert-Path -Path $Path -ErrorAction Stop )
    }
    catch {
        return $script:w6_SentinelValue_String
    }

    return $script:w6_SentinelValue_String
}


function Set-w6_OperatingPathIfValid {
    param(
        [Parameter( Mandatory = $false )] [string] $Path = $script:w6_SentinelValue_String,
        [Parameter( Mandatory = $false )] [string] $Fallback = $script:w6_SentinelValue_String,
        [switch] $Silent = $script:w6_SetOperatingPath_DefaultParameterValue_Silent_IfUsedBy_User
    )

    $universalFailureIntroduction = "Failed to set the Operating Path to '$Path'"

    function Write-w6_ShortCustomFailureMessageIfNotSilent {
        param(
            [Parameter( Mandatory = $true )] [string] $CustomExceptionMessage
        )

        if ( -not $Silent ) {
            Write-w6_ShortErrorCatchMessage `
                -Introduction $universalFailureIntroduction `
                -CustomExceptionMessage:$CustomExceptionMessage
        }
    }

    try {
        if ( $script:w6_SentinelValue_String -eq $Path ) {
            Write-w6_ShortCustomFailureMessageIfNotSilent -CustomExceptionMessage 'No Path Received!'
            return
        }

        $pathUniversal = ( Get-w6_UniversalPath -Path $Path )

        if ( -not ( Test-Path -Path $pathUniversal -PathType Container -ErrorAction Stop ) ) {
            Write-w6_ShortCustomFailureMessageIfNotSilent -CustomExceptionMessage 'The passed Path isn''t a valid Folder!'
            return
        }

        $script:w6_OperatingPath = $pathUniversal

        if ( -not $Silent ) {
            Write-Host ''
            Write-Host "Successfully set `$script:w6_OperatingPath to '$script:w6_OperatingPath'"
            Write-Host ''
        }

        return
    }
    catch {
        if ( $script:w6_SentinelValue_String -eq $Fallback ) {
            Write-w6_ShortErrorCatchMessage -Introduction $universalFailureIntroduction -ErrorObject $_
        }
        else {
            Set-w6_OperatingPathIfValid -Path:$Fallback -Silent:$Silent
        }
    }
}


function Import-w6_TaskbarFlasherIfNecessary {
    if ( -not $script:w6_TaskbarFlashing_DoLoad ) {
        return
    }

    $script:w6_TaskbarFlashing_DoLoad = $false

    Add-Type -TypeDefinition @'
        // Modified from this source:
        // https://learn-PowerShell.net/2013/08/26/make-a-window-flash-in-taskbar-using-PowerShell-and-pinvoke/

        using System;
        using System.Runtime.InteropServices;

        public static class w6_TaskbarFlasher
        {
            [StructLayout( LayoutKind.Sequential )]
            private struct FLASHWINFO
            {
                // public const UInt32 FLASHW_STOP = 0;  // Stop flashing. The system restores the window to its original state.
                // public const UInt32 FLASHW_CAPTION = 1;  // Flash the window caption.
                // public const UInt32 FLASHW_TRAY = 2;  // Flash the taskbar button.
                public const UInt32 FLASHW_ALL = 3;  // Flash both the window caption and taskbar button. This is equivalent to setting both the FLASHW_CAPTION | FLASHW_TRAY flags.
                // public const UInt32 FLASHW_TIMER = 4;  // Keeps flashing, until the FLASHW_STOP flag is set.
                public const UInt32 FLASHW_TIMERNOFG = 12;  // Keeps flashing until the window comes to the foreground.

                public UInt32 cbSize;
                public IntPtr hwnd;
                public UInt32 dwFlags;
                public UInt32 uCount;
                public UInt32 dwTimeout;
            }

            private static readonly UInt32 FlashwinfoSize = Convert.ToUInt32( Marshal.SizeOf( typeof( FLASHWINFO ) ) );

            [DllImport( "kernel32.dll" )]
            public static extern IntPtr GetConsoleWindow();

            [DllImport( "user32.dll" )]
            [return: MarshalAs( UnmanagedType.Bool )]
            private static extern bool FlashWindowEx( ref FLASHWINFO pwfi );

            public static bool FlashWindow( IntPtr handle, UInt32 timeout, UInt32 count )
            {
                FLASHWINFO fInfo = new FLASHWINFO
                {
                    cbSize = FlashwinfoSize,
                    hwnd = handle,
                    dwFlags = FLASHWINFO.FLASHW_ALL | FLASHWINFO.FLASHW_TIMERNOFG,
                    uCount = count,
                    dwTimeout = timeout
                };

                return FlashWindowEx( ref fInfo );
            }

        }
'@
}


function Get-w6_StringExtendedToLength {
    param(
        [Parameter( Mandatory = $true )] $String,
        [Parameter( Mandatory = $true )] $Length
    )

    if ( $String -eq '' ) {
        return ''
    }

    $stringLength = $String.Length
    $fullRepeatsAmount = [Math]::FLoor( $Length / $stringLength )
    $fullRepeats = $String * $fullRepeatsAmount

    $leftOverCharactersAmount = ( $Length % $stringLength )
    $leftOverCharacters = if ( $leftOverCharactersAmount -eq 0 ) {
        ''
    }
    else {
        @( $String[0..( $leftOverCharactersAmount - 1 )] ) -join ''
    }

    $extendedString = $fullRepeats + $leftOverCharacters

    return $extendedString
}


function Get-w6_BoundaryArrowBody {
    param(
        [Parameter( Mandatory = $true )] $Length, # Any real number - int, double, etc. - but not NaN
        [switch] $DoNotMinusOne
    )

    $Length = [Math]::Floor( $Length + 0.5 )

    if ( -not $DoNotMinusOne ) {
        $Length--
    }

    return "$( $script:w6_Boundary_Character_Body * $Length )"
}


function Get-w6_Boundary {
    param(
        [Parameter( Mandatory = $true )] [string] $Direction,
        [Parameter( Mandatory = $false, ParameterSetName = 'LengthMultiplier' )] [double] `
            $LengthMultiplier = $script:w6_SentinelValue_Double,
        [Parameter( Mandatory = $false, ParameterSetName = 'RawLength' )] [double] `
            $RawLength = $script:w6_SentinelValue_Double,
        [switch] $DoNotMinusOne,
        [switch] $MinusOneOnlyIfMaxWidth
    )

    $alreadySetWindowWidth = $false

    $isRightDirection = ( $Direction -eq $script:w6_Boundary_Direction_Name_Right )

    $tipLength = if ( $isRightDirection ) {
        $script:w6_Boundary_Character_RightTip_Length
    }
    else {
        $script:w6_Boundary_Character_LeftTip_Length
    }

    if ( $script:w6_SentinelValue_Double -ne $LengthMultiplier ) {
        Set-w6_NewWindowSizeVariables -Width
        $alreadySetWindowWidth = $true
        $length = $LengthMultiplier * ( $script:w6_Window_Width - $tipLength )
    }
    elseif ( $script:w6_SentinelValue_Double -ne $RawLength ) {
        $length = $RawLength - $tipLength
    }
    else {
        return ''
    }

    if ( $MinusOneOnlyIfMaxWidth ) {
        if ( -not $alreadySetWindowWidth ) {
            Set-w6_NewWindowSizeVariables -Width
        }

        $totalLengthRaw = $length + $tipLength

        if ( $totalLengthRaw -ge $script:w6_Window_Width ) {
            $DoNotMinusOne = $false
        }
        else {
            $DoNotMinusOne = $true
        }
    }

    $length = [Math]::Max( 1, $length )
    $arrowBody = ( Get-w6_BoundaryArrowBody `
            -Length $length `
            -DoNotMinusOne:$DoNotMinusOne )

    if ( $isRightDirection ) {
        return "$( $arrowBody )$( $script:w6_Boundary_Character_RightTip )"
    }
    else {
        return "$( $script:w6_Boundary_Character_LeftTip )$( $arrowBody )"
    }

    return ''
}


function Update-w6_IntroductionTotalAutomaticWrites {
    param(
        [Parameter( Mandatory = $true )] [string] $Value
    )

    try {
        $null = [System.IO.File]::WriteAllText( $script:w6_Introduction_TotalAutomaticWrites_Path, $Value )
        $script:w6_Introduction_TotalAutomaticWrites = [int] $Value
    }
    catch [System.Management.Automation.MethodInvocationException] {
        Write-w6_ShortErrorCatchMessage `
            -CustomExceptionMessage 'Failed to update the PowerShell-File-Walker data file!'

        # `nSuspected reason: Invalid path was generated '$script:w6_Introduction_TotalAutomaticWrites_Path'
    }
}


<#
.SYNOPSIS
    Reset the amount of remaining automatic introduction writes in the PowerShell-File-Walker Commands Bundle
.DESCRIPTION
    *Reset-FileWalkerIntroductionAutomaticWrites is a command from the PowerShell-File-Walker Commands Bundle

    Use this command if you want to reset the amount of remaining automatic introduction writes in the PowerShell-File-Walker Commands Bundle

    How do automatic introductions work?
    The PowerShell-File-Walker Commands Bundle automatically writes its introduction when it's loaded

    When the Commands Bundle is being loaded, it compares the Total Loads Count with the Maximum Loads Setting
    If the Total Loads Count is smaller than the Maximum Loads Setting - the introduction will be displayed
    Usually the Maximum Loads Setting is around 3

    Reset-FileWalkerIntroductionAutomaticWrites sets the Total Loads Count back to 0
.LINK
    Write-FileWalkerIntroduction -> Manually write the introduction
#> 

function Reset-FileWalkerIntroductionAutomaticWrites {
    Update-w6_IntroductionTotalAutomaticWrites -Value $script:w6_Introduction_TotalAutomaticWrites_Default_String
}

# ----------------- Globals, Constants & Developer Settings 1 -----------------
# Changing these variables is like playing with the fire

$script:w6_SentinelValue_String = [string] '_1_SENTINEL_VALUE_1_wP7,2.@yu~ B>4''CT""RW\4`eid[$ir(];I-\ }NK<mFfl""""6UWapsNgbO3VQ~ } )D-*Pqd%3@"L )K$Ga,RZv`c''''ASh M1x { L!GYjx5|2zgzY+8s''+?]el";IM#( S%B<HD 1?C/""""9{ E.QfJ7n[Uk^q8p|u0XH&F=b!''*_/65r0yAkJVm&jtwc9o=tX Zo''#_:nOh:^Ev_1_SENTINEL_VALUE_1_'
$script:w6_SentinelValue_String2 = [string] '_2_SENTINEL_VALUE_2_DefZ''P"&F"S!v>s6J~fvZM''k~.92c|!C<~@t6Fwz\Re3U~4^$4RJ@#p%",`E$H2mNJyIbo6""""/U*nfp5W?`9m%/UL/e"^C\/''''&`V*Mr;$zDPn''L/8*:9P""q*Gc;$|#&( 8p7Wk&M )9\Bic%-#H!aC@=T4F_n"""fE*j5S }P=DEFnUA]C{ 8L]Y$^CQ_2_SENTINEL_VALUE_2_'
$script:w6_SentinelValue_Int32 = [int] 1986515346 # Number can't be larger than 2^31-1
$script:w6_SentinelValue_Double = [double] 0.086983872618053 # This number is very near the maximum decimal places for a Double
$script:w6_SentinelValue_Scriptblock = [scriptblock] { $null = $script:w6_SentinelValue_String }

# Developer variables that do not depend on other developer variables
$script:f = ''
$script:w6_Boundary_Direction_Name_Left = 'Left'
$script:w6_Boundary_Direction_Name_Right = 'Right'
$script:w6_CdaLikeInputCharacters_Filtered = $script:w6_SentinelValue_String  # Lazy Loaded due to performance
$script:w6_Introduction_Greeting_CurrentTimeText_Name_12 = '12'
$script:w6_Introduction_Greeting_CurrentTimeText_Name_24 = '24'
$script:w6_Introduction_Greeting_CurrentTimeText_Name_Both = 'both'
$script:w6_LastWindowTitle = $script:w6_SentinelValue_String
$script:w6_List_Attributes_Colors_Name_Any = 'Any'
$script:w6_List_Attributes_Colors_Name_BackgroundColor = 'BackgroundColor'
$script:w6_List_Attributes_Colors_Name_BackgroundColor_Priority = 'BackgroundColor_Priority'
$script:w6_List_Attributes_Colors_Name_DefaultColor = 'Default'
$script:w6_List_Attributes_Colors_Name_ForegroundColor = 'ForegroundColor'
$script:w6_List_Attributes_Colors_Name_ForegroundColor_Priority = 'ForegroundColor_Priority'
$script:w6_List_Attributes_Colors_ValidColors = ( [enum]::GetNames( [System.ConsoleColor] ) )
$script:w6_List_Raw_Names_Line_Color = 'Color'
$script:w6_List_Raw_Names_Line_Text = 'Text'
$script:w6_List_Times_DefaultValue = 1
$script:w6_OSType_Return_Linux = 'Linux'
$script:w6_OSType_Return_MacOS = 'MacOS'
$script:w6_OSType_Return_Unknown = 'Unknown'
$script:w6_OSType_Return_Windows = 'Windows'
$script:w6_PathSlashes = @( '\', '/' )
$script:w6_PathSlashes_Any_Regex = '\\|\/'
$script:w6_Product_Path = ( $MyInvocation.MyCommand.Path )
$script:w6_PSEdition = $PSVersionTable.PSEdition
$script:w6_Time_Format_24 = 'HH:mm'
$script:w6_UnixEpochDate = ( Get-Date -Year 1970 -Month 1 -Day 1 -Hour 0 -Minute 0 -Second 0 )
$script:w6_WhichByAlphabet = $script:w6_SentinelValue_String
$script:w6_ElevationCommands_UnsetTitle = ''

# Developer variables that DO depend on other developer variables / settings
$script:w6_Product_Name_KebabCase = ( ( $script:w6_Product_Name.ToLower() ) -replace ( ' ', '-' ) )
$script:w6_CurrentOSType = ( Get-w6_OSType )
$script:w6_IsWindows = ( $script:w6_OSType_Return_Windows -eq $script:w6_CurrentOSType )
$script:w6_PathSlash = if ( $script:w6_IsWindows ) { '\' } else { '/' }
$script:w6_TaskbarFlashing_DoLoad = ( $script:w6_IsWindows )
$script:w6_UserHomeDirectory = if ( $script:w6_IsWindows ) { $env:USERPROFILE } else { $env:HOME }
$script:w6_Boundary_Character_RightTip_Length = $script:w6_Boundary_Character_RightTip.Length
$script:w6_Boundary_Character_LeftTip_Length = $script:w6_Boundary_Character_LeftTip.Length
$script:w6_Boundary_Character_Body_Length = $script:w6_Boundary_Character_Body.Length


# ------------------------- Loading User Configuration ------------------------

# UPDATE 2025 - LOADING USER CONFIGURATION HAS BEEN DEPRECATED
# $script:w6_ConfigParentPaths = @( @(
#         [System.IO.Path]::GetFullPath( ( $PROFILE.AllUsersAllHosts ) ),
#         [System.IO.Path]::GetFullPath( ( $PROFILE.AllUsersCurrentHost ) ),
#         [System.IO.Path]::GetFullPath( ( $PROFILE.CurrentUserAllHosts ) ),
#         [System.IO.Path]::GetFullPath( ( $PROFILE.CurrentUserCurrentHost ) ),
#         [System.IO.Path]::GetFullPath( ( Get-w6_StringWithoutDoubleSlashes -String "$( $script:w6_Product_Path )$( $script:w6_PathSlash ).." ) )
#     ) | Select-Object -Unique
# )

# $script:w6_ConfigFileName = 'PowerShell-File-Walker-Config.ps1'
# $script:w6_Config_Found_Count = 0
# $script:w6_Config_Found_Files = @()
# $script:w6_Config_Success_Count = 0
# $script:w6_Config_Error_Count = 0
# $script:w6_Config_Error_CathMessages = @()

# foreach ( $configParentPath in $script:w6_ConfigParentPaths ) {
#     $configPath = ( $configParentPath + $script:w6_PathSlash + $script:w6_ConfigFileName )
#     $configPath = ( Get-w6_StringWithoutDoubleSlashes -String $configPath )
#     $wasFound = $true

#     try {
#         . ( $configPath )
#         $script:w6_Config_Success_Count++
#     }
#     catch [System.Management.Automation.CommandNotFoundException] {
#         $wasFound = $false
#     }
#     catch {
#         $script:w6_Config_Error_Count++

#         $script:w6_Config_Error_CathMessages += @"
# $( Get-w6_Boundary -Direction $script:w6_Boundary_Direction_Name_Left -LengthMultiplier $script:w6_Boundary_Length_Long )
#   Errors have occurred while loading the User Configuration Files:

# $_
# $( Get-w6_Boundary -Direction $script:w6_Boundary_Direction_Name_Right -LengthMultiplier $script:w6_Boundary_Length_Long )

# "@
#     }

#     if ( $wasFound ) {
#         $script:w6_Config_Found_Files += $configPath
#         $script:w6_Config_Found_Count++
#     }
# }


# ----------------- Globals, Constants & Developer Settings 2 -----------------

Set-w6_NewWindowSizeVariables -Height -Width

$script:w6_Introduction_Greeting_CurrentTimeText_Format = ( [string] $script:w6_Introduction_Greeting_CurrentTimeText_Format ).ToLower()
if ( $true `
        -and ( "$script:w6_Introduction_Greeting_CurrentTimeText_Format" -ne "$script:w6_Introduction_Greeting_CurrentTimeText_Name_Both" ) `
        -and ( "$script:w6_Introduction_Greeting_CurrentTimeText_Format" -ne "$script:w6_Introduction_Greeting_CurrentTimeText_Name_24" ) `
        -and ( "$script:w6_Introduction_Greeting_CurrentTimeText_Format" -ne "$script:w6_Introduction_Greeting_CurrentTimeText_Name_12" ) ) {

    $script:w6_Introduction_Greeting_CurrentTimeText_Format = $script:w6_Introduction_Greeting_CurrentTimeText_Name_Both
}

$script:w6_List_Attributes_Colors_ValidColors_HashSet = [System.Collections.Generic.HashSet[string]]::new( $script:w6_List_Attributes_Colors_ValidColors )
if ( $script:w6_List_NegativeValues_Display_ShowEveryXthListing -lt 1 ) {
    $script:w6_List_NegativeValues_Display_ShowEveryXthListing = 1
}

$script:w6_OperatingPath = $script:w6_SentinelValue_String
Set-w6_OperatingPathIfValid `
    -Path '.\' `
    -Silent:$script:w6_SetOperatingPath_DefaultParameterValue_Silent_IfUsedBy_Script

$script:w6_PowerShellLaunchCommand = if ( $script:w6_PSEdition -eq 'Core' ) { 'pwsh' } else { 'PowerShell' }

$script:w6_SystemIOAllDefaultFileAttributes = @( [Enum]::GetValues( [System.IO.FileAttributes] ) )

$script:w6_List_Attributes_Character_FullSpaces = $script:w6_List_Attributes_Character_Space * $script:w6_List_Attributes_SpacesBetweenDashes
$script:w6_List_Attributes_Character_FullSpacesAndNormalDash = "$( $script:w6_List_Attributes_Character_FullSpaces )$( $script:w6_List_Attributes_Character_Dash )"
$script:w6_List_Attributes_Character_FullSpacesAndNormalDash_Length = $script:w6_List_Attributes_Character_FullSpacesAndNormalDash.Length
$script:w6_List_Attributes_Character_FirstSpacesAndFirstDash = (
    "$( $script:w6_List_Attributes_Character_Space * $script:w6_List_Attributes_FirstDash_SpacesBefore )",
    "$script:w6_List_Attributes_FirstDash_Character" -join ''
)

if ( $script:w6_Introduction_Toggle ) {
    $script:w6_Introduction_TotalAutomaticWrites_Default_String = '0'
    $script:w6_Introduction_TotalAutomaticWrites_Default_Int = [int] $script:w6_Introduction_TotalAutomaticWrites_Default_String

    $script:w6_Introduction_TotalAutomaticWrites_Path = ( Get-w6_StringWithoutDoubleSlashes -String `
            "$( $script:w6_UserHomeDirectory )$( $script:w6_PathSlash ).$( $script:w6_Product_Name_KebabCase )-data"
    )

    try {
        $script:w6_Introduction_TotalAutomaticWrites = [int] ( [System.IO.File]::ReadAllText( $script:w6_Introduction_TotalAutomaticWrites_Path ) )
    }
    catch [System.IO.DirectoryNotFoundException] {
        Reset-FileWalkerIntroductionAutomaticWrites
    }
    catch [System.IO.FileNotFoundException] {
        Reset-FileWalkerIntroductionAutomaticWrites
    }
    catch [System.InvalidCastException] {
        Reset-FileWalkerIntroductionAutomaticWrites
    }

    $script:w6_Introduction_Toggle = ( $script:w6_Introduction_TotalAutomaticWrites -le ( $script:w6_Introduction_MaxTotalAutomaticWrites - 1 ) )
}

# ---------------------------- PRIVATE FUNCTIONS 2 ----------------------------


function Get-w6_PaddedTextToConsoleMiddle {
    param(
        [Parameter( Mandatory = $false )] [string] $Text = '',
        [Parameter( Mandatory = $false )] [string] $Padding = ' ',
        [Parameter( Mandatory = $false )] [string] $Prepend = '',
        [Parameter( Mandatory = $false )] [string] $Append = ''
    )

    Set-w6_NewWindowSizeVariables -Width

    $nonPaddingLength = $Prepend.Length + $text.Length + $Append.Length
    $neededPaddingTotal = ( $script:w6_Window_Width - $nonPaddingLength ) / $Padding.Length
    $neededPaddingEven = $neededPaddingTotal / 2

    $paddingLeftAmount = [Math]::Max( [Math]::Ceiling( $neededPaddingEven ), 1 )
    $paddingRightAmount = [Math]::Max( [Math]::Floor( $neededPaddingEven ), 1 )

    $paddingLeft = $Padding * $paddingLeftAmount
    $paddingRight = $Padding * $paddingRightAmount

    return "$( $Prepend )$( $paddingLeft )$( $Text )$( $paddingRight )$( $Append )"
}


function Write-w6_OneColorCombination {
    param(
        [Parameter( Mandatory = $true )] [object] $BackgroundColor,
        [Parameter( Mandatory = $true )] [object] $ForegroundColor,
        [Parameter( Mandatory = $false )] [object] $CustomText = $script:w6_SentinelValue_String,
        [switch] $Swap,
        [switch] $NoAlign
    )

    if ( $Swap ) {
        $BackgroundColor, $ForegroundColor = $ForegroundColor, $BackgroundColor
    }

    if ( $script:w6_SentinelValue_String -eq $CustomText ) {
        $textRaw = "This is $ForegroundColor Text on a $BackgroundColor Background."
    }
    else {
        $textRaw = $CustomText
    }

    if ( $NoAlign ) {
        $text = $textRaw
    }
    else {
        $text = ( Get-w6_PaddedTextToConsoleMiddle `
                -Text $textRaw `
                -Padding $script:w6_Get_Color_Combinations_Characters_PaddingToMiddle )
    }

    Write-Host `
        -Object $text `
        -BackgroundColor $BackgroundColor `
        -ForegroundColor $ForegroundColor

    return
}


function Write-w6_Colors {
    Write-Host ''
    Write-Host $script:w6_List_Attributes_Colors_ValidColors -Separator "`n"
    Write-Host ''
}


function Get-w6_FlattenedArray {
    param(
        [Parameter( Mandatory = $false )] [object] $Array = $script:w6_SentinelValue_String
    )

    $flattenedArray = @()

    foreach ( $item in $Array ) {
        if ( $item -is [array] ) {
            $flattenedArray += ( Get-w6_FlattenedArray -Array $item )
        }
        else {
            $flattenedArray += $item
        }
    }

    return $flattenedArray
}


function Set-w6_AliasBulk {
    param(
        [Parameter( Mandatory = $true )] $Value,
        [Parameter( Mandatory = $true )] $Aliases,
        [Parameter( Mandatory = $false )] $Scope = 'Script'
    )

    foreach ( $alias in $Aliases ) {
        New-Alias -Value $Value -Name $alias -Scope $Scope -Force
    }
}


function Set-w6_WindowTitleToBringBack {
    param(
        [Parameter( Mandatory = $false )] $Title = $script:w6_SentinelValue_String
    )

    if ( $script:w6_SentinelValue_String -eq $Title ) {
        return $true
    }

    try {
        $script:w6_LastWindowTitle = $host.UI.RawUI.WindowTitle
    }
    catch {
        return $false
    }

    try {
        $host.UI.RawUI.WindowTitle = $script:w6_LastWindowTitle
    }
    catch {
        return $false
    }

    try {
        $host.UI.RawUI.WindowTitle = $Title
    }
    catch {

        try {
            $host.UI.RawUI.WindowTitle = $script:w6_LastWindowTitle
        }
        catch {
            return $false
        }

        return $false
    }

    return $true
}


function Set-w6_LastWindowTitle {

    function Invoke-w6_SuccessSequence {
        $script:w6_LastWindowTitle = $script:w6_SentinelValue_String
        return $true
    }

    function Invoke-w6_FailureSequence {

        if ( $script:w6_LastWindowTitle -eq $host.UI.RawUI.WindowTitle ) {
            return ( Invoke-w6_SuccessSequence )
        }

        try {
            $host.UI.RawUI.WindowTitle = $script:w6_LastWindowTitle # This is a retry
            return ( Invoke-w6_SuccessSequence )
        }
        catch { }

        Write-Host ( Get-w6_Boundary -Direction $script:w6_Boundary_Direction_Name_Right -LengthMultiplier $script:w6_Boundary_Length_Long )
        Write-Host " !!! Failed to set the window title back to:`n$script:w6_LastWindowTitle"
        Write-Host ( Get-w6_Boundary -Direction $script:w6_Boundary_Direction_Name_Left -LengthMultiplier $script:w6_Boundary_Length_Long )

        return $false
    }

    if ( $script:w6_SentinelValue_String -eq $script:w6_LastWindowTitle ) {
        return ( Invoke-w6_SuccessSequence )
    }

    try {
        $host.UI.RawUI.WindowTitle = $host.UI.RawUI.WindowTitle
    }
    catch {
        return ( Invoke-w6_FailureSequence )
    }

    try {
        $host.UI.RawUI.WindowTitle = $script:w6_LastWindowTitle
        return ( Invoke-w6_SuccessSequence )
    }
    catch {
        return ( Invoke-w6_FailureSequence )
    }
}


function Add-w6_DirectlyToArrayIfBoolTrue {
    param(
        [Parameter( Mandatory = $true )] [ref] $ArrayReference,
        [Parameter( Mandatory = $false )] [object] $ToAdd,
        [switch] $Prepend,
        [switch] $Bool
    )

    if ( -not $Bool ) {
        return
    }

    if ( $Prepend ) {
        $ArrayReference.Value = @( @( $ToAdd ) + @( $ArrayReference.Value ) )
        return
    }

    $ArrayReference.Value += $ToAdd
}


function Get-w6_PaddedArrayToLength {
    param(
        [Parameter( Mandatory = $false )] [object] $ArrayToPad,
        [Parameter( Mandatory = $false )] [int] $Length,
        [Parameter( Mandatory = $false )] [object] $PaddingObject
    )

    $paddingLength = ( $Length - $ArrayToPad.Length )

    if ( $paddingLength -le 0 ) {
        return $ArrayToPad
    }

    $padding = @( @( $PaddingObject ) * $paddingLength )

    return @( @( $ArrayToPad ) + @( $padding ) )
}


function Get-w6_PrioritizedArrayOfStrings {
    param(
        [Parameter( Mandatory = $false )] [object] $Array = $script:w6_SentinelValue_String,
        [Parameter( Mandatory = $false )] [object] $Priorities = $script:w6_SentinelValue_String,
        [switch] $Capitalize,
        [switch] $CaseSensitiveComparison,
        [switch] $DoNotRemoveEmptyStrings
    )

    if ( $script:w6_SentinelValue_String -eq $Array ) {
        return @()
    }

    if ( $script:w6_SentinelValue_String -eq $Priorities ) {
        return $Array
    }

    $arrayLength = $Array.Length

    if ( $arrayLength -eq 0 ) {
        return $Array
    }

    $newArray = @()

    for ( $i = 0; $i -lt $arrayLength; $i++ ) {

        $Item = [string] ( $Array[$i] )

        if ( $script:w6_SentinelValue_String -eq $Item ) {
            continue
        }

        if ( ( $CaseSensitiveComparison -and ( $Item -cin $Priorities ) ) -or `
            ( -not $CaseSensitiveComparison -and ( $Item -in $Priorities ) ) ) {

            if ( $Capitalize ) {
                $Item = $Item.ToUpper()
            }
            $newArray = @( @( $Item ) + @( $newArray ) )
        }
        else {
            $newArray += $Item
        }

    }

    if ( -not $DoNotRemoveEmptyStrings ) {
        $emptyStringValues = @( $null, '' )
        $newArray = @( @( $newArray ) | Where-Object -FilterScript { $_ -notin $emptyStringValues } )
    }

    return @( $newArray )
}


function Set-w6_NewColorVariableIfCandidateBetter {
    param(
        [Parameter( Mandatory = $true )] [ref] $CurrentColorReference,
        [Parameter( Mandatory = $true )] [ref] $CurrentColorPriorityReference,
        [Parameter( Mandatory = $false )] [object] $CandidateColor = $script:w6_SentinelValue_String,
        [Parameter( Mandatory = $false )] [object] $CandidatePriority = $script:w6_SentinelValue_String
    )

    if ( $null -eq $CandidateColor ) {
        return
    }

    if ( ( $null -eq $CandidatePriority ) -or `
        ( -not ( ConvertTo-w6_DoubleDirectly -ValueReference ( [ref] $CandidatePriority ) ) ) ) {
        $CandidatePriority = $script:w6_List_Attributes_Colors_Default_Priority
    }

    if ( -not ( ConvertTo-w6_DoubleDirectly -ValueReference $CurrentColorPriorityReference ) ) {
        $CurrentColorPriorityReference.Value = $script:w6_List_Attributes_Colors_Default_Priority
    }

    if ( $script:w6_List_Attributes_Colors_Name_DefaultColor -eq $CandidateColor ) {
        $CandidateColor = $script:w6_SentinelValue_String
    }

    if ( $CandidatePriority -le $CurrentColorPriorityReference.Value ) {
        $CurrentColorReference.Value = $CandidateColor
        $CurrentColorPriorityReference.Value = $CandidatePriority
    }
}


function Set-w6_NewColorVariablesFromAttributeName {
    param(
        [Parameter( Mandatory = $true )] [ref] $CurrentBackgroundColorReference,
        [Parameter( Mandatory = $true )] [ref] $CurrentBackgroundColorPriorityReference,
        [Parameter( Mandatory = $true )] [ref] $CurrentForegroundColorReference,
        [Parameter( Mandatory = $true )] [ref] $CurrentForegroundColorPriorityReference,
        [Parameter( Mandatory = $false )] [object] $AttributeName = $script:w6_SentinelValue_String
    )

    if ( $script:w6_SentinelValue_String -eq $AttributeName ) {
        return
    }

    $candidate = $script:w6_List_Attributes_Colors[$AttributeName]
    $badCandidates = @( $null, '', '0', $script:w6_SentinelValue_String )

    if ( $candidate -in @( $badCandidates ) ) {
        continue
    }

    $candidateBackgroundColor = $candidate[$script:w6_List_Attributes_Colors_Name_BackgroundColor]
    $candidateBackgroundColorPriority = $candidate[$script:w6_List_Attributes_Colors_Name_BackgroundColor_Priority]

    $candidateForegroundColor = $candidate[$script:w6_List_Attributes_Colors_Name_ForegroundColor]
    $candidateForegroundColorPriority = $candidate[$script:w6_List_Attributes_Colors_Name_ForegroundColor_Priority]

    Set-w6_NewColorVariableIfCandidateBetter `
        -CurrentColorReference $CurrentBackgroundColorReference `
        -CurrentColorPriorityReference $CurrentBackgroundColorPriorityReference `
        -CandidateColor $candidateBackgroundColor `
        -CandidatePriority $candidateBackgroundColorPriority

    Set-w6_NewColorVariableIfCandidateBetter `
        -CurrentColorReference $CurrentForegroundColorReference `
        -CurrentColorPriorityReference $CurrentForegroundColorPriorityReference `
        -CandidateColor $candidateForegroundColor `
        -CandidatePriority $candidateForegroundColorPriority
}


function Get-w6_ColorsFromFileAttributesNames {
    param(
        [Parameter( Mandatory = $false )] [object] $FileAttributesNames = $script:w6_SentinelValue_String
    )

    if ( $script:w6_SentinelValue_String -eq $FileAttributesNames ) {
        return $script:w6_SentinelValue_String
    }

    $FileAttributesNames = @( @( $FileAttributesNames ) + @( $script:w6_List_Attributes_Colors_Name_Any ) )

    $backgroundColor = $script:w6_SentinelValue_String
    $backgroundColorPriority = $script:w6_List_Attributes_Colors_Default_Priority
    $foregroundColor = $script:w6_SentinelValue_String
    $foregroundColorPriority = $script:w6_List_Attributes_Colors_Default_Priority


    foreach ( $attributeName in $FileAttributesNames ) {

        Set-w6_NewColorVariablesFromAttributeName `
            -CurrentBackgroundColorReference ( [ref] $backgroundColor ) `
            -CurrentBackgroundColorPriorityReference ( [ref] $backgroundColorPriority ) `
            -CurrentForegroundColorReference ( [ref] $foregroundColor ) `
            -CurrentForegroundColorPriorityReference ( [ref] $foregroundColorPriority ) `
            -AttributeName $attributeName
    }

    return @{
        $script:w6_List_Attributes_Colors_Name_BackgroundColor = $backgroundColor
        $script:w6_List_Attributes_Colors_Name_ForegroundColor = $foregroundColor
    }
}


function Get-w6_NamesListFromFileAttributes {
    param(
        [Parameter( Mandatory = $false )] [object] $fileAttributesParameter = $script:w6_SentinelValue_String
    )

    if ( $script:w6_SentinelValue_String -eq $fileAttributesParameter ) {
        return @()
    }

    $attributesArray = @()

    foreach ( $attribute in $script:w6_SystemIOAllDefaultFileAttributes ) {
        if ( ( $fileAttributesParameter -band $attribute ) -eq $attribute ) {
            $attributesArray += $attribute
        }
    }

    return @( $attributesArray )
}


function Get-w6_FileAttributesNames {
    param(
        [Parameter( Mandatory = $false )] [string] $FileName = $script:w6_SentinelValue_String
    )

    $noError = $true
    $fileAttributesNames = @()

    try {
        $Path = ( Get-w6_PathWithAddedSlashIfNecessary `
                -Path "$( $script:w6_OperatingPath )$( $script:w6_PathSlash )$( $FileName )" )
        $Path = ( Get-w6_StringWithoutDoubleSlashes -String $Path )
        $fileAttributesParameter = ( Get-Item -Path $Path -Force -ErrorAction Stop ).Attributes
    }
    catch [System.UnauthorizedAccessException] {
        $noError = $false
        $fileAttributesNames += 'Permission Denied!'
    }
    catch [System.IO.FileNotFoundException] {
        $noError = $false
        $fileAttributesNames += 'File Not Found!'
    }
    catch {
        $noError = $false
        $fileAttributesNames += 'ERROR!'
    }
    # Improvement idea: Be more explicit with error catching here.

    if ( $noError ) {
        $fileAttributesNames = @( Get-w6_NamesListFromFileAttributes -FileAttributesParameter:$fileAttributesParameter )
    }

    $emptyStringValues = @( '', $null, ' ' )

    $fileAttributesNames = @( @( $fileAttributesNames ) | Where-Object -FilterScript {
            $_ -notin @( $emptyStringValues ) } )

    return @( $fileAttributesNames | ForEach-Object -Process { [string] $_ } )
}


function Get-w6_FileAttributesStringRaw {
    param(
        [Parameter( Mandatory = $false )] [object] $FileAttributesNames
    )

    if ( $FileAttributesNames.Length -gt 0 ) {
        $FileAttributesStringRaw = "$script:w6_List_Attributes_Character_Arrow$( $FileAttributesNames -join  $script:w6_List_Attributes_Character_AttributeSeparator )"
    }
    else {
        $FileAttributesStringRaw = ''
    }

    return $FileAttributesStringRaw
}


function Get-w6_FileAttributesString {
    param(
        [Parameter( Mandatory = $false )] [object] $FileAttributesNames,
        [Parameter( Mandatory = $false )] [string] $BeforeAttributesString = $script:w6_SentinelValue_String,
        [Parameter( Mandatory = $false )] [string] $AfterAttributesString = $script:w6_SentinelValue_String,
        [Parameter( Mandatory = $false )] [object] $AttributesBlackList = @(),
        [Parameter( Mandatory = $false )] [object] $AttributesPriorityList = @(),
        [Switch] $AddSeparatorCharacters
    )

    $FileAttributesNames = @( @( $FileAttributesNames ) | Where-Object -FilterScript {
            $_ -notin $AttributesBlackList }
    )

    $FileAttributesNames = @( Get-w6_PrioritizedArrayOfStrings `
            -Array $FileAttributesNames `
            -Priorities $AttributesPriorityList `
            -Capitalize )

    $FileAttributesNames = @( @( $FileAttributesNames ) | ForEach-Object -Process {
            $aliasName = $script:w6_List_Attributes_RenameTable["$_"]

            if ( $null -ne $aliasName ) {
                $aliasName
            }
            else {
                $_
            }
        } )

    $emptyStringValues = @( '', $null, ' ' )

    $FileAttributesNames = @( @( $FileAttributesNames ) | Where-Object -FilterScript {
            $_ -notin @( $emptyStringValues ) } )

    $fileAttributesStringRaw = ( Get-w6_FileAttributesStringRaw -FileAttributesNames @( $FileAttributesNames ) )

    function Get-w6_AttributesStringSpacesLength {
        # DELETE THIS DESCRIPTION ONCE IT'S IRRELEVANT
        # Variable Abbreviations: Left1, Left2, Left3, Right
        # This function tries to fit the best amount of spaces for the specific line based on its length and on the user's settings
        # Steps:
        # Important! If during any of these steps a matching amount of spaces if found, it will be instantly returned, and the function will instantly end. The script will always choose the highest acceptable amount of spaces
        # 1. Check will the text fit with the maximum (Left1) amount of spaces  while respecting Right
        # 2. Try to fit an amount of spaces between Left1 and Left2  while respecting Right
        # 3. Starting from Left2. Decrease Left2 and Right by 1 until both  Left2 has reached Left3   and  Right has reached 0
        #    note: there are max() functions to ensure that  Left2 is never decreased below Left3  and  Right is never decreased below 0
        # 4. (fallback) Return the minimum amount of spaces (Left3)

        #+ Step 1

        $rawLineLength = ( "$( $BeforeAttributesString )$( $fileAttributesStringRaw )$( $AfterAttributesString )" ).Length

        Set-w6_NewWindowSizeVariables -Width
        $newLength = $rawLineLength + $script:w6_List_Attributes_MinCharactersSeparating_Left1
        $newMax = $script:w6_Window_Width - $script:w6_List_Attributes_MinCharactersSeparating_Right

        if ( $newLength -lt $newMax ) {
            return $script:w6_List_Attributes_MinCharactersSeparating_Left1
        }

        #+ Step 2

        $newRange = $script:w6_List_Attributes_MinCharactersSeparating_Left1 - $script:w6_List_Attributes_MinCharactersSeparating_Left2
        $newMax = $script:w6_Window_Width - $script:w6_List_Attributes_MinCharactersSeparating_Right

        $firstMatchingSubtraction = $rawLineLength + $script:w6_List_Attributes_MinCharactersSeparating_Left1 - $newMax

        if ( ( $firstMatchingSubtraction -ge 0 ) -and ( $firstMatchingSubtraction -le $newRange ) ) {
            return $script:w6_List_Attributes_MinCharactersSeparating_Left1 - $firstMatchingSubtraction
        }

        if ( ( $rawLineLength + $script:w6_List_Attributes_MinCharactersSeparating_Left2 ) -lt $newMax ) {
            return $script:w6_List_Attributes_MinCharactersSeparating_Left2
        }

        # The two above if statements are an optimized version of the below for-loop. The for-loop has not been deleted, because it may
        # be easier to understand the more verbose for-loop, than the 'shortcut' math from the if statements
        # IF ANY EDIT IN THE ABOVE CODE IS PERFORMED - IT'S VERY LIKELY THAT THE BELOW FOR-LOOP IS IRRELEVANT
        # for ( $i = 0; $i -le $newRange; $i++ ) {
        #     $newSeparationFromLeft = [Math]::Max( ( $script:w6_List_Attributes_MinCharactersSeparating_Left1 - $i ), $script:w6_List_Attributes_MinCharactersSeparating_Left2 )   # Note: The [Math]::Max() is only useful during the edge case when Left2 > Left1.  When Left1 > Left2 -> the "Left1 - i" will always be greater or equal to Left2
        #     $newLength = $rawLineLength + $newSeparationFromLeft
        #
        #     if ( $newLength -lt $newMax ) {
        #         return $newSeparationFromLeft
        #     }
        # }

        #+ Step 3

        $newRange = [Math]::Max( $script:w6_List_Attributes_MinCharactersSeparating_Left2, $script:w6_List_Attributes_MinCharactersSeparating_Right )

        for ( $i = 0; $i -le $newRange; $i++ ) {

            $newSeparationFromLeft = [Math]::Max(
                ( $script:w6_List_Attributes_MinCharactersSeparating_Left2 - $i ),
                $script:w6_List_Attributes_MinCharactersSeparating_Left3
            )
            $newLength = $rawLineLength + $newSeparationFromLeft

            if ( 0 -eq $i ) {
                $newSeparationFromRight = $script:w6_List_Attributes_MinCharactersSeparating_Right
            }
            else {
                $newSeparationFromRight = [Math]::Max( ( $script:w6_List_Attributes_MinCharactersSeparating_Right - $i + 1 ), 0 )
            }

            $newMax = $script:w6_Window_Width - $newSeparationFromRight

            if ( $newLength -lt $newMax ) {
                return $newSeparationFromLeft
            }

            $newSeparationFromRight = [Math]::Max( ( $script:w6_List_Attributes_MinCharactersSeparating_Right - $i ), 0 )
            $newMax = $script:w6_Window_Width - $newSeparationFromRight

            if ( $newLength -lt $newMax ) {
                return $newSeparationFromLeft
            }

        }

        #+ Step 4

        return $script:w6_List_Attributes_MinCharactersSeparating_Left3
    }

    function Get-w6_AttributesStringSpaces {
        $spacesAmount = ( Get-w6_AttributesStringSpacesLength )
        $spacesWithDashes = ''

        $spacesAmountAfterFirstDash = $spacesAmount - $script:w6_List_Attributes_FirstDash_SpacesBefore - `
            $script:w6_List_Attributes_FirstDash_Character.Length

        if ( ( $spacesAmountAfterFirstDash -le 0 ) -or ( '' -eq $fileAttributesStringRaw ) ) {
            return ( $script:w6_List_Attributes_Character_Space * $spacesAmount )
        }

        $spacesWithDashes += $script:w6_List_Attributes_Character_FirstSpacesAndFirstDash

        $fullSpacesAndNormalDashes_Amount = [Math]::Floor(
            $spacesAmountAfterFirstDash / $script:w6_List_Attributes_Character_FullSpacesAndNormalDash_Length )

        $allFullSpacesAndNormalDashes = `
            $script:w6_List_Attributes_Character_FullSpacesAndNormalDash * $fullSpacesAndNormalDashes_Amount

        $spacesWithDashes += $allFullSpacesAndNormalDashes

        $spacesWithDashes += (
            $script:w6_List_Attributes_Character_Space * (
                $spacesAmountAfterFirstDash % $script:w6_List_Attributes_Character_FullSpacesAndNormalDash_Length ) )

        return $spacesWithDashes

    }

    if ( $AddSeparatorCharacters ) {
        return "$( Get-w6_AttributesStringSpaces )$( $fileAttributesStringRaw )$( $AfterAttributesString )"
    }

    return "$( $fileAttributesStringRaw )$( $AfterAttributesString )"
}


function Get-w6_ChildItems {
    param(
        [switch] $IsDir,
        [switch] $Force
    )

    try {
        return @( Get-ChildItem -Path $script:w6_OperatingPath -ErrorAction Stop -Name -Directory:$IsDir -Force:$Force )
    }
    catch [System.UnauthorizedAccessException] {
        return $script:w6_SentinelValue_String # If you have an access denied error here, you can't access the entire
        #                                        folder, not a single file. No need to handle accessing these
        #                                        files without -Force.
    }
}


function Get-w6_ListOneLineLeftSideSpaces {
    param(
        [Parameter( Mandatory = $false )] [string] $CounterText = $script:w6_SentinelValue_String
    )

    if ( $script:w6_SentinelValue_String -eq $CounterText ) {
        return ''
    }

    return (
        $script:w6_List_BeforeCounterText_Character_Space * [Math]::Max(
            ( $script:w6_List_BeforeCounterText_SpacesIfOneDigit + 1 - "$CounterText".Length ), 0
        )
    )
}


function Set-w6_VariableFToPath {
    param(
        [Parameter( Mandatory = $false )] [object] $Path = $script:w6_SentinelValue_String
    )

    if ( $script:w6_SentinelValue_String -eq $Path ) {
        return
    }

    $script:f = [System.IO.Path]::GetFullPath( ( Get-w6_UniversalPath -Path $Path ) )
}


function Get-w6_BeforeAttributesString {
    param(
        [Parameter( Mandatory = $true )] [object] $FileName,
        [Parameter( Mandatory = $true )] [int] $PositiveCounter,
        [Parameter( Mandatory = $true )] [int] $ListLength
    )

    $negativeNumberModulo = ( $PositiveCounter % $script:w6_List_NegativeValues_Display_ShowEveryXthListing )
    $shouldNegativeCounterBeDisplayed = ( 0 -eq $negativeNumberModulo )

    if ( $script:w6_List_NegativeValues_Display_Toggle -and $shouldNegativeCounterBeDisplayed ) {
        $negativeCounterText = "-$( $ListLength - $PositiveCounter + 1 )$( $script:w6_List_NegativeValues_Display_Separator )"
    }
    else {
        $negativeCounterText = ''
    }

    $beforeAttributesString_Spaces = ( Get-w6_ListOneLineLeftSideSpaces `
            -CounterText "$( $negativeCounterText )$( $PositiveCounter )" )

    return (
        "$beforeAttributesString_Spaces",
        "$script:w6_List_Character_Bracket_ListNumber_BeforeAttributes_Opening",
        "$negativeCounterText",
        "$PositiveCounter",
        "$script:w6_List_Character_Bracket_ListNumber_BeforeAttributes_Closing",
        ' ',
        "$FileName" -join ''
    )
}


function Get-w6_ListLineFromFile {
    param(
        [Parameter( Mandatory = $true )] [object] $FileName,
        [Parameter( Mandatory = $true )] [int] $PositiveCounter,
        [Parameter( Mandatory = $true )] [int] $ListLength,
        [Parameter( Mandatory = $false )] [object] $AttributesBlackList = @(),
        [Parameter( Mandatory = $false )] [object] $AttributesPriorityList = @()
    )

    # Note: The Space characters that separate the File Name and File Attributes are in the $fileAttributesString variable

    $beforeAttributesString = ( Get-w6_BeforeAttributesString `
            -FileName $FileName `
            -PositiveCounter $PositiveCounter `
            -ListLength $ListLength )

    if ( -not $script:w6_List_FileAttributes_Toggle ) {
        return $beforeAttributesString
    }

    if ( $script:w6_List_AfterAttributesListNumber_ListNumber_Visible ) {
        $afterAttributesCounter = $PositiveCounter
    }
    else {
        $afterAttributesCounter = ''
    }


    if ( $script:w6_List_AfterAttributesListNumber_ToggleFullDisplay ) {
        $afterAttributesString = (
            "$script:w6_List_Character_Bracket_ListNumber_AfterAttributes_Opening",
            "$script:w6_List_Attributes_ClosingNumberPrefix",
            "$afterAttributesCounter",
            "$script:w6_List_Attributes_ClosingNumberSuffix",
            "$script:w6_List_Character_Bracket_ListNumber_AfterAttributes_Closing" -join ''
        )
    }
    else {
        $afterAttributesString = ''
    }

    $fileAttributesNames = @( Get-w6_FileAttributesNames `
            -FileName $FileName `
    )

    $fileAttributesString = ( Get-w6_FileAttributesString `
            -BeforeAttributesString $beforeAttributesString `
            -AfterAttributesString $afterAttributesString `
            -FileAttributesNames $fileAttributesNames `
            -AttributesBlackList:$AttributesBlackList `
            -AttributesPriorityList:$AttributesPriorityList `
            -AddSeparatorCharacters
    )

    if ( $script:w6_List_Colors_Toggle ) {
        # The lack of '@' isn't a mistype. Colors are passed as a hashtable
        $colors = ( Get-w6_ColorsFromFileAttributesNames -FileAttributesNames $fileAttributesNames )
    }
    else {
        $colors = $script:w6_SentinelValue_String
    }

    $text = "$( $beforeAttributesString )$( $fileAttributesString )"

    return @{
        $script:w6_List_Raw_Names_Line_Text  = $text
        $script:w6_List_Raw_Names_Line_Color = $colors
    }

}


function Get-w6_RawEnumeratedFilesList {
    param(
        [Parameter( Mandatory = $false )] [object] $ListToEnumerate = $script:w6_SentinelValue_String,
        [Parameter( Mandatory = $false )] [object] $AttributesBlackList = @(),
        [Parameter( Mandatory = $false )] [object] $AttributesPriorityList = @()
    )

    if ( ( ( $script:w6_SentinelValue_String -eq $ListToEnumerate )  ) ) {
        return
    }

    $listLength = $ListToEnumerate.Length

    if ( 0 -eq $ListToEnumerate.Length ) {
        return
    }

    $positiveCounter = 1

    $lines = @( @( $ListToEnumerate ) | ForEach-Object -Process {
            $line = ( Get-w6_ListLineFromFile `
                    -FileName $_ `
                    -PositiveCounter $positiveCounter `
                    -ListLength $listLength `
                    -AttributesBlackList:$AttributesBlackList `
                    -AttributesPriorityList:$AttributesPriorityList )

            $line

            $positiveCounter++ }
    )

    return $lines
}


function Write-w6_HostWithColorsCushion {
    param(
        [Parameter( Mandatory = $false )] [object] $Object,
        [Parameter( Mandatory = $false )] [object] $BackgroundColor = $script:w6_SentinelValue_String,
        [Parameter( Mandatory = $false )] [object] $ForegroundColor = $script:w6_SentinelValue_String
    )

    $backgroundColor_IsValid = ( $script:w6_List_Attributes_Colors_ValidColors.Contains( $BackgroundColor ) )
    $foregroundColor_IsValid = ( $script:w6_List_Attributes_Colors_ValidColors.Contains( $ForegroundColor ) )

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


function Write-w6_EnumeratedFileList {
    param(
        [Parameter( Mandatory = $false )] [object] $ListToEnumerate = $script:w6_SentinelValue_String,
        [Parameter( Mandatory = $false )] [object] $AttributesBlackList = @(),
        [Parameter( Mandatory = $false )] [object] $AttributesPriorityList = @(),
        [switch] $AddDisplayList,
        [switch] $AddZero,
        [switch] $AddQuitStick,
        [switch] $AddAccessDenied
    )

    if ( $script:w6_SentinelValue_String -eq $ListToEnumerate ) {
        $ListToEnumerate = @()
    }

    if ( $AddDisplayList ) {
        Write-Host ( "$( Get-w6_ListOneLineLeftSideSpaces -CounterText $script:w6_List_Character_DisplayList )",
            "[$script:w6_List_Character_DisplayList] ",
            'Force Write List' -join '' )
    }

    if ( $AddZero ) {
        $parentPath = [System.IO.Path]::GetFullPath(
            ( Get-w6_StringWithoutDoubleSlashes -String "$( $script:w6_OperatingPath )$( $script:w6_PathSlash ).." )
        )

        Write-Host ( "$( Get-w6_ListOneLineLeftSideSpaces -CounterText $script:w6_List_Character_Zero )",
            "[$script:w6_List_Character_Zero] Parent Directory - $parentPath" `
                -join '' )
    }

    if ( $AddQuitStick ) {
        Write-Host ( "$( Get-w6_ListOneLineLeftSideSpaces -CounterText $script:w6_List_Character_ExitStick )",
            "[$script:w6_List_Character_ExitStick] ",
            'Exit Stick Mode.' -join '' )

    }

    if ( $AddAccessDenied ) {
        Write-Host ( "$( Get-w6_ListOneLineLeftSideSpaces -CounterText $script:w6_List_Character_AccessDenied )",
            "[$script:w6_List_Character_AccessDenied] ",
            'Access Denied!' -join '' )
    }

    $enumeratedFilesWithLineInfo = ( Get-w6_RawEnumeratedFilesList `
            -ListToEnumerate @( $ListToEnumerate ) `
            -AttributesBlackList:$AttributesBlackList `
            -AttributesPriorityList:$AttributesPriorityList
    )

    if ( -not $script:w6_List_FileAttributes_Toggle ) {
        foreach ( $line in $enumeratedFilesWithLineInfo ) {
            Write-Host $line
        }
        return
    }

    if ( $enumeratedItemsList.Length -lt 0 ) {
        return
    }

    foreach ( $lineInfo in $enumeratedFilesWithLineInfo ) {
        $line = $lineInfo[$script:w6_List_Raw_Names_Line_Text]
        $colors = $lineInfo[$script:w6_List_Raw_Names_Line_Color]

        if ( $script:w6_SentinelValue_String -eq $colors ) {
            Write-Host $line
            continue
        }

        $backgroundColor = $colors[$script:w6_List_Attributes_Colors_Name_BackgroundColor]
        $foregroundColor = $colors[$script:w6_List_Attributes_Colors_Name_ForegroundColor]

        Write-w6_HostWithColorsCushion `
            -Object $line `
            -BackgroundColor $backgroundColor `
            -ForegroundColor $foregroundColor
    }
}


function Write-w6_FullItemList {
    param(
        [Parameter( Mandatory = $false )] [object] $ChildrenItems = $script:w6_SentinelValue_String,
        [Parameter( Mandatory = $false )] [object] $AttributesBlackList = @(),
        [Parameter( Mandatory = $false )] [object] $AttributesPriorityList = @(),
        [switch] $IsDir,
        [switch] $IsStick,
        [switch] $NoNewlineUnderList,
        [switch] $SoftClearBeforeList
    )

    $setWindowTitleSuccess = ( Set-w6_WindowTitleToBringBack -Title $script:w6_List_WindowTitle_Processing )

    if ( $IsDir ) {
        $header = 'Found Directories:'
    }
    else {
        $header = 'Found Items:'
    }

    $addAccessDenied = $false

    if ( $script:w6_SentinelValue_String -eq $ChildrenItems ) {
        $ChildrenItems = @()
        $addAccessDenied = $true
    }

    $ChildrenItems = @( @( $ChildrenItems ) | Where-Object { $_ -ne $script:w6_SentinelValue_String } )

    Set-w6_NewWindowSizeVariables -Width

    $arrowLength = [Math]::Min(
        [Math]::Floor(
            $script:w6_Window_Width -
            $script:w6_List_Attributes_MinCharactersSeparating_Right *
            $script:w6_List_Boundary_LengthEquation_WindowWidthSubtracting_MinCharactersSeparatingRightMultiplier +
            0.5
        ),
        $script:w6_Window_Width
    )

    if ( $SoftClearBeforeList ) {
        Write-w6_SoftClearTerminal
    }

    Write-Host ''
    Write-Host "$( Get-w6_Boundary -RawLength $arrowLength -Direction $script:w6_Boundary_Direction_Name_Right -MinusOneOnlyIfMaxWidth )"
    Write-Host "$( ' ' * $script:w6_List_BeforeCounterText_SpacesIfOneDigit  ) You're at: $( $script:w6_OperatingPath )"
    Write-Host ''
    Write-Host "$header"

    Write-w6_EnumeratedFileList `
        -ListToEnumerate $ChildrenItems `
        -AttributesBlackList:$AttributesBlackList `
        -AttributesPriorityList:$AttributesPriorityList `
        -AddDisplayList:$script:w6_List_Character_DisplayList_DoDisplayOnList `
        -AddZero `
        -AddQuitStick:$IsStick `
        -AddAccessDenied:$addAccessDenied

    Write-Host ''
    Write-Host "$( ' ' * $script:w6_List_BeforeCounterText_SpacesIfOneDigit  ) You're at: $( $script:w6_OperatingPath )"
    Write-Host "$( Get-w6_Boundary -RawLength $arrowLength -Direction $script:w6_Boundary_Direction_Name_Left -MinusOneOnlyIfMaxWidth )"

    if ( -not $NoNewlineUnderList ) {
        Write-Host ''
    }

    if ( $setWindowTitleSuccess ) {
        $null = ( Set-w6_LastWindowTitle )
    }
}


function Get-w6_Correct12HourFormatTime {
    param(
        [Parameter( Mandatory = $true )] [object] $Date
    )

    try {
        $currentHour = ( $Date.ToString( 'HH' ) )
        $currentMinute = ( $Date.ToString( 'mm' ) )

        if ( $currentHour -le 12 ) {
            $current12HourFormatTime = "$( $currentHour ):$currentMinute am"
        }
        else {
            $current12HourFormatTime = "$( $currentHour - 12 ):$currentMinute pm"
        }

        return "$current12HourFormatTime"
    }
    catch {
        return $script:w6_SentinelValue_String
    }
    # Improvement idea: Be more explicit with error catching here.

}


function Get-w6_CurrentTimeString {
    param(
        [Parameter( Mandatory = $true )] [object] $Date
    )

    $current24HourFormatTime = ( $Date.ToString( $script:w6_Time_Format_24 ) )
    $current12HourFormatTime = ( Get-w6_Correct12HourFormatTime -Date $Date )
    $badTimeTextValues = @( '', $script:w6_SentinelValue_String )

    if ( "$script:w6_Introduction_Greeting_CurrentTimeText_Format" -eq "$script:w6_Introduction_Greeting_CurrentTimeText_Name_24" ) {
        $currentTimeTextRaw = $current24HourFormatTime
    }
    elseif ( "$script:w6_Introduction_Greeting_CurrentTimeText_Format" -eq "$script:w6_Introduction_Greeting_CurrentTimeText_Name_12" ) {
        $currentTimeTextRaw = ( Get-w6_ValueOrFallback `
                -ToReturn $current12HourFormatTime `
                -Fallback $current24HourFormatTime `
                -BlacklistMultipleItems @( '', $script:w6_SentinelValue_String ) )
    }
    else {
        $emptyTimeTextValue = ''

        $current12HourFormatTimeTextRaw = ( Get-w6_ValueOrFallback `
                -ToReturn $current12HourFormatTime `
                -Fallback $emptyTimeTextValue `
                -BlacklistMultipleItems $badTimeTextValues )

        $current24HourFormatTimeTextRaw = "$current24HourFormatTime"

        if ( $current12HourFormatTimeTextRaw -ne '' ) {
            $current24HourFormatTimeTextRaw = "($current24HourFormatTimeTextRaw)"
        }

        $current24HourFormatTimeTextRaw = " $current24HourFormatTimeTextRaw"

        $currentTimeTextRaw = "$( $current12HourFormatTimeTextRaw )$( $current24HourFormatTimeTextRaw )"
    }

    return "It's $( $currentTimeTextRaw )!"
}


function Get-w6_IsHourBetween {
    # This function _does_ support wrapping at midnight. It always wraps 'to tomorrow'
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


function Get-w6_Greeting {

    try {
        $currentTime = ( Get-Date )
        $currentTimeString = " $( Get-w6_CurrentTimeString -Date $currentTime )"
        $currentHour = ( $currentTime.ToString( 'HH' ) )

        if ( Get-w6_IsHourBetween `
                -Hour $currentHour `
                -MoreThan $script:w6_Introduction_Greeting_StartHour_Morning `
                -LessThan $script:w6_Introduction_Greeting_StartHour_Afternoon ) {

            $greetingString = $script:w6_Introduction_Greeting_Text_Morning
        }
        elseif ( Get-w6_IsHourBetween `
                -Hour $currentHour `
                -MoreThan $script:w6_Introduction_Greeting_StartHour_Afternoon `
                -LessThan $script:w6_Introduction_Greeting_StartHour_Evening ) {

            $greetingString = $script:w6_Introduction_Greeting_Text_Afternoon
        }
        elseif ( Get-w6_IsHourBetween `
                -Hour $currentHour `
                -MoreThan $script:w6_Introduction_Greeting_StartHour_Evening `
                -LessThan $script:w6_Introduction_Greeting_StartHour_Morning ) {

            $greetingString = $script:w6_Introduction_Greeting_Text_Evening
        }
        else {
            $greetingString = $script:w6_Introduction_Greeting_Text_Fallback
        }

        return "$greetingString$currentTimeString"
    }
    catch {
        return $script:w6_SentinelValue_String
    }
    # Improvement idea: Be more explicit with error catching here.

}


function Get-w6_DoesValueFitInRange {
    param(
        [Parameter( Mandatory = $false )] [object] $Value = $script:w6_SentinelValue_String,
        [Parameter( Mandatory = $false )] [int] $ListLength = $script:w6_SentinelValue_String,
        [switch] $AllowNegative
    )

    if ( $script:w6_SentinelValue_String -eq $Value ) {
        return $false
    }

    if ( $script:w6_SentinelValue_String -eq $ListLength ) {
        return $false
    }

    try {
        $null = [int]::TryParse( $Value, [ref] $Value )
    }
    catch [System.InvalidCastException] {
        return $false
    }

    if ( ( $AllowNegative -and ( $Value -ge - $ListLength ) ) -or ( ( $Value -ge 0 ) ) -and ( $Value -le $ListLength ) ) {
        return $true
    }

    return $false

}


function Write-w6_SoftClearTerminal {
    Set-w6_NewWindowSizeVariables -Height
    Write-Host -NoNewline "$( "`n" * $script:w6_Window_Height )"
}


function Get-w6_CorrectedWhichByAlphabet {
    param(
        [Parameter( Mandatory = $true )] [int] $ListLength,
        [switch] $AllowDisplayListCharacter,
        [switch] $AllowZeroCharacter,
        [switch] $AllowQuitStickCharacter,
        [switch] $AllowNegative
    )

    if ( $script:w6_SentinelValue_String -eq $script:w6_WhichByAlphabet ) {
        return $script:w6_SentinelValue_String
    }

    if ( ( $AllowDisplayListCharacter ) `
            -and ( $script:w6_List_Character_DisplayList -eq $script:w6_WhichByAlphabet  ) ) {
        return $script:w6_WhichByAlphabet
    }

    if ( ( $AllowZeroCharacter ) `
            -and ( $script:w6_List_Character_Zero -eq $script:w6_WhichByAlphabet ) ) {
        return $script:w6_WhichByAlphabet
    }

    if ( ( $AllowQuitStickCharacter ) `
            -and ( $script:w6_List_Character_ExitStick -eq $script:w6_WhichByAlphabet ) ) {
        return $script:w6_WhichByAlphabet
    }

    try {
        $whichByAlphabetInt = ( [int] $script:w6_WhichByAlphabet )
    }
    catch {
        return $script:w6_SentinelValue_String
    }

    $isCorrectWhichByAlphabet = ( Get-w6_DoesValueFitInRange -Value $whichByAlphabetInt -ListLength $ListLength `
            -AllowNegative:$AllowNegative )

    if ( ( $isCorrectWhichByAlphabet ) -and ( $script:w6_SentinelValue_String -ne $isCorrectWhichByAlphabet ) ) {
        return $whichByAlphabetInt
    }

    return $script:w6_SentinelValue_String
}


function Get-w6_NearestAvailableLocationFromPath {
    param(
        [Parameter( Mandatory = $true )] [string] $AbsolutePath
    )

    $absolutePathSplit = @( Get-w6_StringSplitWithArray -String $AbsolutePath -Array @( $script:w6_PathSlashes ) )
    $absolutePathDepth = $absolutePathSplit.Length

    $currentLocationSnapshot = "$( Get-Location )$( $script:w6_PathSlash )"

    for ( $i = 0; $i -lt $absolutePathDepth; $i++ ) {
        try {
            $depth = $absolutePathDepth - $i
            $depths = ( 0..( $depth - 1 ) )
            $pathRaw = ( ( $absolutePathSplit[$depths] ) -join $script:w6_PathSlash )
            $path = "$( $PathRaw )$( $script:w6_PathSlash )"

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
    return $script:w6_SentinelValue_String
}


function Set-w6_NearestAvailableLocationFromPath {
    param(
        [Parameter( Mandatory = $true )] [string] $AbsolutePath
    )

    $nearestAvailableLocation = ( Get-w6_NearestAvailableLocationFromPath -AbsolutePath $AbsolutePath )

    if ( $script:w6_SentinelValue_String -ne $nearestAvailableLocation ) {
        Set-Location -Path ( Get-w6_NearestAvailableLocationFromPath -AbsolutePath $AbsolutePath )
    }
}


function Start-w6_TaskbarFlashingForWindow {
    param(
        [Parameter( Mandatory = $false, ValueFromPipeline = $true )] [int] $Hwid = $script:w6_SentinelValue_String,
        [Parameter( Mandatory = $false )] [int] $OneFlashDurationMilliseconds = $script:w6_TaskbarFlashing_OneFlashDurationMilliseconds,
        [Parameter( Mandatory = $false )] [int] $FlashTimes = $script:w6_TaskbarFlashing_FlashTimes
    )

    if ( $script:w6_SentinelValue_String -eq $Hwid ) {
        return
    }

    if ( -not $Hwid ) {
        return
    }

    Import-w6_TaskbarFlasherIfNecessary
    $null = ( [w6_TaskbarFlasher]::FlashWindow( $Hwid, $OneFlashDurationMilliseconds, $FlashTimes ) )
}


function Start-w6_TaskbarFlashingForCurrentConsoleWindow {
    param(
        [Parameter( Mandatory = $false )] [int] $OneFlashDurationMilliseconds,
        [Parameter( Mandatory = $false )] [int] $FlashTimes
    )

    $oldTitle = $host.UI.RawUI.WindowTitle
    $newTitle = ( New-Guid )

    $host.UI.RawUI.WindowTitle = $newTitle
    $consoleWindowProcesses = @( @( Get-Process ) | Where-Object -FilterScript { $_.MainWindowTitle -eq $newTitle } )
    $host.UI.RawUI.WindowTitle = $oldTitle


    foreach ( $process in $consoleWindowProcesses ) {
        Start-w6_TaskbarFlashingForProcess -Process $process
    }
}


function Start-w6_TaskbarFlashingForProcess {
    param(
        [Parameter( Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'ProcessId' )] $ProcessId = $script:w6_SentinelValue_String,
        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'Process' )] $Process = $script:w6_SentinelValue_String,
        [Parameter( Mandatory = $false )] [int] $OneFlashDurationMilliseconds,
        [Parameter( Mandatory = $false )] [int] $FlashTimes
    )

    if ( $script:w6_SentinelValue_String -eq $Process ) {
        if ( $script:w6_SentinelValue_String -eq $ProcessId ) {
            return
        }

        $Process = ( Get-Process -Id $ProcessId )
    }

    if ( -not $Process ) {
        return
    }

    $Hwid = $Process.MainWindowHandle

    if ( -not $Hwid ) {
        return
    }

    Start-w6_TaskbarFlashingForWindow `
        -Hwid $Hwid `
        -OneFlashDurationMilliseconds $OneFlashDurationMilliseconds `
        -FlashTimes $FlashTimes
}


function Unregister-w6_RemoveMeNamedTasks {
    @( @( Get-ScheduledTask ) | Where-Object -FilterScript {
            $_.TaskName.StartsWith( $script:w6_Unelev_ScheduledTaskName_RemoveMeNamedPrefix )
        } ) | ForEach-Object -Process { `
            Unregister-ScheduledTask -InputObject $_ -Confirm:$false -ErrorAction SilentlyContinue
    }
}


function Get-w6_CdaLikeInputPattern {
    param(
        [switch] $TolerateDisplayListCharacter,
        [switch] $TolerateZeroCharacter,
        [switch] $TolerateQuitStickCharacter,
        [switch] $TolerateSeparatorCharacter
    )

    if ( $script:w6_SentinelValue_String -eq $script:w6_CdaLikeInputCharacters_Filtered ) {
        $allCommandsAndAliasesNames = ( Get-Command -All ).Name
        $allCommandsAndAliasesNamesHashSet = ( [System.Collections.Generic.HashSet[System.Object]]::new(
                $allCommandsAndAliasesNames ) )

        $script:w6_CdaLikeInputCharacters_Filtered = @( @( $script:w6_List_Input_MathCharacters ) | Where-Object {
                -not $allCommandsAndAliasesNamesHashSet.Contains( $_ ) }
        )

        # Two above expressions can take >100ms ( very long ). Optimize them further if possible.
    }

    $CdaLikeInputCharacters = $script:w6_CdaLikeInputCharacters_Filtered

    Add-w6_DirectlyToArrayIfBoolTrue `
        -ArrayReference ( [ref] $CdaLikeInputCharacters ) `
        -Bool:$TolerateDisplayListCharacter `
        -ToAdd $script:w6_List_Character_DisplayList

    Add-w6_DirectlyToArrayIfBoolTrue `
        -ArrayReference ( [ref] $CdaLikeInputCharacters ) `
        -Bool:$TolerateZeroCharacter `
        -ToAdd $script:w6_List_Character_Zero

    Add-w6_DirectlyToArrayIfBoolTrue `
        -ArrayReference ( [ref] $CdaLikeInputCharacters ) `
        -Bool:$TolerateQuitStickCharacter `
        -ToAdd $script:w6_List_Character_ExitStick

    Add-w6_DirectlyToArrayIfBoolTrue `
        -ArrayReference ( [ref] $CdaLikeInputCharacters ) `
        -Bool:$TolerateSeparatorCharacter `
        -ToAdd $script:w6_CdaLikeCommands_InputCharactersPattern_SeparatorCharacter

    $CdaLikeInputCharacters = @( @( $CdaLikeInputCharacters ) | ForEach-Object -Process { [Regex]::Escape( $_ ) } )

    $CdaLikeInputCharacters += '\d'

    $CdaLikeInputCharactersPattern = "($( @( $CdaLikeInputCharacters ) -join '|' ))+"

    return $CdaLikeInputCharactersPattern
}


function Get-w6_ProcessedExpressionOrFallback {
    param(
        [Parameter( Mandatory = $false, ValueFromPipeline = $true )] [object] $Expression,
        [Parameter( Mandatory = $false )] [object] $Fallback = $script:w6_SentinelValue_String,
        [switch] $TolerateDisplayListCharacter,
        [switch] $TolerateZeroCharacter,
        [switch] $TolerateQuitStickCharacter
    )

    if ( $TolerateDisplayListCharacter -and ( $script:w6_List_Character_DisplayList -eq $Expression ) ) {
        return $Expression
    }

    if ( $TolerateZeroCharacter -and ( $script:w6_List_Character_Zero -eq $Expression ) ) {
        return $Expression
    }

    if ( $TolerateQuitStickCharacter -and ( $script:w6_List_Character_ExitStick -eq $Expression ) ) {
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


function Get-w6_EvaluatedExpressionsFromTextAsNestedArray {
    param(
        [Parameter( Mandatory = $false )] [object] $Text = $script:w6_SentinelValue_String,
        [switch] $TolerateDisplayListCharacter,
        [switch] $TolerateZeroCharacter,
        [switch] $TolerateQuitStickCharacter
    )

    function Get-w6_FallbackReturn {
        return , @( , @( $script:w6_SentinelValue_String ) )
    }

    $Text = "$Text"

    if ( ( '' -eq $Text ) -or ( $script:w6_SentinelValue_String -eq $Text ) ) {
        return @( Get-w6_FallbackReturn )
    }

    $pattern = ( Get-w6_CdaLikeInputPattern `
            -TolerateDisplayListCharacter:$TolerateDisplayListCharacter `
            -TolerateZeroCharacter:$TolerateZeroCharacter `
            -TolerateQuitStickCharacter:$TolerateQuitStickCharacter `
            -TolerateSeparatorCharacter )

    $foundExpressionsRaw = $Text | Select-String -AllMatches -Pattern $pattern

    $foundExpressions = @( $foundExpressionsRaw.Matches.Value )

    $foundExpressionsEmptyFiltered = @( @( $foundExpressions ) | Where-Object -FilterScript {
        ( $null -ne $_ ) -and ( $script:w6_CdaLikeCommands_InputCharactersPattern_SeparatorCharacter -ne $_ ) }
    )

    if ( 0 -eq $foundExpressionsEmptyFiltered.Length ) {
        return @( Get-w6_FallbackReturn )
    }

    $slicedExpressions = @( @( $foundExpressionsEmptyFiltered ) | ForEach-Object -Process {
            , @( $_.Split( $script:w6_CdaLikeCommands_InputCharactersPattern_SeparatorCharacter ) ) }
    )

    $slicedExpressionsFiltered = @( @( $slicedExpressions ) | Where-Object -FilterScript {
            $null -ne $_ }
    )

    $slicedExpressionsFilteredTwice = @( @( $slicedExpressionsFiltered ) | ForEach-Object -Process {
            , @( @( $_ ) | Where-Object -FilterScript { $_ -or ( '0' -eq $_ ) } ) }
    )

    $slicedExpressionsFilteredThrice = @( @( $slicedExpressionsFilteredTwice ) | Where-Object -FilterScript {
            -not ( Get-w6_IsEqualByCompareObject -ItemOne @() -ItemTwo @( $_ ) ) }
    )

    if ( 0 -eq $slicedExpressionsFilteredThrice.Length ) {
        return @( Get-w6_FallbackReturn )
    }

    $processedExpressionsTwoDimensionalFiltered = @( @( $slicedExpressionsFilteredThrice ) | ForEach-Object -Process {
            , @(
                $processedExpressions = @( @( $_ ) | ForEach-Object -Process {
                        Get-w6_ProcessedExpressionOrFallback `
                            -Expression $_ `
                            -Fallback $script:w6_SentinelValue_String `
                            -TolerateDisplayListCharacter:$TolerateDisplayListCharacter `
                            -TolerateZeroCharacter:$TolerateZeroCharacter `
                            -TolerateQuitStickCharacter:$TolerateQuitStickCharacter }
                )

                @( @( $processedExpressions ) | Where-Object -FilterScript {
                        $_ -ne $script:w6_SentinelValue_String }
                )
            )

        }
    )

    $processedExpressionsTwoDimensionalFilteredTwice = @( @( $processedExpressionsTwoDimensionalFiltered ) | `
                Where-Object -FilterScript { $_.Length -gt 0 }
    )

    if ( 0 -eq $processedExpressionsTwoDimensionalFilteredTwice.Length ) {
        return @( Get-w6_FallbackReturn )
    }

    return @( $processedExpressionsTwoDimensionalFilteredTwice )
}


function Get-w6_TwoDimensionalExtractedAndEvaluatedExpressionsFromObject {
    param(
        [Parameter( Mandatory = $false )] [object] $Object,
        [Parameter( Mandatory = $false )] [object] $Padding,
        [switch] $TolerateDisplayListCharacter,
        [switch] $TolerateZeroCharacter,
        [switch] $TolerateQuitStickCharacter
    )

    if ( ( $null -ne $Object ) -and ( $Object.GetType().IsArray ) ) {

        $evaluatedExpressions = @( @( $Object ) | ForEach-Object -Process {
                Get-w6_ProcessedExpressionOrFallback `
                    -Expression $_ `
                    -Fallback $script:w6_SentinelValue_String `
                    -TolerateDisplayListCharacter:$TolerateDisplayListCharacter `
                    -TolerateZeroCharacter:$TolerateZeroCharacter `
                    -TolerateQuitStickCharacter:$TolerateQuitStickCharacter }
        )

        $filteredExpressions = @( @( $evaluatedExpressions ) | Where-Object -FilterScript {
                $script:w6_SentinelValue_String -ne $_ }
        )

        $processedExpressions = @( @( $filteredExpressions ) | ForEach-Object -Process { , @( $_ ) } )

        return @( $processedExpressions )
    }

    if ( ConvertTo-w6_StringDirectly -ValueReference ( [ref] $Object ) ) {

        return @( Get-w6_EvaluatedExpressionsFromTextAsNestedArray `
                -Text $Object `
                -TolerateDisplayListCharacter:$TolerateDisplayListCharacter `
                -TolerateZeroCharacter:$TolerateZeroCharacter `
                -TolerateQuitStickCharacter:$TolerateQuitStickCharacter )

    }

    return @( , @( $Padding ) )
}


function Get-w6_WhichByAlphabetTimesQueue {
    param(
        [Parameter( Mandatory = $false, ParameterSetName = 'TwoStringInputMode' )] [object] $WhichByAlphabet,
        [Parameter( Mandatory = $false, ParameterSetName = 'TwoStringInputMode'  )] [object] $Times,
        [Parameter( Mandatory = $false, ParameterSetName = 'OneStringInputMode' )] [object] $OneString = $script:w6_SentinelValue_String,
        [switch] $TolerateDisplayListCharacter,
        [switch] $TolerateZeroCharacter,
        [switch] $TolerateQuitStickCharacter
    )

    if ( $script:w6_SentinelValue_String -ne $OneString ) {
        $oneStringExtract = @( Get-w6_TwoDimensionalExtractedAndEvaluatedExpressionsFromObject `
                -Object:$OneString `
                -Padding:$script:w6_SentinelValue_String `
                -TolerateQuitStickCharacter:$TolerateQuitStickCharacter `
                -TolerateDisplayListCharacter:$TolerateDisplayListCharacter `
                -TolerateZeroCharacter:$TolerateZeroCharacter )

        $whichByAlphabetExtract = @( $oneStringExtract[0] )
        $timesExtract = @( $oneStringExtract[1] )
    }
    else {
        $whichByAlphabetExtract = @( Get-w6_TwoDimensionalExtractedAndEvaluatedExpressionsFromObject `
                -Object:$WhichByAlphabet `
                -Padding:$script:w6_SentinelValue_String `
                -TolerateDisplayListCharacter:$TolerateDisplayListCharacter `
                -TolerateZeroCharacter:$TolerateZeroCharacter `
                -TolerateQuitStickCharacter:$TolerateQuitStickCharacter )

        $timesExtract = @( Get-w6_TwoDimensionalExtractedAndEvaluatedExpressionsFromObject `
                -Object:$Times `
                -Padding 1 `
                -TolerateDisplayListCharacter:$false `
                -TolerateZeroCharacter:$false `
                -TolerateQuitStickCharacter:$false )
    }

    $whichByAlphabetExtract_Flattened = @( Get-w6_FlattenedArray -Array @( $whichByAlphabetExtract ) )

    $timesExtract_Flattened = @( Get-w6_FlattenedArray -Array @( $timesExtract ) )

    $whichByAlphabet_Times_Queue_Length = ( [Math]::Max( $whichByAlphabetExtract_Flattened.Length,
            $timesExtract_Flattened.Length ) )

    $whichByAlphabetQueue = @( Get-w6_PaddedArrayToLength `
            -ArrayToPad $whichByAlphabetExtract_Flattened `
            -PaddingObject $script:w6_SentinelValue_String `
            -Length $whichByAlphabet_Times_Queue_Length )

    $timesQueue = @( Get-w6_PaddedArrayToLength `
            -ArrayToPad $timesExtract_Flattened `
            -PaddingObject 1 `
            -Length $whichByAlphabet_Times_Queue_Length )

    $timesQueue = @( @( $timesQueue ) | ForEach-Object -Process {
            if ( ( $script:w6_SentinelValue_String -eq $_ ) -or ( $null -eq $_ ) ) {
                $script:w6_List_Times_DefaultValue
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


function Invoke-w6_SelectFileFromList {
    param(
        [Parameter( Mandatory = $false )] [object] $AttributesBlackList = @(),
        [Parameter( Mandatory = $false )] [object] $AttributesPriorityList = @(),
        [switch] $UseDirectories,
        [switch] $Stick,
        [switch] $WriteSelectedFiles,
        [switch] $NoList,
        [switch] $ForceFiles,
        [switch] $SoftClearBeforeList
    )

    $script:w6_SelectFileFromList_IsStick = $Stick

    $script:w6_StickLoopDoBreak = $false
    $script:w6_Children = @( Get-w6_ChildItems -IsDir:$UseDirectories -Force:$ForceFiles )
    $ListLength = $script:w6_Children.Length

    function Invoke-w6_WhichByDirectoryCorrectFormatAction {
        if ( $script:w6_List_Character_Zero -eq $script:w6_WhichByAlphabet ) {
            $selectedFile = (
                Get-w6_StringWithoutDoubleSlashes -String "$( $script:w6_OperatingPath )$( $script:w6_PathSlash ).." )
        }
        elseif ( $script:w6_List_Character_DisplayList -eq $script:w6_WhichByAlphabet ) {
            Write-w6_FullItemList `
                -AttributesBlackList:$AttributesBlackList `
                -AttributesPriorityList:$AttributesPriorityList `
                -ChildrenItems $script:w6_Children `
                -IsDir:$UseDirectories `
                -SoftClearBeforeList:$SoftClearBeforeList
            return
        }
        else {
            $operatingPathWithSlash = "$( $script:w6_OperatingPath )$( $script:w6_PathSlash )"
            if ( ( [int] $script:w6_WhichByAlphabet ) -le 0 ) {
                $selectedFile = "$( $operatingPathWithSlash )$( $script:w6_Children[$script:w6_WhichByAlphabet] )"
            }
            else {
                $selectedFile = "$( $operatingPathWithSlash )$( $script:w6_Children[$script:w6_WhichByAlphabet - 1] )"
            }
        }

        $universalSelectedFile = ( Get-w6_UniversalPath -Path $selectedFile )

        $isUniversalSelectedFileSentinel = ( $script:w6_SentinelValue_String -eq $universalSelectedFile )
        $isUniversalSelectedFileValid = ( Test-Path -Path $universalSelectedFile )

        if ( $isUniversalSelectedFileSentinel -or ( -not $isUniversalSelectedFileValid ) ) {

            if ( ( -not $script:w6_SelectFileFromList_IsStick ) -and ( -not $NoList ) ) {
                Write-w6_FullItemList `
                    -AttributesBlackList:$AttributesBlackList `
                    -AttributesPriorityList:$AttributesPriorityList `
                    -ChildrenItems $script:w6_Children `
                    -IsDir:$UseDirectories `
                    -SoftClearBeforeList:$SoftClearBeforeList
            }

            return
        }

        Set-w6_VariableFToPath -Path $universalSelectedFile

        if ( $WriteSelectedFiles ) {
            $selectedFileToWrite = $universalSelectedFile
            $selectedFile_LastCharacter = ( $selectedFileToWrite[-1] )

            if ( $selectedFile_LastCharacter -in @( $script:w6_PathSlashes ) ) {
                $selectedFileToWrite = $universalSelectedFile.Substring( 0, ( $universalSelectedFile.Length - 1 ) )
                $selectedFileToWrite = ( Get-w6_PathWithAddedSlashIfNecessary -Path $selectedFileToWrite )
            }

            Write-Host "$( $script:w6_List_WriteSelectedFiles_Prefix )$( $selectedFileToWrite )"
        }

        if ( $UseDirectories ) {
            Set-Location -Path $universalSelectedFile

            Set-w6_OperatingPathIfValid `
                -Path $universalSelectedFile `
                -Silent:$script:w6_SetOperatingPath_DefaultParameterValue_Silent_IfUsedBy_Script
        }
        else {
            return $universalSelectedFile
        }
    }

    function Invoke-w6_StickBadInputAction {
        $boundaryOpening = ( Get-w6_Boundary `
                -LengthMultiplier $script:w6_Boundary_Length_Medium `
                -Direction $script:w6_Boundary_Direction_Name_Left )
        $boundaryClosing = ( Get-w6_Boundary `
                -LengthMultiplier $script:w6_Boundary_Length_Medium `
                -Direction $script:w6_Boundary_Direction_Name_Right )

        if ( $script:w6_List_Stick_BadInput_FirstTime -eq $true ) {
            $script:w6_List_Stick_BadInput_FirstTime = $false

            $secondsToWaitSuffix = 'seconds'

            if ( 1000 -eq $script:w6_List_Stick_BadInput_Sleep_Milliseconds_FirstTime ) {
                $secondsToWaitSuffix = 'second'
            }

            $secondsToWait = $script:w6_List_Stick_BadInput_Sleep_Milliseconds_FirstTime / 1000

            Write-Host ''
            Write-Host "$boundaryOpening"
            Write-Host "Bad Input! Repeating in $( $secondsToWait ) $secondsToWaitSuffix..."
            Write-Host "$boundaryClosing"
            Write-Host ''

            Start-Sleep -Milliseconds $script:w6_List_Stick_BadInput_Sleep_Milliseconds_FirstTime
            return
        }

        Write-Host ''
        Write-Host "$boundaryOpening"
        Write-Host 'Bad Input! Repeating...'
        Write-Host "$boundaryClosing"
        Write-Host ''

        Start-Sleep -Milliseconds $script:w6_List_Stick_BadInput_Sleep_Milliseconds_NotFirstTime
    }

    function Invoke-w6_OneStickRepetition {
        $errorTimes = 0
        $exceptionMessages = @()

        while ( $true ) {

            try {
                $script:w6_Children = @( Get-w6_ChildItems -IsDir:$UseDirectories -Force:$ForceFiles )
                Write-w6_FullItemList `
                    -AttributesBlackList:$AttributesBlackList `
                    -AttributesPriorityList:$AttributesPriorityList `
                    -ChildrenItems $script:w6_Children `
                    -IsDir:$UseDirectories `
                    -IsStick `
                    -NoNewlineUnderList `
                    -SoftClearBeforeList:$SoftClearBeforeList

                $stickOption = ( Read-Host 'Option' )

                $whichByAlphabet_Times_Queue = @( Get-w6_WhichByAlphabetTimesQueue `
                        -OneString $stickOption `
                        -TolerateDisplayListCharacter `
                        -TolerateZeroCharacter `
                        -TolerateQuitStickCharacter
                )

                foreach ( $whichByAlphabetTimes_Pair in $whichByAlphabet_Times_Queue ) {
                    $script:w6_WhichByAlphabet = $whichByAlphabetTimes_Pair[0]

                    if ( $script:w6_List_Character_ExitStick -eq $script:w6_WhichByAlphabet ) {
                        $script:w6_StickLoopDoBreak = $true
                        return
                    }

                    if ( $script:w6_SentinelValue_String -eq $script:w6_WhichByAlphabet ) {
                        continue
                    }

                    $times = $whichByAlphabetTimes_Pair[1]

                    for ( $i = 0; $i -lt $times; $i++ ) {
                        $script:w6_Children = @( Get-w6_ChildItems -IsDir:$UseDirectories -Force:$ForceFiles )
                        $ListLength = $script:w6_Children.Length

                        Use-w6_WhichByAlphabet -ListLength $ListLength
                    }
                }

                if ( $whichByAlphabet_Times_Queue.Length -eq 1 ) {
                    $isFirstQueueItemEmpty = ( $whichByAlphabet_Times_Queue[0][0] -eq $script:w6_SentinelValue_String )

                    if ( $isFirstQueueItemEmpty) {
                        Invoke-w6_StickBadInputAction
                    }
                }

                break
            }
            catch {
                $errorTimes++

                $exceptionMessage = $_.Exception.Message

                if ( $exceptionMessage -notin $exceptionMessages ) {
                    $exceptionMessages += $exceptionMessage
                }

                if ( $errorTimes -ge $script:w6_List_Stick_BadInput_MaxErrorRetries ) {

                    Write-Host ''

                    Write-Host "$( Get-w6_Boundary `
                        -LengthMultiplier $script:w6_Boundary_Length_Long `
                        -Direction $script:w6_Boundary_Direction_Name_Right )"

                    Write-Host "One or more Exceptions have Occurred Repeatedly ( $errorTimes times )"
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

                        Write-Host ''
                        Write-Host 'TIP: USE CTRL+C TO EXIT STICK'
                    }

                    Write-Host "$( Get-w6_Boundary `
                        -LengthMultiplier $script:w6_Boundary_Length_Long `
                        -Direction $script:w6_Boundary_Direction_Name_Right )"

                    Write-Host ''

                    $errorTimes = 0
                    Set-Location -Path (
                        Get-w6_StringWithoutDoubleSlashes -String "$( $script:w6_OperatingPath )$( $script:w6_PathSlash ).." )
                }

            }
            # Improvement idea: Be more explicit with error catching here.
        }
    }

    function Invoke-w6_StickFunction {
        $script:w6_SelectFileFromList_IsStick = $false
        $script:w6_StickLoopDoBreak = $false

        while ( -not $script:w6_StickLoopDoBreak ) {
            Invoke-w6_OneStickRepetition
        }

        Write-Host ''
        Write-Host 'You Quit Stick Mode!'
        Write-Host ''

    }

    function Use-w6_WhichByAlphabet {
        param(
            [Parameter( Mandatory = $true )] [int] $ListLength
        )

        $script:w6_WhichByAlphabet = ( Get-w6_CorrectedWhichByAlphabet `
                -ListLength $ListLength `
                -AllowDisplayListCharacter `
                -AllowZeroCharacter `
                -AllowNegative )

        if ( $script:w6_SelectFileFromList_IsStick ) {
            if ( -not $UseDirectories ) {
                Write-Host ( "The '-UseDirectories' Parameter has to be True in to use the '-Stick' Parameter",
                    "with 'Invoke-w6_SelectFileFromList'" -join '' )
                return
            }

            Invoke-w6_StickFunction
            return
        }

        if ( $script:w6_SentinelValue_String -eq $script:w6_WhichByAlphabet ) {
            if ( $NoList ) {
                return
            }

            Write-w6_FullItemList `
                -AttributesBlackList:$AttributesBlackList `
                -AttributesPriorityList:$AttributesPriorityList `
                -ChildrenItems $script:w6_Children `
                -IsDir:$UseDirectories `
                -SoftClearBeforeList:$SoftClearBeforeList
            return
        }

        Invoke-w6_WhichByDirectoryCorrectFormatAction
    }

    Use-w6_WhichByAlphabet -ListLength $ListLength
}


function Invoke-w6_CdaLikeFunction {
    param(
        [Parameter( Mandatory = $false )] [string] $OperatingPath,
        [Parameter( Mandatory = $false )] [object] $WhichByAlphabet,
        [Parameter( Mandatory = $false )] [object] $Times,
        [Parameter( Mandatory = $false )] [object] $AttributesBlackList,
        [Parameter( Mandatory = $false )] [object] $AttributesPriorityList,
        [switch] $Stick,
        [switch] $Help,
        [switch] $UseDirectories,
        [switch] $ListForce,
        [switch] $NoList,
        [switch] $WriteSelectedFiles,
        [switch] $ForceFiles,
        [switch] $SoftClearBeforeList
    )


    if ( $WhichByAlphabet.GetType().IsArray ) {
        $WhichByAlphabet = @( @( $WhichByAlphabet ) | Where-Object -FilterScript {
                ( $_ -is [string] ) -or ( $_ -is [int] )
            }
        )
    }
    elseif ( ( $WhichByAlphabet -isnot [int] ) -and ( $WhichByAlphabet -isnot [string] ) ) {
        $WhichByAlphabet = $script:w6_SentinelValue_String
    }

    if ( $Times.GetType().IsArray ) {
        $Times = @( @( $Times ) | Where-Object -FilterScript {
                ( $_ -is [string] ) -or ( $_ -is [int] )
            }
        )
    }
    elseif ( ( $Times -isnot [int] ) -and ( $Times -isnot [string] ) ) {
        $Times = $script:w6_List_Times_DefaultValue
    }

    if ( $AttributesBlackList.GetType().IsArray ) {
        $AttributesBlackList = @( @( $AttributesBlackList ) | ForEach-Object -Process {
                if ( ( $_ -is [string] ) -or ( $_ -is [int] ) ) {
                    "$_"
                }
            }
        )
    }
    elseif ( ( $AttributesBlackList -is [string] ) -or ( $AttributesBlackList -is [int] ) ) {
        $AttributesBlackList = @( "$AttributesBlackList" )
    }
    else {
        $AttributesBlackList = @()
    }

    if ( $AttributesPriorityList.GetType().IsArray ) {
        $AttributesPriorityList = @( @( $AttributesPriorityList ) | ForEach-Object -Process {
                if ( ( $_ -is [string] ) -or ( $_ -is [int] ) ) {
                    "$_"
                }
            } )
    }
    elseif ( ( $AttributesPriorityList -is [string] ) -or ( $AttributesPriorityList -is [int] ) ) {
        $AttributesPriorityList = @( "$AttributesPriorityList" )
    }
    else {
        $AttributesPriorityList = @( )
    }

    Set-w6_OperatingPathIfValid -Path:$OperatingPath -Silent:$script:w6_SetOperatingPath_DefaultParameterValue_Silent_IfUsedBy_Script -Fallback '.'


    $whichByAlphabet_Times_Queue = @( Get-w6_WhichByAlphabetTimesQueue `
            -WhichByAlphabet:$WhichByAlphabet `
            -Times:$Times `
            -TolerateZeroCharacter `
            -TolerateDisplayListCharacter )

    foreach ( $whichByAlphabetTimes_Pair in $whichByAlphabet_Times_Queue ) {
        $script:w6_WhichByAlphabet = $whichByAlphabetTimes_Pair[0]

        for ( $i = 0; $i -lt $whichByAlphabetTimes_Pair[1]; $i++ ) {

            Invoke-w6_SelectFileFromList `
                -AttributesBlackList:$AttributesBlackList `
                -AttributesPriorityList:$AttributesPriorityList `
                -UseDirectories:$UseDirectories `
                -Stick:$false `
                -WriteSelectedFiles:$WriteSelectedFiles `
                -NoList:$NoList `
                -ForceFiles:$ForceFiles `
                -SoftClearBeforeList:$SoftClearBeforeList
        }
    }

    if ( $Stick ) {
        Invoke-w6_SelectFileFromList `
            -AttributesBlackList:$AttributesBlackList `
            -AttributesPriorityList:$AttributesPriorityList `
            -UseDirectories `
            -Stick `
            -WriteSelectedFiles:$WriteSelectedFiles `
            -ForceFiles:$ForceFiles `
            -SoftClearBeforeList:$SoftClearBeforeList
    }
}


function Write-w6_ApproximateTimeSinceScriptStart {
    $script:w6_LoadingTimeStopwatch.Stop()
    $scriptLoadingTimeMilliseconds = $script:w6_LoadingTimeStopwatch.Elapsed.TotalMilliseconds
    $scriptLoadingTimeMillisecondsRounded = [Math]::Floor( $scriptLoadingTimeMilliseconds + 0.5 )

    Write-Host "$script:w6_Product_Name loaded in approximately $scriptLoadingTimeMillisecondsRounded ms"
    Write-Host ''
}


function Get-w6_UnelevScheduledTaskName {
    $scheduledTasksNames = ( [string[]] ( Get-ScheduledTask ).TaskName )
    $scheduledTasksNamesHashSet = ( [System.Collections.Generic.HashSet[string]]::new( $scheduledTasksNames ) )

    $taskNameIndex = 0

    while ( $true ) {
        $taskNameIndex++

        $taskNameCandidate = ( "$script:w6_Unelev_ScheduledTaskName_RemoveMeNamedPrefix unelev - Start a New Unelevated PowerShell Session ( $taskNameIndex )" -join '' )

        if ( -not ( $scheduledTasksNamesHashSet.Contains( $taskNameCandidate ) ) ) {
            return $taskNameCandidate
        }
    }
}


# ------------------------------ PUBLIC FUNCTIONS -----------------------------


function Write-FileWalkerIntroduction {
    param(
        [switch] $IsAutomatic
    )

    if ( $IsAutomatic ) {
        Update-w6_IntroductionTotalAutomaticWrites -Value ( $script:w6_Introduction_TotalAutomaticWrites + 1 )
    }

    if ( $script:w6_Introduction_DoClearConsoleBeforeIntroduction ) {
        Clear-Host
    }

    $messageBuilder = ( New-Object -TypeName 'System.Text.StringBuilder' )

    # ------------------------- INTRODUCTION BEGINNING ------------------------

    # ==========> Message Begin
    $null = $messageBuilder.AppendLine( @"
$( Get-w6_Boundary -LengthMultiplier $script:w6_Boundary_Length_Long -Direction $script:w6_Boundary_Direction_Name_Right )
$( $w6_s1 )$script:w6_Product_Name $script:w6_Product_Version
"@ )
    # <========== Message End

    if ( $script:w6_Introduction_Toggle_Greeting -or $script:w6_Introduction_Toggle_DetectedOS ) {
        # ==========> Message Begin
        $null = $messageBuilder.AppendLine( '' )
        # <========== Message End

        if ( $script:w6_Introduction_Toggle_Greeting ) {
            # ==========> Message Begin
            $null = $messageBuilder.AppendLine( @"
$( $w6_s1 )$( Get-w6_Greeting )
"@ )
            # <========== Message End
        }

        if ( $script:w6_Introduction_Toggle_DetectedOS ) {
            # ==========> Message Begin
            $null = $messageBuilder.AppendLine( @"
$( $w6_s1 )Detected OS: $script:w6_CurrentOSType
"@ )
            # <========== Message End
        }

# UPDATE 2025 - LOADING USER CONFIGURATION HAS BEEN DEPRECATED
#         if ( $script:w6_Introduction_Toggle_ConfigStats ) {
#             # ==========> Message Begin
#             $null = $messageBuilder.AppendLine( @"
# $( $w6_s1 )Config: Found $script:w6_Config_Found_Count (Success $script:w6_Config_Success_Count; Error $script:w6_Config_Error_Count)
# "@ )
#             # <========== Message End
#         }

    }

    if ( $script:w6_Introduction_Toggle_CommandsHelp ) {

        # ==========> Message Begin
        $null = $messageBuilder.AppendLine( @"

$( $w6_s2 )cda - Change Directory Alphabetically - Changing Directory Without Writing File Names
$( $w6_s4 )Usage
$( $w6_s6 )> cda > Displays a list of directories that you can jump to
$( $w6_s6 )> cda 1 > Jumps to the 1'st directory from the list
$( $w6_s6 )> cda -stick > Displays the list and Asks where to jump continuously

$( $w6_s2 )cdf - Current Directory File - Selecting a File From The Current Directory
$( $w6_s4 )Usage
$( $w6_s6 )> cdf > Displays a list of files you can choose
$( $w6_s6 )> cdf 1 > Returns the 1'st file from the list
"@ )
        # <========== Message End

        if ( $script:w6_IsWindows ) {
            # ==========> Message Begin
            $null = $messageBuilder.AppendLine( @"

$( $w6_s2 )elev - Quickly open an Admin PowerShell Session at your current working directory
$( $w6_s4 )Usage
$( $w6_s6 )> elev > Opens a new Admin PowerShell Session at your current working directory
$( $w6_s6 )> elev -exit > Opens an Admin PowerShell Session, and closes your current "old" PowerShell session

$( $w6_s2 )unelev - Open a Non-Admin PowerShell Session at your current working directory
$( $w6_s4 )Usage
$( $w6_s6 )> unelev > Opens a new Non-Admin PowerShell Session at your current working directory
$( $w6_s6 )> unelev -exit > Opens a Non-Admin PowerShell Session, and closes your current "old" PowerShell session
"@ )
            # <========== Message End
        }

        # ==========> Message Begin
        $null = $messageBuilder.AppendLine( @"

$( $w6_s1 )The PowerShell-File-Walker Commands Bundle is highly configurable!
"@ )
        # <========== Message End

    }

    if ( $IsAutomatic ) {

        $displaysLeft = $( $script:w6_Introduction_MaxTotalAutomaticWrites - $script:w6_Introduction_TotalAutomaticWrites )

        # ==========> Message Begin
        $null = $messageBuilder.AppendLine( '' )
        # <========== Message End

        if ( 0 -eq $displaysLeft ) {
            # ==========> Message Begin
            $null = $messageBuilder.AppendLine( @"
$( $w6_s1 )This introduction has been automatically displayed for the last time
"@ )
            # <========== Message End
        }
        elseif ( 1 -eq $displaysLeft ) {
            # ==========> Message Begin
            $null = $messageBuilder.AppendLine( @"
$( $w6_s1 )This introduction will be automatically displayed 1 more time
"@ )
            # <========== Message End
        }
        else {
            # ==========> Message Begin
            $null = $messageBuilder.AppendLine( @"
$( $w6_s1 )This introduction will be automatically displayed $displaysLeft more times
"@ )
            # <========== Message End
        }
    }

    if ( $script:w6_Introduction_Toggle_CommandsHelp ) {
        # ==========> Message Begin
        $null = $messageBuilder.AppendLine( @"

$( $w6_s1 )Tip: Use Get-Help [command] for more info
"@ )
        # <========== Message End
    }

    # ==========> Message Begin
    $null = $messageBuilder.AppendLine( @"
$( Get-w6_Boundary -LengthMultiplier $script:w6_Boundary_Length_Long -Direction $script:w6_Boundary_Direction_Name_Left )
"@ )
    # <========== Message End

    if ( $script:w6_Introduction_ScrollUpMessage_DoDisplay ) {

        # ==========> Message Begin
        $null = $messageBuilder.AppendLine( @"
$( "`n" * ( $script:w6_Introduction_ScrollUpMessage_NewlinesAbove - 1 ) )
Scroll up for information about the applied $script:w6_Product_Name...
...
"@ )
        # <========== Message End

        Set-w6_NewWindowSizeVariables -Height
        $newLinesAmount = $script:w6_Window_Height - 5
        if ( $script:w6_Write_Approximate_Loading_Time ) {
            $newLinesAmount -= 2
        }
        $newLines = ( "`n" * [Math]::Max( $newLinesAmount, 0 ) )

        # ==========> Message Begin
        $null = $messageBuilder.Append( "$newLines" )
        # <========== Message End

    }
    else {

        # ==========> Message Begin
        $null = $messageBuilder.Append( "`n" )
        # <========== Message End

    }

    Write-Host -Object ( $messageBuilder.ToString() )
}


<#
.SYNOPSIS
    Write example text for each foreground+background color combination
.DESCRIPTION
    *Write-ColorCombinations is a command from the PowerShell-File-Walker Commands Bundle

    This command was created to help you choose foreground and/or background colors for your PowerShell console text
    Write-ColorCombinations will display a simple sentence for each color combination

    Default sentence example: "This is DarkBlue Text on a Cyan Background"
.PARAMETER CustomText
    Text to write for each combination

    If you didn't specify custom text, the default text is used
    Default text examples
    - "This is Black Text on a Red Background"
    - "This is DarkGreen Text on a Red Background."
    - and so on...
.PARAMETER Swap
    Swaps the order of for-loops within the code
    Default order: displays all background colors for each foreground color
    Swap order: displays all foreground colors for each background color
.PARAMETER NoAlign
    Removes the center-alignment of the text
    Makes the text be aligned to the left instead
.EXAMPLE
    Write-ColorCombinations
    *consider this text colored correctly*
    This is Red Text on a Black Background.
    This is Red Text on a DarkBlue Background.
    This is Red Text on a DarkGreen Background.
    ...
.EXAMPLE
    Write-ColorCombinations -Swap
    *consider this text colored correctly*
    This is Black Text on a Red Background.
    This is DarkBlue Text on a Red Background.
    This is DarkGreen Text on a Red Background.
    ...
.NOTES
    [!Important Note] The written text is aligned to the middle of the console by default
#>

function Write-ColorCombinations {
    param(
        [Parameter( Mandatory = $false )] [Alias( 'text', 't' )] [string] $CustomText = $script:w6_SentinelValue_String,
        [switch] [Alias( 's', 'switch', 'f', 'flip' )] $Swap,
        [switch] [Alias( 'na' )] $NoAlign
    )

    Write-Host ''

    foreach ( $foregroundColor in $script:w6_List_Attributes_Colors_ValidColors ) {
        foreach ( $backgroundColor in $script:w6_List_Attributes_Colors_ValidColors ) {

            Write-w6_OneColorCombination `
                -CustomText:$CustomText `
                -BackgroundColor $backgroundColor `
                -ForegroundColor $foregroundColor `
                -Swap:$Swap `
                -NoAlign:$NoAlign
        }
        Write-Host ''
    }
}


<#
.SYNOPSIS
    Display a formatted list of all current directory's files and return the paths of the files you select
.DESCRIPTION
    *Cdf is a command from the PowerShell-File-Walker Commands Bundle
    Tested for:  Windows 10, 11 PowerShell 5, 7 | Linux (Ubuntu) PowerShell 7

    'cdf' => Display a numbered list of all files at your current directory
    'cdf x' => Select/return the path of the x'th file

    Example:
    PS C:\BookAuthors> cdf
    ---------------------------------------------------------------------->
        You're at: C:\BookAuthors

    Found Items:
    [0] Parent Directory - C:\
    [1] Notes    >                                   -> Directory [1]
    [2] $100M Offers.txt                                          [2]
    [3] The Way Of The Superior Man.txt    >            -> SYSTEM [3]
    [4] Why We Seep.txt    >                          -> ReadOnly [4]

        You're at: C:\BookAuthors
    <----------------------------------------------------------------------
    PS C:\BookAuthors> cdf 2
    C:\BookAuthors\$100M Offers.txt   <- Cdf returned the full path of the selected file
    PS C:\BookAuthors> cd (cdf 1)
    PS C:\BookAuthors\Notes>


    Learn More
    =============================
    #1 Important Information
    #2 The Only Differences Between Cdf And Cda You Should Know About
    #3 Parameter Summary
    =============================


        #1 Important Information
    There are two sibling commands: Cdf and Cda. They are very similar

    Cdf is for selecting files
    Cda is for changing directories

    Cda has an Amazing documentation
    Cdf doesn't have an Amazing documentation

    "Great! But how do I use advanced Cdf features?!?!"
    Since Cdf and Cda are nearly the same: the Great Majority of the Cda documentation applies to Cdf

    Please continue reading to the section #2 which explains The Only Differences Between Cda and Cdf
    Then read the Cda documentation with "Get-Help cda"


            #2 The Only Differences Between Cdf And Cda You Should Know About
    - Cdf outputs the path of the selected files. Cda changes the directory to the selected file
    - Cdf means "Current Directory File". Cda means "Change Directory Alphabetically"
    - Cdf doesn't have Stick mode
    - A few Cdf parameters have different Default Values than Cda parameters


            #3 Parameters Summary
    Parameter Name => Description
    Supported Types | Usual Default Value | Aliases

    WhichByAlphabet => Where to go
    Number, Array, String | $script:w6_SentinelValue_String | w, i, n, wba, index, number

    Times => How Many Times to go there
    Number, Array, String | 1 | t

    OperatingPath => Cdf will Operate from this path
    String | .\ or ./ | p, op, path

    AttributesBlackList => Cdf will Hide these attributes from the list
    Array, String | NotContentIndexed, ReparsePoint, Normal, Archive | bl, blist, black, blacklist

    AttributesPriorityList => Cdf will Make these attributes stand out
    Array, String | System | pl, plist, priority, prioritylist

    ListForce => After all jumps - cdf will Forcefully Display the list
    Switch | False | l, lf

    NoList => Passing invalid WhichByAlphabet won't trigger the list display
    Switch | False | nl

    WriteSelectedFiles => Cdf will Write the selected files. Useful for debugging
    Switch | False | w, wsf, write

    ForceFiles => Cdf will use -Force with the Get-ChildItem command when generating the files list
    Switch | True | f, ff, force

    SoftClearBeforeList => Cdf will Write empty lines above the list, to hide the previous text
    Switch | True | c, sc, scbl, clear, softclear
.LINK
    Cda - A version of Cdf for Changing Directories
#>

function cdf {
    param(
        [Parameter( Mandatory = $false, ValueFromPipeline = $true )] [Alias( 'w', 'i', 'n', 'wba', 'index', 'number' )] [object] $WhichByAlphabet = $script:w6_SentinelValue_String,

        [Parameter( Mandatory = $false )] [Alias( 't' )] [object] $Times = $script:w6_List_Times_DefaultValue,

        [Parameter( Mandatory = $false )] [Alias( 'p', 'op', 'path' )] [string] $OperatingPath = ".$script:w6_PathSlash",

        [Parameter( Mandatory = $false )] [Alias( 'bl', 'blist', 'black', 'blacklist' )] [object] $AttributesBlackList = $script:w6_List_Attributes_BlackList_cdf,

        [Parameter( Mandatory = $false )] [Alias( 'pl', 'plist', 'priority', 'prioritylist' )] [object] $AttributesPriorityList = $script:w6_List_Attributes_PriorityList_cdf,

        [Alias( 'l', 'lf' )] [switch] $ListForce,

        [Alias( 'nl' )] [switch] $NoList,

        [Alias( 'wf', 'wsf', 'write' )] [switch] $WriteSelectedFiles = $script:w6_List_WriteSelectedFiles_DefaultValue_cdf,

        [Alias( 'f', 'ff', 'force' )] [switch] $ForceFiles = $script:w6_List_ForceFiles_DefaultValue,

        [Alias( 'c', 'sc', 'scbl', 'clear', 'softclear' )] [switch] $SoftClearBeforeList = $script:w6_List_BeforeDisplay_SoftClearConsole
    )

    Invoke-w6_CdaLikeFunction `
        -WhichByAlphabet:$WhichByAlphabet `
        -Times:$Times `
        -OperatingPath:$OperatingPath `
        -AttributesBlackList:$AttributesBlackList `
        -AttributesPriorityList:$AttributesPriorityList `
        -Stick:$false `
        -UseDirectories:$false `
        -ListForce:$ListForce `
        -NoList:$NoList `
        -WriteSelectedFiles:$WriteSelectedFiles `
        -ForceFiles:$ForceFiles `
        -SoftClearBeforeList:$SoftClearBeforeList

}
Set-w6_AliasBulk -Value 'cdf' -Aliases $script:w6_Aliases_cdf -Scope 'Script'


<#
.SYNOPSIS
    Display a formatted list of all current directory's files and change directory to the one you select
.DESCRIPTION
    *Cda is a command from the PowerShell-File-Walker Commands Bundle
    Tested for:  Windows 10, 11 PowerShell 5, 7 | Linux (Ubuntu) PowerShell 7

    'cda' => Display a numbered list of directories you can jump to
    'cda x' => Jump to the x'th directory
    'cda -Stick' => Enable stick mode - repeatedly display the directory list and ask to choose a directory

    PS C:\Users> cda
    ------------------------------------------------------>
        You're at: C:\Users

    Found Directories:
    [0] Parent Directory - C:\
    [1] All Users    >          -> SYSTEM, Hidden [1]
    [2] Default    >          -> ReadOnly, Hidden [2]
    [3] Default User    >       -> SYSTEM, Hidden [3]
    [4] Admin                                     [4]
    [5] Public    >                   -> ReadOnly [5]

        You're at: C:\Users
    <------------------------------------------------------
    PS C:\Users> cda 4
    PS C:\Users\Admin>


    Learn More
    =============================
    #1 Parameter Summary
    #2 Positional Parameters
    #3 Times - Usage
    #4 WhichByAlphabet - Special 0 Number
    #5 WhichByAlphabet - Negative Numbers
    #6 WhichByAlphabet - Arrays as Input
    #7 Times and WhichByAlphabet - Arrays as Input
    #8 Stick Mode
    #9 Config
    #10 Notes
    =============================


            #1 Parameter Summary
    Parameter Name => Description
    Supported Types | Usual Default Value | Aliases

    WhichByAlphabet => Where to go
    Number, Array, String | $script:w6_SentinelValue_String | w, i, n, wba, index, number

    Times => How Many Times to go there
    Number, Array, String | 1 | t

    OperatingPath => Cda will Operate from this path
    String | .\ or ./ | p, op, path

    AttributesBlackList => Cda will Hide these attributes from the list
    Array, String | Directory, NotContentIndexed, ReparsePoint, Normal, Archive | bl, blist, black, blacklist

    AttributesPriorityList => Cda will Make these attributes stand out
    Array, String | System | pl, plist, priority, prioritylist

    Stick => Cda will Repeatedly Display the list and Ask to choose a directory
    Switch | False | s

    ListForce => After all jumps - cda will Forcefully Display the list
    Switch | False | l, lf

    NoList => Passing invalid WhichByAlphabet won't trigger the list display
    Switch | False | nl

    WriteSelectedFiles => Cda will Write the selected files. Useful for debugging
    Switch | False | w, wsf, write

    ForceFiles => Cda will use -Force with the Get-ChildItem command when generating the files list
    Switch | True | f, ff, force

    SoftClearBeforeList => Cda will Write empty lines above the list, to hide the previous text
    Switch | True | c, sc, scbl, clear, softclear


            #2 Positional Parameters
    First two positional parameters are WhichByAlphabet and Times
    'cda -WhichByAlphabet 1 -Times 2'  equals  'cda 1 2'


            #3 Times - Usage
    WhichByAlphabet - where to jump | Times - how many Times to jump
    'cda 1 3'  equals  'cda 1; cda 1; cda 1'
    'cda 1 3'  equals  'jump to the 1'st directory 3 Times'


            #4 WhichByAlphabet - Special 0 Number
    'cda 0'  equals  'jump to the parent directory'
    C:\Users\Admin> cda 0
    C:\Users>

    C:\Users\Admin\Desktop\100MDollarOffers> cda 0 10
    C:\>


            #5 WhichByAlphabet - Negative Numbers
    When you pass a negative number as WhichByAlphabet - the item is selected from the end

    In this list:
    [1] Photos
    [2] Videos
    [3] Audio
    Negative numbers are here:
    [-3] Photos
    [-2] Videos
    [-1] Audio

    'cda -1' here will select the Audio directory


            #6 WhichByAlphabet - Arrays as Input
    PowerShell sees 0,2,3 as @(0,2,3) - both are correct
    'cda @(4,6)'  equals  'cda 4; cda 6'
    'cda 0,2,3'  equals  'cda 0; cda 2; cda 3'


            #7 Times and WhichByAlphabet - Arrays as Input
    When both WhichByAlphabet and Times are arrays - each WhichByAlphabet number lines up with a Times number from left to right
    'cda 1,2,3 4,5,6'  equals  'cda 1 4; cda 2 5; cda 3 6'

    Default values:
    Times: 1
    WhichByAlphabet: *deletes its Times partner*

    'cda 2 3,4'  equals  'cda 2 3'
    4 was deleted by the missing WhichByAlphabet

    'cda 5,6 7'  equals  'cda 5,6 7,1'
    Missing Times was replaced with 1


            #8 Stick Mode
    'cda -Stick' => enter stick mode
    Stick Mode will repeatedly display the list and ask to choose a directory
    Answer 'q' => exit stick mode

    'cda -s' => '-s' is an alias of '-Stick'

    C:\Users\Admin> cda -s
     *the list is displayed*
    Option: 0 10
     *Stick Mode runs 'cda 0 10'
     *the list is displayed*
    Option: 2
     *Stick Mode runs 'cda 2'
     *the list is displayed*
    Option: q
     *You Quit Stick Mode!*
    C:\Program Files>

    1'st found 1 or more recognized characters - WhichByAlphabet
    2'nd found 1 or more recognized characters - Times

    Each group of recognized characters is separated by one or more unrecognized characters
    This allows Stick Mode to differentiate between WhichByAlphabet and Times

    All recognized characters:
    - Special characters -> q, l, ...
    - Digits -> 0, 1, 2, ...
    - Commas -> ,
    - Most math characters -> * / + - ( ) .
    All other characters are unrecognized!
    Space is an Unrecognized character!

    Stick Mode allows you to define both WhichByAlphabet and Times
    Other parameters like -WriteSelectedFiles must be defined BEFORE entering a Stick session

    Stick Mode supports advanced WhichByAlphabet and Times input
    Negative numbers, special characters, math characters, and so on...

    Examples Template:
    'text' => Role => Description

    Option: 2,3 4,5
    '2,3' => WhichByAlphabet => 1'st found recognized characters
    ' ' => unrecognized characters => ends the 1'st found recognized characters group
    '4,5' => Times => 2'nd found recognized characters

    Option: hi 1,-1,b,1,5 hello 6,7
    'hi ' => unrecognized characters => ends nothing
    '1,-1,' => WhichByAlphabet => 1'st found recognized characters.  Note: the , comma at the end is ignored
    'b' => unrecognized character => ends 1'st found recognized characters group
    ',1,5' => Times => 2'nd found recognized characters. Note: the , comma at the beginning is ignored
    ' hello ' => unrecognized characters => ends 2'nd found recognized characters group
    '6,7' => Ignored => 3'rd found recognized characters


            #9 Config
    Cda is highly configurable. Configure cda by changing the constant variables within the script


            #10 Notes
    Files that contain / or \ slashes in their filenames may cause errors
    Cda has no aliases by default
.LINK
    Cdf - A version of Cda for Selecting Files
#>

function cda {
    param(
        [Parameter( Mandatory = $false, ValueFromPipeline = $true )] [Alias( 'w', 'i', 'n', 'wba', 'index', 'number' )] [object] $WhichByAlphabet = $script:w6_SentinelValue_String,

        [Parameter( Mandatory = $false )] [Alias( 't' )] [object] $Times = $script:w6_List_Times_DefaultValue,

        [Parameter( Mandatory = $false )] [Alias( 'p', 'op', 'path' )] [string] $OperatingPath = ".$script:w6_PathSlash",

        [Parameter( Mandatory = $false )] [Alias( 'bl', 'blist', 'black', 'blacklist' )] [object] $AttributesBlackList = $script:w6_List_Attributes_Blacklist_cda,

        [Parameter( Mandatory = $false )] [Alias( 'pl', 'plist', 'priority', 'prioritylist' )] [object] $AttributesPriorityList = $script:w6_List_Attributes_PriorityList_cda,

        [Alias( 's' )] [switch] $Stick,

        [Alias( 'l', 'lf' )] [switch] $ListForce,

        [Alias( 'nl' )] [switch] $NoList = $Stick,

        [Alias( 'wf', 'wsf', 'write' )] [switch] $WriteSelectedFiles = $script:w6_List_WriteSelectedFiles_DefaultValue_cda,

        [Alias( 'f', 'ff', 'force' )] [switch] $ForceFiles = $script:w6_List_ForceFiles_DefaultValue,

        [Alias( 'c', 'sc', 'scbl', 'clear', 'softclear' )] [switch] $SoftClearBeforeList = $script:w6_List_BeforeDisplay_SoftClearConsole
    )

    Invoke-w6_CdaLikeFunction `
        -WhichByAlphabet:$WhichByAlphabet `
        -Times:$Times `
        -OperatingPath:$OperatingPath `
        -AttributesBlackList:$AttributesBlackList `
        -AttributesPriorityList:$AttributesPriorityList `
        -Stick:$Stick `
        -UseDirectories `
        -ListForce:$ListForce `
        -NoList:$NoList `
        -WriteSelectedFiles:$WriteSelectedFiles `
        -ForceFiles:$ForceFiles `
        -SoftClearBeforeList:$SoftClearBeforeList

}
Set-w6_AliasBulk -Value 'cda' -Aliases $script:w6_Aliases_cda -Scope 'Script'


if ( $script:w6_IsWindows ) {

    # Old PowerShell Session
    # New Admin PowerShell Session

    <#
.SYNOPSIS
    Quickly open a New Admin PowerShell Session at your Current Directory
.DESCRIPTION
    WARNING, EXECUTING THIS COMMAND MAY ALLOW A SOPHISTICATED THREAT ACTOR TO GAIN ELEVATED PERMISSIONS (by modifying elev's code)
    EXERCISE CAUTION

    *Elev is a command from the PowerShell-File-Walker Commands Bundle
    Elev works only on Windows devices

    Elev means "Elevate", and refers to "Elevating (giving) Permissions"
    Elev opens a New PowerShell Session at your Current Directory that has Admin Permissions

    Elev can be used inside Admin and Non-Admin PowerShell Sessions

    The steps:
    1. You use Elev
    2. Elev takes a Snapshot of your Current Working Directory in your Current PowerShell Session
    3. Elev opens a New Admin PowerShell Session
    - Elev may ask you for admin permission if it cannot open a New Admin PowerShell Session
    4. Elev loads the PowerShell-File-Walker Commands Bundle to the New Admin PowerShell Session, because it heavily depends on it
    5. Elev starts taskbar flashing for the New Admin PowerShell Session
    6. Elev sets the Working Directory of the New Admin PowerShell Session to the directory from the Snapshot
    7. If everything went well - Elev will write a message in the Old PowerShell Session about its success

    Elev Aliases:  wudo (short for "Windows Sudo")
    Use  'Get-Help elev -Examples'  or  'Get-Help elev -Full'  for more information
.PARAMETER ExitCurrentSession
    Should Elev use the "Exit" command in the Current PowerShell Session after launching the New Admin PowerShell Session?
    ExitCurrentSession Aliases:  e  q  ex  qu  exit  quit

    If you cancel the Admin Permission Ask Prompt - the "Exit" command will NOT be used
.EXAMPLE
    PS C:\Users\Jacob> elev
    *Elev asks for admin permission* - *You allow it*
    *Elev opened a New Admin PowerShell Session with 'C:\Users\Jacob' as the working directory*
.EXAMPLE
    PS C:\Users\Jacob> elev -ExitCurrentSession
    *Elev asks for admin permission* - *You allow it*
    *Elev opened a New Admin PowerShell Session with 'C:\Users\Jacob' as the working directory*
    *Elev closed the Old PowerShell Session because everything went well*
.EXAMPLE
    PS C:\Users\Jacob> elev -ExitCurrentSession
    *Elev asks for Admin Permission* - *You cancel it*
    *Nothing is closed and nothing happens because Elev failed*
.NOTES
    Elevation method: Start-Process -RunAs. Please read the code for more info
.LINK
    Unelev - Open a New Non-Admin PowerShell Session at your current working directory
#> 

    function elev {
        param(
            [Alias( 'e', 'q', 'ex', 'qu', 'exit', 'quit' )] [switch] $ExitCurrentSession = $script:w6_Elev_Default_ExitCurrentSession
        )

        try {
            Write-Host 'Launching a New Admin PowerShell Session...'

            $currentAbsoluteLocation = ( Get-Location )

            Start-Process -FilePath $script:w6_PowerShellLaunchCommand -Verb RunAs -ArgumentList (
                '-NoExit',
                '-Command',
                "( . { if ( -not `$script:w6_AlreadyLoaded ) { . '$script:w6_Product_Path' } } );",
                "( . { if ( '$script:w6_Elev_NewConsoleTitle' -ne '$script:w6_ElevationCommands_UnsetTitle' ) { `$host.UI.RawUI.WindowTitle = '$script:w6_Elev_NewConsoleTitle' } } );",
                "( Set-w6_NearestAvailableLocationFromPath -AbsolutePath '$currentAbsoluteLocation' );", # todo Improvement Idea: save Get-w6_NearestAvailableLocationFromPath to a variable
                "( Set-w6_OperatingPathIfValid -Path ( Get-w6_NearestAvailableLocationFromPath -AbsolutePath '$currentAbsoluteLocation' ) -Silent:`$script:w6_SetOperatingPath_DefaultParameterValue_Silent_IfUsedBy_Script );",
                "( Start-w6_TaskbarFlashingForCurrentConsoleWindow -FlashTimes $script:w6_TaskbarFlashing_FlashTimes -OneFlashDurationMilliseconds $script:w6_TaskbarFlashing_OneFlashDurationMilliseconds );",
                '( Write-Host """You''ve Launched A New Admin PowerShell Session!""" )' -join ' ' )

            if ( $ExitCurrentSession ) {
                Write-Host 'Closing the Current PowerShell Session...'
                exit
            }
        }
        catch {
            $errorIntroduction = 'Something went wrong while opening a New Admin PowerShell Session'
            Write-w6_ShortErrorCatchMessage -Introduction $errorIntroduction -ErrorObject $_
        }
        # Improvement idea: Be more explicit with error catching here.

    }
    Set-w6_AliasBulk -Value 'elev' -Aliases $script:w6_Aliases_elev -Scope 'Script'


    <#
.SYNOPSIS
    Quickly open a New Non-Admin PowerShell Session at your Current Directory
.DESCRIPTION
    WARNING, EXECUTING THIS COMMAND MAY ALLOW A SOPHISTICATED THREAT ACTOR TO GAIN ELEVATED PERMISSIONS (by modifying unelev's code)
    EXERCISE CAUTION

    *Unelev is a command from the PowerShell-File-Walker Commands Bundle
    Unelev works only on Windows devices

    Unelev means "Unelevate", and refers to "Unelevating (revoking) Permissions"
    Unelev opens a New PowerShell Session at your Current Directory that has User (Non-Admin) Permissions

    Unelev can be used inside Admin and Non-Admin PowerShell Sessions

    The steps:
    1. You use Unelev
    2. Unelev takes a Snapshot of your Current Working Directory in your Current PowerShell Session
    3. Unelev opens a New Non-Admin PowerShell Session
    4. Unelev loads the PowerShell-File-Walker Commands Bundle to the New Non-Admin PowerShell Session, because it heavily depends on it
    5. Unelev starts taskbar flashing for the New Non-Admin PowerShell Session
    6. Unelev sets the Working Directory of the New Non-Admin PowerShell Session to the directory from the Snapshot
    7. If everything went well - Unelev will write a message in the Old PowerShell Session about its success

    Unelev Aliases:  nudo (short for "No Sudo")
    Use  'Get-Help unelev -Examples'  or  'Get-Help unelev -Full'  for more information
.PARAMETER ExitCurrentSession
    Should Unelev use the "Exit" command in the Current PowerShell Session after launching the New Non-Admin PowerShell Session?
    ExitCurrentSession Aliases:  e  q  ex  qu  exit  quit

    If Unelev fails - the "Exit" command will NOT be used
.EXAMPLE
    PS C:\Users\Jacob> unelev
    *Unelev opened a New Non-Admin PowerShell Session with 'C:\Users\Jacob' as the working directory*
.EXAMPLE
    PS C:\Users\Jacob> unelev -ExitCurrentSession
    *Unelev opened a New Non-Admin PowerShell Session with 'C:\Users\Jacob' as the working directory*
    *Unelev closed the Old PowerShell Session because everything went well*
.EXAMPLE
    PS C:\Users\Jacob> unelev -ExitCurrentSession
    *Unelev fails*
    *Nothing is closed and nothing happens because Unelev failed*
.NOTES
    Unelevation method: Windows Task Scheduler - Scheduling a one-time task to start PowerShell. Then immediately calling the scheduled task - then deleting that task. Please read the code for more info
.LINK
    Elev - Open an New Admin PowerShell Session at your current working directory
#> 

    function unelev {
        param(
            [Alias( 'e', 'q', 'ex', 'qu', 'exit', 'quit' )] [switch] $ExitCurrentSession = $script:w6_Unelev_Default_ExitCurrentSession
        )

        $currentAbsoluteLocation = ( Get-Location )

        try {
            Write-Host 'Launching a New Non-Admin PowerShell Session...'

            Unregister-w6_RemoveMeNamedTasks

            $taskAction = ( New-ScheduledTaskAction -Execute $script:w6_PowerShellLaunchCommand -Argument (
                    '-NoExit',
                    '-Command',
                    "( . { if ( -not `$script:w6_AlreadyLoaded ) { . '$script:w6_Product_Path' } } );",
                    "( . { if ( '$script:w6_Unelev_NewConsoleTitle' -ne '$script:w6_ElevationCommands_UnsetTitle' ) { `$host.UI.RawUI.WindowTitle = '$script:w6_Unelev_NewConsoleTitle' } } );",
                    "( Set-w7_NearestAvailableLocationFromPath -AbsolutePath '$currentAbsoluteLocation' );", # todo Improvement Idea: save Get-w7_NearestAvailableLocationFromPath to a variable
                    "( Set-w6_OperatingPathIfValid -Path ( Get-w6_NearestAvailableLocationFromPath -AbsolutePath '$currentAbsoluteLocation' ) -Silent:`$script:w6_SetOperatingPath_DefaultParameterValue_Silent_IfUsedBy_Script );",
                    "( Start-w6_TaskbarFlashingForCurrentConsoleWindow -FlashTimes $script:w6_TaskbarFlashing_FlashTimes -OneFlashDurationMilliseconds $script:w6_TaskbarFlashing_OneFlashDurationMilliseconds );",
                    '( Write-Host """You''ve Launched a Non-Admin PowerShell Prompt!""" )' `
                        -join ' ' )
            )
            $taskTrigger = ( New-ScheduledTaskTrigger -Once -At ( $script:w6_UnixEpochDate ) )
            $taskName = ( Get-w6_UnelevScheduledTaskName )
            $taskSettings = ( New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries )

            Register-ScheduledTask -Action $taskAction -Trigger $taskTrigger -TaskName $taskName -Settings $taskSettings -Force | `
                    Start-ScheduledTask

            Unregister-w6_RemoveMeNamedTasks

            if ( $ExitCurrentSession ) {
                Write-Host 'Closing the Current PowerShell Session...'
                exit
            }

        }
        catch {
            $errorIntroduction = 'Something went wrong while opening a New Non-Admin PowerShell Session'
            Write-w6_ShortErrorCatchMessage -Introduction $errorIntroduction -ErrorObject $_
        }
        # Improvement idea: Be more explicit with error catching here.

    }
    Set-w6_AliasBulk -Value 'unelev' -Aliases $script:w6_Aliases_unelev -Scope 'Script'
}


# --------------------------- INTRODUCTION AND SETUP --------------------------

if ( $script:w6_Introduction_Toggle ) {
    Write-FileWalkerIntroduction -IsAutomatic
}

# UPDATE 2025 - LOADING USER CONFIGURATION HAS BEEN DEPRECATED
# foreach ( $errorCatchMessage in $script:w6_Config_Error_CathMessages ) {
#     Write-Host $errorCatchMessage
# }

if ( $script:w6_Write_Approximate_Loading_Time ) {
    Write-w6_ApproximateTimeSinceScriptStart
}
