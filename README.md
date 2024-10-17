# Exchange Online Max Send Size Script

This PowerShell script processes user information from a CSV file and sets the maximum send size for each user's mailbox to 0 KB.

## Prerequisites

1. **PowerShell**: Ensure you have PowerShell installed.
2. **Exchange Online Management Module**: This script uses the `ExchangeOnlineManagement` module. The script will automatically install it if it's not already installed.
3. **Exchange Online Administrator Permissions**: You need an account with Exchange Online Administrator permissions to authenticate and access user mailboxes.

## Instructions

1. **Edit the Script**:
   - Open the script file.
   - Ensure the CSV file path is correctly set in the script:
     ```powershell
     $XLloc = "C:\Users\rajab\Downloads\Trader.ca\Simcoe\Quest\OneDrive\OneDriveReadOnly\"
     ```
   - Modify the path if necessary to point to the location of your `0sendsizeusers.csv` file.

2. **Prepare the CSV File**:
   - Ensure you have a `0sendsizeusers.csv` file in the specified directory.
   - The CSV file should have the following structure:
     ```
     Email
     user1@example.com
     user2@example.com
     ```

3. **Run the Script**:
   - Open PowerShell as an administrator.
   - Navigate to the directory containing the script.
   - Run the script:
     ```powershell
     .\SetMaxSendSizeScript.ps1
     ```
   - Authenticate using your Exchange Online Administrator account when prompted.
   - The script will connect to Exchange Online, process the users, and set the maximum send size for their mailboxes to 0 KB.

4. **Check the Output**:
   - The new maximum send sizes for each user will be displayed in the PowerShell console.

## Troubleshooting

- **No CSV file to read**: Ensure the `0sendsizeusers.csv` file is present and correctly formatted.
- **Permission Issues**: Ensure you have the necessary permissions to connect to Exchange Online and modify the mailbox settings.
- **Module Installation**: If the script fails to install the module, try manually installing it:
  ```powershell
  Install-Module -Name ExchangeOnlineManagement -Force

  Additional Notes
This script is designed to be run in an environment with access to Exchange Online and requires the Exchange Online Management module.
Be cautious when setting the maximum send size to 0 KB, as this will prevent users from sending any emails.
