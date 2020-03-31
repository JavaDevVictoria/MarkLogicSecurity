(:

1. Execute the script to create a protected path.
2. In this script we are protecting the "//clientInformation" path in the documents to only those who have "PII_read" permissions. 
   
Remember "//clientInfomation" is an element that we are trying to protect no matter which country document it appears in.

:)

xquery version "1.0-ml";
import module namespace sec = "http://marklogic.com/xdmp/security" at 
    "/MarkLogic/security.xqy";
    
if (xdmp:database-name(xdmp:database()) = 'sec-unit-05') then
 xdmp:invoke-function(
  function(){
  sec:protect-path("//clientInformation", (), xdmp:permission("PII_read", "read", "element"))
  },
  <options xmlns="xdmp:eval">
      <database>{xdmp:security-database()}</database>
  </options>
  )  
else
  'Please select the sec-unit-05 database from the Database drop down box.';
