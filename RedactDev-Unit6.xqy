(:

1.	Select the sec-unit-06 database and click Run.
2.	You should see "Returned sequence of 30 items".
3.  Examine the elements "clientInformation", "premium", and "assetValue" with randomized numbers as data.
4.  How do you know that the values are random ? 
5.  Run the script again to see that a new set of values are assigned for these attributes. 

Summary: In this script we are applying the redaction rules that we defined earlier "Developer". 
Notice that the attributes for which we created redaction rules for (i.e., the elements "clientInformation", "premium", and "assetValue") 
are no longer the original values but random strings generated and substituted for the original attribute values.  

:)


import module namespace rdt = "http://marklogic.com/xdmp/redaction"
    at "/MarkLogic/redaction.xqy";
    
declare variable $COLLECTION := "Developer";

if (xdmp:database-name(xdmp:database()) = 'sec-unit-06') then
  let $doc := fn:collection("Redaction")
  let $validate := rdt:rule-validate($COLLECTION)
  return rdt:redact($doc, $COLLECTION)
else
  'Please select the sec-unit-06 database from the Database drop down box.'
