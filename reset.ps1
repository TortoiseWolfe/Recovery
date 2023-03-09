$programs = @{
    # 'Autodesk Desktop App' = 'https://download.autodesk.com/iedu/AutodeskDesktopAppInstaller.exe';
    'DockerDesktop' = 'https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe';
    'Dropbox' = 'https://www.dropbox.com/download?plat=win&type=full';
    # 'OBS Studio' = 'https://cdn-fastly.obsproject.com/downloads/OBS-Studio-29.0.0-Full-Installer-x64.exe';
    # 'Outlook' = 'https://go.microsoft.com/fwlink/?linkid=2115415';
    # 'Revit2023' = 'https://trial2.autodesk.com/NET18SWDLD/2023/RVT/DLM/Autodesk_Revit_2023_English_Win_64bit_dlm_001_002.sfx.exe';
    # 'TeamWork Desktop App' = 'https://desktop.teamspace.com/releases/latest/TeamworkDesktopSetup.exe';
    'VSCode' = 'https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user';
    # 'Visual Studio Community 2019' = 'https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&rel=16&src=myvs&utm_medium=microsoft&utm_source=my.visualstudio.com&utm_campaign=download&utm_content=vs+community+2019';
    'Zoom' = 'https://zoom.us/client/latest/ZoomInstaller.exe'
}

$failed = @()

foreach ($program in $programs.GetEnumerator()) {
    try {
        Write-Host "Downloading $($program.Key)..."
        $filePath = "$($Env:USERPROFILE)\Downloads\$($program.Key).exe"
        Invoke-WebRequest -Uri $program.Value -OutFile $filePath -UseBasicParsing

        Write-Host "Installing $($program.Key)..."
        & $filePath /VERYSILENT /SUPPRESSMSGBOXES /NORESTART
    } catch {
        Write-Warning "Failed to install $($program.Key)."
        $failed += $program.Key
    }
}

if ($failed.Count -gt 0) {
    Write-Host "The following programs failed to install: $($failed -join ', ')."
} else {
    Write-Host "All programs have been installed successfully."
}
