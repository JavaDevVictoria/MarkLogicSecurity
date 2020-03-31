(:

1. Execute the script against the sec-101 database to clear users and roles.
2. We are removing the roles and users that we created earlier. 
3. Note that it is important to remove these roles and users so we can create the compartment roles and users that have these compartment based roles.

You may recognize some of the roles and user that we created earlier and some that you may not recognize.

:)

xquery version "1.0-ml";
import module namespace sec = "http://marklogic.com/xdmp/security" at 
    "/MarkLogic/security.xqy";
    
declare variable $ROLES := ("Global_read","Euro_read", "US_read", "US_update", "UK_read", "UK_update", "FR_read", "FR_update","can_read","Home_read",
               "Commercial_read","US_Home_read","UK_Commercial_read","PII_read","Euro_PII_read","Global_PII_read","US_PII_read","UK_PII_read","FR_PII_read");
declare variable $USERS := ("US_reader", "UK_reader", "FR_reader", "US_updater", "UK_updater", "FR_updater", "Global_reader", "Euro_reader","US_Home_reader","UK_Commercial_reader",
               "PII_read","Euro_PII_reader","Global_PII_reader","US_PII_reader","US_PII_updater","UK_PII_reader","FR_PII_reader");

if (xdmp:database-name(xdmp:database()) = 'sec-101') then
(
  for $role in $ROLES
  return xdmp:invoke-function(
    function(){
      if (sec:role-exists($role)) then
        sec:remove-role($role)
      else ()
    },
    <options xmlns="xdmp:eval">
      <database>{xdmp:security-database()}</database>
    </options>
  )
  ,
  for $user in $USERS
  return xdmp:invoke-function(
    function(){
      if (sec:user-exists($user)) then
        sec:remove-user($user)
      else ()
    },
    <options xmlns="xdmp:eval">
      <database>{xdmp:security-database()}</database>
    </options>
  )
  ,
  "Users and roles cleared."
)
else 
  'Please select the sec-101 database from the Database drop down box.';
