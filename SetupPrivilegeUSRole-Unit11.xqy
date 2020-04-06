(: 

1. Execute this script against the security database.
2. This sets up the privilege for US_admin role as admin for all databases.

:)
  
xquery version "1.0-ml";
import module namespace sec="http://marklogic.com/xdmp/security" at 
    "/MarkLogic/security.xqy";

if (xdmp:database-name(xdmp:database()) = 'Security') then
    sec:privilege-set-roles(
    "http://marklogic.com/xdmp/privileges/admin/database", 
     "execute", ("admin","US_admin"))
else
  'Please select the Security database from the Database drop down box.';
