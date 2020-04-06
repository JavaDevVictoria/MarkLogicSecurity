(:

1. Execute this script against the security database.
2. This sets up the privilege for FR_index role as index admin for only database sec-unit-11.

:)

xquery version "1.0-ml";
import module namespace sec="http://marklogic.com/xdmp/security" at 
    "/MarkLogic/security.xqy";
        
if (xdmp:database-name(xdmp:database()) = 'Security') then
                     (sec:create-privilege("admin-database-index-sec-unit-11", 
                     fn:concat("http://marklogic.com/xdmp/privileges/admin/database/index/",xdmp:database("sec-unit-11")), 
                     "execute", 
                     "FR_index"),  "admin-index-sec-unit-11 execute privilege created and granted to role FR_index.")
else 'Please select the Security database from the Database drop down box.' 
