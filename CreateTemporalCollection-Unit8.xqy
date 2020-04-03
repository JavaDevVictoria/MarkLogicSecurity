(:

1.	Click Run to execute the code and create a temporal collection.
2.  Select the "Schemas" database and click "Explore". You should see a
    temporal collection document in the collection "http://marklogic.com/xdmp/temporal/collection".
    
:)

let $collection := <temporal:collection xml:lang="zxx" xmlns:temporal="http://marklogic.com/xdmp/temporal">
  <temporal:collection-name>demo</temporal:collection-name>
  <temporal:system-axis>system</temporal:system-axis>
</temporal:collection>


let $collection := object-node{
  "collection-name": "demo",
  "system-axis": "system"
}
let $options := <options xmlns="xdmp:http">
   <authentication method="digest">
     <username>admin</username>
     <password>admin</password>
   </authentication>
   <!-- xdmp.quote() formats the config object as a string so the REST endpoint understands it -->
   <data>{xdmp:quote($collection)}</data>
   <headers>
     <content-type>application/json</content-type>
   </headers>
 </options>
let $response := xdmp:http-post('http://localhost:8002/manage/v2/databases/sec-unit-08/temporal/collections', $options)
return if ($response//*:code/string() = "201") then
  $collection//*:collection-name || " collection added."
else
  $response[2]
