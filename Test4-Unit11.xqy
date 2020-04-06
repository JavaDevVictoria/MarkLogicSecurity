(: 

1. Run the script to test that FR_index_user DOES NOT have the right to back-up the sec-unit-11 database.
2. We are adding backup operation to sec-unit-11, which should fail.

:)

  
xdmp:eval('
xquery version "1.0-ml";
import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";
let $config := admin:get-configuration()
let $backup := admin:database-monthly-backup("/space/tsoi/backup", 2, 1, xs:time("09:45:00"),2,true(),true(),true())
return admin:save-configuration(admin:database-add-backup($config, xdmp:database("sec-unit-11"), $backup))
',(),
 <options xmlns="xdmp:eval">
  <user-id>{xdmp:user("FR_index_user")}</user-id>
 </options>)
