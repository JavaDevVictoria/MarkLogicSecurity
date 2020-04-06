(:

1.	Select the sec-unit-10 database and click Run.
2.  How do you know that the values are random ? Run the script again to see that a new set of values are assigned for
    these attributes. 
3.  Can you calculate the proportional value factor of the premium based on the random asset value that was generated?
    Hint: If you came up with 0.1 then you are correct..
4.  As we learned earlier how to explore documents in a database see if you can identify a couple of documents    
    and look at the original documents and identify the correct attributes and compare them with the redacted values....
5. (optional)  Modify the custom function for other proportional factors and make sure that you understand how this function works.

Summary: In this script we apply the redaction rules that we defined earlier.
When the redaction rule is invoked it calls the custom redaction function that was defined.

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
