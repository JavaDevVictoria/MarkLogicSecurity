(:

1. Execute the code to create 3 users that will be added to the Security database: US_reader, UK_reader, FR_reader.

:)

for $user in (
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>US_reader</user-name>
    <password>pass</password>
    <roles>
      <role>US_read</role>
    </roles>
  </user-properties>
  ,
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>UK_reader</user-name>
    <password>pass</password>
    <roles>
      <role>UK_read</role>
    </roles>
  </user-properties>
  ,
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>FR_reader</user-name>
    <password>pass</password>
    <roles>
      <role>FR_read</role>
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
