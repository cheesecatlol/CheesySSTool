# ==============================================================================
# CheesySSTool Launcher - Cat & Cheese Edition (WPF)
# Run: powershell -NoProfile -ExecutionPolicy Bypass -File CheesySSTool.ps1
# ==============================================================================

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$installDir = "$env:USERPROFILE\Downloads\CheesySSTool"

# ==============================================================================
# TOOL DATA
# ==============================================================================
$ToolData = @(
    @{ Name="PrefetchView";          Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/PrefetchView/releases/tag/v1.6.7" },
    @{ Name="BAMReveal";             Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/BAMReveal/releases/tag/v1.3.1" },
    @{ Name="StringsParser";         Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/StringsParser/releases/tag/v1.0" },
    @{ Name="Fileless";              Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/Fileless/releases/tag/v1.3" },
    @{ Name="DPS-Analyzer";          Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/DPS-Analyzer/releases/tag/v1.1" },
    @{ Name="UserAssistView";        Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/UserAssistView/releases/tag/v1.0" },
    @{ Name="JournalParser";         Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/JournalParser/releases/tag/v1.2" },
    @{ Name="InjGen";                Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/InjGen/releases/tag/fork" },
    @{ Name="USBDetector";           Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/USBDetector/releases/tag/v1.1" },
    @{ Name="PFTrace";               Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/PFTrace/releases/tag/v1.0.1" },
    @{ Name="CheckDeletedUSN";       Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/CheckDeletedUSN/releases/tag/v0.2.1" },
    @{ Name="JARParser";             Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/JARParser/releases/tag/v1.2" },
    @{ Name="BAM-parser";            Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/BAM-parser/releases/tag/v1.2.9" },
    @{ Name="PathsParser";           Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/PathsParser/releases/tag/v1.2" },
    @{ Name="JournalTrace";          Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/JournalTrace/releases/tag/1.2" },
    @{ Name="KernelLiveDumpTool";    Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/KernelLiveDumpTool/releases/tag/v1.1" },
    @{ Name="BamDeletedKeys";        Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/BamDeletedKeys/releases/tag/v1.0" },
    @{ Name="Tool";                  Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/Tool/releases/tag/v1.1.3" },
    @{ Name="pcasvc-executed";       Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/pcasvc-executed/releases/tag/v0.8.7" },
    @{ Name="process-parser";        Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/process-parser/releases/tag/v0.5.5" },
    @{ Name="prefetch-parser";       Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/prefetch-parser/releases/tag/v1.5.5" },
    @{ Name="ActivitiesCache";       Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/ActivitiesCache-execution/releases/tag/v0.6.5" },
    @{ Name="MeowDoomsdayFucker";    Category="Tonynoh";    Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/tag/V.1.2" },
    @{ Name="MeowModAnalyzer";       Category="Tonynoh";    Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')" },
    @{ Name="MeowResolver";          Category="Tonynoh";    Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowResolver/releases/tag/MeowResolver" },
    @{ Name="MeowNovowareFucker";    Category="Tonynoh";    Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowNovowareFucker/releases/tag/V1" },
    @{ Name="MeowImportsChecker";    Category="Tonynoh";    Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowImportsChecker/releases/tag/MeowImportsChecker" },
    @{ Name="PSHunter";              Category="Praiselily"; Type="GitHub"; URL="https://github.com/praiselily/PSHunter/releases/tag/Built" },
    @{ Name="AltDetector";           Category="Praiselily"; Type="GitHub"; URL="https://github.com/praiselily/AltDetector/releases/tag/Detector" },
    @{ Name="WeHateFakers";          Category="Praiselily"; Type="Cmd";    Command="iwr https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1 | iex" },
    @{ Name="CommonDirectories";     Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')" },
    @{ Name="HarddiskConverter";     Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/HarddiskConverter.ps1')" },
    @{ Name="Services";              Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1')" },
    @{ Name="SignedScheduledTasks";  Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks.ps1')" },
    @{ Name="RL ModAnalyzer";        Category="RedLotus";   Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotus-Mod-Analyzer/releases/tag/RL" },
    @{ Name="RL TaskSentinel";       Category="RedLotus";   Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotus-Task-Sentinel/releases/tag/RL" },
    @{ Name="RL AltChecker";         Category="RedLotus";   Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotusAltChecker/releases/tag/RL" },
    @{ Name="WinPrefetchView";       Category="Others";     Type="Web";    URL="https://www.nirsoft.net/utils/win_prefetch_view.html" },
    @{ Name="ComputerActivityView";  Category="Others";     Type="Web";    URL="https://www.nirsoft.net/utils/computer_activity_view.html" },
    @{ Name="AmcacheParser";         Category="Others";     Type="Web";    URL="https://download.ericzimmermanstools.com/net9/AmcacheParser.zip" },
    @{ Name="JumpListExplorer";      Category="Others";     Type="Web";    URL="https://download.ericzimmermanstools.com/net9/JumpListExplorer.zip" },
    @{ Name="SystemInformer";        Category="Others";     Type="Web";    URL="https://www.systeminformer.com/canary" },
    @{ Name="DIE-engine";            Category="Others";     Type="Web";    URL="https://github.com/horsicq/DIE-engine/releases" },
    @{ Name="DQRKIS-FUCKER";         Category="Others";     Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1')" },
    @{ Name="MacroDetector";         Category="Others";     Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')" }
)

# ==============================================================================
# XAML UI
# ==============================================================================
[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="CheesySSTool"
    Width="1200" Height="760"
    MinWidth="1200" MinHeight="760"
    WindowStartupLocation="CenterScreen"
    ResizeMode="NoResize"
    WindowStyle="None"
    AllowsTransparency="True"
    Background="Transparent"
    FontFamily="Segoe UI">

    <Window.Resources>
        <SolidColorBrush x:Key="MainBg"     Color="#0F0B00"/>
        <SolidColorBrush x:Key="SidebarBg"  Color="#1A1200"/>
        <SolidColorBrush x:Key="CardBg"     Color="#221800"/>
        <SolidColorBrush x:Key="Accent"     Color="#F5C200"/>
        <SolidColorBrush x:Key="AccentDim"  Color="#A07800"/>
        <SolidColorBrush x:Key="TextMain"   Color="#FFF4C8"/>
        <SolidColorBrush x:Key="TextMuted"  Color="#907830"/>
        <SolidColorBrush x:Key="ConsoleBg"  Color="#060400"/>
        <SolidColorBrush x:Key="GhBg"       Color="#191932"/>
        <SolidColorBrush x:Key="Ps1Bg"      Color="#0F2840"/>
        <SolidColorBrush x:Key="WebBg"      Color="#20102D"/>

        <Style x:Key="SideBtn" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="{StaticResource TextMain}"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="Height" Value="38"/>
            <Setter Property="Margin" Value="0,0,0,4"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="4">
                            <ContentPresenter HorizontalAlignment="Left" VerticalAlignment="Center" Margin="14,0"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#2A1E00"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="TitleBtn" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="{StaticResource TextMuted}"/>
            <Setter Property="Width" Value="40"/>
            <Setter Property="Height" Value="36"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#33F5C200"/>
                                <Setter Property="Foreground" Value="#F5C200"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Border Background="{StaticResource MainBg}" BorderBrush="#3D2E00" BorderThickness="1" CornerRadius="8">
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="42"/>
                <RowDefinition Height="*"/>
            </Grid.RowDefinitions>

            <!-- Title Bar -->
            <Border Grid.Row="0" Background="{StaticResource SidebarBg}" CornerRadius="8,8,0,0">
                <Grid Margin="16,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>
                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                        <TextBlock Text="=^.^=" FontSize="14" FontWeight="Bold" Foreground="{StaticResource Accent}" FontFamily="Consolas"/>
                        <TextBlock Text="  CheesySSTool" FontSize="14" FontWeight="SemiBold" Foreground="{StaticResource TextMain}"/>
                        <TextBlock Text="  -  Cat &amp; Cheese Toolkit" FontSize="11" Foreground="{StaticResource TextMuted}" VerticalAlignment="Center" Margin="4,0,0,0"/>
                    </StackPanel>
                    <StackPanel Grid.Column="1" Orientation="Horizontal">
                        <Button x:Name="MinBtn"   Style="{StaticResource TitleBtn}" Content="_"/>
                        <Button x:Name="CloseBtn" Style="{StaticResource TitleBtn}" Content="X"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Body -->
            <Grid Grid.Row="1">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="210"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- Sidebar -->
                <Border Grid.Column="0" Background="{StaticResource SidebarBg}" BorderBrush="#3D2E00" BorderThickness="0,0,1,0">
                    <StackPanel Margin="10,14,10,14">

                        <Border Background="#0A0700" CornerRadius="6" Margin="0,0,0,14" Padding="0,10">
                            <TextBlock x:Name="CatBlock"
                                Text="   /\_____/\  &#x0a;  /  ^   ^  \ &#x0a; (  =  w  =  )&#x0a;  \  (___) / &#x0a;  /  |   |  \ &#x0a; (__|   |__)"
                                FontFamily="Consolas" FontSize="9"
                                Foreground="{StaticResource Accent}"
                                HorizontalAlignment="Center"
                                TextAlignment="Left"
                                xml:space="preserve"/>
                        </Border>

                        <TextBlock Text="ACTIONS" FontSize="9" FontWeight="Bold" Foreground="{StaticResource TextMuted}" Margin="4,0,0,6"/>
                        <Button x:Name="OpenFolderBtn" Content="  Open Install Folder"      Style="{StaticResource SideBtn}"/>
                        <Button x:Name="ClearCacheBtn" Content="  Clear Downloaded Files"   Style="{StaticResource SideBtn}"/>
                        <Button x:Name="OpenCmdBtn"    Content="  Open CMD"                 Style="{StaticResource SideBtn}"/>

                        <Separator Background="#3D2E00" Margin="0,10,0,10"/>

                        <TextBlock Text="LEGEND" FontSize="9" FontWeight="Bold" Foreground="{StaticResource TextMuted}" Margin="4,0,0,6"/>
                        <StackPanel Orientation="Horizontal" Margin="4,2">
                            <Border Width="12" Height="12" Background="{StaticResource Ps1Bg}" CornerRadius="2" Margin="0,0,6,0"/>
                            <TextBlock Text="PS Script" FontSize="10" Foreground="{StaticResource TextMuted}"/>
                        </StackPanel>
                        <StackPanel Orientation="Horizontal" Margin="4,2">
                            <Border Width="12" Height="12" Background="{StaticResource GhBg}" CornerRadius="2" Margin="0,0,6,0"/>
                            <TextBlock Text="GitHub (auto-download)" FontSize="10" Foreground="{StaticResource TextMuted}"/>
                        </StackPanel>
                        <StackPanel Orientation="Horizontal" Margin="4,2">
                            <Border Width="12" Height="12" Background="{StaticResource WebBg}" CornerRadius="2" Margin="0,0,6,0"/>
                            <TextBlock Text="Web / Direct DL" FontSize="10" Foreground="{StaticResource TextMuted}"/>
                        </StackPanel>

                        <Separator Background="#3D2E00" Margin="0,10,0,10"/>
                        <TextBlock x:Name="InstPathBlock" Text="" FontSize="9" Foreground="#5A4010" TextWrapping="Wrap" Margin="4,0"/>
                    </StackPanel>
                </Border>

                <!-- Main Panel -->
                <Grid Grid.Column="1" Margin="16,14,16,14">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="10"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="10"/>
                        <RowDefinition Height="160"/>
                    </Grid.RowDefinitions>

                    <!-- Status card -->
                    <Border Grid.Row="0" Background="{StaticResource CardBg}" CornerRadius="6" Padding="16,10">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="Auto"/>
                            </Grid.ColumnDefinitions>
                            <StackPanel>
                                <TextBlock x:Name="StatusTitle" Text="Ready" FontSize="20" FontWeight="SemiBold" Foreground="{StaticResource TextMain}"/>
                                <TextBlock x:Name="StatusSub"   Text="Select a tool to launch or download it." FontSize="11" Foreground="{StaticResource TextMuted}"/>
                            </StackPanel>
                            <Border Grid.Column="1" Background="#1A3D1A" CornerRadius="4" Padding="10,4" VerticalAlignment="Center">
                                <TextBlock x:Name="StatusBadge" Text="IDLE" FontSize="12" FontWeight="Bold" Foreground="{StaticResource Accent}"/>
                            </Border>
                        </Grid>
                    </Border>

                    <!-- Tab control -->
                    <Border Grid.Row="2" Background="{StaticResource CardBg}" CornerRadius="6">
                        <TabControl x:Name="ToolsTab" Background="Transparent" BorderThickness="0" Padding="0">
                            <TabControl.Resources>
                                <Style TargetType="TabItem">
                                    <Setter Property="Foreground" Value="{StaticResource TextMuted}"/>
                                    <Setter Property="FontSize" Value="11"/>
                                    <Setter Property="Padding" Value="12,6"/>
                                    <Setter Property="Cursor" Value="Hand"/>
                                    <Setter Property="Template">
                                        <Setter.Value>
                                            <ControlTemplate TargetType="TabItem">
                                                <Border x:Name="TabBorder" Background="Transparent" CornerRadius="4" Margin="3,4,3,0" Padding="12,5">
                                                    <ContentPresenter ContentSource="Header" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                                </Border>
                                                <ControlTemplate.Triggers>
                                                    <Trigger Property="IsSelected" Value="True">
                                                        <Setter TargetName="TabBorder" Property="Background" Value="{StaticResource Accent}"/>
                                                        <Setter Property="Foreground" Value="#0F0B00"/>
                                                    </Trigger>
                                                    <MultiTrigger>
                                                        <MultiTrigger.Conditions>
                                                            <Condition Property="IsMouseOver" Value="True"/>
                                                            <Condition Property="IsSelected" Value="False"/>
                                                        </MultiTrigger.Conditions>
                                                        <Setter TargetName="TabBorder" Property="Background" Value="#2A1E00"/>
                                                        <Setter Property="Foreground" Value="{StaticResource TextMain}"/>
                                                    </MultiTrigger>
                                                </ControlTemplate.Triggers>
                                            </ControlTemplate>
                                        </Setter.Value>
                                    </Setter>
                                </Style>
                            </TabControl.Resources>
                        </TabControl>
                    </Border>

                    <!-- Console -->
                    <Border Grid.Row="4" Background="{StaticResource ConsoleBg}" CornerRadius="6" Padding="12,8">
                        <Grid>
                            <Grid.RowDefinitions>
                                <RowDefinition Height="Auto"/>
                                <RowDefinition Height="*"/>
                            </Grid.RowDefinitions>
                            <TextBlock Text="ACTIVITY CONSOLE" FontSize="9" FontWeight="Bold" Foreground="#5A4010" FontFamily="Consolas" Margin="0,0,0,4"/>
                            <TextBox x:Name="LogBox"
                                Grid.Row="1"
                                Background="Transparent"
                                Foreground="{StaticResource Accent}"
                                BorderThickness="0"
                                FontFamily="Consolas"
                                FontSize="11"
                                IsReadOnly="True"
                                VerticalScrollBarVisibility="Auto"
                                TextWrapping="Wrap"/>
                        </Grid>
                    </Border>
                </Grid>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

# ==============================================================================
# LOAD WINDOW
# ==============================================================================
$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

$MinBtn        = $window.FindName("MinBtn")
$CloseBtn      = $window.FindName("CloseBtn")
$StatusTitle   = $window.FindName("StatusTitle")
$StatusSub     = $window.FindName("StatusSub")
$StatusBadge   = $window.FindName("StatusBadge")
$LogBox        = $window.FindName("LogBox")
$ToolsTab      = $window.FindName("ToolsTab")
$OpenFolderBtn = $window.FindName("OpenFolderBtn")
$ClearCacheBtn = $window.FindName("ClearCacheBtn")
$OpenCmdBtn    = $window.FindName("OpenCmdBtn")
$CatBlock      = $window.FindName("CatBlock")
$InstPathBlock = $window.FindName("InstPathBlock")

$InstPathBlock.Text = "Install path:`n$installDir"

# ==============================================================================
# HELPERS
# ==============================================================================
function Write-Log {
    param([string]$msg)
    $time = Get-Date -Format "HH:mm:ss"
    $LogBox.Dispatcher.Invoke([Action]{
        $LogBox.AppendText("[$time] $msg`r`n")
        $LogBox.ScrollToEnd()
    })
}

function Set-Status {
    param($title, $sub, $badge = "BUSY")
    $window.Dispatcher.Invoke([Action]{
        $StatusTitle.Text = $title
        $StatusSub.Text   = $sub
        $StatusBadge.Text = $badge
    })
}

function Start-AppOrScript {
    param(
        [Parameter(Mandatory=$true)][string]$Path,
        [string]$WorkingDirectory
    )

    if (-not $WorkingDirectory) { $WorkingDirectory = Split-Path -Parent $Path }
    $extension = [System.IO.Path]::GetExtension($Path).ToLowerInvariant()

    $quotedPath = '"' + $Path + '"'

    switch ($extension) {
        ".cmd" { Start-Process -FilePath "cmd.exe" -ArgumentList "/k", $quotedPath -WorkingDirectory $WorkingDirectory -WindowStyle Normal }
        ".bat" { Start-Process -FilePath "cmd.exe" -ArgumentList "/k", $quotedPath -WorkingDirectory $WorkingDirectory -WindowStyle Normal }
        default { Start-Process -FilePath $Path -WorkingDirectory $WorkingDirectory -WindowStyle Normal }
    }
}

function Start-CmdToolCommand {
    param([Parameter(Mandatory=$true)][string]$Command)

    $encodedCommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($Command))
    Start-Process -FilePath "cmd.exe" -ArgumentList "/k", "powershell.exe -NoProfile -ExecutionPolicy Bypass -EncodedCommand $encodedCommand" -WindowStyle Normal
}

function Save-UrlToFile {
    param(
        [Parameter(Mandatory=$true)][string]$Uri,
        [Parameter(Mandatory=$true)][string]$OutFile
    )

    $tempFile = "$OutFile.download"
    if (Test-Path -LiteralPath $tempFile) { Remove-Item -LiteralPath $tempFile -Force -ErrorAction SilentlyContinue }

    $client = New-Object System.Net.WebClient
    $client.Headers.Add("User-Agent", "CheesySSTool")
    try {
        $client.DownloadFile($Uri, $tempFile)
        if (Test-Path -LiteralPath $OutFile) { Remove-Item -LiteralPath $OutFile -Force -ErrorAction Stop }
        Move-Item -LiteralPath $tempFile -Destination $OutFile -Force -ErrorAction Stop
    } finally {
        $client.Dispose()
        if (Test-Path -LiteralPath $tempFile) { Remove-Item -LiteralPath $tempFile -Force -ErrorAction SilentlyContinue }
    }
}

function Start-DownloadedTool {
    param(
        [Parameter(Mandatory=$true)][string]$Directory,
        [string]$PreferredFile
    )

    if ($PreferredFile -and (Test-Path -LiteralPath $PreferredFile) -and ($PreferredFile -notmatch "\.zip$")) {
        Write-Log "Launching $(Split-Path -Leaf $PreferredFile)"
        Start-AppOrScript -Path $PreferredFile -WorkingDirectory (Split-Path -Parent $PreferredFile)
        return $true
    }

    $launchable = Get-ChildItem -Path $Directory -Recurse -File -ErrorAction SilentlyContinue |
        Where-Object { $_.Extension -match "^\.(exe|cmd|bat)$" } |
        Sort-Object @{ Expression = { if ($_.Extension -eq ".exe") { 0 } else { 1 } } }, FullName |
        Select-Object -First 1

    if ($launchable) {
        Write-Log "Launching $($launchable.Name)"
        Start-AppOrScript -Path $launchable.FullName -WorkingDirectory $launchable.DirectoryName
        return $true
    }

    Write-Log "No .exe, .cmd, or .bat found - opening folder."
    Start-Process -FilePath explorer.exe -ArgumentList "`"$Directory`""
    return $false
}

function Get-GitHubAssetUrl {
    param([string]$ReleaseUrl)

    if ($ReleaseUrl -match "github\.com/([^/]+)/([^/]+)/releases/tag/(.+)$") {
        $user = $Matches[1]
        $repo = $Matches[2]
        $tag = [Uri]::EscapeDataString(([Uri]::UnescapeDataString($Matches[3])).TrimEnd("/"))
        $api  = "https://api.github.com/repos/$user/$repo/releases/tags/$tag"
        try {
            $rel   = Invoke-RestMethod -Uri $api -Headers @{"User-Agent"="CheesySSTool"} -ErrorAction Stop
            $asset = $rel.assets | Where-Object { $_.name -match "\.(exe|zip|cmd|bat)$" } | Select-Object -First 1
            if ($asset) { return @{ url=$asset.browser_download_url; name=$asset.name } }
        } catch {
            Write-Log "GitHub lookup failed: $($_.Exception.Message)"
        }
    }

    return $null
}

function Invoke-ToolDownloadAndRun {
    param($tool)
    $name = $tool.Name
    $cat  = $tool.Category

    Write-Log "Fetching asset info for $name..."

    $asset = Get-GitHubAssetUrl -ReleaseUrl $tool.URL
    if (-not $asset) {
        Write-Log "No .exe/.zip/.cmd/.bat asset found for $name - opening browser."
        Set-Status "Ready" "No asset found, opened GitHub." "IDLE"
        Start-Process $tool.URL
        return
    }

    $destDir  = "$installDir\$cat\$name"
    if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
    $destFile = "$destDir\$($asset.name)"

    if (Test-Path $destFile) {
        Write-Log "Cached: $($asset.name) - skipping download."
    } else {
        Write-Log "Downloading $($asset.name)..."
        try {
            Save-UrlToFile -Uri $asset.url -OutFile $destFile
            Write-Log "Download complete: $($asset.name)"
        } catch {
            $err = $_
            Write-Log "Download failed: $err"
            Set-Status "Error" "Download failed for $name." "ERR"
            Start-Process $tool.URL
            return
        }
    }

    if ($asset.name -match "\.zip$") {
        Write-Log "Extracting $($asset.name)..."
        try {
            Expand-Archive -Path $destFile -DestinationPath $destDir -Force -ErrorAction Stop
        } catch {
            Write-Log "Extract failed: $($_.Exception.Message)"
            Set-Status "Error" "Could not extract $name." "ERR"
            Start-Process -FilePath explorer.exe -ArgumentList "`"$destDir`""
            return
        }
        [void](Start-DownloadedTool -Directory $destDir)
    } else {
        [void](Start-DownloadedTool -Directory $destDir -PreferredFile $destFile)
    }

    Set-Status "Ready" "$name launched successfully." "IDLE"
}

function Invoke-WebToolDownload {
    param($tool)
    $name = $tool.Name
    $url  = $tool.URL

    if ($url -match "\.(zip|exe|cmd|bat)$") {
        $fileName = ($url -split "/")[-1]
        $destDir  = "$installDir\Others\$name"
        if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
        $destFile = "$destDir\$fileName"

        if (Test-Path $destFile) {
            Write-Log "Cached: $fileName - skipping download."
        } else {
            Write-Log "Downloading $fileName..."
            try {
                Save-UrlToFile -Uri $url -OutFile $destFile
                Write-Log "Download complete: $fileName"
            } catch {
                $err = $_
                Write-Log "Download failed: $err"
                Set-Status "Error" "Download failed." "ERR"
                Start-Process $url
                return
            }
        }

        if ($fileName -match "\.zip$") {
            try {
                Expand-Archive -Path $destFile -DestinationPath $destDir -Force -ErrorAction Stop
            } catch {
                Write-Log "Extract failed: $($_.Exception.Message)"
                Set-Status "Error" "Could not extract $name." "ERR"
                Start-Process -FilePath explorer.exe -ArgumentList "`"$destDir`""
                return
            }
            [void](Start-DownloadedTool -Directory $destDir)
        } else {
            [void](Start-DownloadedTool -Directory $destDir -PreferredFile $destFile)
        }
        Set-Status "Ready" "$name launched." "IDLE"
    } else {
        Write-Log "Opening browser for $name"
        Set-Status "Browser" "Opening $name in browser." "IDLE"
        Start-Process $url
    }
}

# ==============================================================================
# POPULATE TABS
# ==============================================================================
$Categories = @("Orbdiff","Spokwn","Tonynoh","Praiselily","RedLotus","Others")

foreach ($cat in $Categories) {
    $tab = New-Object System.Windows.Controls.TabItem
    $tab.Header = $cat

    $scroll = New-Object System.Windows.Controls.ScrollViewer
    $scroll.VerticalScrollBarVisibility   = "Auto"
    $scroll.HorizontalScrollBarVisibility = "Disabled"

    $wrap = New-Object System.Windows.Controls.WrapPanel
    $wrap.Margin = "8"

    $catTools = $ToolData | Where-Object { $_.Category -eq $cat }

    foreach ($tool in $catTools) {
        $t = $tool

        $btn             = New-Object System.Windows.Controls.Button
        $btn.Content     = $t.Name
        $btn.Width       = 200
        $btn.Height      = 60
        $btn.FontSize    = 12
        $btn.Margin      = "6"
        $btn.Cursor      = "Hand"
        $btn.Foreground  = "#F3E5F5"

        switch ($t.Type) {
            "Cmd"    { $btn.Background = "#0F2840" }
            "GitHub" { $btn.Background = "#191932" }
            "Web"    { $btn.Background = "#20102D" }
        }

        $btn.Template = [Windows.Markup.XamlReader]::Parse("
            <ControlTemplate xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation' TargetType='Button'>
                <Border Background='{TemplateBinding Background}' CornerRadius='6' BorderBrush='#33F5C200' BorderThickness='1'>
                    <ContentPresenter HorizontalAlignment='Center' VerticalAlignment='Center'/>
                </Border>
                <ControlTemplate.Triggers>
                    <Trigger Property='IsMouseOver' Value='True'>
                        <Setter Property='Background' Value='#F5C200'/>
                        <Setter Property='Foreground' Value='#0F0B00'/>
                    </Trigger>
                </ControlTemplate.Triggers>
            </ControlTemplate>
        ")

        $btn.Add_Click({
            $tName = $_.Source.Content
            $tData = $ToolData | Where-Object { $_.Name -eq $tName } | Select-Object -First 1

            if ($tData.Type -eq "Cmd") {
                Set-Status "Running" "Launching $tName..." "BUSY"
                Write-Log "Starting: $tName"
                try {
                    Start-CmdToolCommand -Command $tData.Command
                    Write-Log "Launched: $tName"
                    Set-Status "Ready" "$tName launched." "IDLE"
                } catch {
                    Write-Log "Error: $_"
                    Set-Status "Error" "Failed to launch $tName." "ERR"
                }
            }
            elseif ($tData.Type -eq "GitHub") {
                $captured = $tData
                Set-Status "Downloading" "Fetching $tName..." "BUSY"
                Write-Log "Starting download: $tName"
                try {
                    Invoke-ToolDownloadAndRun -tool $captured
                } catch {
                    $err = $_
                    Write-Log "Unexpected error: $err"
                    Set-Status "Error" "Something went wrong." "ERR"
                }
            }
            elseif ($tData.Type -eq "Web") {
                $captured = $tData
                Set-Status "Downloading" "Fetching $tName..." "BUSY"
                Write-Log "Starting: $tName"
                try {
                    Invoke-WebToolDownload -tool $captured
                } catch {
                    $err = $_
                    Write-Log "Unexpected error: $err"
                    Set-Status "Error" "Something went wrong." "ERR"
                }
            }
        })

        $wrap.Children.Add($btn) | Out-Null
    }

    $scroll.Content = $wrap
    $tab.Content    = $scroll
    $ToolsTab.Items.Add($tab) | Out-Null
}

# ==============================================================================
# CAT ANIMATION
# ==============================================================================
$catFrames = @(
    "   /\_____/\  `n  /  ^   ^  \ `n (  =  w  =  )`n  \  (___) / `n  /  |   |  \ `n (__|   |__)",
    "   /\_____/\  `n  /  -   ^  \ `n (  =  w  =  )`n  \  (___) / `n  /  |   |  \ `n (__|   |__)",
    "   /\_____/\  `n  /  -   -  \ `n (  =  w  =  )`n  \  (___) / `n  /  |   |  \ `n (__|   |__)",
    "   /\_____/\  `n  /  ^   -  \ `n (  =  w  =  )`n  \  (___) / `n  /  |   |  \ `n (__|   |__)"
)
$script:catIdx = 0
$catTimer = New-Object System.Windows.Threading.DispatcherTimer
$catTimer.Interval = [TimeSpan]::FromMilliseconds(900)
$catTimer.Add_Tick({
    $script:catIdx = ($script:catIdx + 1) % $catFrames.Count
    $CatBlock.Text = $catFrames[$script:catIdx]
})
$catTimer.Start()

# ==============================================================================
# EVENTS
# ==============================================================================
$window.Add_MouseLeftButtonDown({ try { $window.DragMove() } catch {} })
$CloseBtn.Add_Click({ $catTimer.Stop(); $window.Close() })
$MinBtn.Add_Click({ $window.WindowState = "Minimized" })

$OpenFolderBtn.Add_Click({
    if (-not (Test-Path $installDir)) { New-Item -ItemType Directory -Path $installDir -Force | Out-Null }
    Start-Process explorer.exe $installDir
    Write-Log "Opened install folder."
})

$ClearCacheBtn.Add_Click({
    if (Test-Path $installDir) {
        $files = Get-ChildItem -Path $installDir -Recurse -File -ErrorAction SilentlyContinue
        $count = $files.Count
        $files | Remove-Item -Force -ErrorAction SilentlyContinue
        Write-Log "Cleared $count file(s) from install folder."
        Set-Status "Clean" "Removed $count downloaded file(s)." "IDLE"
    } else {
        Write-Log "Nothing to clear - install folder does not exist yet."
    }
})

$OpenCmdBtn.Add_Click({
    Start-Process -FilePath "cmd.exe"
    Write-Log "Opened CMD."
})

# ==============================================================================
# STARTUP LOG
# ==============================================================================
Write-Log "+------------------------------------------+"
Write-Log "|  CheesySSTool  =^.^=  v2.0 (WPF)        |"
Write-Log "|  Cat and Cheese Toolkit                  |"
Write-Log "+------------------------------------------+"
Write-Log "$($ToolData.Count) tools loaded across $($Categories.Count) categories."
Write-Log "GitHub/Web tools download in background - UI stays responsive."
Write-Log "Files saved to: $installDir"
Write-Log "Ready. Meow!"

Set-Status "Ready" "Select a tool to launch or download it." "IDLE"

$window.ShowDialog() | Out-Null






