
$VerbosePreference = "Continue"
$InformationPreference = "Continue"
$DefaultWhichByAlphabet = 'None'
$CdaStickFirstBadInput = $true
$SpacesBeforeCounterIfOneDigit = 3

$CurrentProcessExecutionPolicy = Get-ExecutionPolicy -Scope Process

Set-ExecutionPolicy Unrestricted -Scope Process

$RawUIWindowSize = $host.UI.RawUI.WindowSize
$StartingWindowHeight = [Math]::Floor($RawUIWindowSize.Height + 0.5)
$StartingWindowWidth = [Math]::Floor($RawUIWindowSize.Width + 0.5)
$StartingWindowWidthOneThird = [Math]::Floor($StartingWindowWidth / 3 + 0.5)


function uGetFileAttributesString
{
    param(
        [Parameter(Mandatory = $true)] $Path
    )

    if (-not$Path)
    {
        return
    }

    $file = Get-Item $Path
    $fileAttributes = $file.Attributes
    $fileAttributeStrings = @()

    if (($fileAttributes -band [System.IO.FileAttributes]::Hidden) -ne 0) # Checks if the file is Hidden.
    {
        $fileAttributes += '(Hidden)'
    }

    return $fileAttributeStrings -join ''
}


function uGet-AllChildDirNames
{
    param(
        [Parameter(Mandatory = $false)] [String] $Path = '.\',
        [Switch] $GetCountInstead
    )

    $allChildDirNames = Get-ChildItem -Path $Path -Name -Directory # tODO: -Hidden

    if ($GetCountInstead)
    {
        return ($allChildDirNames).Length
    }

    return $allChildDirNames
}


function uGet-AllChildItemNames
{
    param(
        [Parameter(Mandatory = $false)] $Path = '.\',
        [Switch] $GetCountInstead
    )

    $allChildItemNames = Get-ChildItem -Path $Path -Force -Name

    if ($GetCountInstead)
    {
        return $allChildItemNames.Length
    }

    return $allChildItemNames
}


function uGet-Spaces
{
    param(
        [Parameter(Mandatory = $true)] [Object] $counter
    )

    return (' ' * [Math]::Min(($zeroDigitSpaces - "$counter".Length), $StartingWindowWidthOneThird))
}


function uWrite-NumerizedList
{

    param (
        [Parameter(Mandatory = $false)] [Array] $FilesListToNumerize = $false,
        [Parameter(Mandatory = $false)] [String] $PathOfFiles = '.\',
        [Switch] $AddZero = $false,
        [Switch] $AddMinusOne = $false
    )


    function uGet-NumerizedItemsList
    {
        $counter = 1

        return $FilesListToNumerize | ForEach-Object -Process {

            $attributesString = uGetFileAttributesString -Path "$_"

            "$( uGet-Spaces $counter )[$counter] $_ $( uGetFileAttributesString -Path $PathOfFiles ))"

            $counter++
        }

    }


    function uWrite-NumerizedItemsList
    {

        if ($AddMinusOne)
        {
            Write-Information "$( uGet-Spaces -1 )[-1] Exit Stick Mode."
        }

        if ($AddZero)
        {
            Write-Information ("$( uGet-Spaces 0 )[0] Go Back One Level - back to '", $PathOfFiles, "'." -join '')
        }

        Write-Information((uGet-NumerizedItemsList) -join "`n")
    }


    if ($help)
    {
        uWrite-Help
        return
    }


    elseif ($listToNumerize -ne $false)
    {
        uWrite-NumerizedItemsList
        return
    }


    uWrite-NumerizedItemsList

}


function cda
{
    $currentDirDirs = uGet-AllChildDirNames

    function uWrite-Directories
    {
        param(
            [Parameter(Mandatory = $false)] [Bool] $AddMinusOne = $false
        )

        Write-Information ""
        Write-Information "-------------------------------------------------------------------------------------->"
        Write-Information "Found Dirs:"
        Write-Information ""
        uWrite-NumerizedList -FilesListToNumerize $currentDirDirs -Path $Path -AddZero -AddMinusOne:$AddMinusOne
        Write-Information "<--------------------------------------------------------------------------------------"
        Write-Information ""
    }


    function uChange-Directory
    {
        param(
            [Parameter(Mandatory = $false)] [Object] $NewWhichByAlphabet
        )

        if ($WhichByAlphabet -lt 0 -or $WhichByAlphabet -gt (uGet-AllChildDirNames -GetCountInstead))
        {
            return
        }

        if ($WhichByAlphabet -eq 0)
        {
            Set-Location '.\..'
            return
        }

        Set-Location $currentDirDirs[$WhichByAlphabet - 1]
    }


    function uDo-uStickBadInputAction
    {

        if ($CdaStickFirstBadInput)

        {
            Write-Output "---------------------------------------------------->"
            Write-Output "Bad Input! Repeating in 2 seconds..."
            Write-Output "<----------------------------------------------------"

            Start-Sleep -Seconds 2
            return
        }

        Write-Output "---------------------------------------------------->"
        Write-Output "Bad Input! Repeating..."
        Write-Output "<----------------------------------------------------"
    }


    function uDo-OneStickRepetition
    {
        $letAnswerPass = $false

        while (-not$letAnswerPass)
        {
            try
            {
                uWrite-Directories
                $listLength = uGet-AllChildDirNames -GetCountInstead
                $userOption = Read-Host "Option"

                if ($userOption -gt $listLength -and $userOption -lt -1)
                {
                    uDo-uStickBadInputAction
                    continue
                }

                if ($userOption -eq -1)
                {
                    return $true
                }

                uChange-Directory $userOption
                $letAnswerPass = $true
            }
            catch
            {
                uDo-uStickBadInputAction
            }
        }
    }


    function uDo-StickFunction
    {
        $repeatStickFunction = $true

        while ($repeatStickFunction)
        {
            $repeatStickFunction = uDo-OneStickRepetition
        }
    }


    if ($help)
    {
        uWrite-Help
        return
    }

    if ($stick)
    {
        uDo-StickFunction
        return
    }


    if ($WhichByAlphabet -eq $DefaultWhichByAlphabet)
    {
        uWrite-Directories
        return
    }


    if ($WhichByAlphabet -ne $DefaultWhichByAlphabet)
    {
        uChange-Directory
        return
    }

}


