(:

1.	Click Run to execute the script.
2.	You should see "[user] has been created" in the results window for each user created.
3.  Which user is not allowed to read sensitive information? 

Summary: In this script we have created users "Userfoo", "UserClassified" , "ComplianceUserClassified" and "RiskOfficer" with a password of "pass"
for the ACME insurance company. Each user has been assigned one or multiple roles.

:)

declare variable $USERS := (
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>UserFoo</user-name>
    <password>pass</password>
    <roles>
      <role>US_read</role>
    </roles>
  </user-properties>
  ,
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>UserClassified</user-name>
    <password>pass</password>
    <roles>
      <role>US_read</role>
      <role>Classified</role>
    </roles>
  </user-properties>
  ,
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>ComplianceUserClassified</user-name>
    <password>pass</password>
    <roles>
      <role>US_read</role>
      <role>Compliance</role>
      <role>Classified</role>
    </roles>
  </user-properties>
  ,
  <user-properties xmlns="http://marklogic.com/manage">
    <user-name>RiskOfficer</user-name>
    <password>pass</password>
    <roles>
      <role>US_read</role>
      <role>Financial</role>
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
