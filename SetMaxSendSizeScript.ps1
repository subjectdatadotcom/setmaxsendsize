<#
.SYNOPSIS
This script processes user information from a CSV file and sets the maximum send size for each user’s mailbox to 0 KB.

.DESCRIPTION
The script ensures that the Exchange Online Management module is installed and imported. It reads a list of users from a CSV file, connects to Exchange Online, and updates the maximum send size for each user's mailbox. After updating, it retrieves and displays the new maximum send size for each user, providing feedback on the operation.

.NOTES
The script requires an account with Exchange Online Administrator permissions for authentication and access to user mailboxes.

.AUTHOR
SubjectData

.EXAMPLE
.\SetMaxSendSizeScript.ps1
This will run the script in the current directory, processing the '0sendsizeusers.csv' file and setting the maximum send size for the corresponding users' mailboxes to 0 KB.
#>

# Module names
$ExchangeOnlineModule = "ExchangeOnlineManagement"

# Check if the module is already installed
if (-not(Get-Module -Name $ExchangeOnlineModule)) {
    # Install the module
    Install-Module -Name $ExchangeOnlineModule -Force
}

Import-Module $ExchangeOnlineModule -Force


$myDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$XLloc = "$myDir\"

# Authenticate to Exchange Online
try {
    Connect-ExchangeOnline -ErrorAction Stop
    Write-Host "Connected to Exchange Online successfully." -ForegroundColor Green
}
catch {
    Write-Host "Failed to connect to Exchange Online: $_" -ForegroundColor Red
    exit 1
}


try {
    $OneDriveUsers = import-csv ($XLloc + "0sendsizeusers.csv").ToString()
} catch {
    Write-Host "No CSV file to read" -BackgroundColor Black -ForegroundColor Red
    exit
}

foreach ($User in $OneDriveUsers) {
    try {
        # Check if the email field is not empty
        if ($User.Email.ToString() -ne "") {
        $outnull = Set-Mailbox $User.Email.ToString() -MaxSendSize 0KB

        $newMaxSendSize = Get-Mailbox $User.Email.ToString() | select MaxSendSize
        Write-Host "New MaxSendSize for $($User.Email): $($newMaxSendSize.MaxSendSize.Substring(0,2))"

               }
    } catch {
        # Handle any exceptions that occur during processing
        Write-Host "Exception occurred for" $User.Email.ToString() -BackgroundColor Black -ForegroundColor Red
        Continue
    }
}


# Disconnect from Exchange Online
try {
    Disconnect-ExchangeOnline -Confirm:$false
    Write-Host "Disconnected from Exchange Online." -ForegroundColor Green
}
catch {
    Write-Host "Error disconnecting from Exchange Online: $_" -ForegroundColor Red
}

