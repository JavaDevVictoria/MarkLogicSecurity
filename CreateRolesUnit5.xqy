(:

1. Execute the script to create roles.
2. In this script we are creating the "US_read", "UK_read" , "FR_read" roles for the 3 different geographical regions of the ACME insurance 
   company. In addition, we are building on these basic roles and creating hierarchical roles: "Euro_read" and "Global_read". 
3. The PII_read role is created to later define access to Personal Identifiable Information within documents.
4. As an exercise see if you can figure out how "Euro_PII_read" and "Global_PII_read" roles are created and what permissions those roles have.

:)

declare variable $ROLES := 
(
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>US_read</role-name>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>UK_read</role-name>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>FR_read</role-name>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>PII_read</role-name>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>Euro_read</role-name>
    <roles>
      <role>UK_read</role>
      <role>FR_read</role>
    </roles>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>Global_read</role-name>
    <roles>
      <role>US_read</role>
      <role>UK_read</role>
      <role>FR_read</role>
    </roles>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>Euro_PII_read</role-name>
    <roles>
      <role>Euro_read</role>
      <role>PII_read</role>
    </roles>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>Global_PII_read</role-name>
    <roles>
      <role>Global_read</role>
      <role>PII_read</role>
    </roles>
  </role-properties>
);

for $role in $ROLES
let $options := <options xmlns="xdmp:http">
   <authentication method="digest">
     <username>admin</username>
     <password>admin</password>
   </authentication>
   <!-- xdmp.quote() formats the config object as a string so the REST endpoint understands it -->
   <data>{xdmp:quote($role)}</data>
   <headers>
     <content-type>application/xml</content-type>
   </headers>
 </options>
let $response := xdmp:http-post('http://localhost:8002/manage/v2/roles?format=xml', $options)
return if ($response//*:code/string() = "201") then
  $role//*:role-name || " role has been created."
else
  ($role//*:role-name/string(), $response)
