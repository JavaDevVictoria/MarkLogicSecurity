(:

1.	Select the sec-unit-09 database and click Run.
2.	You should see the following results:

The "UserFoo" should not be able to see any information in the policy document at all since all the information in the policy is protected 
by protected paths to which that user has no valid role.

The "UserClassified" should be able to see the name, address, phone, country, and last 4 digits of the SSN.

The "ComplianceUserClassified" should be able to see the name, address, phone, country, as well as the full SSN

The "RiskOfficer" should be able to see only the financial information.

Bonus(Optional): Experiment with creating a similar policy for UK and FR and see if you can extend it to different users..

:)

xquery version "1.0-ml";
declare variable $qry1 := function(){
  fn:doc("US_policy.xml")
};

if (xdmp:database-name(xdmp:database()) = 'sec-unit-09') then
  
  let $log1 := "---------- With UserFoo ---------------------"
  let $result1 := xdmp:invoke-function(
    $qry1,
    <options xmlns="xdmp:eval">
      <user-id>{xdmp:user("UserFoo")}</user-id>
    </options>
  )
  
  let $log2 := "---------- With UserClassified ---------------------"
  let $result2 := xdmp:invoke-function(
    $qry1,
    <options xmlns="xdmp:eval">
      <user-id>{xdmp:user("UserClassified")}</user-id>
    </options>
  )
  
  let $log3 := "---------- With ComplianceUserClassified ---------------------"
  let $result3 := xdmp:invoke-function(
    $qry1,
    <options xmlns="xdmp:eval">
      <user-id>{xdmp:user("ComplianceUserClassified")}</user-id>
    </options>
  )
  
  let $log4 := "---------- With RiskOfficer ---------------------"
  let $result4 := xdmp:invoke-function(
    $qry1,
    <options xmlns="xdmp:eval">
      <user-id>{xdmp:user("RiskOfficer")}</user-id>
    </options>
  )

  return ($log1,$result1,$log2,$result2,$log3,$result3,$log4,$result4)
else
  'Please select the sec-unit-09 database from the Database drop down box.';
