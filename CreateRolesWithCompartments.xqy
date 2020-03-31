(:

1. Execute the script to create roles with compartments. 
   We are creating two roles "UK_read" and "US_read" with the "country" compartment. 
2. Notice that these roles form the country compartment. The two other roles "Home_read" and "Commercial_read" form the "property" compartment.
3. There is one role "can_read" which does not have a property assigned. It is a requirement to have a non-compartment role assigned 
   for compartment security. 

:)

declare variable $ROLES := 

(
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>can_read</role-name>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>US_read</role-name>
    <compartment>country</compartment>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>UK_read</role-name>
    <compartment>country</compartment>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>FR_read</role-name>
    <compartment>country</compartment>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>Home_read</role-name>
    <compartment>property</compartment>
  </role-properties>
  ,
  <role-properties xmlns="http://marklogic.com/manage">
    <role-name>Commercial_read</role-name>
    <compartment>property</compartment>
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
