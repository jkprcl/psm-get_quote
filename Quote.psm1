#$Quote = (Invoke-WebRequest  -Method Get -Uri "https://api.quotable.io/random?tags=technology" -UseBasicParsing).content | ConvertFrom-Json; Write-Host "`"$($Quote.Content)`" - $($Quote.Author)"
function Get-Quote{
    param(
        [Parameter(Mandatory=$false)]
        [ValidateSet('athletics','business','change','character','competition','conservative','courage','education','faith','family','famous-quotes','film','freedom','friendship','future','happiness','history','honor','humor','humorous','inspirational','leadership','life','literature','love','motivational','nature','pain','philosophy','politics','power-quotes','proverb','religion','science','self','self-help','social-justice','spirituality','sports','success','technology','time','truth','virtue','war','wisdom')]
        [string[]]$Tags,
        [Parameter(Mandatory=$false)]
        [string]$QuoteApiUrl = 'https://api.quotable.io/random'
    )
    if($null -ne $Tags){
        $TagList = ''
        for($I = 0; $I -lt $Tags.Count; $I++){
            if($I -eq 0){
                $TagList += $Tags[$I]
            }
            else{
                $TagList += ",$($Tags[$I])"
            }
        }
        $QuoteApiUrl += "?tags=$TagList"
    }
    $Quote = Invoke-WebRequest -UseBasicParsing -Uri $QuoteApiUrl | Select-Object -ExpandProperty Content | ConvertFrom-Json
    return $Quote
}
