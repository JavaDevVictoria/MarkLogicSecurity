(:

1.	Select the sec-unit-08 database and click Run to try to delete the document.
2.  An error message should be returned:  The temporal document demo_policy.xml is protected noUpdate.

:)

import module namespace temporal = "http://marklogic.com/xdmp/temporal" 
      at "/MarkLogic/temporal.xqy";

if (xdmp:database-name(xdmp:database()) = 'sec-unit-08') then
(
  let $cur-time := fn:current-dateTime()
  let $exp-time := xs:dateTime(xdmp:document-get-metadata-value("demo_policy.xml","temporalProtectExTime"))
  return if ($exp-time lt $cur-time) then
    (temporal:document-wipe("demo", "demo_policy.xml"), "Document deleted.")
  else if (xdmp:exists(cts:search(/, cts:document-query('demo_policy.xml')))) then
    "This temporal document is protected."
  else
    "This temporal document does not exist."
)  
else
  'Please select the sec-unit-08 database from the Database drop down box.'
