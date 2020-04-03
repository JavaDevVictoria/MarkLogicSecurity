(:
    
1.	Select the sec-unit-08 database and click Run to insert a temporal document in the database.
2.  Click the Explore button. There should be 1 document in the database.
3.  Click on the document in the list. Notice that the document describes different access policies for different client information
    within the document: //client/name , //clientSSN , //clientIncome , //info .
4.  View the document Metadata. 
5.  If you inserted this document several times you should see different versions.

:)

import module namespace temporal = "http://marklogic.com/xdmp/temporal" 
      at "/MarkLogic/temporal.xqy";

if (xdmp:database-name(xdmp:database()) = 'sec-unit-08') then
(
  let $doc := 
    <policy>
      <access>US Read</access>
      <client>
        <access>ID_read</access>
        <name>Paul</name>
        <last4ssn>5664</last4ssn>
      </client>
      <clientSSN>
        <access>Compliance</access>
        <ssn>999-99-5664</ssn>
      </clientSSN>
      <clientIncome>
        <access>Risk</access>
        <income>44,444</income>
      </clientIncome>
      <info>
        <access>Risk</access>
        <propertyType>Home</propertyType>
        <premium>425</premium>
        <assetValue>750000</assetValue>
      </info>
    </policy>
  return temporal:document-insert(
    "demo",
    "demo_policy.xml",
    $doc,
    <options xmlns="xdmp:document-insert">  
      <collections>
        <collection>Security</collection>
      </collections>
    </options>
  )
  ,
  "Temporal document inserted."
)  
else
  'Please select the sec-unit-08 database from the Database drop down box.'


