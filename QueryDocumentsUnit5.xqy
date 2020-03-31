(:

1. Make sure you select the sec-unit-05 database
2. Click explore to select any document and copy its policyID value.
3. In the code, assign the policyID value to the $qry1 variable.
4. Run the script and examine the log entries for the 3 different users: Global_reader, Euro_PII_reader, Global_PII_reader

** Note: remember the PII appears within the "//ClientInformation" protected path.
    
5. Expected results.
    Our users are searching for a document with the policyId, which is not a PII.
    - "Global_reader” gets a portion of the document back. He can read the non-protected element policyInformation BUT cannot see any PII information 
       at all. So he does not know who the policy holder is.    
    - "Euro_PII_reader” gets the entire document returned including the PII information because the policy originated from Europe.
    - "Global_PII_reader"  gets the entire document returned because he can read PII for all countries. 
    
6. Let's try a different query. Replace qry1 by qry2 in the xdmp:invoke-function functions and re-run the query. 
   This time we are searching for a policy by policy holder name, which is a PII criteria. 

7. Expected results
    - "Global_reader” does not get any result back since he is not allowed to see or search any PII.
    - "Euro_PII_reader” gets policies where the name value is "Robert"  and country is either "FR" or "UK".
    - "Global_PII_reader" gets policies where the name value is "Robert for any country, including US. 

:)

declare variable $qry1 := function(){
  cts:search(/, "925046418883752158")
};

declare variable $qry2 := function(){
  cts:search(/, cts:element-word-query(xs:QName("name"), "Robert"))
};


if (xdmp:database-name(xdmp:database()) = 'sec-unit-05') then
  
  let $log1 := "---------- With Global_reader ---------------------"
  let $result1 := xdmp:invoke-function(
    $qry2,
    <options xmlns="xdmp:eval">
      <user-id>{xdmp:user("Global_reader")}</user-id>
    </options>
  )
  
  let $log2 := "---------- With Euro_PII_reader ---------------------"
  let $result2 := xdmp:invoke-function(
    $qry2,
    <options xmlns="xdmp:eval">
      <user-id>{xdmp:user("Euro_PII_reader")}</user-id>
    </options>
  )
  
  let $log3 := "---------- With Global_PII_reader ---------------------"
  let $result3 := xdmp:invoke-function(
    $qry2,
    <options xmlns="xdmp:eval">
      <user-id>{xdmp:user("Global_PII_reader")}</user-id>
    </options>
  )
  return ($log1,$result1,$log2,$result2,$log3,$result3)
else
  'Please select the sec-unit-05 database from the Database drop down box.';
