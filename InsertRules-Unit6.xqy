(:

1.	Select the sec-unit-06 database and click Run.
2.	You should see "Rules inserted" in the results window.
3.  See if you can identify which Redaction rule is specified for each of them.

Summary: In this script we are creating a set of rules to apply when we are redacting the data in the documents. 
We are creating rules for the following information in a client’s profile: clientInformation, premium and asset value.
We have specified different rules for developers and product managers.

:)

declare variable $COLLECTION_DEV := "Developer";
declare variable $COLLECTION_PM := "ProductManager";
if (xdmp:database-name(xdmp:database()) = 'sec-unit-06') then
(
xdmp:invoke-function(function(){
  let $rule-client-info := 
    <rule xml:lang="zxx" xmlns="http://marklogic.com/xdmp/redaction">
      <description>Random # for client-information, hide all PII as a single #</description>
      <path>/policy/clientInformation</path>
      <method>
        <function>mask-random</function>
      </method>
      <options>
        <length>10</length>
      </options>
    </rule>
  
  let $rule-premium :=
    <rule xml:lang="zxx" xmlns="http://marklogic.com/xdmp/redaction">
      <description>Random # for premium</description>
      <path>/policy/policyInformation/premium</path>
      <method>
        <function>mask-random</function>
      </method>
      <options>
        <length>5</length>
        <character>numeric</character>
      </options>
    </rule>

  let $rule-asset :=
    <rule xml:lang="zxx" xmlns="http://marklogic.com/xdmp/redaction">
      <description>Random # for premium</description>
      <path>/policy/policyInformation/premium</path>
      <method>
        <function>mask-random</function>
      </method>
      <options>
        <length>5</length>
        <character>numeric</character>
      </options>
    </rule>
  
  let $rule-client-info-pm :=
    <rule xml:lang="zxx" xmlns="http://marklogic.com/xdmp/redaction">
      <description>Random # for client-information, hide all PII as a single #</description>
      <path>/policy/clientInformation</path>
      <method>
        <function>mask-deterministic</function>
      </method>
      <options>
        <length>10</length>
      </options>
    </rule>
  return (
    xdmp:document-insert(
      "/security/redaction/rule/ruleClientInfo.xml",
      $rule-client-info,
      <options xmlns="xdmp:document-insert">  
        <collections>
          <collection>{$COLLECTION_DEV}</collection>
        </collections>
      </options>
    )
    ,
    xdmp:document-insert(
      "/security/redaction/rule/rulePremium.xml",
      $rule-premium,
      <options xmlns="xdmp:document-insert">  
        <collections>
          <collection>{$COLLECTION_DEV}</collection>
        </collections>
      </options>
    )
    ,
    xdmp:document-insert(
      "/security/redaction/rule/ruleAsset.xml",
      $rule-asset,
      <options xmlns="xdmp:document-insert">  
        <collections>
          <collection>{$COLLECTION_DEV}</collection>
        </collections>
      </options>
    )
    ,
    xdmp:document-insert(
      "/security/redaction/rule/ruleClientInfoPm.xml",
      $rule-client-info-pm,
      <options xmlns="xdmp:document-insert">  
        <collections>
          <collection>{$COLLECTION_PM}</collection>
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
  'Please select the sec-unit-06 database from the Database drop down box.'
