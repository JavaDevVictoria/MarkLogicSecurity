(: 

1. Execute the script to create admin users for the different regions.

:)

xquery version "1.0-ml";
for $user in (
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>US_admin_user</user-name>
    <password>pass</password>
    <roles>
      <role>US_admin</role>
    </roles>
  </user-properties>
  ,
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>UK_ops_user</user-name>
    <password>pass</password>
    <roles>
      <role>UK_ops</role>
    </roles>
  </user-properties>
  ,
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>FR_index_user</user-name>
    <password>pass</password>
    <roles>
      <role>FR_index</role>
    </roles>
  </user-properties>
)
let $options := <options xmlns="xdmp:http">
   <authentication method="digest">
     <username>admin</username>
     <password>admin</password>
   </authentication>
   <!-- xdmp.quote() formats the config object as a string so the REST endpoint understands it -->
   <data>{xdmp:quote($user)}</data>
   <headers>
     <content-type>application/xml</content-type>
   </headers>
 </options>
let $response := xdmp:http-post('http://localhost:8002/manage/v2/users?format=xml', $options)
return if ($response//*:code/string() = "201") then
  $user//*:user-name || " user has been created."
else
  ($user//*:user-name/string(), $response)