function cdf
{
    param (
        [Parameter(Mandatory = $false)] [Object] $WhichByAlphabet = $DefaultWhichByAlphabet,
        [Parameter(Mandatory = $false)] [String] $Path = '.\',
        [Switch] $help
    )


    $currentDirFiles = uGet-AllChildItemNames


    function uWrite-Help
    {
        Write-Information ""
        Write-Information "-------------------------------------------------------------------------------------->"
        Write-Information "cdf - Command Help: "
        Write-Information ""
        Write-Information "Description: "
        Write-Information "  'cdf' in an abbreviation for 'Current Directory File'"
        Write-Information "  This function is an alternative to writing the filenames manually."
        Write-Information "  It allows the user to select files from a directory simply by writing which the file is in the displayed list."
        Write-Information "  IMPORTANT: The returned string is just the name of the selected file."
        Write-Information("  IMPORTANT: The selected file is also saved as '", '$f', "' so it can be used more easily." -join "")
        Write-Information ""
        Write-Information "Usage:"
        Write-Information "  + cda -> Get list of all directories in Your current working directory numbered and sorted alphabetically. (Use this function to check where You can Go)"
        Write-Information "  + cda [somenumber] -> Use this to go to a directory"
        Write-Information "  + cda 0 -> A special number -> This is the same as doing 'cd .\..` - Going back one directory level"
        Write-Information "  + cda -Path -> Use a custom path with cda"
        Write-Information "<--------------------------------------------------------------------------------------"
        Write-Information ""
    }


    function uWrite-FilesInDirectory
    {
        $myZeroString = "Your Current Directory - '$( Get-Location )'"

        Write-Information ""
        Write-Information "-------------------------------------------------------------------------------------->"
        Write-Information "Found Files:"
        Write-Information ""
        uWrite-NumerizedList -FilesListToNumerize $currentDirFiles -ZeroString $myZeroString
        Write-Information "<--------------------------------------------------------------------------------------"
        Write-Information ""
    }


    function uReturnFileFromList
    {
        Set-Variable -Name 'f' -Value $currentDirFiles[$WhichByAlphabet - 1] -Scope "Global"
        return $f
    }


    if ($help)
    {
        uWrite-Help
        return
    }


    if ($WhichByAlphabet -eq $DefaultWhichByAlphabet)
    {
        uWrite-FilesInDirectory
        return
    }


    if ($WhichByAlphabet -ne $DefaultWhichByAlphabet)
    {
        return uReturnFileFromList
    }
}


function apro
{
    . $PROFILE
}


function uWrite-ProfileDescription
{
    Write-Information ""
    Write-Information "Profile (at $PROFILE) Applied Successfully!"
    Write-Information ""
    Write-Information "-------------------------------------------------------------------------------------->"
    Write-Information "Current Features:"
    Write-Information ""
    Write-Information "  'cda' (Change Directory Alphabetically) -> Changing Directory but without having to write filenames (upgraded 'cd')"
    Write-Information "      Usage:"
    Write-Information "          -> 'cda' -> Displays a list of directories that You can jump to"
    Write-Information "          -> 'cda [directory_number_from_list]' -> jump to a directory"
    Write-Information "          -> 'cdf -Path [your_path] -> use 'cda' but from a path that's not the current working directory."
    Write-Information "          -> 'cda -help' -> more information"
    Write-Information ""
    Write-Information "  'cdf' (Current Directory File) -> Selecting a file from the current Directory. "
    Write-Information "      Usage:"
    Write-Information "          -> '[]' -> []"
    Write-Information "          -> '[]' -> []"
    Write-Information "          -> 'cdf -Path [your_path] -> use 'cdf' but from a path that's not the current working directory."
    Write-Information "          -> 'cdf -help' -> more information"
    Write-Information("      IMPORTANT NOTE: The selected file is also saved as '", '$f', "'." -join "")
    Write-Information ""
    Write-Information("  'apro' (Apply Profile) - A shorter form for writing '", '. $PROFILE', "'" -join "")
    Write-Information "<--------------------------------------------------------------------------------------"
    Write-Information ""
    Write-Information ""
    Write-Information ""
    Write-Information ""
    Write-Information 'Scroll up for information about the applied $PROFILE...'
}


function uWrite-ProfileIntroduction
{
    Clear-Host
    uWrite-ProfileDescription

    $necessaryBlankLines = $StartingWindowHeight - 5
    for ($i = 1; $i -le $necessaryBlankLines; $i++) {
        Write-Information ""
    }
}


uWrite-ProfileIntroduction
