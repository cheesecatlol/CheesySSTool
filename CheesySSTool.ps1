Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml
Add-Type -AssemblyName System.Windows.Forms

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$installDir = "$env:USERPROFILE\Downloads\CheesySSTool"


# TOOL DATA

$ToolData = @(
    @{ Name="PrefetchView";          Desc="Parses prefetch, extracts file info";          Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/PrefetchView/releases/latest" },
    @{ Name="BAMReveal";             Desc="Parses BAM forensic artefact";                 Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/BAMReveal/releases/latest" },
    @{ Name="StringsParser";         Desc="Strings + YARA + signatures scanner";          Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/StringsParser/releases/latest" },
    @{ Name="Fileless";              Desc="Detects fileless via eventlog + memdump";      Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/Fileless/releases/latest" },
    @{ Name="DPS-Analyzer";          Desc="Analyzes DPS memory";                          Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/DPS-Analyzer/releases/latest" },
    @{ Name="UserAssistView";        Desc="Parses UserAssist registry artifact";          Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/UserAssistView/releases/latest" },
    @{ Name="JournalParser";         Desc="Parses NTFS USNJournal entries";               Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/JournalParser/releases/latest" },
    @{ Name="InjGen";                Desc="Detects JNI/JVMTI memory injections";         Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/InjGen/releases/latest" },
    @{ Name="USBDetector";           Desc="Detects USB device history";                   Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/USBDetector/releases/latest" },
    @{ Name="PFTrace";               Desc="Rundll32/Regsvr32 prefetch analysis";          Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/PFTrace/releases/latest" },
    @{ Name="CheckDeletedUSN";       Desc="Compares USN timestamp vs boot time";          Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/CheckDeletedUSN/releases/latest" },
    @{ Name="JARParser";             Desc="Parses JAR prefetch, DcomLaunch strings";      Category="Orbdiff";    Type="GitHub"; URL="https://github.com/Orbdiff/JARParser/releases/latest" },
    @{ Name="BAM-parser";            Desc="Parses BAM entries for execution history";     Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/BAM-parser/releases/latest" },
    @{ Name="PathsParser";           Desc="Extracts and analyzes executable paths";       Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/PathsParser/releases/latest" },
    @{ Name="JournalTrace";          Desc="Traces file activity via USN journal";         Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/JournalTrace/releases/latest" },
    @{ Name="KernelLiveDumpTool";    Desc="Captures live kernel memory dump";             Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/KernelLiveDumpTool/releases/latest" },
    @{ Name="BamDeletedKeys";        Desc="Finds deleted BAM registry keys";              Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/BamDeletedKeys/releases/latest" },
    @{ Name="Espouken Tool";         Desc="All-in-one SS forensics toolkit";              Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/Tool/releases/latest" },
    @{ Name="pcasvc-executed";       Desc="Extracts PCA service execution records";       Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/pcasvc-executed/releases/latest" },
    @{ Name="process-parser";        Desc="Parses process execution artefacts";           Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/process-parser/releases/latest" },
    @{ Name="prefetch-parser";       Desc="Parses Windows prefetch files";                Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/prefetch-parser/releases/latest" },
    @{ Name="ActivitiesCache";       Desc="Parses ActivitiesCache execution history";     Category="Spokwn";     Type="GitHub"; URL="https://github.com/spokwn/ActivitiesCache-execution/releases/latest" },
    @{ Name="MeowDoomsdayFucker";    Desc="Detects Doomsday cheat artefacts";             Category="Tonynoh";    Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/latest" },
    @{ Name="MeowModAnalyzer";       Desc="Analyzes mod files for suspicious content";    Category="Tonynoh";    Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')" },
    @{ Name="MeowResolver";          Desc="Resolves obfuscated strings in binaries";      Category="Tonynoh";    Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowResolver/releases/latest" },
    @{ Name="MeowNovowareFucker";    Desc="Detects Novoware cheat artefacts";             Category="Tonynoh";    Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowNovowareFucker/releases/latest" },
    @{ Name="MeowImportsChecker";    Desc="Checks PE imports for suspicious DLLs";        Category="Tonynoh";    Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowImportsChecker/releases/latest" },
    @{ Name="MeowClientsFucker";     Desc="Detects known cheat client artefacts";         Category="Tonynoh";    Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowClientFucker/releases/latest" },
    @{ Name="PSHunter";              Desc="Hunts suspicious PowerShell activity";         Category="Praiselily"; Type="GitHub"; URL="https://github.com/praiselily/PSHunter/releases/latest" },
    @{ Name="AltDetector";           Desc="Detects alternate account artefacts";          Category="Praiselily"; Type="GitHub"; URL="https://github.com/praiselily/AltDetector/releases/latest" },
    @{ Name="WeHateFakers";          Desc="Checks hotspot / tethering logs";              Category="Praiselily"; Type="Cmd";    Command="iwr https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1 | iex" },
    @{ Name="CommonDirectories";     Desc="Lists files in common suspicious dirs";        Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')" },
    @{ Name="HarddiskConverter";     Desc="Converts harddisk identifiers for review";     Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/HarddiskConverter.ps1')" },
    @{ Name="Services";              Desc="Lists and analyzes running services";          Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1')" },
    @{ Name="SignedScheduledTasks";  Desc="Finds unsigned / suspicious scheduled tasks"; Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks.ps1')" },
    @{ Name="RL ModAnalyzer";        Desc="Analyzes mod files for cheat indicators";     Category="RedLotus";   Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotus-Mod-Analyzer/releases/latest" },
    @{ Name="RL TaskSentinel";       Desc="Monitors scheduled tasks for anomalies";      Category="RedLotus";   Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotus-Task-Sentinel/releases/latest" },
    @{ Name="RL AltChecker";         Desc="Checks for alternate account indicators";     Category="RedLotus";   Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotusAltChecker/releases/latest" },
    @{ Name="ComputerActivityView";  Desc="Timeline of computer activity events";        Category="Others";     Type="Web";    URL="https://www.nirsoft.net/utils/computer_activity_view.html" },
    @{ Name="AmcacheParser";         Desc="Parses AMCache with YARA + signatures";       Category="Others";     Type="Web";    URL="https://download.ericzimmermanstools.com/net9/AmcacheParser.zip" },
    @{ Name="SystemInformer";        Desc="Advanced process and kernel inspector";        Category="Others";     Type="Link";   URL="https://www.systeminformer.com/canary" },
    @{ Name="DIE-engine";            Desc="Detects file type, packer, compiler";         Category="Others";     Type="Web";    URL="https://github.com/horsicq/DIE-engine/releases" },
    @{ Name="DQRKIS-FUCKER";         Desc="Detects DQRKIS cheat artefacts";              Category="Others";     Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1')" },
    @{ Name="MacroDetector";         Desc="Detects macro / clicker software traces";     Category="Others";     Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/NiccBlahh/MacroDetector/refs/heads/main/MacroDetector.ps1')" },
    @{ Name="Jarabel";               Desc="Locates .jar files with detailed checks";     Category="Others";     Type="GitHub"; URL="https://github.com/nay-cat/Jarabel/releases/latest" },
    @{ Name="Luyten";                Desc="Open source Java decompiler GUI (Procyon)";   Category="Others";     Type="GitHub"; URL="https://github.com/deathmarine/Luyten/releases/latest" },
    @{ Name="VMAware";               Desc="Advanced VM detection library and tool";      Category="Others";     Type="GitHub"; URL="https://github.com/kernelwernel/VMAware/releases/latest" },
    @{ Name="Velociraptor";          Desc="Endpoint DFIR and threat hunting agent";      Category="Others";     Type="GitHub"; URL="https://github.com/Velocidex/velociraptor/releases/latest" },
    @{ Name="NTFS Parser";           Desc="NTFS forensics: MFT, Bitlocker, USN";        Category="Others";     Type="GitHub"; URL="https://github.com/thewhiteninja/ntfstool/releases/latest" },
    @{ Name="Hayabusa";              Desc="Fast forensics timeline generator";           Category="Others";     Type="GitHub"; URL="https://github.com/Yamato-Security/hayabusa/releases/latest" },
    @{ Name="Everything";            Desc="Instant filename search engine for Windows";  Category="Others";     Type="Link";   URL="https://www.voidtools.com/downloads/" },
    @{ Name="HxD";                   Desc="Fast hex editor with disk and RAM editing";   Category="Others";     Type="Link";   URL="https://mh-nexus.de/en/hxd/" },
    @{ Name="bstrings";              Desc="Searches strings with regex + YARA";          Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net9/bstrings.zip" },
    @{ Name="JLECmd";                Desc="Parses Jump List files (CLI)";                Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net9/JLECmd.zip" },
    @{ Name="JumpListExplorer";      Desc="GUI explorer for Jump List artefacts";        Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net9/JumpListExplorer.zip" },
    @{ Name="MFTECmd";               Desc="Parses MFT, UsnJrnl, LogFile, Boot";         Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net9/MFTECmd.zip" },
    @{ Name="PECmd";                 Desc="Parses Windows prefetch files (CLI)";         Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net9/PECmd.zip" },
    @{ Name="RecentFileCacheParser"; Desc="Parses RecentFileCache.bcf artefact";         Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net9/RecentFileCacheParser.zip" },
    @{ Name="RegistryExplorer";      Desc="GUI explorer for registry hives";             Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net9/RegistryExplorer.zip" },
    @{ Name="ShellBagsExplorer";     Desc="GUI explorer for ShellBags artefacts";        Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net9/ShellBagsExplorer.zip" },
    @{ Name="SrumECmd";              Desc="Parses SRUM database for usage data";         Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net9/SrumECmd.zip" },
    @{ Name="TimelineExplorer";      Desc="GUI viewer for CSV timeline output";          Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net9/TimelineExplorer.zip" },
    @{ Name="FullEventLogView";      Desc="Views all Windows event log entries";         Category="NirSoft";    Type="Web";    URL="https://www.nirsoft.net/utils/fulleventlogview.zip" },
    @{ Name="NetworkUsageView";      Desc="Shows network usage per process";             Category="NirSoft";    Type="Web";    URL="https://www.nirsoft.net/utils/networkusageview.zip" },
    @{ Name="BrowserDownloadsView";  Desc="Lists all browser download history";          Category="NirSoft";    Type="Web";    URL="https://www.nirsoft.net/utils/browserdownloadsview.zip" },
    @{ Name="AlternateStreamView";   Desc="Reveals hidden NTFS alternate streams";       Category="NirSoft";    Type="Web";    URL="https://www.nirsoft.net/utils/alternatestreamview.zip" },
    @{ Name="USBDeview";             Desc="Lists all USB devices ever connected";        Category="NirSoft";    Type="Web";    URL="https://www.nirsoft.net/utils/usbdeview.zip" },
    @{ Name="OpenSaveFilesView";     Desc="Shows files opened/saved via dialogs";        Category="NirSoft";    Type="Web";    URL="https://www.nirsoft.net/utils/opensavefilesview.zip" },
    @{ Name="ExecutedProgramsList";  Desc="Lists programs run from various sources";     Category="NirSoft";    Type="Web";    URL="https://www.nirsoft.net/utils/executedprogramslist.zip" },
    @{ Name="TaskSchedulerView";     Desc="Views all scheduled tasks and history";       Category="NirSoft";    Type="Web";    URL="https://www.nirsoft.net/utils/taskschedulerview.zip" },
    @{ Name="JumpListsView";         Desc="Views Jump List recent/frequent files";       Category="NirSoft";    Type="Web";    URL="https://www.nirsoft.net/utils/jumplistsview.zip" },
    @{ Name="WinPrefetchView";       Desc="Views Windows prefetch file details";         Category="NirSoft";    Type="Web";    URL="https://www.nirsoft.net/utils/winprefetchview.zip" },
    @{ Name="RegScanner";            Desc="Scans registry for values / patterns";        Category="NirSoft";    Type="Web";    URL="https://www.nirsoft.net/utils/regscanner.zip" },
    @{ Name="ShellBagsView";         Desc="Views ShellBags folder access history";       Category="NirSoft";    Type="Web";    URL="https://www.nirsoft.net/utils/shellbagsview.zip" },
    @{ Name="NET 9.0";               Desc="Microsoft .NET 9 SDK runtime";                Category="Dependencies"; Type="Web"; URL="https://download.visualstudio.microsoft.com/download/pr/92dba916-bc51-4e76-8b0e-d41d37ce5fa4/ab08f3e95bf7a3d3da336a7e8c8eca63/dotnet-sdk-9.0.203-win-x64.exe" },
    @{ Name="NET 10.0";              Desc="Microsoft .NET 10 runtime";                   Category="Dependencies"; Type="Web"; URL="https://download.visualstudio.microsoft.com/download/pr/b3f93f0e-9e5e-4b4c-a4c4-36db0c4b0e3e/dotnet-runtime-10.0.0-win-x64.exe" },
    @{ Name="VSRedist";              Desc="Visual C++ redistributable (x64)";            Category="Dependencies"; Type="Web"; URL="https://aka.ms/vs/17/release/vc_redist.x64.exe" }
)


# UI

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
                        <TextBlock Text="  -  by cheese cat" FontSize="11" Foreground="{StaticResource TextMuted}" VerticalAlignment="Center" Margin="4,0,0,0"/>
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

                        <TextBlock Text="CREDITS" FontSize="9" FontWeight="Bold" Foreground="{StaticResource TextMuted}" Margin="4,0,0,6"/>
                        <TextBlock Text="Made by cheese cat" FontSize="11" FontWeight="SemiBold" Foreground="{StaticResource TextMain}" Margin="4,2,0,4"/>
                        <TextBlock Text="Discord: cheese_cat0" FontSize="10" Foreground="{StaticResource TextMuted}" TextWrapping="Wrap" Margin="4,1,0,0"/>
                        <TextBlock Text="GitHub: cheesecatlol" FontSize="10" Foreground="{StaticResource TextMuted}" TextWrapping="Wrap" Margin="4,1,0,0"/>

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


# LOADs WINDOW

# ==============================================================================
# DISCLAIMER DIALOG (shown before main window)
# ==============================================================================
[xml]$disclaimerXaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="CheesySSTool"
    Width="560" Height="560"
    WindowStartupLocation="CenterScreen"
    ResizeMode="NoResize"
    WindowStyle="None"
    AllowsTransparency="True"
    Background="Transparent"
    FontFamily="Segoe UI">
    <Border Background="#0F0B00" BorderBrush="#3D2E00" BorderThickness="1" CornerRadius="8" Padding="24">
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="*"/>
                <RowDefinition Height="56"/>
            </Grid.RowDefinitions>
            <StackPanel Grid.Row="0">
                <TextBlock Text="CheesySSTool" FontSize="20" FontWeight="Bold" Foreground="#F5C200" Margin="0,0,0,12"/>
                <TextBlock TextWrapping="Wrap" Foreground="#FFF4C8" FontSize="13" Margin="0,0,0,12"
                           Text="All programs are downloaded automatically from their official GitHub repositories and saved in a neatly organized folder. None of your information is ever collected or modified."/>
                <TextBlock TextWrapping="Wrap" Foreground="#FFF4C8" FontSize="13" Margin="0,0,0,16"
                           Text="Each tool is developed and maintained by its own author. I take no responsibility for anything that may be found regarding these tools in the future."/>
                <TextBlock TextWrapping="Wrap" Foreground="#FFF4C8" FontSize="13" FontWeight="SemiBold"
                           Text="To continue, you must agree with everything stated above."/>
            </StackPanel>
            <Grid Grid.Row="1" VerticalAlignment="Bottom">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="12"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>
                <Button x:Name="CancelBtn" Grid.Column="0" Content="Cancel" Height="40"
                        Background="Transparent" Foreground="#FFF4C8" BorderBrush="#3D2E00" BorderThickness="1"
                        Cursor="Hand" FontSize="13"/>
                <Button x:Name="AcceptBtn" Grid.Column="2" Content="Accept &amp; Continue" Height="40"
                        Background="#221800" Foreground="#F5C200" BorderBrush="#F5C200" BorderThickness="1"
                        Cursor="Hand" FontSize="13" FontWeight="SemiBold"/>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

$disclaimerReader = New-Object System.Xml.XmlNodeReader $disclaimerXaml
$disclaimerWindow = [Windows.Markup.XamlReader]::Load($disclaimerReader)
$disclaimerWindow.Add_MouseLeftButtonDown({ try { $disclaimerWindow.DragMove() } catch {} })

$CancelBtn = $disclaimerWindow.FindName("CancelBtn")
$AcceptBtn = $disclaimerWindow.FindName("AcceptBtn")

$script:disclaimerAccepted = $false

$AcceptBtn.Add_Click({
    $script:disclaimerAccepted = $true
    $disclaimerWindow.Close()
})
$CancelBtn.Add_Click({
    $script:disclaimerAccepted = $false
    $disclaimerWindow.Close()
})

$disclaimerWindow.ShowDialog() | Out-Null

if (-not $script:disclaimerAccepted) {
    exit
}

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


# HELPERS

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
        $destDir  = "$installDir\$($tool.Category)\$name"
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


# LAUNCH ANIMATION

function Start-ButtonAnimation {
    param([System.Windows.Controls.Button]$Button)

    $origBg  = $Button.Background
    $origFg  = $Button.Foreground
    $origW   = $Button.Width
    $origH   = $Button.Height

    # Flash sequence: gold -> white -> gold -> restore, with a scale pulse
    $flashColors = @("#F5C200", "#FFFFFF", "#F5C200", "#FFE066")
    $flashFg     = "#0F0B00"
    $scales      = @(0.93, 0.96, 1.04, 1.0)
    $delays      = @(0, 80, 160, 250)

    # Disable the button during animation so it can't be double-clicked
    $Button.IsEnabled = $false

    for ($i = 0; $i -lt $flashColors.Count; $i++) {
        $color   = $flashColors[$i]
        $scale   = $scales[$i]
        $delay   = $delays[$i]
        $w       = [Math]::Round($origW * $scale)
        $h       = [Math]::Round($origH * $scale)

        $Button.Dispatcher.Invoke([Action]{
            $Button.Background = $color
            $Button.Foreground = $flashFg
            $Button.Width      = $w
            $Button.Height     = $h
        }, [System.Windows.Threading.DispatcherPriority]::Render)

        Start-Sleep -Milliseconds 80
    }

    # Restore original look
    $Button.Dispatcher.Invoke([Action]{
        $Button.Background = $origBg
        $Button.Foreground = $origFg
        $Button.Width      = $origW
        $Button.Height     = $origH
        $Button.IsEnabled  = $true
    }, [System.Windows.Threading.DispatcherPriority]::Render)
}


# TABS

$Categories = @("Orbdiff","Spokwn","Tonynoh","Praiselily","RedLotus","Zimmerman","NirSoft","Dependencies","Others")

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
        $btn.Width       = 210
        $btn.Height      = 80
        $btn.FontSize    = 12
        $btn.Margin      = "6"
        $btn.Cursor      = "Hand"
        $btn.Foreground  = "#F3E5F5"

        # Build name + description StackPanel as button content
        $btnStack = New-Object System.Windows.Controls.StackPanel
        $btnStack.Margin = "10,8"
        $nameBlock = New-Object System.Windows.Controls.TextBlock
        $nameBlock.Text = $t.Name
        $nameBlock.FontSize = 12
        $nameBlock.FontWeight = "SemiBold"
        $nameBlock.TextWrapping = "Wrap"
        $descBlock = New-Object System.Windows.Controls.TextBlock
        $descBlock.Text = $t.Desc
        $descBlock.FontSize = 10
        $descBlock.Opacity = 0.6
        $descBlock.TextWrapping = "Wrap"
        $descBlock.Margin = "0,3,0,0"
        $btnStack.Children.Add($nameBlock) | Out-Null
        $btnStack.Children.Add($descBlock) | Out-Null
        $btn.Content = $btnStack

        switch ($t.Type) {
            "Cmd"    { $btn.Background = "#1A1200" }
            "GitHub" { $btn.Background = "#1A1200" }
            "Web"    { $btn.Background = "#1A1200" }
            "Link"   { $btn.Background = "#1A1200" }
        }

        # Create animatable (unfrozen) objects in PowerShell code
        $btnBg    = [Windows.Media.SolidColorBrush]::new([Windows.Media.Color]::FromRgb(0x1A, 0x12, 0x00))
        $btnScale = [Windows.Media.ScaleTransform]::new(1.0, 1.0)
        $btnGlow  = [Windows.Media.Effects.DropShadowEffect]::new()
        $btnGlow.Color       = [Windows.Media.Color]::FromRgb(0xF5, 0xC2, 0x00)
        $btnGlow.BlurRadius  = 0
        $btnGlow.ShadowDepth = 0
        $btnGlow.Opacity     = 0

        # Minimal template - binds to the PS-created objects via tag
        $btn.Template = [Windows.Markup.XamlReader]::Parse(
            "<ControlTemplate xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation' TargetType='Button'>" +
            "  <Border CornerRadius='6' BorderThickness='1' RenderTransformOrigin='0.5,0.5'" +
            "          Background='{TemplateBinding Background}'" +
            "          RenderTransform='{TemplateBinding Tag}'" +
            "          BorderBrush='#33F5C200'>" +
            "    <ContentPresenter HorizontalAlignment='Center' VerticalAlignment='Center'/>" +
            "  </Border>" +
            "</ControlTemplate>"
        )
        $btn.Background = $btnBg
        $btn.Tag        = $btnScale

        # Apply glow after the button is loaded (effect must be set on the Border, not Button)
        $btn.Add_Loaded({
            $b = $_.Source
            if ([Windows.Media.VisualTreeHelper]::GetChildrenCount($b) -gt 0) {
                $border = [Windows.Media.VisualTreeHelper]::GetChild($b, 0)
                if ($border) { $border.Effect = $b.Resources["glow"] }
            }
        })
        $btn.Resources["glow"] = $btnGlow

        # Animation helper - all objects are local PS variables, never frozen
        $btnBgRef    = $btnBg
        $btnScaleRef = $btnScale
        $btnGlowRef  = $btnGlow

        $btn.Add_MouseEnter({
            $b   = $_.Source
            $bg  = $b.Background
            $sc  = $b.Tag
            $glw = $b.Resources["glow"]
            if (-not $bg -or -not $sc) { return }
            $d    = [Windows.Duration]::new([TimeSpan]::FromMilliseconds(130))
            $ease = [Windows.Media.Animation.CubicEase]::new()
            $a  = [Windows.Media.Animation.ColorAnimation]::new([Windows.Media.Color]::FromRgb(0xF5,0xC2,0x00), $d)
            $bg.BeginAnimation([Windows.Media.SolidColorBrush]::ColorProperty, $a)
            $ax = [Windows.Media.Animation.DoubleAnimation]::new(1.06, $d); $ax.EasingFunction = $ease
            $sc.BeginAnimation([Windows.Media.ScaleTransform]::ScaleXProperty, $ax)
            $ay = [Windows.Media.Animation.DoubleAnimation]::new(1.06, $d); $ay.EasingFunction = $ease
            $sc.BeginAnimation([Windows.Media.ScaleTransform]::ScaleYProperty, $ay)
            if ($glw) {
                $ab = [Windows.Media.Animation.DoubleAnimation]::new(20.0, $d)
                $glw.BeginAnimation([Windows.Media.Effects.DropShadowEffect]::BlurRadiusProperty, $ab)
                $ao = [Windows.Media.Animation.DoubleAnimation]::new(0.9, $d)
                $glw.BeginAnimation([Windows.Media.Effects.DropShadowEffect]::OpacityProperty, $ao)
            }
            $b.Foreground = [Windows.Media.Brushes]::Black
        })

        $btn.Add_MouseLeave({
            $b   = $_.Source
            $bg  = $b.Background
            $sc  = $b.Tag
            $glw = $b.Resources["glow"]
            if (-not $bg -or -not $sc) { return }
            $d    = [Windows.Duration]::new([TimeSpan]::FromMilliseconds(180))
            $ease = [Windows.Media.Animation.CubicEase]::new()
            $a  = [Windows.Media.Animation.ColorAnimation]::new([Windows.Media.Color]::FromRgb(0x1A,0x12,0x00), $d)
            $bg.BeginAnimation([Windows.Media.SolidColorBrush]::ColorProperty, $a)
            $ax = [Windows.Media.Animation.DoubleAnimation]::new(1.0, $d); $ax.EasingFunction = $ease
            $sc.BeginAnimation([Windows.Media.ScaleTransform]::ScaleXProperty, $ax)
            $ay = [Windows.Media.Animation.DoubleAnimation]::new(1.0, $d); $ay.EasingFunction = $ease
            $sc.BeginAnimation([Windows.Media.ScaleTransform]::ScaleYProperty, $ay)
            if ($glw) {
                $ab = [Windows.Media.Animation.DoubleAnimation]::new(0.0, $d)
                $glw.BeginAnimation([Windows.Media.Effects.DropShadowEffect]::BlurRadiusProperty, $ab)
                $ao = [Windows.Media.Animation.DoubleAnimation]::new(0.0, $d)
                $glw.BeginAnimation([Windows.Media.Effects.DropShadowEffect]::OpacityProperty, $ao)
            }
            $b.Foreground = [Windows.Media.BrushConverter]::new().ConvertFrom("#F3E5F5")
        })

        $btn.Add_PreviewMouseDown({
            $b  = $_.Source
            $sc = $b.Tag
            if (-not $sc) { return }
            $d  = [Windows.Duration]::new([TimeSpan]::FromMilliseconds(80))
            $ax = [Windows.Media.Animation.DoubleAnimation]::new(0.95, $d)
            $sc.BeginAnimation([Windows.Media.ScaleTransform]::ScaleXProperty, $ax)
            $ay = [Windows.Media.Animation.DoubleAnimation]::new(0.95, $d)
            $sc.BeginAnimation([Windows.Media.ScaleTransform]::ScaleYProperty, $ay)
        })

        $btn.Add_PreviewMouseUp({
            $b  = $_.Source
            $sc = $b.Tag
            if (-not $sc) { return }
            $d  = [Windows.Duration]::new([TimeSpan]::FromMilliseconds(100))
            $ax = [Windows.Media.Animation.DoubleAnimation]::new(1.06, $d)
            $sc.BeginAnimation([Windows.Media.ScaleTransform]::ScaleXProperty, $ax)
            $ay = [Windows.Media.Animation.DoubleAnimation]::new(1.06, $d)
            $sc.BeginAnimation([Windows.Media.ScaleTransform]::ScaleYProperty, $ay)
        })

        $btn.Add_Click({
            $clickedBtn = $_.Source
            $tName      = ($clickedBtn.Content.Children[0]).Text
            $tData      = $ToolData | Where-Object { $_.Name -eq $tName } | Select-Object -First 1

            $clickedBtn.IsEnabled = $false

            # Smooth press-down animation, then run action after UI has painted
            $sc = $clickedBtn.Tag
            if ($sc) {
                $dPress = [Windows.Duration]::new([TimeSpan]::FromMilliseconds(80))
                $axP = [Windows.Media.Animation.DoubleAnimation]::new(0.93, $dPress)
                $sc.BeginAnimation([Windows.Media.ScaleTransform]::ScaleXProperty, $axP)
                $ayP = [Windows.Media.Animation.DoubleAnimation]::new(0.93, $dPress)
                $sc.BeginAnimation([Windows.Media.ScaleTransform]::ScaleYProperty, $ayP)
            }

            # Defer actual work so the press animation renders first
            $script:timer = [Windows.Threading.DispatcherTimer]::new()
            $script:timer.Interval = [TimeSpan]::FromMilliseconds(100)
            $script:timerBtn  = $clickedBtn
            $script:timerName = $tName
            $script:timerData = $tData
            $script:timer.Add_Tick({
                $script:timer.Stop()

                # Animate back to resting state
                $sc2 = $script:timerBtn.Tag
                if ($sc2) {
                    $dRel = [Windows.Duration]::new([TimeSpan]::FromMilliseconds(150))
                    $ease = [Windows.Media.Animation.CubicEase]::new()
                    $axR = [Windows.Media.Animation.DoubleAnimation]::new(1.0, $dRel); $axR.EasingFunction = $ease
                    $sc2.BeginAnimation([Windows.Media.ScaleTransform]::ScaleXProperty, $axR)
                    $ayR = [Windows.Media.Animation.DoubleAnimation]::new(1.0, $dRel); $ayR.EasingFunction = $ease
                    $sc2.BeginAnimation([Windows.Media.ScaleTransform]::ScaleYProperty, $ayR)
                    $bg2 = $script:timerBtn.Background
                    if ($bg2) {
                        $aC = [Windows.Media.Animation.ColorAnimation]::new([Windows.Media.Color]::FromRgb(0x1A,0x12,0x00), $dRel)
                        $bg2.BeginAnimation([Windows.Media.SolidColorBrush]::ColorProperty, $aC)
                    }
                }
                $script:timerBtn.Foreground = [Windows.Media.BrushConverter]::new().ConvertFrom("#F3E5F5")

                if ($script:timerData.Type -eq "Link") {
                    Start-Process $script:timerData.URL
                    Set-Status "Ready" "Opened $script:timerName in browser." "IDLE"
                    $script:timerBtn.IsEnabled = $true
                } elseif ($script:timerData.Type -eq "Cmd") {
                    Set-Status "Running" "Launching $script:timerName..." "BUSY"
                    Write-Log "Starting: $script:timerName"
                    # Run Cmd in background too so UI never blocks
                    $rsc = [runspacefactory]::CreateRunspace()
                    $rsc.ApartmentState = "STA"; $rsc.ThreadOptions = "ReuseThread"; $rsc.Open()
                    $rsc.SessionStateProxy.SetVariable("timerData",    $script:timerData)
                    $rsc.SessionStateProxy.SetVariable("timerName",    $script:timerName)
                    $rsc.SessionStateProxy.SetVariable("timerBtn",     $script:timerBtn)
                    $rsc.SessionStateProxy.SetVariable("dispatcher",   $script:timerBtn.Dispatcher)
                    $rsc.SessionStateProxy.SetVariable("StatusTitle",  $StatusTitle)
                    $rsc.SessionStateProxy.SetVariable("StatusSub",    $StatusSub)
                    $rsc.SessionStateProxy.SetVariable("StatusBadge",  $StatusBadge)
                    $rsc.SessionStateProxy.SetVariable("LogBox",       $LogBox)
                    $psc = [powershell]::Create(); $psc.Runspace = $rsc
                    $null = $psc.AddScript({
                        function Set-StatusBg { param($t,$s,$b)
                            $dispatcher.Invoke([Action]{ $StatusTitle.Text=$t; $StatusSub.Text=$s; $StatusBadge.Text=$b })
                        }
                        function Write-LogBg { param($m)
                            $dispatcher.Invoke([Action]{ $LogBox.AppendText("[$(Get-Date -f 'HH:mm:ss')] $m`n"); $LogBox.ScrollToEnd() })
                        }
                        try {
                            $cmd = $timerData.Command
                            if ($cmd -match '^http') { Start-Process $cmd }
                            else { Start-Process "cmd.exe" -ArgumentList "/c $cmd" }
                            Write-LogBg "Launched: $timerName"
                            Set-StatusBg "Ready" "$timerName launched." "IDLE"
                        } catch {
                            Write-LogBg "Error: $_"
                            Set-StatusBg "Error" "Failed to launch $timerName." "ERR"
                        }
                        $dispatcher.Invoke([Action]{ $timerBtn.IsEnabled = $true })
                    })
                    $null = $psc.BeginInvoke()
                } else {
                # Downloads run in background runspace so UI stays responsive
                Set-Status "Downloading" "Fetching $script:timerName..." "BUSY"
                Write-Log "Starting download: $script:timerName"

                $rs = [runspacefactory]::CreateRunspace()
                $rs.ApartmentState = "STA"
                $rs.ThreadOptions  = "ReuseThread"
                $rs.Open()

                # Pass everything needed into the runspace
                $rs.SessionStateProxy.SetVariable("tData",      $script:timerData)
                $rs.SessionStateProxy.SetVariable("installDir", $installDir)
                $rs.SessionStateProxy.SetVariable("dispatcher", $script:timerBtn.Dispatcher)
                $rs.SessionStateProxy.SetVariable("btn",        $script:timerBtn)
                $rs.SessionStateProxy.SetVariable("StatusTitle", $StatusTitle)
                $rs.SessionStateProxy.SetVariable("StatusSub",   $StatusSub)
                $rs.SessionStateProxy.SetVariable("StatusBadge", $StatusBadge)
                $rs.SessionStateProxy.SetVariable("LogBox",      $LogBox)

                $ps = [powershell]::Create()
                $ps.Runspace = $rs

                $null = $ps.AddScript({
                    function Set-StatusBg {
                        param($title, $sub, $badge)
                        $dispatcher.Invoke([Action]{
                            $StatusTitle.Text = $title
                            $StatusSub.Text   = $sub
                            $StatusBadge.Text = $badge
                        })
                    }
                    function Write-LogBg {
                        param($msg)
                        $dispatcher.Invoke([Action]{
                            $LogBox.AppendText("[$(Get-Date -f 'HH:mm:ss')] $msg`n")
                            $LogBox.ScrollToEnd()
                        })
                    }
                    function Restore-Button {
                        $dispatcher.Invoke([Action]{
                            $btn.IsEnabled  = $true
                        })
                    }

                    $name = $tData.Name
                    $url  = $tData.URL
                    $cat  = $tData.Category
                    $type = $tData.Type

                    try {
                        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

                        $destDir = "$installDir\$cat\$name"
                        if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }

                        if ($type -eq "GitHub") {
                            $urlParts = $url -replace "https://github.com/", "" -split "/"
                            $owner    = $urlParts[0]
                            $repo     = $urlParts[1]
                            $apiUrl   = "https://api.github.com/repos/$owner/$repo/releases/latest"
                            $headers  = @{ "User-Agent" = "CheesySSTool" }
                            $release  = Invoke-RestMethod -Uri $apiUrl -Headers $headers -ErrorAction Stop
                            $asset    = $release.assets | Where-Object { $_.name -match "\.(zip|exe)$" } | Select-Object -First 1
                            if (-not $asset) { throw "No downloadable asset found." }
                            $dlUrl    = $asset.browser_download_url
                            $fileName = $asset.name
                            $destFile = "$destDir\$fileName"
                        } else {
                            $dlUrl    = $url
                            $fileName = ($url -split "/")[-1]
                            $destFile = "$destDir\$fileName"
                        }

                        if (Test-Path $destFile) {
                            Write-LogBg "Cached: $fileName - skipping download."
                        } else {
                            Write-LogBg "Downloading $fileName..."
                            $wc = New-Object System.Net.WebClient
                            $wc.DownloadFile($dlUrl, $destFile)
                            Write-LogBg "Download complete: $fileName"
                        }

                        if ($fileName -match "\.zip$") {
                            Write-LogBg "Extracting..."
                            Expand-Archive -Path $destFile -DestinationPath $destDir -Force -ErrorAction Stop
                            # Find and launch exe
                            $exe = Get-ChildItem -Path $destDir -Filter "*.exe" -Recurse | Select-Object -First 1
                            if ($exe) {
                                Write-LogBg "Launching $($exe.Name)..."
                                Start-Process -FilePath $exe.FullName
                            } else {
                                $dispatcher.Invoke([Action]{ Start-Process -FilePath explorer.exe -ArgumentList "`"$destDir`"" })
                            }
                        } else {
                            Write-LogBg "Launching $fileName..."
                            Start-Process -FilePath $destFile
                        }

                        Set-StatusBg "Ready" "$name launched successfully." "IDLE"
                    } catch {
                        Write-LogBg "Error: $_"
                        Set-StatusBg "Error" "Something went wrong with $name." "ERR"
                    }

                    Restore-Button
                    $rs.Close()
                })

                $null = $ps.BeginInvoke()
                }
            })
            $timer.Start()
        })

        $wrap.Children.Add($btn) | Out-Null
    }

    $scroll.Content = $wrap
    $tab.Content    = $scroll
    $ToolsTab.Items.Add($tab) | Out-Null
}


# CAT ANIMATION

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




# EVENTS

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
        $items = Get-ChildItem -Path $installDir -Force -ErrorAction SilentlyContinue
        $count = @($items).Count
        $items | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
        Write-Log "Cleared $count item(s) from install folder."
        Set-Status "Clean" "Removed downloaded files and folders." "IDLE"
    } else {
        Write-Log "Nothing to clear - install folder does not exist yet."
    }
})

$OpenCmdBtn.Add_Click({
    Start-Process -FilePath "cmd.exe"
    Write-Log "Opened CMD."
})

Write-Log "Files saved to: $installDir"

Set-Status "Ready" "Select a tool to launch or download it." "IDLE"

$window.ShowDialog() | Out-Null
