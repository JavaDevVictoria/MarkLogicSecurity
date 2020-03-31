(:

1. Select the sec-101 database and execute the code. 90 documents should be added to the database.

2. Click on any document in the list and view its permissions, which should match the country the policy document originated from. 

3. Note that this script assigns permissions based on the document country of origin.

:)

declare variable $policyPerCountryCOUNT := 30;
declare variable $SURNAMES := ("Smith", "Jones", "Williams", "Taylor", "Brown", "Davies", "Evans");
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

declare function local:mask_id(
  $id as xs:string
) as xs:string {
  replace($id, "^(\d{3})-(\d{2})-(\d{4})","XXXX-XXX-$3")
};

if (xdmp:database-name(xdmp:database()) = 'sec-101') then
(
  for $country at $index in $COUNTRY
  for $j in (1 to $policyPerCountryCOUNT)
  let $policy-id := xdmp:random(999) + 1000
  let $name as xs:string := concat(local:random-item($FIRST_NAMES), " ", local:random-item($SURNAMES))
  let $address as xs:string := concat(xdmp:random(100) + 1, " ", local:random-item($STREET))
  let $uid := fn:string-join((fn:string(xdmp:random(899) + 100), fn:string(xdmp:random(89) + 10), fn:string(xdmp:random(8999) + 1000)), "-")
  let $masked_uid := local:mask_id($uid)
  let $phone := fn:string-join((fn:string(xdmp:random(899) + 100), fn:string(xdmp:random(899) + 100), fn:string(xdmp:random(8999) + 1000)), "-")
  let $property-type as xs:string := local:random-item($PROPERTY)
  let $asset-value := xdmp:random(899999) + 100000
  let $premium := xs:int(sem:random() * .3 * $asset-value)
  let $policy := <policy>
    <client-information>
      <name>{$name}</name>
      <id>{$uid}</id>
      <masked_id>{$masked_uid}</masked_id>
      <address>{$address}</address>
      <phone>{$phone}</phone>
      <country>{$country}</country>
    </client-information>
    <policy-information>
      <policyID>{$policy-id}</policyID>
      <property>{$property-type}</property>
      <premium>{$premium}</premium>
      <asset-value>{$asset-value}</asset-value>
      <currency>{$CURRENCIES[$index]}</currency>
    </policy-information>
  </policy>
  return xdmp:document-insert(
    concat("/security/", $country, $j, ".xml"),
    $policy,
    <options xmlns="xdmp:document-insert">  
      <collections>
        <collection>{$country}</collection>
        <collection>{$property-type}</collection>
        <collection>Security</collection>
      </collections>
      <permissions>{
        xdmp:permission(concat($country, "_read"), "read")
      }</permissions>
    </options>
  )
  ,
  'Documents inserted.'
)
else
  'Please select the sec-101 database from the Database drop down box.'
