param([switch]$watch = $false)

$source = './site'
$dist = '../dist'

Write-Output "watch: $($watch)"

if ($watch -eq $true) {
    start-process "http://localhost:1313"    
    & bin\hugo.exe server -s $source --watch -d $dist
}
else {
    & bin\hugo.exe -s $source -d $dist
}