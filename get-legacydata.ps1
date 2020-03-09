# Copyright (c) 2020 SEPPmail AG
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#region pwd
$user = 'soneamdin@domain.at'
$pwd = 'yourpassword'
$cred = New-object pscredential -ArgumentList ($user,(Convertto-Securestring $pwd -asplaintext -force))
#endregion

$urlroot = 'https://mail.domain.at:8443/v1/legacy.app/'

# Encryption Info
# Liefert alle möglichen Verschlüsselungsmethoden für S/MIME personal/domain, PGP personal/domain, GINA personal, HIN domain und TLS domain

$uri = $urlroot + 'encinfo'
$encinfodata = Invoke-RestMethod -Uri $uri -Method GET -Authentication Basic -Credential $cred -OutVariable 'encinfo' #-outvariable 'encinfodata'

#Liefert alle möglichen Verschlüsselungsmethoden für S/MIME personal/domain
$uri = $urlroot + 'encinfo/smime'
Invoke-RestMethod -Uri $uri -Method GET -Authentication Basic -Credential $cred 

# Liefert alle möglichen Verschlüsselungsmethoden für S/MIME domain
$uri = $urlroot + 'encinfo/smime/domain'
Invoke-RestMethod -Uri $uri -Method GET -Authentication Basic -Credential $cred 

#Willst du die Abfrage auf z.B. eine Empfängeradresse limitieren so kannst du das Argument mailAddress nutzen
$mailaddr = 'info@seppmail.com'
$uri = $urlroot + 'encinfo/smime/domain' + '?mailAddress=' + $mailaddr 
Invoke-RestMethod -Uri $uri -Method GET -Authentication Basic -Credential $cred 

# Stats
# Alle Tagesstatistiken (Default User) als JSON
$uri = $urlroot + 'statistics?returnType=JSON'
$userstats = Invoke-RestMethod -Uri $uri -Method GET -Authentication Basic -Credential $cred

# Alle Tagesstatistiken (Default User) als CSV
$uri = $urlroot + 'statistics'
$userstats = Invoke-RestMethod -Uri $uri -Method GET -Authentication Basic -Credential $cred

# Domain Tagesstatistiken
$uri = $urlroot + 'statistics/domain?returnType=JSON'
Invoke-RestMethod -Uri $uri -Method GET -Authentication Basic -Credential $cred -OutVariable 'domainstat'
$domainstat|ConvertFrom-Csv -Delimiter ';'
