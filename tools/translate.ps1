$ErrorActionPreference = 'Stop'
$base    = 'D:\DSH ROBLOX\汉化脚本合集'
$src     = Join-Path $base '原版\Silence_Hub_V36_Christmas.lua'
$dstDir  = Join-Path $base '汉化版'
$dst     = Join-Path $dstDir 'Silence_Hub_V36_Christmas_CN.lua'
$logFile = 'D:\DSH ROBLOX\tools\更新日志_CN.txt'
$missOut = 'D:\DSH ROBLOX\tools\未命中.txt'
$mapFiles = @(
  'D:\DSH ROBLOX\汉化脚本合集\tools\翻译表_界面.tsv',
  'D:\DSH ROBLOX\汉化脚本合集\tools\翻译表_杂项.tsv',
  'D:\DSH ROBLOX\汉化脚本合集\tools\翻译表_界面2.tsv',
  'D:\DSH ROBLOX\汉化脚本合集\tools\翻译表_修补.tsv',
  'D:\DSH ROBLOX\汉化脚本合集\tools\翻译表_界面3.tsv'
)

$utf8 = New-Object System.Text.UTF8Encoding($false)
if (-not (Test-Path $dstDir)) { New-Item -ItemType Directory -Force -Path $dstDir | Out-Null }

$raw = [IO.File]::ReadAllText($src, $utf8)
$origBytes = $raw.Length

$map = @{}
$dupWarn = 0
foreach ($f in $mapFiles) {
  if (-not (Test-Path $f)) { Write-Output ('MISSING_MAP=' + $f); continue }
  foreach ($line in [IO.File]::ReadAllLines($f, $utf8)) {
    $i = $line.IndexOf('|||')
    if ($i -lt 1) { continue }
    $k = $line.Substring(0, $i)
    $v = $line.Substring($i + 3)
    if ($map.ContainsKey($k)) { $dupWarn += 1 }
    $map[$k] = $v
  }
}
Write-Output ('MAP_KEYS=' + $map.Count)
Write-Output ('MAP_DUP=' + $dupWarn)

$script:mapRef = $map
$script:hitKeys = New-Object 'System.Collections.Generic.HashSet[string]'
$script:hitCount = 0

$rxStr = New-Object System.Text.RegularExpressions.Regex('"((?:[^"\\]|\\.)*)"')
$evMap = [System.Text.RegularExpressions.MatchEvaluator]{
  param($m)
  $inner = $m.Groups[1].Value
  if ($script:mapRef.ContainsKey($inner)) {
    $script:hitCount += 1
    [void]$script:hitKeys.Add($inner)
    return '"' + $script:mapRef[$inner] + '"'
  }
  return $m.Value
}
$raw = $rxStr.Replace($raw, $evMap)
Write-Output ('EXACT_STRINGS_REPLACED=' + $script:hitCount)
Write-Output ('EXACT_KEYS_USED=' + $script:hitKeys.Count)

$rxLoad = New-Object System.Text.RegularExpressions.Regex('"Loads and runs ([^"\r\n]+)\."')
$script:loadCount = 0
$evLoad = [System.Text.RegularExpressions.MatchEvaluator]{
  param($m)
  $n = $m.Groups[1].Value
  if ($script:mapRef.ContainsKey($n)) { $n = $script:mapRef[$n] }
  $script:loadCount += 1
  return '"加载并运行：' + $n + '。"'
}
$raw = $rxLoad.Replace($raw, $evLoad)
Write-Output ('TEMPLATE_LOADS=' + $script:loadCount)

$tpl = @(
  @('"(Made by |Made By )([^"\r\n]+)"',                       '"作者：$2"'),
  @('"(Credits to |Credit to )([^"\r\n]+)"',                  '"鸣谢：$2"'),
  @('"(Fixed by |Fixed By )([^"\r\n]+)"',                     '"修复：$2"'),
  @('"(Recreated by |Recreated By |Recreation By )([^"\r\n]+)"', '"重制：$2"'),
  @('"(Remaked by |Remaked By |Remake by )([^"\r\n]+)"',       '"重制：$2"'),
  @('"(Released By |Released by )([^"\r\n]+)"',                '"发布：$2"'),
  @('"(Created by |Created By )([^"\r\n]+)"',                  '"制作：$2"'),
  @('"(Updated by |Updated By )([^"\r\n]+)"',                  '"更新：$2"'),
  @('"(By )([^"\r\n]+)"',                                      '"作者：$2"')
)
$tplTotal = 0
foreach ($t in $tpl) {
  $rx = New-Object System.Text.RegularExpressions.Regex($t[0])
  $n = $rx.Matches($raw).Count
  if ($n -gt 0) { $raw = $rx.Replace($raw, $t[1]); $tplTotal += $n }
}
Write-Output ('TEMPLATE_CREDIT=' + $tplTotal)

$rxSign = New-Object System.Text.RegularExpressions.Regex('鸣谢：([^"\r\n\.]+) for the sign text in chat\.?')
$signCount = $rxSign.Matches($raw).Count
if ($signCount -gt 0) { $raw = $rxSign.Replace($raw, '鸣谢：$1 的聊天签名文案') }
Write-Output ('TEMPLATE_SIGN=' + $signCount)

$logText = [IO.File]::ReadAllText($logFile, $utf8).TrimEnd()
$script:logRef = $logText
$rxLog = New-Object System.Text.RegularExpressions.Regex('local UPDATE_LOGS = \{\r?\n\[\[[\s\S]*?\]\],\r?\n\}')
$logMatches = $rxLog.Matches($raw).Count
$evLog = [System.Text.RegularExpressions.MatchEvaluator]{
  param($m)
  return 'local UPDATE_LOGS = {' + "`r`n" + '[[' + $script:logRef + ']],' + "`r`n" + '}'
}
if ($logMatches -gt 0) { $raw = $rxLog.Replace($raw, $evLog, 1) }
Write-Output ('UPDATELOGS_MATCH=' + $logMatches)

$unused = New-Object 'System.Collections.Generic.List[string]'
foreach ($k in $map.Keys) { if (-not $script:hitKeys.Contains($k)) { $unused.Add($k) } }
[IO.File]::WriteAllText($missOut, ($unused -join "`r`n"), $utf8)
Write-Output ('MAP_KEYS_UNUSED=' + $unused.Count)

$sanity1 = $raw.Contains('"遗忘模式"')
$sanity2 = $raw.Contains('"设置"') -or $raw.Contains('"关于"')
$sanity3 = $raw.Contains('加载并运行')
Write-Output ('SANITY_NAME=' + $sanity1)
Write-Output ('SANITY_UI=' + $sanity2)
Write-Output ('SANITY_DESC=' + $sanity3)
if (-not ($sanity1 -and $sanity3)) {
  Write-Output 'ABORT=sanity_failed'
  exit 3
}

[IO.File]::WriteAllText($dst, $raw, $utf8)
Write-Output ('OUT_BYTES=' + (Get-Item $dst).Length)
Write-Output ('ORIG_BYTES=' + $origBytes)
Write-Output ('OUT=' + $dst)
