(:

1. Execute the script to create 90 documents.
   In this script we have created policy holder documents and set permissions on them based on their country of origin . 
   In the next few exercises we will see how PII access is controlled.

:)

declare variable $policyPerCountryCOUNT := 30;
declare variable $LAST_NAMES := ("Smith", "Jones", "Williams", "Taylor", "Brown", "Davies", "Evans");
declare variable $FIRST_NAMES := ("James", "John", "Robert", "Mary", "Jennifer", "Elizabeth");
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

if (xdmp:database-name(xdmp:database()) = 'sec-unit-05') then
(
  for $country at $index in $COUNTRY
  for $j in (1 to $policyPerCountryCOUNT)
  let $policyId := xdmp:random() + 1000
  let $name := concat(local:random-item($FIRST_NAMES), " ", local:random-item($LAST_NAMES))
  let $address := concat(xdmp:random(100), " ", local:random-item($STREET))
  let $uuid := sem:uuid()
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
      </collections>
      <permissions>{
        xdmp:permission(concat($country, "_read"), "read")
      }</permissions>
    </options>
  )
  ,
  "Documents inserted."
)  
else
  'Please select the sec-unit-05 database from the Database drop down box.'
