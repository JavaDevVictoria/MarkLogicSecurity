(:

1.	Select the sec-unit-09 database and click Run to execute the script.
2.	You should see numbers returned.

Summary: In this script we restrict access to Client Information using XPath with a predicate on a value.

:)

xquery version "1.0-ml";
import module namespace sec = "http://marklogic.com/xdmp/security" at 
    "/MarkLogic/security.xqy";
    
if (xdmp:database-name(xdmp:database()) = 'sec-unit-09') then
xdmp:invoke-function(
function(){
  sec:protect-path("//clientInformation[classification='Classified']", (), xdmp:permission("Classified", "read", "element")),
  sec:protect-path("//clientSocialSecurity[classification='Classified']", (), xdmp:permission("Classified", "read", "element")),
  sec:protect-path("//clientSocialSecurity[department='Compliance']", (), xdmp:permission("Compliance", "read", "element")),
  sec:protect-path("//clientFinancials[classification='Financial']", (), xdmp:permission("Financial", "read", "element")),
  sec:protect-path("//policyInformation[classification='Financial']", (), xdmp:permission("Financial", "read", "element"))
  },
   <options xmlns="xdmp:eval">
      <database>{xdmp:security-database()}</database>
  </options>  
)
else
  'Please select the sec-unit-09 database from the Database drop down box.';
