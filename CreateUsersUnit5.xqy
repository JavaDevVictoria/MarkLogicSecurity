(:

1. Execute the script to create users.
   "US_reader", "UK_reader" and "FR_reader" are users for the 3 different geographical regions for the ACME insurance company.
   "Global_reader" can access generic information for all documents.
   "Euro_PII_reader" user can access European PII and "Global_PII_reader" can access all PII. 

:)

declare variable $USERS := (
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
  ,
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>Global_reader</user-name>
    <password>pass</password>
    <roles>
      <role>Global_read</role>
    </roles>
  </user-properties>
  ,
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>Euro_PII_reader</user-name>
    <password>pass</password>
    <roles>
      <role>Euro_read</role>
      <role>PII_read</role>
    </roles>
  </user-properties>
  ,
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>Global_PII_reader</user-name>
    <password>pass</password>
    <roles>
      <role>Global_read</role>
      <role>PII_read</role>
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
  ($user//*:user-name/string, $response)
