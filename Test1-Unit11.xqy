(: 

1. Run the script to test that UK_ops_user DOES NOT HAVE admin access to Documents.
2. We are trying to add range index named "column1" to the Documents database, which should fail.

:)

xdmp:eval('
xquery version "1.0-ml";
import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";
let $config := admin:get-configuration()
let $dbid := xdmp:database("Documents")
let $rangespec := admin:database-range-element-index("int", "http://marklogic.com/qa",
                "column1", (), fn:false() )
let $config := admin:database-add-range-element-index($config, $dbid, $rangespec)
return admin:save-configuration($config)
',(),
 <options xmlns="xdmp:eval">
  <user-id>{xdmp:user("UK_ops_user")}</user-id>
 </options>)
