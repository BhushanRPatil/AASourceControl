$dev = $false

if ($dev) {
    $uri = 'https://mswsautomation.blob.core.windows.net/dev/students.zip?sp=r&st=2020-07-28T04:29:30Z&se=2021-07-28T12:29:30Z&spr=https&sv=2019-12-12&sr=b&sig=TDtETJ56me52fuk7tJI38nToCTAwvNoaphpZX0vFd%2Fo%3D'
}
else {
    $uri = 'https://mswsautomation.blob.core.windows.net/master/students.zip?sp=r&st=2020-07-28T04:28:23Z&se=2021-07-01T12:28:23Z&spr=https&sv=2019-12-12&sr=b&sig=cq9cToD8pum9gea0JSQvxEHOAegEFPcgfGHQ3oEuVdA%3D'
}

if (!(Test-Path C:\Temp)) {
    New-Item C:\Temp -ItemType 'Directory' -Force
}

Invoke-WebRequest -Uri $uri -UseBasicParsing -OutFile C:\Temp\students.zip

Expand-Archive -Path C:\Temp\students.zip -DestinationPath C:\Temp\Students -Verbose

$sources = "C:\Temp\Students\Students\Labs", "C:\Temp\Students\Students\Slides"

foreach ($source in $sources) {
    $robocopyCmd = "$source $($source.Replace('\Temp\Students\Students','')) /E /XC /XO /XN"
    Write-Output $robocopyCmd
    Start-Process -FilePath robocopy -ArgumentList $robocopyCmd | Out-Null
}