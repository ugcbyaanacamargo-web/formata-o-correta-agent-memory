#requires -version 5.1
<#
.SYNOPSIS
  FORMATAÇÃO CORRETA — FASE 1 / SCRIPT 1
  Coleta definitiva de plataforma persistente, BIOS/UEFI, firmware e segurança.

.DESCRIPTION
  SOMENTE LEITURA em relação à configuração do notebook.

  NÃO ALTERA BIOS.
  NÃO limpa TPM/PTT.
  NÃO altera Secure Boot ou suas chaves.
  NÃO altera SATA Mode.
  NÃO instala/remove drivers.
  NÃO grava firmware.
  NÃO apaga SSD/partições.
  NÃO altera Registro/Bcd/NVRAM.

  O script apenas lê o estado atual e grava os relatórios em uma pasta nova
  no Desktop, depois cria um ZIP único para análise.

  Alvo do projeto: Lenovo IdeaPad 320-15IKB Type 80YH / NM-B242.
#>

[CmdletBinding()]
param()

$ErrorActionPreference = 'Continue'
$ProgressPreference = 'SilentlyContinue'
$StartTime = Get-Date

function Test-IsAdministrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdministrator)) {
    Write-Host 'ERRO: abra o Windows PowerShell como Administrador e execute novamente.' -ForegroundColor Red
    exit 1
}

$Timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$Desktop = [Environment]::GetFolderPath('Desktop')
$Root = Join-Path $Desktop "FORMACAO_CORRETA_FASE1_80YH_$Timestamp"
$Raw = Join-Path $Root 'raw'
$Events = Join-Path $Root 'events'
$SecureBootDir = Join-Path $Root 'secureboot'
$BiosDir = Join-Path $Root 'bios'
$FirmwareDir = Join-Path $Root 'firmware'
$Status = New-Object System.Collections.Generic.List[object]

New-Item -ItemType Directory -Force -Path $Root,$Raw,$Events,$SecureBootDir,$BiosDir,$FirmwareDir | Out-Null

function Add-CollectorStatus {
    param(
        [string]$Name,
        [string]$State,
        [string]$Detail = ''
    )
    $Status.Add([pscustomobject]@{
        collector = $Name
        status = $State
        detail = $Detail
        timestamp = (Get-Date).ToString('o')
    }) | Out-Null
}

function Save-Text {
    param(
        [string]$Path,
        [object]$Value
    )
    $Value | Out-String -Width 4096 | Set-Content -Path $Path -Encoding UTF8
}

function Invoke-Collector {
    param(
        [string]$Name,
        [scriptblock]$ScriptBlock,
        [string]$Path
    )
    try {
        $result = & $ScriptBlock 2>&1
        Save-Text -Path $Path -Value $result
        Add-CollectorStatus -Name $Name -State 'PASS' -Detail $Path
        return $result
    }
    catch {
        Save-Text -Path ($Path + '.error.txt') -Value $_
        Add-CollectorStatus -Name $Name -State 'WARN' -Detail $_.Exception.Message
        return $null
    }
}

function Invoke-NativeCapture {
    param(
        [string]$Name,
        [string]$Command,
        [string[]]$Arguments,
        [string]$Path
    )
    try {
        $cmd = Get-Command $Command -ErrorAction Stop
        $output = & $cmd.Source @Arguments 2>&1
        $exitCode = $LASTEXITCODE
        Save-Text -Path $Path -Value $output
        if ($null -eq $exitCode -or $exitCode -eq 0) {
            Add-CollectorStatus -Name $Name -State 'PASS' -Detail $Path
        }
        else {
            Add-CollectorStatus -Name $Name -State 'WARN' -Detail "exit=$exitCode; $Path"
        }
        return $output
    }
    catch {
        Save-Text -Path ($Path + '.error.txt') -Value $_
        Add-CollectorStatus -Name $Name -State 'WARN' -Detail $_.Exception.Message
        return $null
    }
}

function Export-EventSlice {
    param(
        [string]$Name,
        [hashtable]$Filter,
        [string]$Path,
        [int]$MaxEvents = 3000
    )
    try {
        $records = @(Get-WinEvent -FilterHashtable $Filter -MaxEvents $MaxEvents -ErrorAction Stop |
            Select-Object TimeCreated,Id,LevelDisplayName,ProviderName,LogName,RecordId,Message)
        $records | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $Path
        Add-CollectorStatus -Name $Name -State 'PASS' -Detail "$($records.Count) eventos"
        return $records
    }
    catch {
        Save-Text -Path ($Path + '.error.txt') -Value $_
        Add-CollectorStatus -Name $Name -State 'WARN' -Detail $_.Exception.Message
        return @()
    }
}

function Get-ReadableByteStrings {
    param([byte[]]$Bytes)
    if (-not $Bytes -or $Bytes.Length -eq 0) { return @() }

    $found = New-Object System.Collections.Generic.List[string]
    try {
        $ascii = [Text.Encoding]::ASCII.GetString($Bytes)
        foreach ($m in [regex]::Matches($ascii,'[\x20-\x7E]{6,}')) {
            $v = $m.Value.Trim()
            if ($v) { $found.Add($v) | Out-Null }
        }
    } catch {}

    try {
        $unicode = [Text.Encoding]::Unicode.GetString($Bytes)
        foreach ($m in [regex]::Matches($unicode,'[\x20-\x7E]{6,}')) {
            $v = $m.Value.Trim()
            if ($v) { $found.Add($v) | Out-Null }
        }
    } catch {}

    return $found | Sort-Object -Unique
}

