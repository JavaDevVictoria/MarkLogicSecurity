(:

1.	Select the sec-unit-10 database and execute the script.
2.	You should see “Rule installed” in the results window.

Summary: In the previous script we created a custom rule. In this script install a rule that calls the custom function 
to generate a random asset value and a premium proportional to the asset value. 
Note that the collection name is rdt_UAT and the document name for this function is ruleAssetPremium.json.

Bonus(Optional) : Explore the schemas database and see if you can review this document that was just inserted.

:)

declare variable $COLLECTION_UAT := "rdt_UAT";
if (xdmp:database-name(xdmp:database()) = 'sec-unit-10') then
(
xdmp:invoke-function(function(){
  let $ruleAssetPremium := 
    <rule xml:lang="zxx" xmlns="http://marklogic.com/xdmp/redaction">
      <description>Use a custom function to generate a random asset value and a premium propotional to the asset value</description>
      <path>/policy/policyInformation</path>
      <method>
        <function>redactAssetPremium</function>
        <module>/security/redaction/custom-function/assetValue.xqy</module>
        <module-namespace>http://security.marklogic.com/security/api/redact</module-namespace>
      </method>
    </rule>
  
  return (
    xdmp:document-insert(
      "/security/redaction/rule/ruleAssetPremium.xml",
      $ruleAssetPremium,
      <options xmlns="xdmp:document-insert">  
        <collections>
          <collection>{$COLLECTION_UAT}</collection>
        </collections>
      </options>
    )
  )}
  , 
    <options xmlns="xdmp:eval">
      <database>{xdmp:schema-database()}</database>
    </options>
 )
  ,
  "Rules inserted."
)
else
  'Please select the sec-unit-10 database from the Database drop down box.';
