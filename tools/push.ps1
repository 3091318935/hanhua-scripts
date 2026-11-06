param(
    [string]$User  = $env:GITHUB_USER,
    [string]$Token = $env:GITHUB_TOKEN,
    [string]$Repo  = '汉化脚本合集'
)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent (Split-Path -Parent $PSCommandPath)
Set-Location $root

if (-not $User)  { $User  = Read-Host 'GitHub 用户名' }
if (-not $Token) { $Token = Read-Host 'GitHub PAT (repo 权限，输入时不显示)' -AsSecureString | ForEach-Object { [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($_)) } }

# --- git 基础配置（缺什么补什么，不覆盖已有值）---
if (-not (git config --global user.name))  { git config --global user.name  $User }
if (-not (git config --global user.email)) { git config --global user.email "$User@users.noreply.github.com" }
git config core.quotepath false

# --- 建库（已存在会返回 422，忽略即可）---
$body = @{
    name        = $Repo
    description = 'Roblox 脚本汉化合集 | Silence Hub V36 中文化'
    private     = $false
    has_issues  = $true
} | ConvertTo-Json -Compress
try {
    Invoke-RestMethod -Method Post -Uri 'https://api.github.com/user/repos' `
        -Headers @{ Authorization = "token $Token"; 'User-Agent' = $User; Accept = 'application/vnd.github+json' } `
        -ContentType 'application/json; charset=utf-8' -Body ([Text.Encoding]::UTF8.GetBytes($body)) | Out-Null
    "已创建仓库: $User/$Repo"
} catch {
    "建库返回: $($_.Exception.Message)（仓库已存在时会这样，继续推送）"
}

# --- 提交并推送 ---
if (-not (Test-Path '.git')) { git init | Out-Null; git branch -M main }
git add -A
if (-not (git log -1 2>$null)) { git commit -m '汉化：Silence Hub V36 圣诞版 全界面中文化' | Out-Null }
else { git commit -m '更新汉化' | Out-Null }

$remoteUrl = "https://$User`:$Token@github.com/$User/$Repo.git"
if (git remote 2>$null | Select-String -Pattern '^origin$' -SimpleMatch) { git remote set-url origin $remoteUrl }
else { git remote add origin $remoteUrl }

git push -u origin main --force
git remote set-url origin "https://github.com/$User/$Repo.git"

"完成: https://github.com/$User/$Repo"
