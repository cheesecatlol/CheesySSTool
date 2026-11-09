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
    @{ Name="MFT-HardLink";          Desc="Finds hard link entries in the MFT";          Category="Orbdiff";    Type="Web";    URL="https://github.com/Orbdiff/MFT-HardLink/releases/download/v1.2/HardLink.exe" },
    @{ Name="AmcacheParser (Orbdiff)"; Desc="Parses Amcache execution records";         Category="Orbdiff";    Type="Web";    URL="https://github.com/Orbdiff/AmcacheParser/releases/download/v1.0/AmcacheParser.exe" },
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
    @{ Name="AltDetector";           Desc="Lists Minecraft + Discord accounts on the PC"; Category="Praiselily"; Type="Web";    URL="https://github.com/praiselily/AltDetector/releases/latest/download/AltDetector.exe" },
    @{ Name="Collector";             Desc="Downloads SS tools (adds Defender exclusion)"; Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Collector.ps1')" },
    @{ Name="CommonDirectories";     Desc="Lists files in common suspicious dirs";        Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')" },
    @{ Name="DoomsdayFinder";        Desc="Hunts for Doomsday client traces";             Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/DoomsdayFinder.ps1')" },
    @{ Name="HarddiskConverter";     Desc="Converts \Device\HarddiskVolume paths";        Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/HarddiskConverter.ps1')" },
    @{ Name="IHateScreensharing";    Desc="Lily's screenshare check script (admin)";      Category="Praiselily"; Type="Cmd";    Admin=$true; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/IHateScreensharing.ps1')" },
    @{ Name="SchedulesV2";           Desc="Finds suspicious / unsigned scheduled tasks";  Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/SchedulesV2.ps1')" },
    @{ Name="Service-Enabler";       Desc="GUI to re-enable SS-relevant services";        Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Service-Enabler.ps1')" },
    @{ Name="Services";              Desc="Lists and analyzes services (admin)";          Category="Praiselily"; Type="Cmd";    Admin=$true; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1')" },
    @{ Name="ShellSearch";           Desc="Searches PowerShell event logs (admin)";       Category="Praiselily"; Type="Cmd";    Admin=$true; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/ShellSearch.ps1')" },
    @{ Name="SignedScheduledTasks";  Desc="Finds unsigned / suspicious scheduled tasks"; Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks')" },
    @{ Name="Spokwn-Collect";        Desc="Downloads Spokwn's tools to C:\Screenshare";   Category="Praiselily"; Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Spokwn-Collect.ps1')" },
    @{ Name="ComputerActivityView";  Desc="Timeline of computer activity events";        Category="Others";     Type="Link";   URL="https://www.nirsoft.net/utils/computer_activity_view.html" },
    @{ Name="AmcacheParser";         Desc="Parses AMCache with YARA + signatures";       Category="Others";     Type="Web";    URL="https://download.ericzimmermanstools.com/net/AmcacheParser.zip" },
    @{ Name="SystemInformer";        Desc="Advanced process and kernel inspector";        Category="Others";     Type="Link";   URL="https://www.systeminformer.com/canary" },
    @{ Name="DIE-engine";            Desc="Detects file type, packer, compiler";         Category="Others";     Type="Web";    URL="https://github.com/horsicq/DIE-engine/releases/download/3.10/die_win64_portable_3.10_x64.zip" },
    @{ Name="RegistryScanner";       Desc="Scans registry for suspicious entries";       Category="Others";     Type="Web";    URL="https://github.com/Inkenal/RegistryScanner/releases/download/main/RegistryScanner.exe" },
    @{ Name="VigilsTaskParser";      Desc="Parses scheduled tasks for review";           Category="Others";     Type="Web";    URL="https://github.com/Inkenal/TaskParser/releases/download/main/VigilsTaskParser.exe" },
    @{ Name="MarsPixelDumpAnalyzer"; Desc="Analyzes memory dumps for cheat traces";      Category="Others";     Type="Web";    URL="https://github.com/zedoonvm1/MarsPixelDumpAnalyzer/releases/download/Dev/MarsPixelDumpAnalyzer.exe" },
    @{ Name="Storm Fuser Finder";    Desc="Finds Fuser artefacts on the system";         Category="Others";     Type="Web";    URL="https://github.com/Sorted1/StormSS-Fuser-Finder/releases/download/Main/Storm.Fuser.Finder.zip" },
    @{ Name="Recaf";                 Desc="Java bytecode editor / decompiler (needs Java)"; Category="Others";  Type="Web";    URL="https://github.com/Col-E/Recaf/releases/download/2.21.14/recaf-2.21.14-J8-jar-with-dependencies.jar" },
    @{ Name="MSC Event Viewer";      Desc="Event log viewer for SS checks";              Category="Others";     Type="Web";    URL="https://github.com/piespeas/MSC-Event-Viewer/releases/download/BETA/Event.Viewer.MSC.exe" },
    @{ Name="DQRKIS-FUCKER";         Desc="Detects DQRKIS cheat artefacts";              Category="Others";     Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1')" },
    @{ Name="MacroDetector";         Desc="Detects macro / clicker software traces";     Category="Others";     Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/NiccBlahh/MacroDetector/refs/heads/main/MacroDetector.ps1')" },
    @{ Name="Jarabel";               Desc="Locates .jar files with detailed checks";     Category="Others";     Type="GitHub"; URL="https://github.com/nay-cat/Jarabel/releases/latest" },
    @{ Name="Luyten";                Desc="Open source Java decompiler GUI (Procyon)";   Category="Others";     Type="GitHub"; URL="https://github.com/deathmarine/Luyten/releases/latest" },
    @{ Name="VMAware";               Desc="Advanced VM detection library and tool";      Category="Others";     Type="GitHub"; URL="https://github.com/NotRequiem/VMAware/releases/latest" },
    @{ Name="Velociraptor";          Desc="Endpoint DFIR and threat hunting agent";      Category="Others";     Type="GitHub"; URL="https://github.com/Velocidex/velociraptor/releases/latest" },
    @{ Name="NTFS Parser";           Desc="NTFS forensics: MFT, Bitlocker, USN";        Category="Others";     Type="GitHub"; URL="https://github.com/thewhiteninja/ntfstool/releases/latest" },
    @{ Name="Hayabusa";              Desc="Fast forensics timeline generator";           Category="Others";     Type="Web";    URL="https://github.com/Yamato-Security/hayabusa/releases/download/v4.1.0/hayabusa-4.1.0-win-x64.zip" },
    @{ Name="Everything";            Desc="Instant filename search engine for Windows";  Category="Others";     Type="Link";   URL="https://www.voidtools.com/downloads/" },
    @{ Name="HxD";                   Desc="Fast hex editor with disk and RAM editing";   Category="Others";     Type="Link";   URL="https://mh-nexus.de/en/hxd/" },
    @{ Name="bstrings";              Desc="Searches strings with regex + YARA";          Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net/bstrings.zip" },
    @{ Name="JLECmd";                Desc="Parses Jump List files (CLI)";                Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net/JLECmd.zip" },
    @{ Name="JumpListExplorer";      Desc="GUI explorer for Jump List artefacts";        Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net/JumpListExplorer.zip" },
    @{ Name="MFTECmd";               Desc="Parses MFT, UsnJrnl, LogFile, Boot";         Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net/MFTECmd.zip" },
    @{ Name="PECmd";                 Desc="Parses Windows prefetch files (CLI)";         Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net/PECmd.zip" },
    @{ Name="RecentFileCacheParser"; Desc="Parses RecentFileCache.bcf artefact";         Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net/RecentFileCacheParser.zip" },
    @{ Name="RegistryExplorer";      Desc="GUI explorer for registry hives";             Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net/RegistryExplorer.zip" },
    @{ Name="ShellBagsExplorer";     Desc="GUI explorer for ShellBags artefacts";        Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net/ShellBagsExplorer.zip" },
    @{ Name="SrumECmd";              Desc="Parses SRUM database for usage data";         Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net/SrumECmd.zip" },
    @{ Name="TimelineExplorer";      Desc="GUI viewer for CSV timeline output";          Category="Zimmerman";  Type="Web";    URL="https://download.ericzimmermanstools.com/net/TimelineExplorer.zip" },
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
    @{ Name="LastActivityView";      Desc="Timeline of recent user/system actions";      Category="NirSoft";    Type="Web";    URL="https://www.nirsoft.net/utils/lastactivityview.zip" },
    @{ Name="NET 9.0";               Desc="Microsoft .NET 9 Desktop runtime";                Category="Dependencies"; Type="Web"; URL="https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/9.0.22/windowsdesktop-runtime-9.0.22-win-x64.exe" },
    @{ Name="NET 10.0";              Desc="Microsoft .NET 10 Desktop runtime";           Category="Dependencies"; Type="Web"; URL="https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/10.0.14/windowsdesktop-runtime-10.0.14-win-x64.exe" },
    @{ Name="VSRedist";              Desc="Visual C++ redistributable (x64)";            Category="Dependencies"; Type="Web"; URL="https://aka.ms/vs/17/release/vc_redist.x64.exe" }
)


# DISCLAIMER TEXT (shared by the GUI dialog and the console "Download All" flow)

$DisclaimerTitle = "CheesySSTool"
$DisclaimerLines = @(
    "All programs are downloaded automatically from their official GitHub repositories and saved in a neatly organized folder. None of your information is ever collected or modified."
    "Each tool is developed and maintained by its own author. I take no responsibility for anything that may be found regarding these tools in the future."
    "To continue, you must agree with everything stated above."
)


# CONSOLE WINDOW CONTROL (hide the console while the GUI is open, so no blank window sits behind it)

if (-not ([System.Management.Automation.PSTypeName]'CheesyNative.Win32').Type) {
    Add-Type -Namespace CheesyNative -Name Win32 -MemberDefinition @'
[DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
'@
}

function Set-ConsoleVisible {
    param([bool]$Visible)
    try {
        $h = [CheesyNative.Win32]::GetConsoleWindow()
        if ($h -ne [IntPtr]::Zero) { [void][CheesyNative.Win32]::ShowWindow($h, $(if ($Visible) { 5 } else { 0 })) }
    } catch {}
}


# CONSOLE: STARTUP CHOICE + DOWNLOAD ALL

function Show-StartupChoice {
    $host.UI.RawUI.WindowTitle = "CheesySSTool"
    Write-Host ""
    Write-Host "  =^.^=  CheesySSTool  -  by cheese cat" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  [1] Download All Tools"
    Write-Host "  [2] Open Menu"
    Write-Host ""
    while ($true) {
        $c = (Read-Host "  Choose 1 or 2").Trim()
        if ($c -eq '1' -or $c -eq '2') { return $c }
        Write-Host "  Please type 1 or 2." -ForegroundColor DarkYellow
    }
}

function Confirm-DisclaimerConsole {
    Write-Host ""
    Write-Host "  $DisclaimerTitle" -ForegroundColor Yellow
    Write-Host ""
    foreach ($line in $DisclaimerLines) {
        Write-Host "  $line"
        Write-Host ""
    }
    $a = (Read-Host "  Type Y to Accept & Continue, or anything else to Cancel").Trim()
    return ($a -match '^(y|yes)$')
}

# Finds the best .exe/.zip in a repo's latest GitHub release WITHOUT the GitHub API
# (the API allows only 60 requests/hour per IP, then returns 403). Uses the public
# /releases/latest redirect + the expanded_assets page; falls back to the API only if that fails.
# Kept as text so it can be loaded inside background runspaces.
$GitHubResolverCode = @'
function Resolve-GitHubLatestAsset {
    param([string]$Owner, [string]$Repo)
    $ua  = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) CheesySSTool"
    $tag = $null
    $url = "https://github.com/$Owner/$Repo/releases/latest"
    try {
        # Follow redirects by hand (handles renamed/moved repos) until we reach /releases/tag/<tag>
        for ($hop = 0; $hop -lt 4 -and -not $tag; $hop++) {
            $req = [System.Net.HttpWebRequest]::Create($url)
            $req.AllowAutoRedirect = $false
            $req.Method    = "HEAD"
            $req.UserAgent = $ua
            $resp = $req.GetResponse()
            try { $loc = $resp.Headers["Location"] } finally { $resp.Close() }
            if (-not $loc) { break }
            if ($loc.StartsWith('/')) { $loc = "https://github.com$loc" }
            if ($loc -match 'github\.com/([^/]+)/([^/]+)/releases/tag/([^/?#]+)') {
                $Owner = $Matches[1]; $Repo = $Matches[2]; $tag = $Matches[3]
            } else {
                $url = $loc
            }
        }
    } catch {}

    $urls = @()
    if ($tag) {
        try {
            $html = (Invoke-WebRequest -Uri "https://github.com/$Owner/$Repo/releases/expanded_assets/$tag" -UseBasicParsing -UserAgent $ua -ErrorAction Stop).Content
            $urls = @([regex]::Matches($html, 'href="(/[^"]+/releases/download/[^"]+)"') | ForEach-Object { "https://github.com" + [System.Net.WebUtility]::HtmlDecode($_.Groups[1].Value) })
        } catch {}
    }
    if ($urls.Count -eq 0) {
        $rel  = Invoke-RestMethod -Uri "https://api.github.com/repos/$Owner/$Repo/releases/latest" -Headers @{ "User-Agent" = $ua } -ErrorAction Stop
        $urls = @($rel.assets | ForEach-Object { $_.browser_download_url })
    }

    # Pick the best Windows x64 .exe/.zip/.exe.gz (first one wins on ties)
    $best = $null; $bestScore = [int]::MinValue
    foreach ($u in $urls) {
        $n = [Uri]::UnescapeDataString(($u -split '/')[-1])
        if ($n -notmatch '\.(zip|exe|exe\.gz)$') { continue }
        $score = 0
        if ($n -match 'win')                                       { $score += 10 }
        if ($n -match 'x64|amd64|win64|x86_64')                    { $score += 5 }
        if ($n -match '\.exe$')                                    { $score += 1 }
        if ($n -match '\.gz$')                                     { $score -= 2 }
        if ($n -match '(?<!win)32')                                { $score -= 6 }
        if ($n -match 'source|src|^cli\.zip$')                     { $score -= 15 }
        if ($n -match 'dbg|debug|symbols')                         { $score -= 8 }
        if ($n -match 'arm|i386|386|linux|darwin|macos|legacy')    { $score -= 20 }
        if ($score -gt $bestScore) { $best = @{ url = $u; name = $n }; $bestScore = $score }
    }
    if (-not $best) { throw "No .zip/.exe asset in the latest release." }
    return $best
}
'@
. ([scriptblock]::Create($GitHubResolverCode))

# Runs inside a background runspace: resolves, downloads and extracts ONE tool.
# Writes live byte counts into the shared $progress / $sizes arrays (one slot per tool).
$DownloadJob = {
    param($t, $i, $installDir, $progress, $sizes, $resolverCode)
    . ([scriptblock]::Create($resolverCode))

    $result = [pscustomobject]@{ Name = $t.Name; Status = 'OK'; Message = ''; Dir = $null; File = $null }
    $tmp = $null
    try {
        if ($t.Type -eq 'GitHub') {
            $parts    = $t.URL -replace "https://github.com/", "" -split "/"
            $asset    = Resolve-GitHubLatestAsset -Owner $parts[0] -Repo $parts[1]
            $dlUrl    = $asset.url
            $fileName = $asset.name
        } else {
            if ($t.URL -notmatch "\.(zip|exe|jar|msi)$") {
                $result.Status  = 'Skipped'
                $result.Message = 'not a direct download link'
                return $result
            }
            $dlUrl    = $t.URL
            $fileName = ($t.URL -split "/")[-1]
        }

        $destDir  = "$installDir\$($t.Category)\$($t.Name)"
        if (-not (Test-Path -LiteralPath $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
        $destFile = [System.IO.Path]::Combine($destDir, $fileName)
        $result.Dir  = $destDir
        $result.File = $destFile

        if (Test-Path -LiteralPath $destFile) {
            $result.Status = 'Cached'
        } else {
            $tmp = "$destFile.download"
            Add-Type -AssemblyName System.Net.Http
            $handler = New-Object System.Net.Http.HttpClientHandler
            $handler.AllowAutoRedirect = $true
            $client = New-Object System.Net.Http.HttpClient($handler)
            $client.Timeout = [TimeSpan]::FromMinutes(30)
            [void]$client.DefaultRequestHeaders.UserAgent.TryParseAdd("CheesySSTool")
            $HCO = [System.Net.Http.HttpCompletionOption]::ResponseHeadersRead
            try {
                # Probe: headers only, to learn size, range support and the final (post-redirect) URL
                $resp = $client.GetAsync($dlUrl, $HCO).GetAwaiter().GetResult()
                [void]$resp.EnsureSuccessStatusCode()
                $len      = $resp.Content.Headers.ContentLength
                $finalUrl = $resp.RequestMessage.RequestUri
                $ranges   = $resp.Headers.AcceptRanges -contains 'bytes'
                if ($len) { $sizes[$i] = [long]$len }

                $segmented = $false
                if ($ranges -and $len -and $len -ge 16MB) {
                    # Big file: split into parallel byte-range segments
                    $resp.Dispose(); $resp = $null
                    $segCount = 4
                    $pre = New-Object System.IO.FileStream($tmp, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write, [System.IO.FileShare]::ReadWrite)
                    $pre.SetLength([long]$len); $pre.Dispose()

                    $chunk = [long][Math]::Ceiling($len / $segCount)
                    $segs  = @()
                    try {
                        for ($s = 0; $s -lt $segCount; $s++) {
                            $from = [long]$s * $chunk
                            if ($from -ge $len) { break }
                            $to   = [Math]::Min([long]$len - 1, $from + $chunk - 1)
                            $req  = New-Object System.Net.Http.HttpRequestMessage([System.Net.Http.HttpMethod]::Get, $finalUrl)
                            $req.Headers.Range = New-Object System.Net.Http.Headers.RangeHeaderValue($from, $to)
                            $segs += [pscustomobject]@{ From = $from; Task = $client.SendAsync($req, $HCO); Resp = $null; Dst = $null; Copy = $null }
                        }
                        foreach ($sg in $segs) {
                            $sg.Resp = $sg.Task.GetAwaiter().GetResult()
                            if ([int]$sg.Resp.StatusCode -ne 206) { throw "Server ignored range request." }
                            $src    = $sg.Resp.Content.ReadAsStreamAsync().GetAwaiter().GetResult()
                            $sg.Dst = New-Object System.IO.FileStream($tmp, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Write, [System.IO.FileShare]::ReadWrite, 1048576)
                            [void]$sg.Dst.Seek($sg.From, [System.IO.SeekOrigin]::Begin)
                            $sg.Copy = $src.CopyToAsync($sg.Dst, 1048576)
                        }
                        $tasks = [System.Threading.Tasks.Task[]]@($segs | ForEach-Object { $_.Copy })
                        while (-not [System.Threading.Tasks.Task]::WaitAll($tasks, 150)) {
                            $sum = 0L
                            foreach ($sg in $segs) { try { $sum += ($sg.Dst.Position - $sg.From) } catch {} }
                            $progress[$i] = $sum
                        }
                        $progress[$i] = [long]$len
                        $segmented = $true
                    } catch {
                        if ($_.Exception.Message -notmatch 'range') { throw }
                        $progress[$i] = 0   # fall back to single stream below
                    } finally {
                        foreach ($sg in $segs) {
                            if ($sg.Dst)  { $sg.Dst.Dispose() }
                            if ($sg.Resp) { $sg.Resp.Dispose() }
                        }
                    }
                    if (-not $segmented) {
                        $resp = $client.GetAsync($finalUrl, $HCO).GetAwaiter().GetResult()
                        [void]$resp.EnsureSuccessStatusCode()
                    }
                }

                if (-not $segmented) {
                    # Small file (or no range support): single fast stream
                    $in  = $resp.Content.ReadAsStreamAsync().GetAwaiter().GetResult()
                    $out = New-Object System.IO.FileStream($tmp, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write, [System.IO.FileShare]::None, 1048576)
                    try {
                        $buf = New-Object byte[] 1048576
                        while (($n = $in.Read($buf, 0, $buf.Length)) -gt 0) {
                            $out.Write($buf, 0, $n)
                            $progress[$i] += $n
                        }
                    } finally { $out.Dispose(); $in.Dispose(); $resp.Dispose() }
                }
            } finally { $client.Dispose() }

            Move-Item -LiteralPath $tmp -Destination $destFile -Force -ErrorAction Stop
            $tmp = $null
        }

        if ($fileName -match "\.gz$") {
            # e.g. Velociraptor ships its Windows build as .exe.gz
            $gzOut = $destFile -replace '\.gz$', ''
            if (-not ($result.Status -eq 'Cached' -and (Test-Path -LiteralPath $gzOut))) {
                $inF  = [System.IO.File]::OpenRead($destFile)
                $gz   = New-Object System.IO.Compression.GZipStream($inF, [System.IO.Compression.CompressionMode]::Decompress)
                $outF = [System.IO.File]::Create($gzOut)
                try { $gz.CopyTo($outF) } finally { $outF.Dispose(); $gz.Dispose(); $inF.Dispose() }
            }
            $result.File = $gzOut
        }

        # A cached zip that was already unpacked doesn't need extracting again (makes re-launching instant)
        $alreadyExtracted = $false
        if ($fileName -match "\.zip$" -and $result.Status -eq 'Cached') {
            $alreadyExtracted = [bool](Get-ChildItem -LiteralPath $destDir -Recurse -File -ErrorAction SilentlyContinue |
                Where-Object { $_.FullName -ne $destFile } | Select-Object -First 1)
        }

        if ($fileName -match "\.zip$" -and -not $alreadyExtracted) {
            # Much faster than Expand-Archive on Windows PowerShell 5.1
            Add-Type -AssemblyName System.IO.Compression.FileSystem
            $root = [System.IO.Path]::GetFullPath($destDir).TrimEnd('\') + '\'
            $zip  = [System.IO.Compression.ZipFile]::OpenRead($destFile)
            try {
                foreach ($e in $zip.Entries) {
                    $target = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($destDir, $e.FullName))
                    if (-not $target.StartsWith($root, [StringComparison]::OrdinalIgnoreCase)) { continue }  # block path traversal
                    if ($e.FullName.EndsWith('/') -or $e.FullName.EndsWith('\')) {
                        [void][System.IO.Directory]::CreateDirectory($target)
                        continue
                    }
                    [void][System.IO.Directory]::CreateDirectory([System.IO.Path]::GetDirectoryName($target))
                    [System.IO.Compression.ZipFileExtensions]::ExtractToFile($e, $target, $true)
                }
            } finally { $zip.Dispose() }
        }
    } catch {
        $result.Status  = 'Failed'
        $ex = $_.Exception
        while ($ex.InnerException) { $ex = $ex.InnerException }
        $result.Message = $ex.Message
        if ($tmp -and (Test-Path -LiteralPath $tmp)) { Remove-Item -LiteralPath $tmp -Force -ErrorAction SilentlyContinue }
    }
    return $result
}

function Invoke-DownloadAllTools {
    param([switch]$IncludeDependencies)
    [Net.ServicePointManager]::SecurityProtocol      = [Net.SecurityProtocolType]::Tls12
    [Net.ServicePointManager]::DefaultConnectionLimit = 64     # default is 2 per host, which throttles parallel downloads
    [Net.ServicePointManager]::Expect100Continue      = $false

    # Balanced for typical home connections: enough parallelism to hide per-file latency,
    # few enough connections that each one gets a useful share of the bandwidth.
    $parallel = 6
    $tools    = @($ToolData | Where-Object { ($_.Type -eq 'GitHub' -or $_.Type -eq 'Web') -and ($IncludeDependencies -or $_.Category -ne 'Dependencies') })
    # Tools first, big dependency installers last
    $tools    = @($tools | Where-Object { $_.Category -ne 'Dependencies' }) + @($tools | Where-Object { $_.Category -eq 'Dependencies' })
    $total    = $tools.Count
    $progress = New-Object 'long[]' $total
    $sizes    = New-Object 'long[]' $total
    $ok = 0; $cached = 0; $skipped = @(); $failed = @(); $completed = 0

    $width = 100
    try { $width = $host.UI.RawUI.WindowSize.Width } catch {}
    if (-not $width -or $width -lt 50) { $width = 100 }

    Write-Host ""
    Write-Host "  Downloading $total tools ($parallel at a time) to: $installDir" -ForegroundColor Yellow
    Write-Host ""

    $pool = [runspacefactory]::CreateRunspacePool(1, $parallel)
    $pool.Open()
    $jobs = @()
    $sw   = [System.Diagnostics.Stopwatch]::StartNew()

    function Clear-BarLine { Write-Host -NoNewline ("`r" + (' ' * ($width - 1)) + "`r") }

    function Show-Bar {
        $frac = 0.0
        for ($k = 0; $k -lt $total; $k++) {
            if ($jobs[$k].Done)       { $frac += 1.0 }
            elseif ($sizes[$k] -gt 0) { $frac += [Math]::Min(1.0, $progress[$k] / [double]$sizes[$k]) }
        }
        $pct   = if ($total -gt 0) { $frac / $total } else { 1.0 }
        $bytes = 0; foreach ($p in $progress) { $bytes += $p }
        $secs  = [Math]::Max(0.1, $sw.Elapsed.TotalSeconds)
        $info  = "  {0,3}%  {1}/{2} tools  {3:N1} MB  {4:N1} MB/s" -f [int][Math]::Floor($pct * 100), $completed, $total, ($bytes / 1MB), (($bytes / 1MB) / $secs)
        $barLen = [Math]::Min(40, [Math]::Max(10, $width - $info.Length - 6))
        $fill   = [int][Math]::Round($pct * $barLen)
        $bar    = ([string][char]0x2588 * $fill) + ([string][char]0x2591 * ($barLen - $fill))
        $line   = "  [$bar]$info"
        if ($line.Length -gt $width - 1) { $line = $line.Substring(0, $width - 1) }
        Write-Host -NoNewline ("`r" + $line.PadRight($width - 1)) -ForegroundColor Yellow
    }

    try {
        try { [Console]::CursorVisible = $false } catch {}

        for ($i = 0; $i -lt $total; $i++) {
            $ps = [powershell]::Create()
            $ps.RunspacePool = $pool
            [void]$ps.AddScript($DownloadJob).AddArgument($tools[$i]).AddArgument($i).AddArgument($installDir).AddArgument($progress).AddArgument($sizes).AddArgument($GitHubResolverCode)
            $jobs += [pscustomobject]@{ PS = $ps; Handle = $ps.BeginInvoke(); Index = $i; Done = $false }
        }

        while ($completed -lt $total) {
            foreach ($j in $jobs) {
                if ($j.Done -or -not $j.Handle.IsCompleted) { continue }
                $j.Done = $true
                $completed++
                $r = $null
                try { $r = $j.PS.EndInvoke($j.Handle) | Select-Object -Last 1 } catch { $r = [pscustomobject]@{ Name = $tools[$j.Index].Name; Status = 'Failed'; Message = $_.Exception.Message } }
                if (-not $r) { $r = [pscustomobject]@{ Name = $tools[$j.Index].Name; Status = 'Failed'; Message = 'No result returned.' } }
                $j.PS.Dispose()

                Clear-BarLine
                switch ($r.Status) {
                    'OK'      { Write-Host "  OK       $($r.Name)" -ForegroundColor Green;                       $ok++ }
                    'Cached'  { Write-Host "  CACHED   $($r.Name)" -ForegroundColor DarkGreen;                   $ok++; $cached++ }
                    'Skipped' { Write-Host "  SKIPPED  $($r.Name) - $($r.Message)" -ForegroundColor DarkYellow; $skipped += $r.Name }
                    default   { Write-Host "  ERROR    $($r.Name) - $($r.Message)" -ForegroundColor Red;         $failed  += $r.Name }
                }
            }
            Show-Bar
            Start-Sleep -Milliseconds 120
        }
        Show-Bar
        Write-Host ""
    } finally {
        try { [Console]::CursorVisible = $true } catch {}
        foreach ($j in $jobs) { if (-not $j.Done) { try { $j.PS.Stop(); $j.PS.Dispose() } catch {} } }
        $pool.Close()
        $pool.Dispose()
    }

    Write-Host ("  Finished in {0:N1}s" -f $sw.Elapsed.TotalSeconds)
    Write-Host ""
    Write-Host "  ===== Summary =====" -ForegroundColor Yellow
    Write-Host ("  Succeeded: {0}  (of which already downloaded: {1})" -f $ok, $cached) -ForegroundColor Green
    if ($skipped.Count -gt 0) { Write-Host ("  Skipped:   {0}  ({1})" -f $skipped.Count, ($skipped -join ", ")) -ForegroundColor DarkYellow }
    if ($failed.Count  -gt 0) { Write-Host ("  Failed:    {0}  ({1})" -f $failed.Count,  ($failed  -join ", ")) -ForegroundColor Red }
    Write-Host "  Files saved to: $installDir"
    if ($IncludeDependencies) {
        Write-Host "  Installers in the Dependencies folder (.NET, VC++ Redist) were downloaded but not run - run them yourself if needed." -ForegroundColor DarkGray
    }
}

$startChoice = Show-StartupChoice
if ($startChoice -eq '1') {
    if (Confirm-DisclaimerConsole) {
        Write-Host ""
        $dep = (Read-Host "  Also download the dependency installers (.NET 9, .NET 10, VC++ Redist - about 140 MB)? (y/N)").Trim()
        Invoke-DownloadAllTools -IncludeDependencies:($dep -match '^(y|yes)$')
    } else {
        Write-Host ""
        Write-Host "  Cancelled. Nothing was downloaded." -ForegroundColor DarkYellow
    }
    Write-Host ""
    [void](Read-Host "  Press Enter to exit")
    exit
}


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

        <Style x:Key="PillBtn" TargetType="Button">
            <Setter Property="Background" Value="{StaticResource CardBg}"/>
            <Setter Property="Foreground" Value="{StaticResource TextMain}"/>
            <Setter Property="BorderBrush" Value="#3D2E00"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="Height" Value="36"/>
            <Setter Property="Padding" Value="14,0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Bd" Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="1" CornerRadius="6" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Bd" Property="BorderBrush" Value="#F5C200"/>
                            </Trigger>
                            <Trigger Property="IsEnabled" Value="False">
                                <Setter Property="Opacity" Value="0.45"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="PillToggle" TargetType="ToggleButton">
            <Setter Property="Background" Value="{StaticResource CardBg}"/>
            <Setter Property="Foreground" Value="{StaticResource TextMain}"/>
            <Setter Property="BorderBrush" Value="#3D2E00"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="Height" Value="36"/>
            <Setter Property="Padding" Value="14,0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="ToggleButton">
                        <Border x:Name="Bd" Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="1" CornerRadius="6" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Bd" Property="BorderBrush" Value="#F5C200"/>
                            </Trigger>
                            <Trigger Property="IsChecked" Value="True">
                                <Setter TargetName="Bd" Property="Background" Value="#F5C200"/>
                                <Setter TargetName="Bd" Property="BorderBrush" Value="#F5C200"/>
                                <Setter Property="Foreground" Value="#0F0B00"/>
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
                            <Grid.RowDefinitions>
                                <RowDefinition Height="Auto"/>
                                <RowDefinition Height="Auto"/>
                            </Grid.RowDefinitions>
                            <StackPanel>
                                <TextBlock x:Name="StatusTitle" Text="Ready" FontSize="20" FontWeight="SemiBold" Foreground="{StaticResource TextMain}"/>
                                <TextBlock x:Name="StatusSub"   Text="Select a tool to launch or download it." FontSize="11" Foreground="{StaticResource TextMuted}" TextTrimming="CharacterEllipsis"/>
                            </StackPanel>
                            <Border Grid.Column="1" Background="#1A3D1A" CornerRadius="4" Padding="10,4" VerticalAlignment="Center">
                                <TextBlock x:Name="StatusBadge" Text="IDLE" FontSize="12" FontWeight="Bold" Foreground="{StaticResource Accent}"/>
                            </Border>
                            <!-- Download progress (shown while menu downloads are running) -->
                            <Grid Grid.Row="1" Grid.ColumnSpan="2" x:Name="DlPanel" Visibility="Collapsed" Margin="0,8,0,0">
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <ProgressBar x:Name="DlBar" Height="8" Minimum="0" Maximum="100" Value="0" Foreground="#F5C200" Background="#0F0B00" BorderThickness="0" VerticalAlignment="Center"/>
                                <TextBlock Grid.Column="1" x:Name="DlText" Text="" FontFamily="Consolas" FontSize="11" Foreground="{StaticResource TextMuted}" Margin="12,0,0,0" VerticalAlignment="Center"/>
                            </Grid>
                        </Grid>
                    </Border>

                    <!-- Search bar -->
                    <Grid Grid.Row="2">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>
                    <ToggleButton Grid.Column="1" x:Name="DlOnlyBtn" Style="{StaticResource PillToggle}" Content="Downloaded (0)" Margin="8,0,0,0" ToolTip="Show only tools you have already downloaded"/>
                    <Border Grid.Column="0" x:Name="SearchBorder" Background="{StaticResource CardBg}" BorderBrush="#3D2E00" BorderThickness="1" CornerRadius="6" Padding="10,0">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="Auto"/>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="Auto"/>
                            </Grid.ColumnDefinitions>
                            <TextBlock Grid.Column="0" Text="&#xE721;" FontFamily="Segoe MDL2 Assets" FontSize="13" Foreground="{StaticResource TextMuted}" VerticalAlignment="Center" Margin="2,0,8,0"/>
                            <TextBlock Grid.Column="1" x:Name="SearchHint" Text="Search tools by name, description or category...  (Ctrl+F)" FontSize="12" Foreground="{StaticResource TextMuted}" VerticalAlignment="Center" IsHitTestVisible="False" Margin="3,0,0,0"/>
                            <TextBox Grid.Column="1" x:Name="SearchBox" Height="34" FontSize="12" Background="Transparent" Foreground="{StaticResource TextMain}" CaretBrush="#F5C200" SelectionBrush="#F5C200" BorderThickness="0" VerticalContentAlignment="Center"/>
                            <Button Grid.Column="2" x:Name="SearchClearBtn" Style="{StaticResource TitleBtn}" Width="30" Height="30" Content="X" FontSize="11" Visibility="Collapsed" ToolTip="Clear search (Esc)"/>
                        </Grid>
                    </Border>
                    </Grid>

                    <!-- Tab control -->
                    <TextBlock Grid.Row="4" x:Name="NoResultsBlock" Text="No tools match your search." FontSize="13" Foreground="{StaticResource TextMuted}" HorizontalAlignment="Center" VerticalAlignment="Center" Visibility="Collapsed" Panel.ZIndex="1"/>
                    <Border Grid.Row="4" Background="{StaticResource CardBg}" CornerRadius="6">
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
                    <Border Grid.Row="6" Background="{StaticResource ConsoleBg}" CornerRadius="6" Padding="12,8">
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
                           Text="$($DisclaimerLines[0])"/>
                <TextBlock TextWrapping="Wrap" Foreground="#FFF4C8" FontSize="13" Margin="0,0,0,16"
                           Text="$($DisclaimerLines[1])"/>
                <TextBlock TextWrapping="Wrap" Foreground="#FFF4C8" FontSize="13" FontWeight="SemiBold"
                           Text="$($DisclaimerLines[2])"/>
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

Set-ConsoleVisible $false
$disclaimerWindow.ShowDialog() | Out-Null

if (-not $script:disclaimerAccepted) {
    Set-ConsoleVisible $true
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
$SearchBox      = $window.FindName("SearchBox")
$SearchHint     = $window.FindName("SearchHint")
$SearchClearBtn = $window.FindName("SearchClearBtn")
$SearchBorder   = $window.FindName("SearchBorder")
$NoResultsBlock = $window.FindName("NoResultsBlock")
$DlOnlyBtn      = $window.FindName("DlOnlyBtn")
$DlPanel        = $window.FindName("DlPanel")
$DlBar          = $window.FindName("DlBar")
$DlText         = $window.FindName("DlText")

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

    $tempScript = [System.IO.Path]::Combine($env:TEMP, "cheesy_$([guid]::NewGuid().ToString('N')).ps1")
    Set-Content -LiteralPath $tempScript -Value $Command -Encoding UTF8 -Force

    # cmd /c start opens a new, separate, persistent console window.
    # This is the most reliable pattern on Windows for this purpose.
    $startArgs = '/c start "CheesySSTool" powershell.exe -NoExit -NoProfile -ExecutionPolicy Bypass -File "' + $tempScript + '"'
    Start-Process -FilePath "cmd.exe" -ArgumentList $startArgs -WindowStyle Hidden
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


# TOOL INFO (hover tooltip + right-click menu)

# Info pages for tools whose download link isn't a GitHub repo
$ToolPages = @{
    "FullEventLogView"     = "https://www.nirsoft.net/utils/full_event_log_view.html"
    "NetworkUsageView"     = "https://www.nirsoft.net/utils/network_usage_view.html"
    "BrowserDownloadsView" = "https://www.nirsoft.net/utils/web_browser_downloads_view.html"
    "AlternateStreamView"  = "https://www.nirsoft.net/utils/alternate_data_streams.html"
    "USBDeview"            = "https://www.nirsoft.net/utils/usb_devices_view.html"
    "OpenSaveFilesView"    = "https://www.nirsoft.net/utils/open_save_files_view.html"
    "ExecutedProgramsList" = "https://www.nirsoft.net/utils/executed_programs_list.html"
    "TaskSchedulerView"    = "https://www.nirsoft.net/utils/task_scheduler_view.html"
    "JumpListsView"        = "https://www.nirsoft.net/utils/jump_lists_view.html"
    "WinPrefetchView"      = "https://www.nirsoft.net/utils/win_prefetch_view.html"
    "RegScanner"           = "https://www.nirsoft.net/utils/regscanner.html"
    "ShellBagsView"        = "https://www.nirsoft.net/utils/shell_bags_view.html"
    "LastActivityView"     = "https://www.nirsoft.net/utils/computer_activity_view.html"
    "NET 9.0"              = "https://dotnet.microsoft.com/en-us/download/dotnet/9.0"
    "NET 10.0"             = "https://dotnet.microsoft.com/en-us/download/dotnet/10.0"
    "VSRedist"             = "https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist"
}

function Get-ToolPage {
    param($t)
    if ($ToolPages.ContainsKey($t.Name)) { return $ToolPages[$t.Name] }
    $u = if ($t.Type -eq "Cmd") { [regex]::Match($t.Command, "https://[^'`"\s)]+").Value } else { $t.URL }
    if ($u -match '^https://raw\.githubusercontent\.com/([^/]+)/([^/]+)/') { return "https://github.com/$($Matches[1])/$($Matches[2])" }
    if ($u -match '^https://github\.com/([^/]+)/([^/]+)')                 { return "https://github.com/$($Matches[1])/$($Matches[2])" }
    if ($u -match 'ericzimmermanstools\.com')                            { return "https://ericzimmerman.github.io/" }
    return $u
}

function Test-ToolDownloadable {
    param($t)
    return ($t.Type -eq "GitHub" -or ($t.Type -eq "Web" -and $t.URL -match '\.(zip|exe|jar|msi)$'))
}

function Get-ToolDir {
    param($t)
    return [System.IO.Path]::Combine($installDir, $t.Category, $t.Name)
}

function Test-ToolDownloaded {
    param($t)
    $dir = Get-ToolDir $t
    if (-not (Test-Path -LiteralPath $dir)) { return $false }
    return [bool](Get-ChildItem -LiteralPath $dir -Recurse -File -ErrorAction SilentlyContinue |
        Where-Object { $_.Extension -ne ".download" } | Select-Object -First 1)
}

function Format-Size {
    param([double]$Bytes)
    if ($Bytes -ge 1GB) { return "{0:N1} GB" -f ($Bytes / 1GB) }
    if ($Bytes -ge 1MB) { return "{0:N1} MB" -f ($Bytes / 1MB) }
    if ($Bytes -ge 1KB) { return "{0:N0} KB" -f ($Bytes / 1KB) }
    return "{0:N0} B" -f $Bytes
}

function Get-ToolTypeLabel {
    param($t)
    switch ($t.Type) {
        "GitHub" { return "GitHub release (always the latest version)" }
        "Web"    { if (Test-ToolDownloadable $t) { return "Direct download (" + [System.IO.Path]::GetExtension($t.URL) + ")" } else { return "Web page" } }
        "Link"   { return "Opens the website in your browser" }
        "Cmd"    { if ($t.Admin) { return "PowerShell script, runs in CMD as administrator" } else { return "PowerShell script, runs in CMD" } }
    }
    return $t.Type
}

# Remote download sizes are looked up lazily (first hover) in the background and cached
$script:SizeCache  = @{}
$script:SizeProbes = New-Object System.Collections.ArrayList
$SizeProbeJob = {
    param($t, $resolverCode)
    try {
        . ([scriptblock]::Create($resolverCode))
        $url = $t.URL
        if ($t.Type -eq "GitHub") {
            $p   = $t.URL -replace "https://github.com/", "" -split "/"
            $url = (Resolve-GitHubLatestAsset -Owner $p[0] -Repo $p[1]).url
        }
        $req = [System.Net.HttpWebRequest]::Create($url)
        $req.Method = "HEAD"; $req.UserAgent = "CheesySSTool"; $req.AllowAutoRedirect = $true; $req.Timeout = 15000
        $resp = $req.GetResponse()
        try { $len = $resp.ContentLength } finally { $resp.Close() }
        if ($len -gt 0) { return [long]$len }
    } catch {}
    return [long]-1
}


# MENU DOWNLOAD MANAGER
# Single-tool launches and "Download Selected" share one pool (6 at a time) and one progress bar.

[Net.ServicePointManager]::DefaultConnectionLimit = 64
[Net.ServicePointManager]::Expect100Continue      = $false
$script:GuiPool = [runspacefactory]::CreateRunspacePool(1, 6)
$script:GuiPool.Open()
$script:GuiJobs = New-Object System.Collections.ArrayList
$script:GuiSw   = $null
$ToolMeta = @{}   # tool name -> tile parts + state

function Set-TileDownloaded {
    param($meta)
    $meta.Downloaded = $meta.Downloadable -and (Test-ToolDownloaded $meta.Tool)
    $meta.Mark.Visibility = if ($meta.Downloaded) { "Visible" } else { "Collapsed" }
}

function Update-DownloadedMarks {
    foreach ($m in $ToolMeta.Values) { Set-TileDownloaded $m }
    Update-DownloadedCount
    Update-ToolSearch
}

function Update-DownloadedCount {
    $n = @($ToolMeta.Values | Where-Object { $_.Downloaded }).Count
    $DlOnlyBtn.Content = "Downloaded ($n)"
}

function Find-ToolLaunchable {
    param($t, [string]$Dir)
    $key = ($t.Name -replace '\s*\(.*\)$', '' -replace '[^A-Za-z0-9]', '')
    return Get-ChildItem -LiteralPath $Dir -Recurse -File -ErrorAction SilentlyContinue |
        Where-Object { $_.Extension -match '^\.(exe|cmd|bat|jar)$' } |
        Sort-Object @{ Expression = { if (($_.BaseName -replace '[^A-Za-z0-9]', '') -like "*$key*") { 0 } else { 1 } } },
                    @{ Expression = { if ($_.Extension -eq ".exe") { 0 } else { 1 } } },
                    @{ Expression = { ($_.FullName -split '\\').Count } },
                    FullName |
        Select-Object -First 1
}

function Start-GuiDownload {
    param([object[]]$Tools, [switch]$Launch)
    foreach ($t in $Tools) {
        $meta = $ToolMeta[$t.Name]
        if (@($script:GuiJobs | Where-Object { -not $_.Done -and $_.Tool.Name -eq $t.Name }).Count -gt 0) {
            Write-Log "$($t.Name) is already downloading."
            continue
        }
        $prog = New-Object 'long[]' 1
        $size = New-Object 'long[]' 1
        $ps = [powershell]::Create()
        $ps.RunspacePool = $script:GuiPool
        [void]$ps.AddScript($DownloadJob).AddArgument($t).AddArgument(0).AddArgument($installDir).AddArgument($prog).AddArgument($size).AddArgument($GitHubResolverCode)
        if ($meta) { $meta.Btn.IsEnabled = $false; $meta.Btn.Opacity = 0.6 }
        [void]$script:GuiJobs.Add([pscustomobject]@{ PS = $ps; Handle = $ps.BeginInvoke(); Tool = $t; Progress = $prog; Size = $size; Launch = [bool]$Launch; Done = $false; Status = "" })
    }
    if ($script:GuiJobs.Count -eq 0) { return }
    if (-not $script:GuiSw) { $script:GuiSw = [System.Diagnostics.Stopwatch]::StartNew() }
    $DlBar.Value = 0
    $DlPanel.Visibility = "Visible"
    $script:DlHideTimer.Stop()
    $script:DlTimer.Start()
}

function Complete-GuiDownload {
    param($j, $r)
    $t    = $j.Tool
    $meta = $ToolMeta[$t.Name]
    if ($meta) { $meta.Btn.IsEnabled = $true; $meta.Btn.Opacity = 1.0 }
    $j.Status = $r.Status

    switch ($r.Status) {
        "OK"      { Write-Log "Downloaded: $($t.Name)" }
        "Cached"  { Write-Log "Already downloaded: $($t.Name)" }
        "Skipped" {
            if ($j.Launch) { Write-Log "Opening $($t.Name) in browser."; Start-Process (Get-ToolPage $t); Set-Status "Browser" "Opened $($t.Name) in browser." "IDLE" }
            else           { Write-Log "Skipped $($t.Name) - $($r.Message)" }
            return
        }
        default {
            Write-Log "ERROR $($t.Name): $($r.Message)"
            if ($j.Launch) { Set-Status "Error" "Something went wrong with $($t.Name)." "ERR" }
            return
        }
    }
    if ($meta) { Set-TileDownloaded $meta; Update-DownloadedCount }

    if ($j.Launch) {
        try {
            $file = $r.File
            if ($file -and $file -notmatch '\.zip$' -and (Test-Path -LiteralPath $file)) {
                Write-Log "Launching $(Split-Path -Leaf $file)..."
                Start-AppOrScript -Path $file
            } else {
                $exe = Find-ToolLaunchable -t $t -Dir $r.Dir
                if ($exe) {
                    Write-Log "Launching $($exe.Name)..."
                    Start-AppOrScript -Path $exe.FullName -WorkingDirectory $exe.DirectoryName
                } else {
                    Write-Log "Nothing to launch in $($t.Name) - opening its folder."
                    Start-Process -FilePath explorer.exe -ArgumentList "`"$($r.Dir)`""
                }
            }
            Set-Status "Ready" "$($t.Name) launched successfully." "IDLE"
        } catch {
            $msg = $_.Exception.Message
            if ($msg -match 'canceled by the user') { $msg = "Administrator permission was declined." }
            Write-Log "Could not launch $($t.Name): $msg"
            Set-Status "Error" "Could not launch $($t.Name)." "ERR"
        }
    }
}

function Update-GuiDownloads {
    $jobs = @($script:GuiJobs)
    foreach ($j in $jobs) {
        if ($j.Done -or -not $j.Handle.IsCompleted) { continue }
        $j.Done = $true
        $r = $null
        try { $r = $j.PS.EndInvoke($j.Handle) | Select-Object -Last 1 } catch { $r = [pscustomobject]@{ Name = $j.Tool.Name; Status = "Failed"; Message = $_.Exception.Message } }
        if (-not $r) { $r = [pscustomobject]@{ Name = $j.Tool.Name; Status = "Failed"; Message = "No result returned." } }
        $j.PS.Dispose()
        Complete-GuiDownload $j $r
    }

    $total = $jobs.Count
    if ($total -eq 0) { $script:DlTimer.Stop(); return }
    $done  = @($jobs | Where-Object { $_.Done }).Count
    $frac  = 0.0; $bytes = 0L
    foreach ($j in $jobs) {
        $bytes += $j.Progress[0]
        if ($j.Done)                { $frac += 1.0 }
        elseif ($j.Size[0] -gt 0)   { $frac += [Math]::Min(1.0, $j.Progress[0] / [double]$j.Size[0]) }
    }
    $pct  = $frac / $total * 100
    $secs = [Math]::Max(0.1, $script:GuiSw.Elapsed.TotalSeconds)
    $DlBar.Value = $pct
    $DlText.Text = "{0,3:N0}%   {1}/{2} tools   {3}   {4:N1} MB/s" -f $pct, $done, $total, (Format-Size $bytes), (($bytes / 1MB) / $secs)

    if ($done -lt $total) {
        $active = @($jobs | Where-Object { -not $_.Done } | ForEach-Object { $_.Tool.Name })
        $more   = if ($active.Count -gt 3) { " +$($active.Count - 3) more" } else { "" }
        $StatusTitle.Text = "Downloading"
        $StatusSub.Text   = (($active | Select-Object -First 3) -join ", ") + $more
        $StatusBadge.Text = "BUSY"
        return
    }

    # Batch finished
    $script:DlTimer.Stop()
    $ok     = @($jobs | Where-Object { $_.Status -eq "OK" -or $_.Status -eq "Cached" }).Count
    $failed = @($jobs | Where-Object { $_.Status -ne "OK" -and $_.Status -ne "Cached" -and $_.Status -ne "Skipped" }).Count
    if (@($jobs | Where-Object { -not $_.Launch }).Count -gt 0) {
        $msg = "$ok of $total downloaded" + $(if ($failed) { ", $failed failed (see console below)" } else { "" }) + ("  -  {0:N0}s" -f $secs)
        Write-Log "Batch finished: $msg"
        Set-Status $(if ($failed) { "Finished with errors" } else { "Download complete" }) $msg $(if ($failed) { "ERR" } else { "IDLE" })
    }
    $script:GuiJobs.Clear()
    $script:GuiSw = $null
    Update-DownloadedCount
    Update-ToolSearch
    $script:DlHideTimer.Start()
}

$script:DlTimer = New-Object System.Windows.Threading.DispatcherTimer
$script:DlTimer.Interval = [TimeSpan]::FromMilliseconds(150)
$script:DlTimer.Add_Tick({ Update-GuiDownloads })

# Hide the progress bar a few seconds after everything finishes
$script:DlHideTimer = New-Object System.Windows.Threading.DispatcherTimer
$script:DlHideTimer.Interval = [TimeSpan]::FromSeconds(4)
$script:DlHideTimer.Add_Tick({
    $script:DlHideTimer.Stop()
    if ($script:GuiJobs.Count -eq 0) { $DlPanel.Visibility = "Collapsed" }
})

# Picks up finished size look-ups and writes them into the open tooltip
$script:ProbeTimer = New-Object System.Windows.Threading.DispatcherTimer
$script:ProbeTimer.Interval = [TimeSpan]::FromMilliseconds(250)
$script:ProbeTimer.Add_Tick({
    foreach ($pr in @($script:SizeProbes)) {
        if (-not $pr.Handle.IsCompleted) { continue }
        $len = -1
        try { $len = [long]($pr.PS.EndInvoke($pr.Handle) | Select-Object -Last 1) } catch {}
        $pr.PS.Dispose()
        $txt = if ($len -gt 0) { Format-Size $len } else { "unknown" }
        $script:SizeCache[$pr.Name] = $txt
        $pr.Line.Text = "Download size: $txt"
        $script:SizeProbes.Remove($pr)
    }
    if ($script:SizeProbes.Count -eq 0) { $script:ProbeTimer.Stop() }
})

function Update-ToolTipInfo {
    param($meta)
    $t = $meta.Tool
    if ($meta.Downloadable) {
        if (Test-ToolDownloaded $t) {
            $sum = (Get-ChildItem -LiteralPath (Get-ToolDir $t) -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
            $meta.TipStatus.Text = "Status: downloaded  ($(Format-Size $sum) on disk)"
        } else {
            $meta.TipStatus.Text = "Status: not downloaded yet"
        }
        if ($script:SizeCache.ContainsKey($t.Name)) {
            $meta.TipSize.Text = "Download size: $($script:SizeCache[$t.Name])"
        } elseif (@($script:SizeProbes | Where-Object { $_.Name -eq $t.Name }).Count -eq 0) {
            $meta.TipSize.Text = "Download size: checking..."
            $ps = [powershell]::Create()
            $ps.RunspacePool = $script:GuiPool
            [void]$ps.AddScript($SizeProbeJob).AddArgument($t).AddArgument($GitHubResolverCode)
            [void]$script:SizeProbes.Add([pscustomobject]@{ Name = $t.Name; PS = $ps; Handle = $ps.BeginInvoke(); Line = $meta.TipSize })
            $script:ProbeTimer.Start()
        }
    }
}

$bc = [Windows.Media.BrushConverter]::new()
function New-Pill {
    param([string]$Text, [string]$Bg, [string]$Fg)
    $pb = New-Object System.Windows.Controls.Border
    $pb.Background   = $bc.ConvertFrom($Bg)
    $pb.CornerRadius = 3
    $pb.Padding      = "5,1"
    $pb.Margin       = "4,0,0,0"
    $pt = New-Object System.Windows.Controls.TextBlock
    $pt.Text       = $Text
    $pt.FontSize   = 9
    $pt.FontWeight = "Bold"
    $pt.Foreground = $bc.ConvertFrom($Fg)
    $pb.Child = $pt
    return $pb
}


# TABS

$Categories =@("Orbdiff","Spokwn","Tonynoh","Praiselily","Zimmerman","NirSoft","Dependencies","Others")

foreach ($cat in $Categories) {
    $tab = New-Object System.Windows.Controls.TabItem
    $tab.Header = $cat
    $tab.Tag    = $cat

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

        $btn.Uid = $t.Name   # tool lookup key (click handler, search, selection)
        $downloadable = Test-ToolDownloadable $t

        # Tile layout: name + description on top, badges bottom-right
        $tileGrid = New-Object System.Windows.Controls.Grid
        $tileGrid.Width  = 192
        $tileGrid.Height = 68
        $r0 = New-Object System.Windows.Controls.RowDefinition; $r0.Height = "*"
        $r1 = New-Object System.Windows.Controls.RowDefinition; $r1.Height = "Auto"
        $tileGrid.RowDefinitions.Add($r0); $tileGrid.RowDefinitions.Add($r1)

        $btnStack = New-Object System.Windows.Controls.StackPanel
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
        $descBlock.TextTrimming = "CharacterEllipsis"
        $descBlock.MaxHeight = 28
        $btnStack.Children.Add($nameBlock) | Out-Null
        $btnStack.Children.Add($descBlock) | Out-Null
        $tileGrid.Children.Add($btnStack) | Out-Null

        # Badges: Downloaded / Admin
        $badgeRow = New-Object System.Windows.Controls.StackPanel
        $badgeRow.Orientation = "Horizontal"
        $badgeRow.HorizontalAlignment = "Right"
        [System.Windows.Controls.Grid]::SetRow($badgeRow, 1)
        $mark = New-Pill -Text ([string][char]0x2713 + " Downloaded") -Bg "#1E3A1E" -Fg "#6EE7A0"
        $mark.Visibility = "Collapsed"
        $badgeRow.Children.Add($mark) | Out-Null
        if ($t.Admin) { $badgeRow.Children.Add((New-Pill -Text "ADMIN" -Bg "#3A1E1E" -Fg "#FF9B8A")) | Out-Null }
        $tileGrid.Children.Add($badgeRow) | Out-Null

        $btn.Content = $tileGrid

        # Hover info tooltip
        $page = Get-ToolPage $t
        $tip = New-Object System.Windows.Controls.ToolTip
        $tip.Background  = $bc.ConvertFrom("#1A1200")
        $tip.BorderBrush = $bc.ConvertFrom("#A07800")
        $tip.Foreground  = $bc.ConvertFrom("#FFF4C8")
        $tip.Padding     = "10,8"
        $tipStack = New-Object System.Windows.Controls.StackPanel
        $tipStack.MaxWidth = 380
        $tipLines = @(
            @{ T = $t.Name;                             S = 13; B = $true;  C = "#F5C200" },
            @{ T = $t.Desc;                             S = 11; B = $false; C = "#FFF4C8" },
            @{ T = "Type: " + (Get-ToolTypeLabel $t);   S = 11; B = $false; C = "#C8B070" },
            @{ T = "Source: $page";                     S = 11; B = $false; C = "#C8B070" }
        )
        foreach ($ln in $tipLines) {
            $tb = New-Object System.Windows.Controls.TextBlock
            $tb.Text = $ln.T; $tb.FontSize = $ln.S; $tb.TextWrapping = "Wrap"; $tb.Margin = "0,1,0,1"
            $tb.Foreground = $bc.ConvertFrom($ln.C)
            if ($ln.B) { $tb.FontWeight = "SemiBold" }
            $tipStack.Children.Add($tb) | Out-Null
        }
        $tipSize   = New-Object System.Windows.Controls.TextBlock; $tipSize.FontSize = 11;   $tipSize.Foreground = $bc.ConvertFrom("#C8B070")
        $tipStatus = New-Object System.Windows.Controls.TextBlock; $tipStatus.FontSize = 11; $tipStatus.Foreground = $bc.ConvertFrom("#C8B070")
        if ($downloadable) { $tipStack.Children.Add($tipSize) | Out-Null; $tipStack.Children.Add($tipStatus) | Out-Null }
        $hint = New-Object System.Windows.Controls.TextBlock
        $hint.Text = "Right-click for more options"; $hint.FontSize = 10; $hint.Margin = "0,6,0,0"; $hint.Foreground = $bc.ConvertFrom("#907830")
        $tipStack.Children.Add($hint) | Out-Null
        $tip.Content = $tipStack
        $btn.ToolTip = $tip
        [System.Windows.Controls.ToolTipService]::SetShowDuration($btn, 30000)
        [System.Windows.Controls.ToolTipService]::SetInitialShowDelay($btn, 600)
        [System.Windows.Controls.ToolTipService]::SetShowOnDisabled($btn, $true)
        $btn.Add_ToolTipOpening({ $m = $ToolMeta[$this.Uid]; if ($m) { Update-ToolTipInfo $m } })

        # Right-click menu
        $menu = New-Object System.Windows.Controls.ContextMenu
        $menu.Background  = $bc.ConvertFrom("#1A1200")
        $menu.Foreground  = $bc.ConvertFrom("#FFF4C8")
        $menu.BorderBrush = $bc.ConvertFrom("#A07800")
        $miPage = New-Object System.Windows.Controls.MenuItem
        $miPage.Header = $(if ($page -match 'github\.com') { "Open GitHub page" } else { "Open website" })
        $miPage.Tag = $t.Name
        $miPage.Add_Click({ $tt = $ToolMeta[$this.Tag].Tool; Start-Process (Get-ToolPage $tt); Write-Log "Opened page for $($tt.Name)." })
        $menu.Items.Add($miPage) | Out-Null
        if ($downloadable) {
            $miFolder = New-Object System.Windows.Controls.MenuItem
            $miFolder.Header = "Open download folder"
            $miFolder.Tag = $t.Name
            $miFolder.Add_Click({
                $tt = $ToolMeta[$this.Tag].Tool
                $d  = Get-ToolDir $tt
                if (Test-Path -LiteralPath $d) { Start-Process -FilePath explorer.exe -ArgumentList "`"$d`"" }
                else { Write-Log "$($tt.Name) hasn't been downloaded yet." }
            })
            $menu.Items.Add($miFolder) | Out-Null
        }
        $miCopy = New-Object System.Windows.Controls.MenuItem
        $miCopy.Header = "Copy link"
        $miCopy.Tag = $t.Name
        $miCopy.Add_Click({ $tt = $ToolMeta[$this.Tag].Tool; [System.Windows.Clipboard]::SetText((Get-ToolPage $tt)); Write-Log "Copied link for $($tt.Name)." })
        $menu.Items.Add($miCopy) | Out-Null
        $btn.ContextMenu = $menu

        $ToolMeta[$t.Name] = [pscustomobject]@{
            Tool = $t; Btn = $btn; Mark = $mark; Tab = $tab
            Downloadable = $downloadable; Downloaded = $false
            TipSize = $tipSize; TipStatus = $tipStatus
        }

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
            if ($clickedBtn -isnot [System.Windows.Controls.Button]) { return }
            $tName      = $clickedBtn.Uid
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
                            # Open in a cmd.exe window (cmd /k keeps it open); PowerShell runs the script inside it
                            $cmdArgs = '/k powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "' + $cmd + '"'
                            if ($timerData.Admin) {
                                # Script needs admin rights: open the CMD window elevated (Windows shows a UAC prompt)
                                Write-LogBg "$timerName needs admin - asking for administrator permission..."
                                Start-Process "cmd.exe" -ArgumentList $cmdArgs -Verb RunAs -ErrorAction Stop
                                Write-LogBg "Launched as administrator: $timerName"
                            } else {
                                Start-Process "cmd.exe" -ArgumentList $cmdArgs
                                Write-LogBg "Launched: $timerName"
                            }
                            Set-StatusBg "Ready" "$timerName launched." "IDLE"
                        } catch {
                            $em = "$_"
                            if ($em -match 'canceled by the user') { $em = "Administrator permission was declined." }
                            Write-LogBg "Error: $em"
                            Set-StatusBg "Error" "Failed to launch $timerName." "ERR"
                        }
                        $dispatcher.Invoke([Action]{ $timerBtn.IsEnabled = $true })
                    })
                    $null = $psc.BeginInvoke()
                } else {
                    # Download (or reuse the cached copy) in the background with live progress, then launch it
                    Set-Status "Downloading" "Fetching $script:timerName..." "BUSY"
                    Write-Log "Starting download: $script:timerName"
                    Start-GuiDownload -Tools @($script:timerData) -Launch
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


# SEARCH
# Filters tool buttons across every tab. All words must match (name, description or category).
# Tabs with no matches are hidden and show a match count while searching.

function Update-ToolSearch {
    $q     = $SearchBox.Text.Trim()
    $terms = @($q -split '\s+' | Where-Object { $_ })
    $SearchHint.Visibility     = if ($SearchBox.Text.Length -gt 0) { "Collapsed" } else { "Visible" }
    $SearchClearBtn.Visibility = if ($SearchBox.Text.Length -gt 0) { "Visible" } else { "Collapsed" }

    $dlOnly    = [bool]$DlOnlyBtn.IsChecked
    $filtering = ($terms.Count -gt 0) -or $dlOnly

    $total = 0
    foreach ($tab in $ToolsTab.Items) {
        $count = 0
        foreach ($b in $tab.Content.Content.Children) {
            $m     = $ToolMeta[$b.Uid]
            $hay   = "$($m.Tool.Name) $($m.Tool.Desc) $($tab.Tag)"
            $match = (-not $dlOnly) -or $m.Downloaded
            if ($match) {
                foreach ($term in $terms) {
                    if ($hay.IndexOf($term, [StringComparison]::OrdinalIgnoreCase) -lt 0) { $match = $false; break }
                }
            }
            $b.Visibility = if ($match) { "Visible" } else { "Collapsed" }
            if ($match) { $count++ }
        }
        $total += $count
        if ($filtering) {
            $tab.Header     = "$($tab.Tag) ($count)"
            $tab.Visibility = if ($count -gt 0) { "Visible" } else { "Collapsed" }
        } else {
            $tab.Header     = $tab.Tag
            $tab.Visibility = "Visible"
        }
    }

    # Keep the selection on a tab that still has results
    $sel = $ToolsTab.SelectedItem
    if (-not $sel -or $sel.Visibility -ne "Visible") {
        $first = $ToolsTab.Items | Where-Object { $_.Visibility -eq "Visible" } | Select-Object -First 1
        if ($first) { $ToolsTab.SelectedItem = $first }
    }

    $ToolsTab.Visibility       = if ($total -gt 0) { "Visible" } else { "Hidden" }
    $NoResultsBlock.Visibility = if ($total -gt 0) { "Collapsed" } else { "Visible" }
    if ($total -eq 0) {
        $NoResultsBlock.Text = if ($dlOnly -and $terms.Count -eq 0) { "No downloaded tools yet." }
                               elseif ($dlOnly) { "No downloaded tools match `"$q`"." }
                               else { "No tools match `"$q`"." }
    }
}

$DlOnlyBtn.Add_Checked({ Update-ToolSearch })
$DlOnlyBtn.Add_Unchecked({ Update-ToolSearch })

# Initial downloaded marks
Update-DownloadedMarks

$SearchBox.Add_TextChanged({ Update-ToolSearch })
$SearchBox.Add_GotKeyboardFocus({ $SearchBorder.BorderBrush = [Windows.Media.BrushConverter]::new().ConvertFrom("#F5C200") })
$SearchBox.Add_LostKeyboardFocus({ $SearchBorder.BorderBrush = [Windows.Media.BrushConverter]::new().ConvertFrom("#3D2E00") })
$SearchBox.Add_PreviewKeyDown({
    if ($_.Key -eq [System.Windows.Input.Key]::Escape) { $SearchBox.Clear(); $_.Handled = $true }
})
$SearchClearBtn.Add_Click({ $SearchBox.Clear(); $SearchBox.Focus() | Out-Null })
$window.Add_PreviewKeyDown({
    if ($_.Key -eq [System.Windows.Input.Key]::F -and
        ([System.Windows.Input.Keyboard]::Modifiers -band [System.Windows.Input.ModifierKeys]::Control)) {
        $SearchBox.Focus() | Out-Null; $SearchBox.SelectAll(); $_.Handled = $true
    }
})


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
$CloseBtn.Add_Click({
    $catTimer.Stop(); $script:DlTimer.Stop(); $script:ProbeTimer.Stop()
    if (@($script:GuiJobs | Where-Object { -not $_.Done }).Count -gt 0) {
        $ans = [System.Windows.MessageBox]::Show("Downloads are still running. Close anyway? Unfinished downloads will be cancelled.", "CheesySSTool", "YesNo", "Warning")
        if ($ans -ne "Yes") { $catTimer.Start(); $script:DlTimer.Start(); return }
    }
    $window.Close()
})
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
        Update-DownloadedMarks
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

# Cancel anything still running and free the download pool
foreach ($j in @($script:GuiJobs)) { if (-not $j.Done) { try { $j.PS.Stop(); $j.PS.Dispose() } catch {} } }
foreach ($pr in @($script:SizeProbes)) { try { $pr.PS.Stop(); $pr.PS.Dispose() } catch {} }
try { $script:GuiPool.Close(); $script:GuiPool.Dispose() } catch {}
Set-ConsoleVisible $true
