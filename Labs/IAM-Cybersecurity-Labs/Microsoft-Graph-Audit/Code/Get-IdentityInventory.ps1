# Microsoft Entra ID Identity Inventory
# Project: THL IAM Audit
# Requires an authenticated Microsoft Graph session

$users = @(Get-MgUser -All -Property DisplayName,UserPrincipalName,AccountEnabled,UserType,CreatedDateTime)

# Display user inventory
$users |
    Select-Object DisplayName,UserPrincipalName,AccountEnabled,UserType,CreatedDateTime |
    Format-Table -AutoSize

# Analyze account status
$enabled = @($users | Where-Object { $_.AccountEnabled -eq $true })
$disabled = @($users | Where-Object { $_.AccountEnabled -eq $false })

Write-Host "Total accounts: $($users.Count)"
Write-Host "Enabled accounts: $($enabled.Count)"
Write-Host "Disabled accounts: $($disabled.Count)"

# Display disabled identities
$disabled |
    Select-Object DisplayName,AccountEnabled |
    Format-Table -AutoSize



