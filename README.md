# 汉化脚本合集

> 一个干净的 Roblox 脚本汉化仓库：**只翻译界面文字，不改动任何功能、链接与逻辑**。

## 收录内容

| 文件 | 说明 |
| --- | --- |
| `scripts/Silence_Hub_V36_Christmas_CN.lua` | Silence Hub V36（圣诞版）完整中文化，可直接执行 |
| `originals/Silence_Hub_V36_Christmas.lua` | 作者原版，用于对照 / 回滚 |

原作者：**Rip_Silence**（Owner） / **WH1T3**（Co-Owner，界面作者）。
本仓库仅做简体中文界面汉化，脚本功能、远程地址与原作者信息全部保留。

## 使用方法

1. 打开 Roblox 执行器（任何支持 `loadstring` + `game:HttpGet` 的执行器）。
2. 粘贴下面这一行，回车：

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/3091318935/%E6%B1%89%E5%8C%96%E8%84%9A%E6%9C%AC%E5%90%88%E9%9B%86/main/scripts/Silence_Hub_V36_Christmas_CN.lua"))()
```

3. 加载完成后按 **右 Shift** 呼出 / 收起面板（浮动圆形按钮同样可以）。
4. 点按钮即可加载对应模式；带 `•••` 的按钮点开可看说明。

> 分支保持 `main`，否则上面的链接要跟着改。

## 汉化范围

- 面板标题、加载进度、聊天公告、Doors 开场文字
- 所有标签页名称与分区说明（模式 / 实体 / 道具 / 合集 / 经典旧版）
- 全部按钮的 名称 / 副标题 / 说明 / 二次确认弹窗
- 设置页（音乐、音量、特效、防挂机、视野、FPS、快捷键、主题色……）全部文案
- 搜索、收藏、最常使用、最近运行、笔记、团队、圣诞小玩意、调试信息
- 更新日志（V36 全文）
- 运行结果提示、报错提示、`warn` / `print` 输出

**未改动**：所有 `loadstring(game:HttpGet(...))` 的远程地址、执行顺序、`pcall` 逻辑、`_G` 变量名、`Enum` 取值、存档文件名与实例名。任何一个模式的行为都与原版完全一致。

### 刻意保留英文的部分

| 保留项 | 原因 |
| --- | --- |
| `Silence Hub` / `WH1T3` / `Rip_Silence` 等作者与品牌名 | 署名信息，不翻译 |
| `Made by` 后面的作者 ID | 用户名，保持原样 |
| `A-60`、`Z-88`、`B ∆ B`、`Pim`、`WH1T3` 等实体代号 | 社区通用代号 |
| `http 404`、`timed out`、`nil value` 等 | 代码用于匹配执行器原始报错的关键词，翻译会导致判断失效 |
| `HalloweenHub_v6_save.json`、`HalloweenHub/song.mp3` | 存档与音频文件名 |
| `home`/`settings` 等内部 `kind`、`sort` 的 `az`/`za`/`new`、语言码 `en`/`es`/`pt`/`fr` | 代码内部标识，翻译会让判断失效 |

> 主题色名（Cranberry / Holly / Gold / Frost / Candy / Bone / Ink / Ash）与天气名（Snow / Blizzard / Lights / Embers / leaves / rain / ghosts）已经翻成中文。存档里保存的仍是原英文名，所以**升级到汉化版后第一次启动时，主题色可能回落到默认的蔓越莓色**，手动再选一次即可，之后正常记住。

## 目录结构

```
汉化脚本合集/
├── README.md
├── scripts/
│   └── Silence_Hub_V36_Christmas_CN.lua     # 汉化版（发布用）
├── originals/
│   └── Silence_Hub_V36_Christmas.lua         # 原版（对照用）
└── tools/
    ├── translate.ps1        # 生成器：读原版 + 翻译表 → 输出汉化版
    ├── run2.ps1             # UTF-8 启动器（Windows PowerShell 5.1 下避免中文路径乱码）
    ├── 翻译表_界面.tsv       # 模式名 / 标签页 / 分区 / 设置项 / 说明
    ├── 翻译表_杂项.tsv       # 长说明、确认弹窗、团队页
    ├── 翻译表_界面2.tsv      # 聊天公告、通知、音乐页、搜索、笔记、统计
    ├── 翻译表_修补.tsv       # 二轮补漏（尾随空格 key、公告、状态提示）
    ├── 翻译表_界面3.tsv      # 侧栏标签、颜色名、天气名、弹窗按钮
    └── 更新日志_CN.txt       # UPDATE_LOGS 中文全文
```

## 自己维护汉化

翻译表就是 `英文|||中文` 的纯文本（UTF-8），分隔符 `|||`，没有 `|||` 的行会被忽略。

1. 把新脚本放进 `originals/`；
2. 在翻译表里补 `English|||中文`；
3. 跑一次生成器：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\run2.ps1 -p tools\translate.ps1
```

生成器只会替换**完整引号包裹**的字符串字面量（`"English"` → `"中文"`），因此不会误伤标识符、子串或代码结构；剩余的 `Made by X` / `Credit to X` / `Loads and runs X.` 这类模板句由正则兜底统一处理。

## 注意事项

- 大部分模式实际运行的是**第三方作者的远程脚本**，对方删库 / 改路径时对应按钮会失效，与汉化无关。
- 少数模式（Impossible V1.8 Alpha、Fragmented 系列等）原版就标注「可能坏掉」，汉化版保持同样状态。
- 文件编码为 **UTF-8（无 BOM）**，自己改文本请保持该编码，否则中文会乱码。
