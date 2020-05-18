# ######################################################
# Windows Powershell dotFile for setting up environment
#
# For Mac & *nix environments running PS see:
# https://github.com/PowerShell/PowerShell
#
# Usage: pwsh install-windows.ps1
#
# Notee: May need to first run Powershell as admin & set exec policy
#
# C:\> Set-ExecutionPolicy unrestricted
#
# ######################################################

function Install-VM {
    Write-Host '* ####################################### *'
    Write-Host '* *** INSTALL VIRTUAL MACHINE RELATED *** *'
    Write-Host '* ####################################### *'

    choco install vmwareworkstation -y
    choco install virtualbox -y
    choco install docker-desktop -y
    choco install docker-cli -y
    choco install docker-compose -y
}

function Install-Dev-Tools {
    Write-Host '* ################################# *'
    Write-Host '* *** INSTALL DEV TOOLS RELATED *** *'
    Write-Host '* ################################# *'

    # Language/Runtime
    choco install python3 -y
    choco install python2 -y
    choco install golang -y
    choco install ruby -y
    choco install nodejs -y
    choco install nvm -y
    choco install typescript -y
    choco install adoptopenjdk -y
    choco install mono -y
    choco install opencv -y

    # Apps - IDE
    choco install vim -y
    choco install vscode -y
    choco install eclipse -y
    choco install springtoolsuite -y # add-on to Eclipse
    choco install arduino -y
    choco install android-sdk -y
    choco install adb -y
    choco install apktool -y
    choco install androidstudio -y

    # Libs/Packages
    choco install phantomjs -y
    choco install casperjs -y
    choco install protoc -y
    choco install jq -y
    choco install docfx -y
    choco install doxygen.install
    choco install msys2 -y
    choco install mingw -y
    choco install make -y
    choco install cmake.install -y
    choco install maven -y
    choco install ant -y
    choco install gradle -y
    choco install groovy -y
}

function Install-CLI-Tools {
    Write-Host '* ################################# *'
    Write-Host '* *** INSTALL CLI TOOLS RELATED *** *'
    Write-Host '* ################################# *'

    choco install git.install -y
    choco install gitextensions -y
    choco install youtube-dl -y
    choco install gcloudsdk --ignore-checksums -y
    choco install awscli -y
    choco install awstools.powershell -y
    choco install azure-cli -y
    choco install terraform -y
    choco install hugo -y
    choco install sqlite -y
    choco install sqlitebrowser.install -y

    # GNU / *NIX
    choco install gnuwin32-coreutils.portable -y
    choco install curl -y
    choco install wget -y
    choco install which -y
    choco install grep -y
    choco install ack -y
    choco install cloc -y
    choco install less -y
    choco install sed -y
    choco install bat -y # clone of cat
    choco install tree -y
    choco install netcat -y
    choco install miktex.install -y
    choco install pandoc -y
    choco install ffmpeg -y
    choco install nmap -y
    choco install zap -y
    choco install openssh -y
}

function Install-SDR {
    Write-Host '* ###################################### *'
    Write-Host '* *** INSTALL SOFTWARE DEFINED RADIO *** *'
    Write-Host '* ###################################### *'

    choco install sdrsharp -y
    choco install rtlsdr-scanner -y
    choco install gps-sdr-sim -y
}

function Install-Apps {
    Write-Host '* ################################# *'
    Write-Host '* *** INSTALL GUI APPLICATIONS **** *'
    Write-Host '* ################################# *'

    choco install ChocolateyGUI -y
    choco install slack -y
    choco install signal -y
    choco install github-desktop -y
    choco install tightvnc -y
    choco install putty.install -y
    choco install electron -y
    choco install deluge -y  # bit torrent client
    choco install box-drive -y
    choco install firefox -y
    choco install googlechrome -y
    choco install selenium -y
    choco install selenium-chrome-driver -y
    choco install selenium-ie-driver -y
    choco install f.lux -y
    choco install google-hangouts-chromea -y
    choco install googlephotos -y
    choco install googledrive -y
    choco install googleearth -y
    choco install calibre -y
    choco install kindle -y
    choco install notepadplusplus -y
    choco install imagemagick -y
    choco install imagemagick.app -y
    choco install balsamiqmockups3 -y
    choco install drawio -y
    choco install spotify --ignore-checksums -y
    choco install steam -y
    choco install sumatrapdf -y
    choco install adobereader -y
    choco install vlc -y
    choco install gimp -y
    choco install adobereader -y
    choco install lastpass -y
    choco install expressvpn -y
    choco install irfanview -y
    choco install greenshot -y
    choco install 7zip -y
    choco install skype -y
    choco install zoom -y
    choco install libreoffice-fresh -y
    choco install postman -y
    choco install paint.net -y
    choco install wireshark -y
    choco install imgburn -y
    choco install virtualclonedrive -y
    choco install hxd -y
    choco install blender -y
    choco install unity -y
    choco install handbrake.install -y
}

