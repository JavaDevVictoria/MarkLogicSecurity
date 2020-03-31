(:

1. Execute the script againt sec-101 database to get a document permissions.
   US_read:read should appear in the results window.
   You can change the document uri and rerun the script: '/security/FR22.xml', '/workshop/UK28.xml'.

:)

if (xdmp:database-name(xdmp:database()) = 'sec-101') then
  let $permissions := xdmp:document-get-permissions('/security/US14.xml')
  for $permission in $permissions
  return concat(xdmp:role-name($permission//*:role-id), ':', $permission//*:capability)
else
  'Please select the sec-101 database from the Database drop down box.'
