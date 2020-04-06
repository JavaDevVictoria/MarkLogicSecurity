(: 

1.	Select the sec-unit-10 database and click Run.
2.	You should see “Returned sequence of items in …”
3.  How do you know that the values are random ?
4.  Can you identify which information stays the same every time you run the script and which ones change every time?

Summary: In this script we apply the redaction rules that we defined earlier.
Notice that the attributes for which we created redaction rules for are no longer the original values but random string.  

:)

import module namespace rdt = "http://marklogic.com/xdmp/redaction"
    at "/MarkLogic/redaction.xqy";
    
declare variable $COLLECTION_UAT := "rdt_UAT";

if (xdmp:database-name(xdmp:database()) = 'sec-unit-10') then
  let $doc := fn:collection("Production")
  let $validate := rdt:rule-validate($COLLECTION_UAT)
  return rdt:redact($doc, $COLLECTION_UAT)
else
  'Please select the sec-unit-10 database from the Database drop down box.';
