# Variables
$certUrlRoot = "https://iamerikpaz.github.io/IdenTrust_Commercial_Root_CA_1.pem"
$certUrlUser = "https://iamerikpaz.github.io/client.p12"
$certUrlIntermediate = "https://iamerikpaz.github.io/intermediate.crt"
$wlanProfileUrl = "https://iamerikpaz.github.io/WLANProfileMSFMEXICOOficina.xml"
$localCertRoot = "$env:temp\IdenTrust_Commercial_Root_CA_1.pem"
$localCertUser = "$env:temp\client.p12"
$localCertIntermediate = "$env:temp\intermediate.crt"
$localWlanProfile = "$env:temp\WLANProfileMSFMEXICOOficina.xml"
$certPassword = "Ps4?d"

# Download Files
Invoke-WebRequest -Uri $certUrlRoot -OutFile $localCertRoot
Invoke-WebRequest -Uri $certUrlUser -OutFile $localCertUser
Invoke-WebRequest -Uri $certUrlIntermediate -OutFile $localCertIntermediate
Invoke-WebRequest -Uri $wlanProfileUrl -OutFile $localWlanProfile

# Install Root Certificate
Import-Certificate -FilePath $localCertRoot -CertStoreLocation Cert:\LocalMachine\Root
Import-Certificate -FilePath $localCertIntermediate -CertStoreLocation Cert:\LocalMachine\Root

# Install User Certificate
$securePassword = ConvertTo-SecureString -String $certPassword -AsPlainText -Force
Import-PfxCertificate -FilePath $localCertUser -CertStoreLocation Cert:\LocalMachine\My -Password $securePassword -Verbose

# Add WLAN Profile
netsh wlan add profile filename=$localWlanProfile

# Clean Up
Remove-Item $localCertRoot, $localCertUser, $localWlanProfile -Force