function Save-SecureBootVariable {
    param([string]$Name)

    $safeName = $Name -replace '[^A-Za-z0-9_.-]','_'
    try {
        $variable = Get-SecureBootUEFI -Name $Name -ErrorAction Stop
        $length = 0
        if ($variable.Bytes) { $length = $variable.Bytes.Length }

        [pscustomobject]@{
            Name = $variable.Name
            Bytes = $length
            Attributes = ($variable.Attributes -join '; ')
        } | Export-Csv -NoTypeInformation -Encoding UTF8 -Path (Join-Path $SecureBootDir "$safeName-meta.csv")

        if ($variable.Bytes -and $length -gt 0) {
            $binPath = Join-Path $SecureBootDir "$safeName.bin"
            [IO.File]::WriteAllBytes($binPath,[byte[]]$variable.Bytes)
            Get-ReadableByteStrings -Bytes ([byte[]]$variable.Bytes) |
                Set-Content -Path (Join-Path $SecureBootDir "$safeName-readable-strings.txt") -Encoding UTF8

            $knownMarkers = @(
                'Microsoft Corporation KEK CA 2011',
                'Microsoft Corporation KEK 2K CA 2023',
                'Microsoft Windows Production PCA 2011',
                'Windows UEFI CA 2023',
                'Microsoft UEFI CA 2011',
                'Microsoft UEFI CA 2023',
                'Microsoft Option ROM UEFI CA 2023'
            )

            $asciiData = [Text.Encoding]::ASCII.GetString([byte[]]$variable.Bytes)
            $unicodeData = [Text.Encoding]::Unicode.GetString([byte[]]$variable.Bytes)
            $markerRows = foreach ($marker in $knownMarkers) {
                [pscustomobject]@{
                    Variable = $Name
                    Marker = $marker
                    FoundASCII = ($asciiData.IndexOf($marker,[StringComparison]::OrdinalIgnoreCase) -ge 0)
                    FoundUnicode = ($unicodeData.IndexOf($marker,[StringComparison]::OrdinalIgnoreCase) -ge 0)
                }
            }
            $markerRows | Export-Csv -NoTypeInformation -Encoding UTF8 -Path (Join-Path $SecureBootDir "$safeName-known-markers.csv")
        }

        Add-CollectorStatus -Name "SecureBoot variable $Name" -State 'PASS' -Detail "$length bytes"
    }
    catch {
        Save-Text -Path (Join-Path $SecureBootDir "$safeName-error.txt") -Value $_
        Add-CollectorStatus -Name "SecureBoot variable $Name" -State 'WARN' -Detail $_.Exception.Message
    }
}

$ScriptPath = $MyInvocation.MyCommand.Path
$ScriptHash = $null
if ($ScriptPath -and (Test-Path $ScriptPath)) {
    try { $ScriptHash = (Get-FileHash -Algorithm SHA256 -Path $ScriptPath -ErrorAction Stop).Hash } catch {}
}

Invoke-Collector -Name 'Execution environment' -Path (Join-Path $Raw 'execution-environment.txt') -ScriptBlock {
    "StartTime = $($StartTime.ToString('o'))"
    "ComputerName = $env:COMPUTERNAME"
    "User = $env:USERDOMAIN\$env:USERNAME"
    "PowerShell = $($PSVersionTable.PSVersion)"
    "ScriptPath = $ScriptPath"
    "ScriptSHA256 = $ScriptHash"
} | Out-Null

Invoke-Collector -Name 'Computer system' -Path (Join-Path $Raw 'computer-system.txt') -ScriptBlock { Get-CimInstance Win32_ComputerSystem | Format-List * } | Out-Null
Invoke-Collector -Name 'Computer system product' -Path (Join-Path $Raw 'computer-system-product.txt') -ScriptBlock { Get-CimInstance Win32_ComputerSystemProduct | Format-List * } | Out-Null
Invoke-Collector -Name 'Baseboard' -Path (Join-Path $Raw 'baseboard.txt') -ScriptBlock { Get-CimInstance Win32_BaseBoard | Format-List * } | Out-Null
Invoke-Collector -Name 'BIOS' -Path (Join-Path $BiosDir 'win32-bios.txt') -ScriptBlock { Get-CimInstance Win32_BIOS | Format-List * } | Out-Null
Invoke-Collector -Name 'ComputerInfo BIOS/platform' -Path (Join-Path $BiosDir 'computerinfo.txt') -ScriptBlock { Get-ComputerInfo | Format-List * } | Out-Null

Invoke-Collector -Name 'Firmware boot type' -Path (Join-Path $BiosDir 'firmware-type.txt') -ScriptBlock {
    if (-not ('FirmwareNative.Methods' -as [type])) {
        Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
namespace FirmwareNative {
    public static class Methods {
        [DllImport("kernel32.dll", SetLastError=true)]
        public static extern bool GetFirmwareType(out UInt32 firmwareType);
    }
}
'@
    }
    [uint32]$fwType = 0
    $ok = [FirmwareNative.Methods]::GetFirmwareType([ref]$fwType)
    $fwTypeName = switch ($fwType) { 1 {'BIOS'} 2 {'UEFI'} default {'Unknown'} }
    $fwLastError = 0
    if (-not $ok) { $fwLastError = [Runtime.InteropServices.Marshal]::GetLastWin32Error() }
    [pscustomobject]@{ Success=$ok; FirmwareTypeNumeric=$fwType; FirmwareType=$fwTypeName; LastWin32Error=$fwLastError } | Format-List
} | Out-Null

Invoke-Collector -Name 'Lenovo WMI class inventory' -Path (Join-Path $BiosDir 'lenovo-wmi-classes.txt') -ScriptBlock {
    Get-CimClass -Namespace root\wmi -ErrorAction Stop | Where-Object { $_.CimClassName -like 'Lenovo*' } | Select-Object CimClassName | Sort-Object CimClassName | Format-Table -AutoSize
} | Out-Null

