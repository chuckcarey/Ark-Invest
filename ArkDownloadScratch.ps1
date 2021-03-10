function Get-DateTimeGroup {
    Get-Date -Format yyyyddMM_HHmmss
}

function Get-DateGroup {
    Get-Date -Format yyyyddMM
}

function Get-CreateNewDir {

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $True)]
        [String] $DirectoryToCreate)

    # Check to see if the directory exists
    if (-not (Test-Path -LiteralPath $DirectoryToCreate)) {
    
        try {
            New-Item -Path $DirectoryToCreate -ItemType Directory -ErrorAction Stop | Out-Null #-Force
        }
        catch {
            Write-Error -Message "Unable to create directory '$DirectoryToCreate'. Error was: $_" -ErrorAction Stop
        }
        Write-Verbose "Successfully created directory '$DirectoryToCreate'."

    }
    else {
        Write-Verbose "Directory already exists"
    }
}

# Source file location
$source1 = 'https://ark-funds.com/wp-content/fundsiteliterature/csv/ARK_INNOVATION_ETF_ARKK_HOLDINGS.csv'
$source2 = 'https://ark-funds.com/wp-content/fundsiteliterature/csv/ARK_AUTONOMOUS_TECHNOLOGY_&_ROBOTICS_ETF_ARKQ_HOLDINGS.csv'
$source3 = 'https://ark-funds.com/wp-content/fundsiteliterature/csv/ARK_NEXT_GENERATION_INTERNET_ETF_ARKW_HOLDINGS.csv'
$source4 = 'https://ark-funds.com/wp-content/fundsiteliterature/csv/ARK_GENOMIC_REVOLUTION_MULTISECTOR_ETF_ARKG_HOLDINGS.csv'
$source5 = 'https://ark-funds.com/wp-content/fundsiteliterature/csv/ARK_FINTECH_INNOVATION_ETF_ARKF_HOLDINGS.csv'
$source6 = 'https://ark-funds.com/wp-content/fundsiteliterature/csv/THE_3D_PRINTING_ETF_PRNT_HOLDINGS.csv'
$source7 = 'https://ark-funds.com/wp-content/fundsiteliterature/csv/ARK_ISRAEL_INNOVATIVE_TECHNOLOGY_ETF_IZRL_HOLDINGS.csv'



# Create the new directory to save the files
$DateGroup = Get-DateGroup
$root = 'C:\Users\ccarey01\Desktop\ARK_Invest\csv\' + $DateGroup + '\'
Get-CreateNewDir -DirectoryToCreate $root

# Destination to save the file
$theDTG = Get-DateTimeGroup
$destination = $root + $theDTG +'_ARK_INNOVATION_ETF_ARKK_HOLDINGS.csv'


#Download the file
try {
    $browser = New-Object System.Net.WebClient
    $browser.Proxy.Credentials =[System.Net.CredentialCache]::DefaultNetworkCredentials 
    Invoke-WebRequest -Uri $source1 -OutFile $destination
    }
    catch {
        Write-Error -Message "`n `nUnable to download file to directory: '$destination'.`n `nError was: $_ `n `n" -ErrorAction Stop
    }
"Successfully downloaded file: '$source1' "
"Saved file: '$destination' "


