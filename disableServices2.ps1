# Scripts stops insecure services. Put hashtag infront of eseential service names to 'comment' them out and ensure they remain enabled
# Commenting something out tells the computer to ignore the name of that service and jsut keep going

$Services = @(
    "FTPSVC"                                   # Microsoft FTP Service
    "lfsvc"                                    # Geolocation Service
    "MapsBroker"                               # Maps Manager
    "NetTcpPortSharing"                        # Net.Tcp Port Sharing Service
    "RemoteAccess"                             # Routing and Remote Access
    "RemoteRegistry"                           # Remote Registry
    "RDSessMgr"                                # Remote Assistance
    "SNMPTRAP"                                 # Simple Network Management Protocol
    "TapiSrv"                                  # Telephony
    "TlntSvr"                                  # Telnet
    "XboxGipSvc"                               # Manages connected Xbox Accessories
    "XblAuthManager"                           # Xbox Live Auth Manager
    "XblGameSave"                              # Xbox Live Game Save Service
    "XboxNetApiSvc"                            # Xbox Live Networking Service
)

foreach ($ServiceName in $Services) {
    if (Get-Service -Name $ServiceName -ErrorAction SilentlyContinue) {
        Write-Output "Stopping and disabling $ServiceName..."
        Stop-Service -Name $ServiceName -Force
        Set-Service -Name $ServiceName -StartupType Disabled
    } else {
        Write-Output "Service $ServiceName not found."
    }
}
