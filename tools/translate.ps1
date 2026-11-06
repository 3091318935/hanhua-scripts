$ErrorActionPreference = 'Stop'

# 仓库根目录：优先按本脚本位置推断（tools 的上一级），推断不出来时回退到本机工作目录
$base = 'D:\DSH ROBLOX\汉化脚本合集'
$here = $null
try { if ($PSScriptRoot) { $here = Split-Path -Parent $PSScriptRoot } } catch { $here = $null }
if ($here -and (Test-Path (Join-Path $here 'tools'))) { $base = $here }
$src = Join-Path $base '原版\Silence_Hub_V36_Christmas.lua'
if (-not (Test-Path $src)) { $src = Join-Path $base 'originals\Silence_Hub_V36_Christmas.lua' }
$dstDir  = Join-Path $base '汉化版'
$dst     = Join-Path $dstDir 'Silence_Hub_V36_Christmas_CN.lua'
$logFile = 'D:\DSH ROBLOX\tools\更新日志_CN.txt'
if (-not (Test-Path $logFile)) { $logFile = Join-Path $base 'tools\更新日志_CN.txt' }
$missOut = Join-Path $env:TEMP '未命中.txt'
$mapFiles = @(
  (Join-Path $base 'tools\翻译表_界面.tsv'),
  (Join-Path $base 'tools\翻译表_杂项.tsv'),
  (Join-Path $base 'tools\翻译表_界面2.tsv'),
  (Join-Path $base 'tools\翻译表_修补.tsv'),
  (Join-Path $base 'tools\翻译表_界面3.tsv')
)

$utf8 = New-Object System.Text.UTF8Encoding($false)
if (-not (Test-Path $dstDir)) { New-Item -ItemType Directory -Force -Path $dstDir | Out-Null }

$raw = [IO.File]::ReadAllText($src, $utf8)
$origBytes = $raw.Length

# ================= 保护通道 =================
# 引擎 API 的参数、实例名、服务名、属性名绝对不能被翻译，
# 否则会出现 game:GetService("统计") -> '统计' is not a valid Service name 这类启动崩溃。
$script:keepList = New-Object 'System.Collections.Generic.List[string]'
$rxApiCall = New-Object System.Text.RegularExpressions.Regex('((?:GetService|Instance\.new|WaitForChild|FindFirstChildWhichIsA|FindFirstChildOfClass|FindFirstChild|IsA|GetAttribute|SetAttribute|GetPropertyChangedSignal|FireServer|InvokeServer)\s*\(\s*")((?:[^"\\]|\\.)*)(")')
$evApiCall = [System.Text.RegularExpressions.MatchEvaluator]{
  param($m)
  [void]$script:keepList.Add($m.Groups[2].Value)
  $n = $script:keepList.Count - 1
  return $m.Groups[1].Value + '@@KEEP' + $n.ToString('D4') + '@@' + $m.Groups[3].Value
}
$apiProtected = $rxApiCall.Matches($raw).Count
$raw = $rxApiCall.Replace($raw, $evApiCall)

$rxApiIdx = New-Object System.Text.RegularExpressions.Regex('((?:ServerStatsItem|StatsItem)\[")((?:[^"\\]|\\.)*)("\])')
$evApiIdx = [System.Text.RegularExpressions.MatchEvaluator]{
  param($m)
  [void]$script:keepList.Add($m.Groups[2].Value)
  $n = $script:keepList.Count - 1
  return $m.Groups[1].Value + '@@KEEP' + $n.ToString('D4') + '@@' + $m.Groups[3].Value
}
$apiProtected += $rxApiIdx.Matches($raw).Count
$raw = $rxApiIdx.Replace($raw, $evApiIdx)
Write-Output ('API_PROTECTED=' + $apiProtected)

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
$script:lowerSkip = 0

