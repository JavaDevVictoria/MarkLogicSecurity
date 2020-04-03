(:

1.	Select the sec-unit-09 database and click Run.
2.  A success message should display: Document inserted.
3.  Click the Explore button. There should be 1 document in the database.
4.  Examine the document content.

Summary: In this script we have created a single policy document for policy . This document includes different
types of client information under different sections.

Note: in each section of the policy document there is a classification property/element with a role as value and for one of them 
we have a department property element with a role as value.

:)
if (xdmp:database-name(xdmp:database()) = 'sec-unit-09') then
(
  let $policy := 
  <policy>
    <classification>US Read</classification>
    <clientInformation>
      <classification>Classified</classification>
      <name>Paul</name>
      <address>999 Broadway St</address>
      <phone>323-344-1555</phone>
      <country>US</country>
      <ssn4digits>5664</ssn4digits>
    </clientInformation>
    <clientSocialSecurity>
      <classification>Classified</classification>
      <department>Compliance</department>
      <ssn>999-999-5664</ssn>
    </clientSocialSecurity>
    <clientFinancials>
      <classification>Financial</classification>
      <income>44,4444</income>
    </clientFinancials>
    <policyInformation>
      <classification>Financial</classification>
      <propertyType>Home</propertyType>
      <premium>432</premium>
      <assetValue>750000</assetValue>
      <currency>Dollar</currency>
    </policyInformation>
  </policy>
  return xdmp:document-insert(
    concat("US_policy.xml"),
    $policy,
    <options xmlns="xdmp:document-insert">  
      <collections>
        <collection>Security</collection>
      </collections>
      <permissions>{
        xdmp:permission("US_read", "read")
      }</permissions>
    </options>
  )
  ,
  "Document inserted."
)  
else
  'Please select the sec-unit-09 database from the Database drop down box.'
