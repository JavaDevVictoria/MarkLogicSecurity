(:

1. Select the sec-101 database create in the previous lab and execute the script.
2. You can try different word queries to certify that the Global_reader can see all (US,UK,FR) or try the Euro_reader with "US" to get no results.
3. Note that the Global_reader sees all documents.

:)

if (xdmp:database-name(xdmp:database()) = 'sec-101') then
  xdmp:invoke-function(
    function(){
      cts:search(/, cts:word-query('UK'), 'filtered')
    },
    <options xmlns="xdmp:eval">
      <user-id>{xdmp:user('Global_reader')}</user-id>
    </options>
  )
else
  'Please select the sec-101 database from the Database drop down box.';
