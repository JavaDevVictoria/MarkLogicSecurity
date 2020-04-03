(:
  
  This is Helper function - Use only if you are stuck and need to clear everything.
  Note: Please do not run the scripts "Remove Rules" and "Tear Down" unless directed by the instructor.
  This must run against the sec-unit-6 database.
 
:)

import module namespace admin = "http://marklogic.com/xdmp/admin"
		  at "/MarkLogic/admin.xqy";

if (xdmp:database-name(xdmp:database()) = 'sec-unit-06') then
(
  let $config := admin:get-configuration()
  let $forests := admin:database-get-attached-forests($config, xdmp:database("sec-unit-06"))
  return xdmp:forest-clear($forests)
  ,
  "Data cleared."
)
else
 'Please select the sec-unit-06 database from the Database drop down box.';
