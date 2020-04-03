(:

1.	Click Run to add 2 metadata fields and range indexes to our sec-unit-08 database: sys-sart and sys-end.

Note: Metadata refers to a quick and efficient mechanism to capture metadata information of a document represented
as string key and string value pairs outside of the document's root node. In the context of temporal document management, 
metadata is used to store valid and system timestamps and archival information. 

:)

declare variable $PROPERTIES := 
  <database-properties xmlns="http://marklogic.com/manage">
  <range-field-indexes>
    <range-field-index>
      <scalar-type>dateTime</scalar-type>
      <field-name>sys-start</field-name>
      <collation/>
      <range-value-positions>true</range-value-positions>
      <invalid-values>reject</invalid-values>
    </range-field-index>
    <range-field-index>
      <scalar-type>dateTime</scalar-type>
      <field-name>sys-end</field-name>
      <collation/>
      <range-value-positions>true</range-value-positions>
      <invalid-values>reject</invalid-values>
    </range-field-index>
  </range-field-indexes>
  <fields>
    <field>
      <field-name>sys-start</field-name>
      <metadata/>
    </field>
    <field>
      <field-name>sys-end</field-name>
      <metadata/>
    </field>
  </fields>
</database-properties>;

let $options := <options xmlns="xdmp:http">
   <authentication method="digest">
     <username>admin</username>
     <password>admin</password>
   </authentication>
   <!-- xdmp.quote() formats the config object as a string so the REST endpoint understands it -->
   <data>{xdmp:quote($PROPERTIES)}</data>
   <headers>
     <content-type>application/xml</content-type>
   </headers>
 </options>

let $response := xdmp:http-put('http://localhost:8002/manage/v2/databases/sec-unit-08/properties?format=xml', $options)
return if ($response//*:code/string() = "204") then
  $PROPERTIES//*:name || " Metadata fields and range indexes added."
else
  $response[2]//*:message/data()
