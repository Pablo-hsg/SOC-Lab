param(
    [Parameter(Mandatory=$false)]
    [object]$WebhookData,

    [Parameter(Mandatory=$false)]
    [string]$ListaIPs
)

if ($WebhookData) {
    $Corpo = $WebhookData.RequestBody | ConvertFrom-Json
    $ListaIPs = $Corpo.ip
}

if ([string]::IsNullOrWhiteSpace($ListaIPs)) {
    Write-Error "Nenhum IP foi fornecido (nem via parametro manual, nem via webhook)."
    return
}

$ChaveVirusTotal = Get-AutomationVariable -Name 'VTApiKey'
$ChaveAbuseIPDB = Get-AutomationVariable -Name 'AbuseIPDBApiKey'

function Consultar-Reputacao {
    param([string]$IP)

    $MaliciososVT = 0
    $ConfiancaAbuse = 0

    Write-Output "=================================================="
    Write-Output "RELATORIO DE REPUTACAO - IP: $IP"
    Write-Output "=================================================="

    try {
        $HeadersVT = @{ "x-apikey" = $ChaveVirusTotal }
        $UriVT = "https://www.virustotal.com/api/v3/ip_addresses/$IP"
        $RespostaVT = Invoke-RestMethod -Uri $UriVT -Headers $HeadersVT -Method Get

        $StatsVT = $RespostaVT.data.attributes.last_analysis_stats
        $MaliciososVT = $StatsVT.malicious

        Write-Output ""
        Write-Output "--- VirusTotal ---"
        Write-Output "Pais: $($RespostaVT.data.attributes.country)"
        Write-Output "Maliciosos: $($StatsVT.malicious) | Suspeitos: $($StatsVT.suspicious) | Inofensivos: $($StatsVT.harmless)"
    }
    catch {
        Write-Error "Erro ao consultar o VirusTotal para $IP : $_"
    }

    try {
        $HeadersAbuse = @{ "Key" = $ChaveAbuseIPDB; "Accept" = "application/json" }
        $UriAbuse = "https://api.abuseipdb.com/api/v2/check?ipAddress=$IP&maxAgeInDays=90"
        $RespostaAbuse = Invoke-RestMethod -Uri $UriAbuse -Headers $HeadersAbuse -Method Get

        $DadosAbuse = $RespostaAbuse.data
        $ConfiancaAbuse = $DadosAbuse.abuseConfidenceScore

        Write-Output ""
        Write-Output "--- AbuseIPDB ---"
        Write-Output "ISP: $($DadosAbuse.isp)"
        Write-Output "Confianca de Abuso: $($DadosAbuse.abuseConfidenceScore)%"
        Write-Output "Total de denuncias: $($DadosAbuse.totalReports)"
    }
    catch {
        Write-Error "Erro ao consultar o AbuseIPDB para $IP : $_"
    }

    try {
        $UriShodan = "https://internetdb.shodan.io/$IP"
        $RespostaShodan = Invoke-RestMethod -Uri $UriShodan -Method Get

        Write-Output ""
        Write-Output "--- Shodan (InternetDB) ---"
        Write-Output "Portas abertas: $($RespostaShodan.ports -join ', ')"
        Write-Output "Hostnames: $($RespostaShodan.hostnames -join ', ')"
        if ($RespostaShodan.vulns) {
            Write-Output "Vulnerabilidades (CVEs): $($RespostaShodan.vulns -join ', ')"
        }
    }
    catch {
        Write-Output ""
        Write-Output "--- Shodan (InternetDB) ---"
        Write-Output "Nenhum dado encontrado para esse IP (sem portas indexadas)."
    }

    $Veredito = "BAIXO RISCO"
    if ($ConfiancaAbuse -gt 80 -or $MaliciososVT -gt 5) {
        $Veredito = "ALTO RISCO"
    }
    elseif ($ConfiancaAbuse -gt 30 -or $MaliciososVT -gt 2) {
        $Veredito = "MONITORAR"
    }

    Write-Output ""
    Write-Output "--- Veredito Combinado ---"
    Write-Output "Classificacao: $Veredito"
    Write-Output "=================================================="
    Write-Output ""
}

$Ips = $ListaIPs -split "," | ForEach-Object { $_.Trim() }
$Total = $Ips.Count
$Contador = 0

foreach ($Ip in $Ips) {
    $Contador++
    Consultar-Reputacao -IP $Ip

    if ($Contador -lt $Total) {
        Start-Sleep -Seconds 16
    }
}
