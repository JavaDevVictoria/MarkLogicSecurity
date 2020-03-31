(:

1. Execute the script to set up permissions on documents.
2. In this script we were searching for documents that contain "US" and "Home" and then update the permissions on those documents to
   "can_read" , "US_read" and "Home_read". In order to read those documents all of these roles will be required.

:)

if (xdmp:database-name(xdmp:database()) = 'sec-101') then
(
  let $docsUris := cts:uris(
    "",
    "document",
    cts:and-query((
      cts:element-value-query(xs:QName("country"), "US"),
      cts:element-value-query(xs:QName("property"), "Home")
    ))
  )
  for $uri in $docsUris 
  return xdmp:document-add-permissions($uri, (
    xdmp:permission("can_read", "read"),
    xdmp:permission("US_read", "read"),
    xdmp:permission("Home_read", "read")
  ))
  ,
  "Documents' permissions set."
)
else 
  'Please select the sec-101 database from the Database drop down box.';
