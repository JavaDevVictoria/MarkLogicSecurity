(:

1.	Click Run to execute the code and add a adds a system axis to the "Schemas" database.
2.  Select the "Schemas" database and click "Explore". You should see a
    temporal axis document in the collection "http://marklogic.com/xdmp/temporal/axis".

Note: An Axis is a named pair of range indexes that is the container for periods. 
Bi-temporal documents have both a valid and a system axes. Uni-temporal documents have only a system axis.

:)

let $axis := <temporal-axis-properties xmlns="http://marklogic.com/manage/temporal-axis/properties">
<axis-name>system</axis-name>
  <axis-start>
    <cts:field-reference xmlns:cts="http://marklogic.com/cts">
    <cts:field-name>sys-start</cts:field-name>
    </cts:field-reference>
  </axis-start>
  <axis-end>
    <cts:field-reference xmlns:cts="http://marklogic.com/cts">
    <cts:field-name>sys-end</cts:field-name>
    </cts:field-reference>
  </axis-end>
</temporal-axis-properties>

let $options := <options xmlns="xdmp:http">
   <authentication method="digest">
     <username>admin</username>
     <password>admin</password>
   </authentication>
   <!-- xdmp.quote() formats the config object as a string so the REST endpoint understands it -->
   <data>{xdmp:quote($axis)}</data>
   <headers>
     <content-type>application/xml</content-type>
   </headers>
 </options>
 
let $response := xdmp:http-post('http://localhost:8002/manage/v2/databases/sec-unit-08/temporal/axes', $options)
return if ($response//*:code/string() = "201") then
  $axis//*:axis-name || " axis added."
  
else
  $response
