(: 

1. Run the script to test that FR_index_user has "create range index" access to sec-unit-11. 
2. A "column2" range index should be added to the sec-unit-11 database successfully.

:)

xdmp:eval('
xquery version "1.0-ml";
import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";
let $config := admin:get-configuration()
let $dbid := xdmp:database("sec-unit-11")
let $rangespec := admin:database-range-element-index("int", "http://marklogic.com/qa",
                "column2", (), fn:false() )
let $config := admin:database-add-range-element-index($config, $dbid, $rangespec)
return admin:save-configuration($config)
',(),
 <options xmlns="xdmp:eval">
  <user-id>{xdmp:user("FR_index_user")}</user-id>
 </options>)