$rxStr = New-Object System.Text.RegularExpressions.Regex('"((?:[^"\\]|\\.)*)"')
$evMap = [System.Text.RegularExpressions.MatchEvaluator]{
  param($m)
  $inner = $m.Groups[1].Value
  # 纯小写标识符（snow/leaves/rain/ghosts/embers 这类内部 key）绝不翻译，
  # 它们是表键，翻了会让 EFFECTS[kind] / TBL[key] 取到 nil 直接崩。
  if ($inner -cmatch '^[a-z][a-z0-9_]*$') {
    $script:lowerSkip += 1
    return $m.Value
  }
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
  return 'local UPDATE_LOGS = {' + "`n" + '[[' + $script:logRef + ']],' + "`n" + '}'
}
if ($logMatches -gt 0) { $raw = $rxLog.Replace($raw, $evLog, 1) }
Write-Output ('UPDATELOGS_MATCH=' + $logMatches)

# ---- 还原保护通道：把引擎 API 字面量原样放回 ----
for ($ki = 0; $ki -lt $script:keepList.Count; $ki++) {
  $raw = $raw.Replace('@@KEEP' + $ki.ToString('D4') + '@@', $script:keepList[$ki])
}
$leftover = New-Object System.Text.RegularExpressions.Regex('@@KEEP\d{4}@@')
Write-Output ('KEEP_RESTORED=' + $script:keepList.Count)
Write-Output ('KEEP_LEFTOVER=' + $leftover.Matches($raw).Count)
Write-Output ('SERVICE_STATS_OK=' + $raw.Contains('game:GetService("Stats")'))
Write-Output ('PING_KEY_OK=' + $raw.Contains('ServerStatsItem["Data Ping"]'))

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

# ---- API 字面量必须全 ASCII（防止再出现 GetService("统计") 这类启动崩溃）----
$rxApiScan = New-Object System.Text.RegularExpressions.Regex('(?:GetService|Instance\.new|WaitForChild|FindFirstChildWhichIsA|FindFirstChildOfClass|FindFirstChild|IsA|GetAttribute|SetAttribute|FireServer|InvokeServer)\s*\(\s*"((?:[^"\\]|\\.)*)"')
$rxIdxScan = New-Object System.Text.RegularExpressions.Regex('(?:ServerStatsItem|StatsItem)\["((?:[^"\\]|\\.)*)"\]')
$badApi = 0
foreach ($m in $rxApiScan.Matches($raw)) { if ($m.Groups[1].Value -match '[^\x00-\x7F]') { $badApi += 1 } }
foreach ($m in $rxIdxScan.Matches($raw)) { if ($m.Groups[1].Value -match '[^\x00-\x7F]') { $badApi += 1 } }
Write-Output ('NON_ASCII_API_ARGS=' + $badApi)
Write-Output ('LOWER_IDENT_SKIPPED=' + $script:lowerSkip)

# ---- 内部 key 列表必须保持英文（否则 EFFECTS[kind] 取到 nil）----
$effectsListOk = $raw.Contains('ipairs({ "snow", "leaves", "rain", "ghosts", "embers" })')
Write-Output ('EFFECTS_LIST_OK=' + $effectsListOk)
$rxCnIndex = New-Object System.Text.RegularExpressions.Regex('\[\s*"((?:[^"\\]|\\.)*)"\s*\]')
$cnIndexBad = 0
foreach ($m in $rxCnIndex.Matches($raw)) {
  $v = $m.Groups[1].Value
  if ($v -match '[^\x00-\x7F]') {
    # 只允许与界面名同源的 refreshers / NEW_SCRIPTS 键
    if (-not ($v -eq '主页' -or $v -eq '收藏' -or $v -eq '播放列表' -or $v -eq '疯狂模式 1.2' -or $v -eq '懒得写说明了')) { $cnIndexBad += 1 }
  }
}
Write-Output ('CN_INDEX_OTHER=' + $cnIndexBad)

if ((-not ($sanity1 -and $sanity3)) -or $badApi -gt 0 -or $leftover.Matches($raw).Count -gt 0 -or -not $raw.Contains('game:GetService("Stats")') -or -not $effectsListOk -or $cnIndexBad -gt 0) {
  Write-Output 'ABORT=sanity_failed'
  exit 3
}

[IO.File]::WriteAllText($dst, $raw, $utf8)
Write-Output ('OUT_BYTES=' + (Get-Item $dst).Length)
Write-Output ('ORIG_BYTES=' + $origBytes)
Write-Output ('OUT=' + $dst)
