(:  

1.	Select the sec-unit-10 database and click Run to execute the script.
2.	"Rules inserted" should be returned.

Summary: In this script we create a set of rules to apply when redacting data in the documents. A dictionary will be used to replace
the actual client name, country and property type by random values.

:)
declare variable $COLLECTION_UAT := "rdt_UAT";
if (xdmp:database-name(xdmp:database()) = 'sec-unit-10') then
(
  xdmp:invoke-function(function(){
  let $ruleNamesDictRandom := 
    <rule xml:lang="zxx" xmlns="http://marklogic.com/xdmp/redaction">
      <description>Random Dictionary masking for client names, using names dictionary</description>
      <path>/policy/clientInformation/name</path>
      <method>
        <function>mask-random</function>
      </method>
      <options>
        <dictionary>/security/redaction/dictionary/names.xml</dictionary>
      </options>
    </rule>
      
  let $ruleCountriesDictRandom :=
    <rule xml:lang="zxx" xmlns="http://marklogic.com/xdmp/redaction">
      <description>Random Dictionary masking for client countries, using countries dictionary</description>
      <path>/policy/clientInformation/country</path>
      <method>
        <function>mask-random</function>
      </method>
      <options>
        <dictionary>/security/redaction/dictionary/countries.xml</dictionary>
      </options>
    </rule>

  let $rulePropertyTypeDictRandom :=
    <rule xml:lang="zxx" xmlns="http://marklogic.com/xdmp/redaction">
      <description>Deterministic dictionary masking property-type</description>
      <path>/policy/policyInformation/property</path>
      <method>
        <function>mask-deterministic</function>
      </method>
      <options>
        <dictionary>/security/redaction/dictionary/property-types.xml</dictionary>
      </options>
    </rule>
  
  return (
    xdmp:document-insert(
      "/security/redaction/rule/ruleNamesDictRandom.xml",
      $ruleNamesDictRandom,
      <options xmlns="xdmp:document-insert">  
        <collections>
          <collection>{$COLLECTION_UAT}</collection>
        </collections>
      </options>
    )
    ,
    xdmp:document-insert(
      "/security/redaction/rule/ruleCountriesDictRandom.xml",
      $ruleCountriesDictRandom,
      <options xmlns="xdmp:document-insert">  
        <collections>
          <collection>{$COLLECTION_UAT}</collection>
        </collections>
      </options>
    )
    ,
    xdmp:document-insert(
      "/security/redaction/rule/rulePropertyTypeDictRandom.xml",
      $rulePropertyTypeDictRandom,
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
