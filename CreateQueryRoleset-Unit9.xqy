(:

1.  Select the sec-unit-09 database and click Run to execute the script.
2.	You should see numbers returned.

Summary: In this script we create rolesets that we covered earlier when learning about Element Level Security. 

:)

xquery version "1.0-ml";
import module namespace sec = "http://marklogic.com/xdmp/security" at 
    "/MarkLogic/security.xqy";

if (xdmp:database-name(xdmp:database()) = 'sec-unit-09') then
  let $rolesets := xdmp:invoke-function(
    function(){
      xdmp:database-node-query-rolesets(fn:doc())
    },
    <options xmlns="xdmp:eval">
      <database>{xdmp:database("sec-unit-09")}</database>
    </options>
  )
  return 
  xdmp:invoke-function(
  function(){
    sec:add-query-rolesets($rolesets)
    },
   <options xmlns="xdmp:eval">
      <database>{xdmp:security-database()}</database>
  </options>
  )  
else
  'Please select the sec-unit-09 database from the Database drop down box.';
