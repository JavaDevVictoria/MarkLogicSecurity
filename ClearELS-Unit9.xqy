(:

1.	Execute the script to unprotect and delete existing protected paths from the security database attached to our sec-unit-09 database.

:)

xquery version "1.0-ml";
import module namespace sec = "http://marklogic.com/xdmp/security" at 
    "/MarkLogic/security.xqy";

if (xdmp:database-name(xdmp:database()) = 'sec-unit-09') then
(
  xdmp:invoke-function(function(){
    let $paths := fn:collection('http://marklogic.com/xdmp/protected-paths')
    for $path in $paths
    return sec:unprotect-path($path//sec:path-expression, ())
  },
    <options xmlns="xdmp:eval">
      <database>{xdmp:security-database()}</database>
    </options>
   )
  ,
  xdmp:sleep(5)
  ,
  xdmp:invoke-function(function(){
  let $paths := fn:collection('http://marklogic.com/xdmp/protected-paths')
  for $path in $paths
  return sec:remove-path($path//sec:path-expression, ())
  },
    <options xmlns="xdmp:eval">
      <database>{xdmp:security-database()}</database>
    </options>
  )
  ,
   xdmp:invoke-function(function(){
  let $qrss := fn:collection('http://marklogic.com/xdmp/query-rolesets')
  for $qrs in $qrss
  return sec:remove-query-rolesets($qrs//sec:query-rolesets)
  },
    <options xmlns="xdmp:eval">
      <database>{xdmp:security-database()}</database>
    </options>
  )
  ,
  'Protected paths and query rolesets cleared.'
)
else 
  'Please select the sec-unit-09 database from the Database drop down box.';