function Install-MSFT-Related {
    Write-Host '* ############################# *'
    Write-Host '* *** INSTALL MSFT RELATED **** *'
    Write-Host '* ############################# *'

    choco install windows-10-update-assistant -y
    choco install office365proplus -y
    choco install sysinternals -y
    choco install kb3035131 -y # Windows kernel security updates
    choco install visualstudio2019buildtools -y # vis studio build tools
    choco install visualstudio2017-workload-vctools -y
    choco install vcredist140 -y # Visual C++ Redistribuate Vis Studio
    choco install kb2999226 -y # universal C runtime update for windoze

    # Microsoft .NET Framework 4.7.2
    choco install netfx-4.7.1-devpack -y
    # or Microsoft .NET Framework 4.7.2
    choco install dotnetfx -y
    # or Microsoft .NET Framework 4.7.2 Developer Pack
    choco install netfx-4.7.2-devpack
    # Microsoft .NET Core 2.2.6
    choco install dotnetcore -y
    # or Microsoft .NET Core Runtime (Install) 2.2.6
    choco install dotnetcore-runtime.install -y
}

function Install-All {
    Install-CLI-Tools
    Install-VM
    Install-Dev-Tools
    Install-SDR
    Install-Apps
    Install-MSFT-Related
}

function Print-Header {
    Clear-Host
    Write-Host '* ################################## *'
    Write-Host '* ******** WINDOZE DOTFILE ********* *'
    Write-Host '* ################################## *'
}

function Print-Footer {
    Write-Host '* ######################### *'
    Write-Host '* *** FINISHED !!!!!!! **** *'
    Write-Host '* ######################### *'
}

function Install-Chocolatey {
    # Install Chocolatey for package mgmt
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

function Test-IsAdmin {
    ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
}

function Cleanup-Config {
    # Remove all icons from desktop
    if ((Test-IsAdmin)) {
        Remove-Item C:\Users\*\Desktop\*lnk -Force
    }

    # Config File Explorer Settings
    $key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    Set-ItemProperty $key Hidden 1
    Set-ItemProperty $key HideFileExt 0
    Set-ItemProperty $key ShowSuperHidden 0
    Set-ItemProperty $key TaskbarGlomLevel 2
    Set-ItemProperty $key UseSharingWizard 0
    Set-ItemProperty $key TaskbarSmallIcons 1

    # Privacy: Let apps use my advertising ID: Disable
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

    # Activity Tracking: Disable
    @('EnableActivityFeed','PublishUserActivities','UploadUserActivities') |% { Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -Name $_ -Type DWord -Value 0 }

    # Disable Telemetry (requires a reboot to take effect)
    Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection -Name AllowTelemetry -Type DWord -Value 0
Get-Service DiagTrack,Dmwappushservice | Stop-Service | Set-Service -StartupType Disabled

    # Change Explorer home screen back to "This PC"
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 1

    # Enable Firewall
    Set-NetFirewallProfile -Profile * -Enabled True

    # Disable Autoplay
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" -Name "DisableAutoplay" -Type DWord -Value 1

    # Change default Explorer view to "Computer"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

    # Restart Explorer to take affect
    Stop-Process -processname explorer
}

function Usage {
    Write-Host './install-windows.ps1 [all|cli|dev|vm|sdr|apps|msft'
    Write-Host ''
    Write-Host '  all:  install all software'
    Write-Host '  cli:  install command-line software'
    Write-Host '  vm:   install virtual machine related software'
    Write-Host '  sdr:  install software defined radio software'
    Write-Host '  apps: install GUI application software'
    Write-Host '  msft: install Microsoft related software/updates'
    Write-Host '  cfg:  apply clean-up and registry configurations settings'
    Write-Host ''
}

# #####################################################
# M A I N     L O G I C
# #####################################################
#
Print-Header

# Install Chocolatey if applicable
try {
    if(Get-Command choco) {
        Write-Host 'choco exists - upgrade'
        choco upgrade chocolatey
    }
}
Catch {
    Install-Chocolatey
}

# No args or 'all' default full install
If ($($args.Count) -eq 0 -OR $args[0] -eq 'all') {
    Write-Host 'Install All'
    Install-All
    Cleanup-Config
    Print-Footer
    Exit(0)
}

# handle individual per param/installation
Switch ($args[0])
{
    "cli" {
        Write-Host 'Install CLI'
        Install-CLI-Tools
    }
    "vm" {
        Write-Host 'Install VM'
        Install-VM
    }
    "dev" {
        Write-Host 'Install Dev-Tools'
        Install-Dev-Tools
    }
    "sdr" {
        Write-Host 'Install SDR'
        Install-SDR
    }
    "apps" {
        Write-Host 'Install Applications'
        Install-Apps
    }
    "msft" {
        Write-Host 'Install MSFT Related'
        Install-MSFT-Related
    }
    "cfg" {
        Write-Host 'Cleanup & Config'
        Cleanup-Config
    }
    "help" {
        Clear-Host
        Usage
    }
    default {
        Clear-Host
        Write-Host 'Invalid Argument: ' $($args[0])
        Usage
        Exit(1)
    }
}

# Ensure environment refreshed
refreshenv

Exit(0)