$LenovoSettingsCsv = Join-Path $BiosDir 'lenovo-bios-settings.csv'
try {
    $biosSettings = @(Get-WmiObject -Namespace root\wmi -Class Lenovo_BiosSetting -ErrorAction Stop | Where-Object { $_.CurrentSetting })
    $settingRows = foreach ($entry in $biosSettings) {
        $parts = [string]$entry.CurrentSetting -split ',',2
        [pscustomobject]@{ Item=$parts[0]; Value=$(if ($parts.Count -gt 1) { $parts[1] } else { '' }); Raw=[string]$entry.CurrentSetting }
    }
    $settingRows | Sort-Object Item | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $LenovoSettingsCsv
    Add-CollectorStatus -Name 'Lenovo BIOS settings' -State 'PASS' -Detail "$($settingRows.Count) settings"

    try {
        $selectionProvider = Get-WmiObject -Namespace root\wmi -Class Lenovo_GetBiosSelections -ErrorAction Stop
        $selectionRows = New-Object System.Collections.Generic.List[object]
        foreach ($row in $settingRows) {
            try {
                $selectionResult = $selectionProvider.GetBiosSelections([string]$row.Item)
                $selectionRows.Add([pscustomobject]@{ Item=$row.Item; CurrentValue=$row.Value; Selections=[string]$selectionResult.Selections; ReturnValue=[string]$selectionResult.ReturnValue }) | Out-Null
            } catch {
                $selectionRows.Add([pscustomobject]@{ Item=$row.Item; CurrentValue=$row.Value; Selections='<QUERY FAILED>'; ReturnValue=$_.Exception.Message }) | Out-Null
            }
        }
        $selectionRows | Export-Csv -NoTypeInformation -Encoding UTF8 -Path (Join-Path $BiosDir 'lenovo-bios-selections.csv')
        Add-CollectorStatus -Name 'Lenovo BIOS possible selections' -State 'PASS' -Detail "$($selectionRows.Count) settings"
    } catch {
        Save-Text -Path (Join-Path $BiosDir 'lenovo-bios-selections.error.txt') -Value $_
        Add-CollectorStatus -Name 'Lenovo BIOS possible selections' -State 'WARN' -Detail $_.Exception.Message
    }
} catch {
    Save-Text -Path ($LenovoSettingsCsv + '.error.txt') -Value $_
    Add-CollectorStatus -Name 'Lenovo BIOS settings' -State 'WARN' -Detail $_.Exception.Message
}

Invoke-Collector -Name 'Lenovo BIOS password status' -Path (Join-Path $BiosDir 'lenovo-bios-password-status.txt') -ScriptBlock {
    try { Get-CimInstance -Namespace root\wmi -ClassName Lenovo_BiosPasswordSettings -ErrorAction Stop | Format-List * }
    catch { "Lenovo_BiosPasswordSettings indisponível: $($_.Exception.Message)" }
} | Out-Null

Invoke-Collector -Name 'Firmware revision WMI' -Path (Join-Path $FirmwareDir 'firmware-revision-wmi.txt') -ScriptBlock {
    try { Get-CimInstance -Namespace root\wmi -ClassName MSDeviceUI_FirmwareRevision -ErrorAction Stop | Format-List * }
    catch { "MSDeviceUI_FirmwareRevision unavailable: $($_.Exception.Message)" }
} | Out-Null

Invoke-Collector -Name 'Secure Boot enabled' -Path (Join-Path $SecureBootDir 'secureboot-enabled.txt') -ScriptBlock {
    try { "Confirm-SecureBootUEFI = $(Confirm-SecureBootUEFI -ErrorAction Stop)" } catch { "ERROR: $($_.Exception.Message)" }
} | Out-Null

Invoke-Collector -Name 'Secure Boot policy' -Path (Join-Path $SecureBootDir 'secureboot-policy.txt') -ScriptBlock {
    try { Get-SecureBootPolicy -ErrorAction Stop | Format-List * } catch { "Get-SecureBootPolicy unavailable: $($_.Exception.Message)" }
} | Out-Null

foreach ($variableName in @('SecureBoot','SetupMode','PK','KEK','db','dbx','PKDefault','KEKDefault','dbDefault','dbxDefault','dbt','dbtDefault')) { Save-SecureBootVariable -Name $variableName }

Invoke-Collector -Name 'Secure Boot registry root' -Path (Join-Path $SecureBootDir 'registry-root.txt') -ScriptBlock {
    $p='HKLM:\SYSTEM\CurrentControlSet\Control\SecureBoot'; if (Test-Path $p) { Get-ItemProperty $p | Format-List * } else { 'NOT PRESENT' }
} | Out-Null

Invoke-Collector -Name 'Secure Boot servicing state' -Path (Join-Path $SecureBootDir 'registry-servicing.txt') -ScriptBlock {
    $p='HKLM:\SYSTEM\CurrentControlSet\Control\SecureBoot\Servicing'
    if (-not (Test-Path $p)) { 'SecureBoot\Servicing = NOT PRESENT'; return }
    $x=Get-ItemProperty $p; $x | Format-List *; ''; '--- Normalized values ---'
    foreach ($name in @('UEFICA2023Status','UEFICA2023Error','UEFICA2023ErrorEvent','WindowsUEFICA2023Capable','AvailableUpdatesPolicy','MicrosoftUpdateManagedOptIn','HighConfidenceOptOut','BucketHash','ConfidenceLevel')) {
        $prop=$x.PSObject.Properties[$name]
        if ($prop) { if ($prop.Value -is [int] -or $prop.Value -is [long]) { '{0} = {1} (0x{1:X})' -f $name,$prop.Value } else { '{0} = {1}' -f $name,$prop.Value } }
        else { "$name = <NOT PRESENT>" }
    }
} | Out-Null

