(:

1.	Click Run to execute the script.
2.	You should see "[role] has been created" in the results window for each role created.

Summary: In this script we have created the roles "US_read", "Unclassified", "Classified", "Financial" and "Compliance" for 
the ACME insurance company. 

:)

declare variable $ROLES := 
(
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>US_read</role-name>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>Unclassified</role-name>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>Classified</role-name>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>Financial</role-name>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>Compliance</role-name>
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
