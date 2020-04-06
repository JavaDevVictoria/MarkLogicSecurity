(: 

1. Run the script to test that UK_ops_user has admin access to the sec-unit-11 database.
2. We are adding backup operation to sec-unit-11, which should succeed.

:)

xdmp:eval('
xquery version "1.0-ml";
import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";
let $config := admin:get-configuration()
let $backup := admin:database-monthly-backup("/space/tsoi/backup", 2, 1, xs:time("09:45:00"),2,true(),true(),true())
return admin:save-configuration(admin:database-add-backup($config, xdmp:database("sec-unit-11"), $backup))
',(),
 <options xmlns="xdmp:eval">
  <user-id>{xdmp:user("UK_ops_user")}</user-id>
 </options>)
