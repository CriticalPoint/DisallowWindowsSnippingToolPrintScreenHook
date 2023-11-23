#############################################################
#                                                           #
#      DisallowWindowsSnippingToolPrintScreenHook.ps1       #
#                                                           #
#       Disables the use of the Snipping Tool via REG       #
#                                                           #
#     Releases the PrntScrn hook, and gives back control    #
#                                                           #
#            https://github.com/CriticalPoint               #
#                                                           #
#############################################################

# Disable the Snipping Tool for the current user
New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\TabletPC" -Name "DisableSnippingTool" -Value "1"
New-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\TabletPC" -Name "DisableSnippingTool" -Value "1"

# Add the System.Windows.Forms assembly reference
Add-Type -AssemblyName System.Windows.Forms

# Check if the registry keys have been applied
$hkCUvalue = Get-ItemPropertyValue -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\TabletPC" -Name "DisableSnippingTool"
$hkLMvalue = Get-ItemPropertyValue -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\TabletPC" -Name "DisableSnippingTool"

# Construct the message content
$message = ""
$message += "PrintScreen Release Status"
$message += "`n-------------------"
$message += "`nHKCU - Print Screen keyboard hook release: "
$message += if ($hkCUvalue -eq 1) { "SUCCESS" } else { "FAILED" }
$message += "`nHKLM - Print Screen keyboard hook release: "
$message += if ($hkLMvalue -eq 1) { "SUCCESS" } else { "FAILED" }

# Center the text in the modal box
[System.Windows.Forms.MessageBox]::Show($message, "PrintScreen Release Status", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
