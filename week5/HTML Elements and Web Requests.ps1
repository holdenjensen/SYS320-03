#Deliverable 1
$scraped_page = Invoke-WebRequest -TimeOutSec 10 http://10.0.17.45/ToBeScraped.html
$scraped_page.Links.Count

#Deliverable 2
$scraped_page.Links

#Deliverable 3
$scraped_page.Links | Format-Table outerText, href

#Deliverable 4
$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object outerText

$h2s

#Deliverable 5
$divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | Where-Object { $_.getAttributeNode("class").value -ilike "*div-1*" } | Select-Object innertext

$divs1