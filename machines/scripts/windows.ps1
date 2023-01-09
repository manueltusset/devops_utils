$ErrorActionPreference = "Stop";
$PathCustom = "C:\vagrant\scripts\custom\custom.ps1"

If (Test-Path -Path $PathCustom -PathType Leaf) {
  Powershell -Command $PathCustom
}