(:

Note: This must run after tabs 1-6

1.	Select the "sec-Modules" database and execute the script
2.	You should see "your query returned an empty sequence"

Summary: In this script we have setup a custom function to generate a random asset value and a premium proportional to the asset value.

 :)

if (xdmp:database-name(xdmp:database()) = 'sec-Modules') then
(
  let $textNode := document {'
    module namespace ns = "http://security.marklogic.com/security/api/redact";
    declare default function namespace "http://security.marklogic.com/security/api/redact";

    declare function redactAssetPremium(
      $node as node(),
      $options as map:map
    ) as node()? {
      let $assetValue := math:floor(xdmp:random(100000) + 1)
      let $premium := $assetValue * 0.1
      let $property := fn:string(fn:head($node//property)) 
      let $currency := fn:string(fn:head($node//currency))
      return 
        <policyInformation>
          <property>{$property}</property>
          <premium>{$premium}</premium>
          <assetValue>{$assetValue}</assetValue>
          <currency>{$currency}</currency>
        </policyInformation>
    };  
  '}
  return xdmp:document-insert(
    "/security/redaction/custom-function/assetValue.xqy",
    $textNode
  )
  ,
  "Custom function installed."
)
else
  'Please select the sec-Modules database from the Database drop down box.'

