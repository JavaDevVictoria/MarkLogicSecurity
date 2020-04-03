(:

1.	Select the sec-unit-08 database and click Run to protect our temporal document from updates for 90 seconds.

:)

import module namespace temporal = "http://marklogic.com/xdmp/temporal" 
      at "/MarkLogic/temporal.xqy";

if (xdmp:database-name(xdmp:database()) = 'sec-unit-08') then
(
  temporal:document-protect (
    "demo",
    "demo_policy.xml",
    <options xmlns="temporal:document-protect">
      <level>noUpdate</level>
      <duration>PT90S</duration>
    </options>

  )
  ,
  "Document protected."
)  
else
  'Please select the sec-unit-08 database from the Database drop down box.'


