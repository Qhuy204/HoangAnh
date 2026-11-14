# Dựng anime/index.html từ index.html gốc + anime.css + anime.js. Chạy lại mỗi khi sửa bản gốc.
$root = Split-Path $PSScriptRoot -Parent
$utf8 = New-Object System.Text.UTF8Encoding $false
$h = [IO.File]::ReadAllText("$root\index.html", $utf8)
$css = [IO.File]::ReadAllText("$PSScriptRoot\anime.css", $utf8)
$js = [IO.File]::ReadAllText("$PSScriptRoot\anime.js", $utf8)

$h = $h.Replace('"assets/', '"../assets/')
$h = $h.Replace('family=Quicksand:wght@600;700', 'family=Baloo+2:wght@400;500;600;700;800')
$h = $h.Replace('"Quicksand"', '"Baloo 2"')
$h = $h.Replace('<meta name="theme-color" content="#07060b">', '<meta name="theme-color" content="#120c35">')
$h = $h.Replace('<canvas id="gl"></canvas>', "<canvas id=`"sky`"></canvas>`n<canvas id=`"gl`"></canvas>`n<canvas id=`"sakura`"></canvas>")
$i = $h.IndexOf('</style>'); $h = $h.Insert($i, "`n" + $css)
$i = $h.LastIndexOf('</body>'); $h = $h.Insert($i, "<script>`n" + $js + "</script>`n")

[IO.File]::WriteAllText("$PSScriptRoot\index.html", $h, $utf8)
"ok: " + $h.Length
