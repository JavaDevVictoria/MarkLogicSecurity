(:

1. Execute the script to create two users: "US_Home_reader" with the roles "US_read", "Home_read", 
   which are compartmented roles with the country compartment and property compartment
   and "UK_Commercial_reader" with the roles "UK_read", "Commercial_read", which are also compartmented roles (country and property comparments).
2. Note that "can_read" is common to both users as it is requirement of compartment security.

:)

declare variable $USERS := (
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>US_Home_reader</user-name>
    <password>pass</password>
    <roles>
      <role>can_read</role>
      <role>US_read</role>
      <role>Home_read</role>
    </roles>
  </user-properties>
  ,
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>UK_Commercial_reader</user-name>
    <password>pass</password>
    <roles>
      <role>can_read</role>
      <role>UK_read</role>
      <role>FR_read</role>
      <role>Commercial_read</role>
    </roles>
  </user-properties>
);

for $user in $USERS
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
