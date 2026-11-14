# Dựng green/index.html từ index.html gốc: đổi bảng màu hồng sang xanh lá + gắn nền mới (green.css).
# Chạy lại mỗi khi sửa bản gốc, rồi: docker compose up -d --build
$root = Split-Path $PSScriptRoot -Parent
$utf8 = New-Object System.Text.UTF8Encoding $false
$h = [IO.File]::ReadAllText("$root\index.html", $utf8)
$css = [IO.File]::ReadAllText("$PSScriptRoot\green.css", $utf8)

$map = [ordered]@{
  # nền, chữ
  '#07060b' = '#06120a'; '#1a0f1f' = '#0f2a14'; '#17131c' = '#0d1f11'; '#f3ead9' = '#E8F5E9'; '#9a93a3' = '#8FB894'
  # hồng -> xanh lá
  '#ff4d6d' = '#66BB6A'; '#ff9ab5' = '#A5D6A7'; '#ffc2d4' = '#E8F5E9'; '#ffc2d6' = '#A5D6A7'; '#ff8fb4' = '#A5D6A7'; '#ff6f8a' = '#81C784'
  '#ffe9d6' = '#E8F5E9'; '#ffb3c8' = '#A5D6A7'; '#ff6f9c' = '#66BB6A'; '#c9a3ff' = '#C5E1A5'; '#8fb8ff' = '#80CBC4'
  '#ffe2ee' = '#E8F5E9'; '#ffe0ea' = '#E8F5E9'; '#ff7aa5' = '#66BB6A'; '#d6336c' = '#1B5E20'; '#ffe4ee' = '#E8F5E9'; '#ffb3cb' = '#A5D6A7'
  '0xff9ec8' = '0xA5D6A7'; '0xff6f9c' = '0x66BB6A'; '0xc9a3ff' = '0xC5E1A5'; '0xffb3d1' = '0xA5D6A7'; '0xffd6e6' = '0xE8F5E9'
  '0xffc2dc' = '0xC8E6C9'; '0xbfb6d6' = '0xB7D3BA'
  'rgba(255,77,140,' = 'rgba(102,187,106,'; 'rgba(255,77,109,' = 'rgba(102,187,106,'; 'rgba(255,143,180,' = 'rgba(165,214,167,'
  'rgba(255,180,205,' = 'rgba(200,230,201,'; 'rgba(255,200,220,' = 'rgba(220,240,221,'; 'rgba(255,235,242,' = 'rgba(232,245,233,'
  'rgba(255,120,160,' = 'rgba(129,199,132,'; 'rgba(255,214,230,' = 'rgba(200,230,201,'; 'rgba(255,190,215,' = 'rgba(165,214,167,'
  'rgba(255,90,150,' = 'rgba(102,187,106,'; 'rgba(255,130,180,' = 'rgba(129,199,132,'; 'rgba(214,51,108,' = 'rgba(27,94,32,'
  'rgba(243,234,217,' = 'rgba(232,245,233,'; 'rgba(7,6,11,' = 'rgba(6,18,10,'
}
foreach ($k in $map.Keys) { $h = $h.Replace($k, $map[$k]) }

$h = $h.Replace('"assets/', '"../assets/')
$h = $h.Replace('<canvas id="gl"></canvas>', "<div id=`"bg`"><i class=`"b1`"></i><i class=`"b2`"></i><i class=`"b3`"></i><i class=`"b4`"></i></div>`n<canvas id=`"gl`"></canvas>")
$i = $h.IndexOf('</style>'); $h = $h.Insert($i, "`n" + $css)

[IO.File]::WriteAllText("$PSScriptRoot\index.html", $h, $utf8)
"ok"
