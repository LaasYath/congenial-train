# Install the necessary module
Install-Module -Name SecurityPolicyDsc -Force -SkipPublisherCheck

# Import the module
Import-Module -Name SecurityPolicyDsc

# Get the current security policies
$currentPolicies = Get-DSCConfiguration -CimSession localhost

# Path to the baseline policies JSON file
$baselineFilePath = "C:\Path\To\MicrosoftSecurityBaseline.json"

# Read the baseline policies
$baselinePolicies = Get-Content -Path $baselineFilePath | ConvertFrom-Json

# Compare current policies against baseline
foreach ($policy in $baselinePolicies) {
    $currentPolicy = $currentPolicies | Where-Object { $_.Setting -eq $policy.Setting }
    if ($currentPolicy) {
        $match = Compare-Object $currentPolicy.Value $policy.Value
        if ($match) {
            Write-Output "Mismatch found in policy: $($policy.Setting)"
            Write-Output "Current Value: $($currentPolicy.Value)"
            Write-Output "Baseline Value: $($policy.Value)"
        }
    }
    else {
        Write-Output "Policy not found: $($policy.Setting)"
    }
}

Write-Output "Security policy comparison completed."
