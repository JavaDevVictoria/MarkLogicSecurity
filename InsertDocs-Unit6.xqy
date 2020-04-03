(:

1.	Select the sec-unit-06 database and click Run.
2.	"Documents inserted" should appear in the results window.

:)

declare variable $policyPerCountryCount := 10;
declare variable $SURNAMES := ("Smith", "Jones", "Williams", "Taylor", "Brown", "Davies", "Evans");
declare variable $FIRSTNAMES := ("James", "John", "Robert", "Mary", "Jennifer", "Elizabeth");
declare variable $STREET := ("Broadway", "Regent", "Main", "Defence", "Command", "Conquer");
declare variable $CURRENCIES := ("USD","GBP", "EUR");
declare variable $PROPERTY := ("Home", "Commercial", "Industrial", "Auto","Vessel");
declare variable $COUNTRY := ("US", "UK", "FR");


declare function local:random-item(
  $items as xs:string+
) as xs:string {
  let $index := 1 + xdmp:random(count($items) - 1)
  return $items[$index]
};

if (xdmp:database-name(xdmp:database()) = 'sec-unit-06') then
(
  for $country at $index in $COUNTRY
  for $j in (1 to $policyPerCountryCount)
  let $policyId := xdmp:random() + 1000
  let $name := concat(local:random-item($FIRSTNAMES), " ", local:random-item($SURNAMES))
  let $address := concat(xdmp:random(100), " ", local:random-item($STREET))
  let $uuid := sem:uuid-string()
  let $phone := string(xdmp:random(8999999999) + 1000000000)
  let $propertyType := local:random-item($PROPERTY)
  let $policy := 
    <policy>
      <clientInformation>
        <name>{$name}</name>
        <address>{$address}</address>
        <phone>{$phone}</phone>
        <country>{$country}</country>
      </clientInformation>
      <policyInformation>
        <policyId>{$policyId}</policyId>
        <propertyType>{$propertyType}</propertyType>
        <premium>{xdmp:random(100000)}</premium>
        <assetValue>{xdmp:random(1000000)}</assetValue>
        <currency>{$CURRENCIES[$index]}</currency>
      </policyInformation>
    </policy>
  return xdmp:document-insert(
    concat("/security/", $country, $j, ".xml"),
    $policy,
    <options xmlns="xdmp:document-insert">  
      <collections>
        <collection>{$country}</collection>
        <collection>{$propertyType}</collection>
        <collection>Security</collection>
        <collection>Redaction</collection>
      </collections>
    </options>
  )
  ,
  "Documents inserted."
)
else
  'Please select the sec-unit-06 database from the Database drop down box.'
