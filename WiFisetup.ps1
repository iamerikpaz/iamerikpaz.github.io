# Variables
$certUrlRoot = "https://iamerikpaz.github.io/IdenTrust_Commercial_Root_CA_1.pem"
$certUrlUser = "https://iamerikpaz.github.io/client.p12"
$wlanProfileUrl = "https://iamerikpaz.github.io/WLANProfileMSFMEXICOOficina.xml"
$localCertRoot = "$env:temp\IdenTrust_Commercial_Root_CA_1.pem"
$localCertUser = "$env:temp\client.p12"
$localWlanProfile = "$env:temp\WLANProfileMSFMEXICOOficina.xml"
$certPassword = "Ps4?d"

# Download Files
Invoke-WebRequest -Uri $certUrlRoot -OutFile $localCertRoot
Invoke-WebRequest -Uri $certUrlUser -OutFile $localCertUser
Invoke-WebRequest -Uri $wlanProfileUrl -OutFile $localWlanProfile

# Install Root Certificate
Import-Certificate -FilePath $localCertRoot -CertStoreLocation Cert:\LocalMachine\Root

# Install User Certificate
$securePassword = ConvertTo-SecureString -String $certPassword -AsPlainText -Force
Import-PfxCertificate -FilePath $localCertUser -CertStoreLocation Cert:\LocalMachine\Root -Password $certPassword
$securePassword

# Add WLAN Profile
netsh wlan add profile filename=$localWlanProfile

# Clean Up
Remove-Item $localCertRoot, $localCertUser, $localWlanProfile -Force