Invoke-Collector -Name 'Secure Boot AvailableUpdates' -Path (Join-Path $SecureBootDir 'available-updates.txt') -ScriptBlock {
    $p='HKLM:\SYSTEM\CurrentControlSet\Control\SecureBoot'; $x=Get-ItemProperty $p -ErrorAction SilentlyContinue
    foreach ($name in @('AvailableUpdates','WindowsUEFICA2023Capable')) {
        $prop=$null; if ($x) { $prop=$x.PSObject.Properties[$name] }
        if ($prop) { if ($prop.Value -is [int] -or $prop.Value -is [long]) { '{0} = {1} (0x{1:X})' -f $name,$prop.Value } else { '{0} = {1}' -f $name,$prop.Value } }
        else { "$name = <NOT PRESENT>" }
    }
} | Out-Null

Invoke-Collector -Name 'Secure Boot update scheduled task' -Path (Join-Path $SecureBootDir 'secure-boot-update-task.txt') -ScriptBlock {
    try {
        $task=Get-ScheduledTask -TaskPath '\Microsoft\Windows\PI\' -TaskName 'Secure-Boot-Update' -ErrorAction Stop
        $info=Get-ScheduledTaskInfo -TaskPath '\Microsoft\Windows\PI\' -TaskName 'Secure-Boot-Update' -ErrorAction Stop
        '--- Task ---'; $task | Select-Object TaskName,TaskPath,State,Author,Description | Format-List
        '--- Info ---'; $info | Select-Object LastRunTime,LastTaskResult,NextRunTime,NumberOfMissedRuns | Format-List
    } catch { "Task unavailable: $($_.Exception.Message)" }
} | Out-Null

$secureEventIds=1032,1033,1034,1035,1036,1043,1044,1045,1795,1796,1797,1798,1799,1800,1801,1802,1803,1808
Export-EventSlice -Name 'Secure Boot system events' -Filter @{LogName='System';Id=$secureEventIds;StartTime=(Get-Date).AddDays(-180)} -Path (Join-Path $Events 'secureboot-system-events.csv') -MaxEvents 4000 | Out-Null
Export-EventSlice -Name 'Kernel Boot SBAT Event 292' -Filter @{LogName='Microsoft-Windows-Kernel-Boot/Operational';Id=292;StartTime=(Get-Date).AddDays(-180)} -Path (Join-Path $Events 'kernel-boot-292-sbat.csv') -MaxEvents 4000 | Out-Null
Export-EventSlice -Name 'Kernel Boot operational' -Filter @{LogName='Microsoft-Windows-Kernel-Boot/Operational';StartTime=(Get-Date).AddDays(-90)} -Path (Join-Path $Events 'kernel-boot-operational.csv') -MaxEvents 4000 | Out-Null

Invoke-Collector -Name 'Get-Tpm' -Path (Join-Path $Raw 'tpm-get-tpm.txt') -ScriptBlock { Get-Tpm | Format-List * } | Out-Null
Invoke-Collector -Name 'Win32_Tpm' -Path (Join-Path $Raw 'tpm-win32-tpm.txt') -ScriptBlock { Get-CimInstance -Namespace root\cimv2\security\microsofttpm -ClassName Win32_Tpm -ErrorAction Stop | Format-List * } | Out-Null
Invoke-NativeCapture -Name 'tpmtool getdeviceinformation' -Command 'tpmtool.exe' -Arguments @('getdeviceinformation') -Path (Join-Path $Raw 'tpmtool-device-information.txt') | Out-Null
Invoke-NativeCapture -Name 'manage-bde status' -Command 'manage-bde.exe' -Arguments @('-status') -Path (Join-Path $Raw 'bitlocker-status.txt') | Out-Null
Invoke-Collector -Name 'Get-BitLockerVolume' -Path (Join-Path $Raw 'bitlocker-powershell.txt') -ScriptBlock { if (Get-Command Get-BitLockerVolume -ErrorAction SilentlyContinue) { Get-BitLockerVolume | Format-List * } else { 'Get-BitLockerVolume cmdlet not available.' } } | Out-Null
Export-EventSlice -Name 'TPM WMI events' -Filter @{LogName='System';ProviderName='Microsoft-Windows-TPM-WMI';StartTime=(Get-Date).AddDays(-180)} -Path (Join-Path $Events 'tpm-wmi-system-events.csv') -MaxEvents 3000 | Out-Null

Invoke-NativeCapture -Name 'BCD firmware' -Command 'bcdedit.exe' -Arguments @('/enum','firmware') -Path (Join-Path $Raw 'bcd-firmware.txt') | Out-Null
Invoke-NativeCapture -Name 'BCD boot manager' -Command 'bcdedit.exe' -Arguments @('/enum','{bootmgr}') -Path (Join-Path $Raw 'bcd-bootmgr.txt') | Out-Null
Invoke-NativeCapture -Name 'BCD all' -Command 'bcdedit.exe' -Arguments @('/enum','all') -Path (Join-Path $Raw 'bcd-all.txt') | Out-Null
Invoke-NativeCapture -Name 'mountvol inventory' -Command 'mountvol.exe' -Arguments @() -Path (Join-Path $Raw 'mountvol.txt') | Out-Null

Invoke-Collector -Name 'Processor' -Path (Join-Path $Raw 'processor.txt') -ScriptBlock {
    Get-CimInstance Win32_Processor | Select-Object Name,Manufacturer,ProcessorId,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed,CurrentClockSpeed,VirtualizationFirmwareEnabled,VMMonitorModeExtensions,SecondLevelAddressTranslationExtensions,Status | Format-List
} | Out-Null

