(:
  
 Note: Please do not run the scripts "Remove Rules" and "Tear Down" unless directed by the instructor.
 This must run against the sec-unit-06 database.
  
:)


if (xdmp:database-name(xdmp:database()) = 'sec-unit-06') then
(
xdmp:invoke-function(function(){
  xdmp:collection-delete("rdt_UAT")
  ,
  xdmp:collection-delete("Developer")
  ,
  xdmp:collection-delete("ProductManager")
  ,
  "Rules removed."
  },
  <options xmlns="xdmp:eval">
     <database>{xdmp:schema-database()}</database>
  </options>
    )
)
else
  'Please select the sec-unit-06 database from the Database drop down box.';
