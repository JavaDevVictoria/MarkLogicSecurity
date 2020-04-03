(:

1. Click Run to delete the demo temporal collection and system axis from the Schema database attached to the sec-unit-08 database.

:)

xquery version "1.0-ml";

import module namespace temporal = "http://marklogic.com/xdmp/temporal" 
      at "/MarkLogic/temporal.xqy";
      
if (xdmp:database-name(xdmp:database()) = 'sec-unit-08') then
(  
   temporal:collection-remove("demo"),
   temporal:axis-remove("system"),
   "Temporal collection and axis removed.")
  else
('Please select the sec-unit-08 database from the Database drop down box.')