Invoke-Collector -Name 'CPU microcode registry state' -Path (Join-Path $Raw 'cpu-microcode-registry.txt') -ScriptBlock {
    $cpuReg='HKLM:\HARDWARE\DESCRIPTION\System\CentralProcessor\0'; if (Test-Path $cpuReg) { Get-ItemProperty $cpuReg | Format-List * } else { 'CentralProcessor registry key not present.' }
} | Out-Null

Invoke-NativeCapture -Name 'systeminfo' -Command 'systeminfo.exe' -Arguments @() -Path (Join-Path $Raw 'systeminfo.txt') | Out-Null
Invoke-NativeCapture -Name 'active power scheme' -Command 'powercfg.exe' -Arguments @('/getactivescheme') -Path (Join-Path $Raw 'power-active-scheme.txt') | Out-Null
Invoke-NativeCapture -Name 'processor power policy' -Command 'powercfg.exe' -Arguments @('/qh','SCHEME_CURRENT','SUB_PROCESSOR') -Path (Join-Path $Raw 'power-processor-policy.txt') | Out-Null
Invoke-NativeCapture -Name 'sleep states' -Command 'powercfg.exe' -Arguments @('/a') -Path (Join-Path $Raw 'power-sleep-states.txt') | Out-Null

Invoke-Collector -Name 'Battery and AC state' -Path (Join-Path $Raw 'battery-power-status.txt') -ScriptBlock {
    '--- Win32_Battery ---'
    Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue | Select-Object Name,DeviceID,BatteryStatus,EstimatedChargeRemaining,EstimatedRunTime,Status | Format-List
    ''; '--- root\wmi BatteryStatus ---'
    try { Get-CimInstance -Namespace root\wmi -ClassName BatteryStatus -ErrorAction Stop | Select-Object InstanceName,Active,PowerOnline,Discharging,Charging,Critical,Voltage,DischargeRate,ChargeRate,RemainingCapacity | Format-List }
    catch { "BatteryStatus unavailable: $($_.Exception.Message)" }
} | Out-Null

Invoke-Collector -Name 'Battery static data' -Path (Join-Path $Raw 'battery-static-data.txt') -ScriptBlock {
    try { Get-CimInstance -Namespace root\wmi -ClassName BatteryStaticData -ErrorAction Stop | Select-Object InstanceName,DesignedCapacity,ManufactureName,DeviceName,SerialNumber,UniqueID | Format-List }
    catch { "BatteryStaticData unavailable: $($_.Exception.Message)" }
} | Out-Null

$BatteryReport = Join-Path $Raw 'battery-report.html'
Invoke-NativeCapture -Name 'battery report' -Command 'powercfg.exe' -Arguments @('/batteryreport','/output',$BatteryReport) -Path (Join-Path $Raw 'battery-report-command.txt') | Out-Null

Invoke-Collector -Name 'ACPI thermal zones' -Path (Join-Path $Raw 'acpi-thermal-zones.txt') -ScriptBlock {
    try { Get-CimInstance -Namespace root\wmi -ClassName MSAcpi_ThermalZoneTemperature -ErrorAction Stop | Select-Object InstanceName,CurrentTemperature,CriticalTripPoint,PassiveTripPoint,Active | Format-List }
    catch { "Thermal zone WMI unavailable: $($_.Exception.Message)" }
} | Out-Null

Export-EventSlice -Name 'CPU firmware throttle Event 37' -Filter @{LogName='System';ProviderName='Microsoft-Windows-Kernel-Processor-Power';Id=37;StartTime=(Get-Date).AddDays(-180)} -Path (Join-Path $Events 'cpu-event37.csv') -MaxEvents 2000 | Out-Null
Export-EventSlice -Name 'WHEA Logger events' -Filter @{LogName='System';ProviderName='Microsoft-Windows-WHEA-Logger';StartTime=(Get-Date).AddDays(-180)} -Path (Join-Path $Events 'whea-logger.csv') -MaxEvents 3000 | Out-Null
Export-EventSlice -Name 'Kernel Power events' -Filter @{LogName='System';ProviderName='Microsoft-Windows-Kernel-Power';StartTime=(Get-Date).AddDays(-120)} -Path (Join-Path $Events 'kernel-power.csv') -MaxEvents 3000 | Out-Null
Export-EventSlice -Name 'ACPI events' -Filter @{LogName='System';ProviderName='ACPI';StartTime=(Get-Date).AddDays(-180)} -Path (Join-Path $Events 'acpi.csv') -MaxEvents 3000 | Out-Null

Invoke-Collector -Name 'MEI signed driver' -Path (Join-Path $FirmwareDir 'mei-driver.txt') -ScriptBlock {
    Get-CimInstance Win32_PnPSignedDriver | Where-Object { $_.DeviceName -match 'Management Engine|MEI|HECI' -or $_.InfName -match 'heci|mei' } | Select-Object DeviceName,DeviceID,DriverVersion,DriverProviderName,InfName,DriverDate,IsSigned | Format-List
} | Out-Null

Invoke-Collector -Name 'MEI PnP properties' -Path (Join-Path $FirmwareDir 'mei-pnp-properties.txt') -ScriptBlock {
    $devices=@(Get-PnpDevice -PresentOnly -ErrorAction SilentlyContinue | Where-Object { $_.FriendlyName -match 'Management Engine' -or $_.InstanceId -match 'VEN_8086&DEV_9D3A' })
    foreach ($device in $devices) { "===== $($device.FriendlyName) | $($device.InstanceId) ====="; Get-PnpDeviceProperty -InstanceId $device.InstanceId -ErrorAction SilentlyContinue | Select-Object KeyName,Type,Data | Format-Table -Wrap -AutoSize }
} | Out-Null

