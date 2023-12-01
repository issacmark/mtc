function Invoke-BLEvaluation {
    param (
        [String][Parameter(Mandatory=$true, Position=1)] $ComputerName,
        [String][Parameter(Mandatory=$False, Position=2)] $BLName
    )
    $Session = New-CimSession -ComputerName $ComputerName
    If ($BLName -eq $Null) {
        $Baselines = Invoke-CMWmiMethod -Namespace root\\ccm\\dcm -ClassName SMS_DesiredConfiguration -MethodName GetInstances
    } Else {
        $Baselines = Invoke-CMWmiMethod -Namespace root\\ccm\\dcm -ClassName SMS_DesiredConfiguration -MethodName GetInstances | Where-Object {$_.DisplayName -like $BLName}
    }
    $Baselines | ForEach-Object {
        $Arguments = @{
            'Name' = $_.Name
            'Version' = $_.Version
        }
        Invoke-CMWmiMethod -Namespace root\\ccm\\dcm -ClassName SMS_DesiredConfiguration -MethodName TriggerEvaluation -Arguments $Arguments
    }
    Remove-CimSession -CimSession $Session
}

# Call the function for a specific computer and baseline
Invoke-BLEvaluation -ComputerName "YourComputerName" -BLName "YourBaselineName"