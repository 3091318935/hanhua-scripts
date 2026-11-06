param([Parameter(Mandatory=$true)]$p)
$s = [IO.File]::ReadAllText($p, [Text.Encoding]::UTF8)
Invoke-Expression $s