Invoke-Collector -Name 'Intel ME related registry values' -Path (Join-Path $FirmwareDir 'intel-me-registry.txt') -ScriptBlock {
    $candidatePaths=@('HKLM:\SOFTWARE\Intel\ME','HKLM:\SOFTWARE\Intel\Intel(R) Management Engine Components','HKLM:\SOFTWARE\WOW6432Node\Intel\ME','HKLM:\SOFTWARE\WOW6432Node\Intel\Intel(R) Management Engine Components')
    foreach ($path in $candidatePaths) {
        "===== $path ====="
        if (Test-Path $path) {
            Get-ItemProperty $path | Format-List *
            Get-ChildItem $path -ErrorAction SilentlyContinue | ForEach-Object { "--- $($_.PSPath) ---"; Get-ItemProperty $_.PSPath -ErrorAction SilentlyContinue | Format-List * }
        } else { 'NOT PRESENT' }
    }
} | Out-Null

Invoke-Collector -Name 'Intel ME namespace inventory' -Path (Join-Path $FirmwareDir 'intel-me-namespaces.txt') -ScriptBlock {
    $roots=@(Get-CimInstance -Namespace root -ClassName __NAMESPACE -ErrorAction SilentlyContinue | Where-Object { $_.Name -match 'Intel|ME|Management' } | Select-Object Name); $roots | Format-Table -AutoSize
} | Out-Null

Invoke-Collector -Name 'Known Intel firmware diagnostic tools' -Path (Join-Path $FirmwareDir 'intel-firmware-tools-presence.txt') -ScriptBlock {
    $names=@('MEInfoWin64.exe','MEInfo.exe','Intel-SA-00086-console.exe','CSME_Version_Detection_Tool.exe')
    foreach ($name in $names) {
        $hits=@()
        foreach ($base in @($env:ProgramFiles,${env:ProgramFiles(x86)},$env:USERPROFILE)) {
            if (-not $base -or -not (Test-Path $base)) { continue }
            if ($base -eq $env:USERPROFILE) { foreach ($sub in @('Desktop','Downloads')) { $candidate=Join-Path (Join-Path $base $sub) $name; if (Test-Path $candidate) { $hits += $candidate } } }
            else { $candidate=Join-Path $base $name; if (Test-Path $candidate) { $hits += $candidate } }
        }
        [pscustomobject]@{Tool=$name;Found=($hits.Count -gt 0);Paths=($hits -join '; ')}
    }
} | Out-Null

Invoke-Collector -Name 'Firmware PnP devices' -Path (Join-Path $FirmwareDir 'firmware-pnp-devices.txt') -ScriptBlock { Get-PnpDevice -Class Firmware -ErrorAction SilentlyContinue | Select-Object Status,Class,FriendlyName,InstanceId,Problem | Format-Table -Wrap -AutoSize } | Out-Null

Invoke-Collector -Name 'Firmware PnP properties' -Path (Join-Path $FirmwareDir 'firmware-pnp-properties.txt') -ScriptBlock {
    $fwDevices=@(Get-PnpDevice -Class Firmware -ErrorAction SilentlyContinue)
    foreach ($device in $fwDevices) { "===== $($device.FriendlyName) | $($device.InstanceId) ====="; Get-PnpDeviceProperty -InstanceId $device.InstanceId -ErrorAction SilentlyContinue | Select-Object KeyName,Type,Data | Format-Table -Wrap -AutoSize }
} | Out-Null

Invoke-Collector -Name 'SATA controller signed driver' -Path (Join-Path $Raw 'sata-controller-driver.txt') -ScriptBlock {
    Get-CimInstance Win32_PnPSignedDriver | Where-Object { $_.DeviceID -match 'VEN_8086&DEV_9D03' -or $_.DeviceName -match 'SATA AHCI' } | Select-Object DeviceName,DeviceID,DriverVersion,DriverProviderName,InfName,DriverDate,IsSigned | Format-List
} | Out-Null

Invoke-Collector -Name 'SATA controller PnP properties' -Path (Join-Path $Raw 'sata-controller-pnp-properties.txt') -ScriptBlock {
    $devices=@(Get-PnpDevice -PresentOnly -ErrorAction SilentlyContinue | Where-Object { $_.InstanceId -match 'VEN_8086&DEV_9D03' })
    foreach ($device in $devices) { "===== $($device.FriendlyName) | $($device.InstanceId) ====="; Get-PnpDeviceProperty -InstanceId $device.InstanceId -ErrorAction SilentlyContinue | Select-Object KeyName,Type,Data | Format-Table -Wrap -AutoSize }
} | Out-Null

Invoke-Collector -Name 'Storage services' -Path (Join-Path $Raw 'storage-services.txt') -ScriptBlock {
    $serviceRows=foreach ($name in @('storahci','iaStorA','iaStorAVC','iaStorAC','stornvme','spaceport')) {
        $service=Get-CimInstance Win32_SystemDriver -Filter "Name='$name'" -ErrorAction SilentlyContinue
        if ($service) { $service | Select-Object Name,State,StartMode,PathName,ServiceType }
        else { [pscustomobject]@{Name=$name;State='NOT FOUND';StartMode='';PathName='';ServiceType=''} }
    }
    $serviceRows | Format-Table -AutoSize
} | Out-Null

