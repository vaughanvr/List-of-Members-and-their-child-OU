# Copyright 2020  (Vaughan) VV
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation,  version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# It Creates a list of members and their mailbox sizes in temp folder 
# this can only be run in powershell for exchange on premise
# To run at the prompt type ./GetEnabledMembersandOU.ps1 and hit enter.







PROCESS

{

Import-Module ActiveDirectory 



$list = Get-ADUser -filter 'enabled -eq $true'  -SearchBase "OU=OU1,OU=OU2,DC=DC1,DC=DC2" -Properties displayname | sort -unique

 
 



$list | foreach {Get-ADUser -Identity $_.distinguishedname -Properties givenname , surname, samaccountname, enabled } | select givenname , surname, samaccountname, enabled , @{n='OU';e={ ( ($_.distinguishedName -Split  "," )[($_.distinguishedName -Split  "," ).length -5].Replace("OU=", "") )  }} | Export-Csv -path "c:/temp/AllEnabledUsersandOU.csv" -Encoding UTF8

		 
}
