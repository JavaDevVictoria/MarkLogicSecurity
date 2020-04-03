(:

1.	Select the sec-unit-06 database and "Run".
2.	You should see "Returned sequence of 30 items"  in the results window.
3.  Notice the redacted client records.
4.  How do you know that the values are random ? 
5.  Run the script again to see that a new set of values are assigned for these attributes.
6.  Did you notice that the values did not change each time run the script ? Can you answer why ?

Answer: The redaction rule that was specified for "Developer" was "random" but the one that was specified for "ProductManager" was 
        "mask-deterministic" which means that the same value is used every time. "mask-random" which was the rule used for the "Developer"
        generates a random value everytime it is run.

Summary: In this script we are applying the redaction rules that we defined earlier for "ProductManager". 
          Notice that the attributes for which we created redaction rules for are no longer the original values
          but random string is generated and the attribute values changed.

:)

import module namespace rdt = "http://marklogic.com/xdmp/redaction"
    at "/MarkLogic/redaction.xqy";
    
declare variable $COLLECTION := "ProductManager";

if (xdmp:database-name(xdmp:database()) = 'sec-unit-06') then
  let $doc := fn:collection("Redaction")
  let $validate := rdt:rule-validate($COLLECTION)
  return rdt:redact($doc, $COLLECTION)
else
  'Please select the sec-unit-06 database from the Database drop down box.';
