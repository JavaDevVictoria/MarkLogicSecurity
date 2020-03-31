(:

1.Execute the script to create query rolesets for the previously created protected paths.

:)

xquery version "1.0-ml";
import module namespace sec = "http://marklogic.com/xdmp/security" at 
    "/MarkLogic/security.xqy";

if (xdmp:database-name(xdmp:database()) = 'sec-unit-05' )then
 let $rolesets := xdmp:invoke-function(
  function(){
  xdmp:database-node-query-rolesets(fn:doc())
  },
  <options xmlns="xdmp:eval">
      <database>{xdmp:database('sec-unit-05')}</database>
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
  'Please select the sec-unit-05 database from the Database drop down box.';