Invoke-NativeCapture -Name 'driverquery verbose' -Command 'driverquery.exe' -Arguments @('/v','/fo','csv') -Path (Join-Path $Raw 'driverquery.csv.txt') | Out-Null
Export-EventSlice -Name 'Storage related events' -Filter @{LogName='System';StartTime=(Get-Date).AddDays(-180);Level=1,2,3} -Path (Join-Path $Events 'system-critical-error-warning-180d.csv') -MaxEvents 8000 | Out-Null
foreach ($provider in @('disk','storahci','iaStorA','iaStorAC','StorPort','Ntfs','Microsoft-Windows-Storage-Storport')) {
    $safeProvider=$provider -replace '[^A-Za-z0-9_.-]','_'
    Export-EventSlice -Name "Storage provider $provider" -Filter @{LogName='System';ProviderName=$provider;StartTime=(Get-Date).AddDays(-180)} -Path (Join-Path $Events "storage-$safeProvider.csv") -MaxEvents 3000 | Out-Null
}

Invoke-Collector -Name 'Physical memory' -Path (Join-Path $Raw 'physical-memory.txt') -ScriptBlock { Get-CimInstance Win32_PhysicalMemory | Select-Object BankLabel,DeviceLocator,Manufacturer,PartNumber,SerialNumber,Capacity,Speed,ConfiguredClockSpeed,DataWidth,TotalWidth,SMBIOSMemoryType,FormFactor | Format-Table -Wrap -AutoSize } | Out-Null
Invoke-Collector -Name 'Memory arrays' -Path (Join-Path $Raw 'memory-array.txt') -ScriptBlock { Get-CimInstance Win32_PhysicalMemoryArray | Format-List * } | Out-Null
Invoke-Collector -Name 'Video controllers' -Path (Join-Path $Raw 'video-controllers.txt') -ScriptBlock { Get-CimInstance Win32_VideoController | Select-Object Name,PNPDeviceID,AdapterCompatibility,AdapterRAM,DriverVersion,DriverDate,VideoProcessor,VideoModeDescription,Status | Format-List } | Out-Null
Invoke-Collector -Name 'Display signed drivers' -Path (Join-Path $Raw 'display-signed-drivers.txt') -ScriptBlock { Get-CimInstance Win32_PnPSignedDriver | Where-Object { $_.DeviceClass -eq 'DISPLAY' } | Select-Object DeviceName,DeviceID,DriverVersion,DriverProviderName,InfName,DriverDate,IsSigned | Format-List } | Out-Null

Invoke-Collector -Name 'NVIDIA SMI' -Path (Join-Path $Raw 'nvidia-smi.txt') -ScriptBlock {
    $nvidiaCommand=Get-Command nvidia-smi.exe -ErrorAction SilentlyContinue; $nvidiaPath=$null
    if ($nvidiaCommand) { $nvidiaPath=$nvidiaCommand.Source }
    if (-not $nvidiaPath) { $known='C:\Program Files\NVIDIA Corporation\NVSMI\nvidia-smi.exe'; if (Test-Path $known) { $nvidiaPath=$known } }
    if ($nvidiaPath) { & $nvidiaPath '--query-gpu=name,driver_version,vbios_version,memory.total,pci.device_id,pci.bus_id' '--format=csv,noheader' 2>&1 } else { 'nvidia-smi.exe not found.' }
} | Out-Null

Invoke-Collector -Name 'PnP problem devices' -Path (Join-Path $Raw 'pnp-problem-devices.txt') -ScriptBlock { Get-PnpDevice -ErrorAction SilentlyContinue | Where-Object { $_.Status -ne 'OK' -or $_.Problem -ne 0 } | Select-Object Status,Class,FriendlyName,InstanceId,Problem | Sort-Object Class,FriendlyName | Format-Table -Wrap -AutoSize } | Out-Null
Invoke-Collector -Name 'Key PnP devices' -Path (Join-Path $Raw 'key-pnp-devices.txt') -ScriptBlock { Get-PnpDevice -PresentOnly -ErrorAction SilentlyContinue | Where-Object { $_.Class -in @('System','Display','Net','Bluetooth','HDC','SCSIAdapter','Firmware') -or $_.FriendlyName -match 'Intel|NVIDIA|Realtek|SATA|Management Engine|ACPI|PCI Express|USB' } | Select-Object Status,Class,FriendlyName,InstanceId,Problem | Sort-Object Class,FriendlyName | Format-Table -Wrap -AutoSize } | Out-Null

Invoke-Collector -Name 'Operating system' -Path (Join-Path $Raw 'operating-system.txt') -ScriptBlock { Get-CimInstance Win32_OperatingSystem | Format-List * } | Out-Null
Invoke-Collector -Name 'Device Guard' -Path (Join-Path $Raw 'device-guard.txt') -ScriptBlock { try { Get-CimInstance -Namespace root\Microsoft\Windows\DeviceGuard -ClassName Win32_DeviceGuard -ErrorAction Stop | Format-List * } catch { "Win32_DeviceGuard unavailable: $($_.Exception.Message)" } } | Out-Null
Invoke-Collector -Name 'Windows time' -Path (Join-Path $Raw 'windows-time.txt') -ScriptBlock { '--- timezone ---'; Get-TimeZone | Format-List *; '--- w32tm status ---'; & w32tm.exe /query /status 2>&1; '--- w32tm configuration ---'; & w32tm.exe /query /configuration 2>&1 } | Out-Null

$Status | Export-Csv -NoTypeInformation -Encoding UTF8 -Path (Join-Path $Root 'collector-status.csv')
$Status | ConvertTo-Json -Depth 5 | Set-Content -Path (Join-Path $Root 'collector-status.json') -Encoding UTF8

