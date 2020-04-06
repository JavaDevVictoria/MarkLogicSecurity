(: 

1. Execute this script against the security database.
2. This sets up the privilege for UK_ops role as admin for only database sec-unit-11.

:)

xquery version "1.0-ml";
import module namespace sec="http://marklogic.com/xdmp/security" at 
    "/MarkLogic/security.xqy";
    
    
if (xdmp:database-name(xdmp:database()) = 'Security') then
                   ( sec:create-privilege("admin-database-sec-unit-11", 
                     fn:concat("http://marklogic.com/xdmp/privileges/admin/database/",xdmp:database("sec-unit-11")), 
                     "execute", 
                     "UK_ops"),
                     "admin-database-sec-unit-11 execute privilege created and granted to role UK_ops.")
else 'Please select the Security database from the Database drop down box.'
