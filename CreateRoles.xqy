(:

1. Execute the script to create roles that will be added to the Security database.
2. The 3 roles to create are: US_read, UK_read, FR_read.

:)

xquery version "1.0-ml";
for $role in ('US_read', 'UK_read', 'FR_read')

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
  ($data//*:role-name/string(), $response[2])
