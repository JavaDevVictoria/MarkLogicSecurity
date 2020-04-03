(:

1.	Select the sec-unit-08 database and click Run to try to update the protected document.
2.  An error message should be returned:  The document demo_policy.xml is protected noUpdate.

:)

import module namespace temporal = "http://marklogic.com/xdmp/temporal" 
      at "/MarkLogic/temporal.xqy";

if (xdmp:database-name(xdmp:database()) = 'sec-unit-08') then
(
  let $doc := 
    <policy>
      <client>
        <access>ID_read</access>
        <name>Paul</name>
        <last4ssn>5664</last4ssn>
      </client>
      <clientSSN>
        <access>Compliance</access>
        <ssn>999-99-566</ssn>
      </clientSSN>
      <clientIncome>
        <access>Risk</access>
        <income>94,444</income>
      </clientIncome>
      <info>
        <access>Risk</access>
        <propertyType>Home</propertyType>
        <premium>432</premium>
        <assetValue>750000</assetValue>
      </info>
    </policy>
  return temporal:document-insert(
    "demo",
    "demo_policy.xml",
    $doc,
    <options xmlns="xdmp:document-insert">  
      <collections>
        <collection>Security_Workshop</collection>
      </collections>
    </options>
  )
)  
else
  'Please select the sec-unit-08 database from the Database drop down box.'

