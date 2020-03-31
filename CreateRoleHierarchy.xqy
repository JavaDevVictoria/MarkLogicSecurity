(:

Execute the script to create a role hierarchies. 
The "Euro_read" role can see documents that are associated with accounts in France and UK but cannot see documents that are associated with accounts in the US. 
The "Global_read" role, however, can see all documents in the database from all countries.

:)

declare variable $ROLES := 
(
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
