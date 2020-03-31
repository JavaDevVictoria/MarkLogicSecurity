(:

In this script we are searching for policies using different users. According to document permissions, users
of a specific country should ONLY be able to read insurance policy documents matching their country of origin.

1. Select the sec-101 database and click run. You should see a list 30 items returned where the country is FR – only those clients based in France.

2. Take a closer look at the query in this script. Note that the search is being done on the word “FR” and the user executing this query is 
   FR_reader, which was assign the role FR_read earlier.
   
3. You can experiment with the following sets of word and user selections:

        word-query("US")  
    a)  user("US_reader")
        You should see a list of account policy holder information of account holders based in the “US”.

        word-query("UK")  
    b)  user("UK_reader")
        You should see a list of account policy holder information of account holders based in the “UK”.

4. You can try mismatching the word US, UK and FR with different users US_reader, UK_reader and FR_reader. 
   If the permissions and country don’t match you should not get any information back.             

:)

if (xdmp:database-name(xdmp:database()) = 'sec-101') then
  xdmp:invoke-function(
    function(){
      cts:search(/, cts:word-query('FR'), 'unfiltered')
    },
    <options xmlns="xdmp:eval">
      <user-id>{xdmp:user('FR_reader')}</user-id>
    </options>
  )
else
 'Please select the sec-101 database from the Database drop down box.'