$bios=Get-CimInstance Win32_BIOS -ErrorAction SilentlyContinue
$cs=Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue
$cpu=Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue | Select-Object -First 1
$tpm=$null; try { $tpm=Get-Tpm -ErrorAction Stop } catch {}
$secureBoot='<UNAVAILABLE>'; try { $secureBoot=Confirm-SecureBootUEFI -ErrorAction Stop } catch {}
$uefi2023='<NOT PRESENT>'; $uefi2023Error='<NOT PRESENT>'
try {
    $servicing=Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\SecureBoot\Servicing' -ErrorAction Stop
    if ($servicing.PSObject.Properties['UEFICA2023Status']) { $uefi2023=[string]$servicing.UEFICA2023Status }
    if ($servicing.PSObject.Properties['UEFICA2023Error']) { $uefi2023Error=[string]$servicing.UEFICA2023Error }
} catch {}

$event37Count=0; try { $event37Count=@(Get-WinEvent -FilterHashtable @{LogName='System';ProviderName='Microsoft-Windows-Kernel-Processor-Power';Id=37;StartTime=(Get-Date).AddDays(-180)} -ErrorAction Stop).Count } catch {}
$wheaCount=0; try { $wheaCount=@(Get-WinEvent -FilterHashtable @{LogName='System';ProviderName='Microsoft-Windows-WHEA-Logger';StartTime=(Get-Date).AddDays(-180)} -ErrorAction Stop).Count } catch {}

$summary=@(
    '# FORMATAÇÃO CORRETA — FASE 1 / RESUMO AUTOMÁTICO',
    '',
    "- Coleta: $((Get-Date).ToString('yyyy-MM-dd HH:mm:ss zzz'))",
    "- Computador: $env:COMPUTERNAME",
    "- Fabricante/modelo WMI: $($cs.Manufacturer) / $($cs.Model)",
    "- BIOS: $($bios.SMBIOSBIOSVersion)",
    "- CPU: $($cpu.Name)",
    "- Secure Boot: $secureBoot",
    "- UEFICA2023Status: $uefi2023",
    "- UEFICA2023Error: $uefi2023Error",
    "- TPM Present/Ready/Enabled: $(if ($tpm) { "$($tpm.TpmPresent)/$($tpm.TpmReady)/$($tpm.TpmEnabled)" } else { '<UNAVAILABLE>' })",
    "- Event 37 (180d): $event37Count",
    "- WHEA events (180d): $wheaCount",
    "- Script SHA256: $ScriptHash",
    '',
    'Nenhuma alteração de BIOS/TPM/Secure Boot/SATA/firmware/driver foi realizada.'
)
$summary | Set-Content -Path (Join-Path $Root 'summary.md') -Encoding UTF8

$manualNeed=@(
    '# Evidência manual da BIOS',
    '',
    'Se bios\lenovo-bios-settings.csv estiver ausente/vazio ou não mostrar SATA Mode, Boot Mode, Secure Boot, PTT, Virtualization, Hyper-Threading, Fast Boot, PXE e SGX,',
    'envie junto com o ZIP fotos nítidas de TODAS as páginas da BIOS: Information/Main, Configuration, Security, Boot e Exit.',
    '',
    'Não altere nenhuma opção para tirar as fotos.'
)
$manualNeed | Set-Content -Path (Join-Path $Root 'BIOS-FOTOS-SE-NECESSARIO.txt') -Encoding UTF8

$manifest=[ordered]@{ project='FORMATAÇÃO CORRETA'; phase='Fase 1 — Plataforma persistente / BIOS / firmware / segurança'; script=$(if ($ScriptPath) { Split-Path $ScriptPath -Leaf } else { '<unknown>' }); script_sha256=$ScriptHash; mode='READ-ONLY'; started=$StartTime.ToString('o'); completed=(Get-Date).ToString('o'); computer=$env:COMPUTERNAME; powershell=$PSVersionTable.PSVersion.ToString() }
$manifest | ConvertTo-Json -Depth 5 | Set-Content -Path (Join-Path $Root 'manifest.json') -Encoding UTF8

$filesToHash=@(Get-ChildItem -Path $Root -File -Recurse | Where-Object { $_.Name -ne 'file-hashes.csv' })
$hashRows=foreach ($file in $filesToHash) {
    try { $hash=Get-FileHash -Algorithm SHA256 -Path $file.FullName -ErrorAction Stop; [pscustomobject]@{File=$file.FullName.Substring($Root.Length).TrimStart('\');SHA256=$hash.Hash;Size=$file.Length} }
    catch { [pscustomobject]@{File=$file.FullName.Substring($Root.Length).TrimStart('\');SHA256='<HASH ERROR>';Size=$file.Length} }
}
$hashRows | Export-Csv -NoTypeInformation -Encoding UTF8 -Path (Join-Path $Root 'file-hashes.csv')

$ZipPath="$Root.zip"
try {
    if (Test-Path $ZipPath) { throw "ZIP path already exists unexpectedly: $ZipPath" }
    Compress-Archive -Path $Root -DestinationPath $ZipPath -CompressionLevel Optimal
    Write-Host ''
    Write-Host '========================================================' -ForegroundColor Green
    Write-Host 'FORMATAÇÃO CORRETA — FASE 1 / COLETA CONCLUÍDA' -ForegroundColor Green
    Write-Host '========================================================' -ForegroundColor Green
    Write-Host "Pasta: $Root"
    Write-Host "ZIP:   $ZipPath" -ForegroundColor Cyan
    Write-Host ''
    Write-Host 'Envie ESTE ZIP ao ChatGPT.' -ForegroundColor Yellow
    Write-Host 'Se BIOS-FOTOS-SE-NECESSARIO.txt indicar lacuna, envie também as fotos pedidas.' -ForegroundColor Yellow
    Write-Host 'NÃO altere BIOS, TPM, Secure Boot, SATA ou firmware antes da análise.' -ForegroundColor Yellow
} catch {
    Write-Host "ERRO ao criar ZIP: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "A pasta de coleta foi preservada em: $Root"
    exit 2
}