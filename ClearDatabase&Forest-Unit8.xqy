(:

1. Click Run to delete the sec-unit-08 database and its forest.

:)
xquery version "1.0-ml";  

    let $name := 'sec-unit-08'
    let $options := <options xmlns="xdmp:http">
       <authentication method="digest">
         <username>admin</username>
         <password>admin</password>
       </authentication>
     </options>
    let $responses := (
      xdmp:http-delete(fn:concat("http://localhost:8002/manage/v2/databases/", $name, "?forest-delete=data"), $options)
    )
    return $responses
