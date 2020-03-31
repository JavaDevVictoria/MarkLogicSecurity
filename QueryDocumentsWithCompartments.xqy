(:

1. Execute the script to query documents with the "US_Home_reader".
2. There should be some documents returned from US clients.
3. In this script we are searching for documents that contain "US" that the user "US_Home_reader"  is allowed to search.
4. Note : The search result should contain documents which country value is "US" and property value is "Home".
5. Try changing the "US" to "UK" or "FR" and no documents should be returned.

:)

if (xdmp:database-name(xdmp:database()) = 'sec-101') then
  xdmp:invoke-function(
    function(){
      cts:search(/, cts:word-query('US'), 'unfiltered')
    }
    ,
    <options xmlns="xdmp:eval">
      <user-id>{xdmp:user('US_Home_reader')}</user-id>
    </options>
  )
else
  'Please select the sec-101 database from the Database drop down box.';
