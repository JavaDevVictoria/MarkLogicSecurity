(:
  
1.	Select the sec-unit-10 database and click Run to insert policy documents.

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

if (xdmp:database-name(xdmp:database()) = 'sec-unit-10') then
(
  for $country at $index in $COUNTRY
  for $j in (1 to $policyPerCountryCOUNT)
  let $policyId := xdmp:random() + 1000
  let $name := concat(local:random-item($FIRST_NAMES), " ", local:random-item($LAST_NAMES))
  let $address := concat(xdmp:random(100), " ", local:random-item($STREET))
  let $ssn := concat((xdmp:random(899)+100), "-", (xdmp:random(89)+10), "-", (xdmp:random(8999)+1000))

  let $phone := string(xdmp:random(8999999999) + 1000000000)
  let $propertyType := local:random-item($PROPERTY)
  let $policy :=
    <policy>
      <clientInformation>
        <name>{$name}</name>
        <address>{$address}</address>
        <phone>{$phone}</phone>
        <country>{$country}</country>
        <ssn>{$ssn}</ssn>
      </clientInformation>
      <policyInformation>
        <policyId>{$policyId}</policyId>
        <property>{$propertyType}</property>
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
        <collection>Production</collection>
      </collections>
    </options>
  )
  ,
  "Documents inserted."
)  
else
  'Please select the sec-unit-10 database from the Database drop down box.'
