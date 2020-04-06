(: 

1. Execute the script to create a few admin roles for the different regions.

:)

xquery version "1.0-ml";

for $role in ('US_admin', 'UK_ops', 'FR_index')
return 

let $data := <role-properties xmlns="http://marklogic.com/manage">
  <role-name>{$role}</role-name>
</role-properties>
let $options := <options xmlns="xdmp:http">
   <authentication method="digest">
     <username>admin</username>
     <password>admin</password>
   </authentication>
   <!-- xdmp.quote() formats the config object as a string so the REST endpoint understands it -->
   <data>{xdmp:quote($data)}</data>
   <headers>
     <content-type>application/xml</content-type>
   </headers>
 </options>
let $response := xdmp:http-post('http://localhost:8002/manage/v2/roles?format=xml', $options)
return if ($response//*:code/string() = "201") then
  $data//*:role-name || " role has been created."
else
  ($data//*:role-name/string(), $response)
