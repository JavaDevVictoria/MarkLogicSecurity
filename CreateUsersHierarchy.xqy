(:

1. Execute the script to create new users.
2. Note that the "Euro_reader" user can see documents that are associated with accounts in France and UK but cannot see documents 
   that are associated with accounts in the US.
3. Note that the "Global_reader" user, however, can see all documents in the database from all countries.

:)

declare variable $USERS := (
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>Global_reader</user-name>
    <password>pass</password>
    <roles>
      <role>Global_read</role>
    </roles>
  </user-properties>
  ,
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>Euro_reader</user-name>
    <password>pass</password>
    <roles>
      <role>Euro_read</role>
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
