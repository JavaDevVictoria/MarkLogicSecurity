(:  

1. Select the sec-unit-10 database and click Run to execute the script.
2. The dictionaries should be in the Schemas database.

Summary: In this script we create dictionaries for different names, countries and property types.

:)

if (xdmp:database-name(xdmp:database()) = 'sec-unit-10') then
(
  xdmp:invoke-function(function(){
  let $dictionaryNames :=
    <dictionary xmlns="http://marklogic.com/xdmp/redaction">
      <entry>JAMES</entry>
      <entry>JOHN</entry>
      <entry>ROBERT</entry>
      <entry>MICHAEL</entry>
      <entry>MARY</entry>
      <entry>WILLIAM</entry>
      <entry>DAVID</entry>
      <entry>RICHARD</entry>
      <entry>CHARLES</entry>
      <entry>JOSEPH</entry>
      <entry>THOMAS</entry>
      <entry>PATRICIA</entry>
      <entry>CHRISTOPHER</entry>
      <entry>LINDA</entry>
      <entry>BARBARA</entry>
      <entry>DANIEL</entry>
      <entry>PAUL</entry>
      <entry>MARK</entry>
      <entry>ELIZABETH</entry>
      <entry>DONALD</entry>
      <entry>JENNIFER</entry>
      <entry>GEORGE</entry>
      <entry>MARIA</entry>
      <entry>KENNETH</entry>
      <entry>SUSAN</entry>
      <entry>STEVEN</entry>
      <entry>EDWARD</entry>
      <entry>MARGARET</entry>
      <entry>BRIAN</entry>
      <entry>RONALD</entry>
      <entry>DOROTHY</entry>
      <entry>ANTHONY</entry>
      <entry>LISA</entry>
      <entry>KEVIN</entry>
      <entry>NANCY</entry>
      <entry>KAREN</entry>
      <entry>BETTY</entry>
      <entry>HELEN</entry>
      <entry>JASON</entry>
      <entry>MATTHEW</entry>
      <entry>GARY</entry>
      <entry>TIMOTHY</entry>
      <entry>SANDRA</entry>
      <entry>JOSE</entry>
      <entry>LARRY</entry>
      <entry>JEFFREY</entry>
      <entry>FRANK</entry>
      <entry>DONNA</entry>
      <entry>CAROL</entry>
      <entry>RUTH</entry>
      <entry>SCOTT</entry>
      <entry>ERIC</entry>
      <entry>STEPHEN</entry>
      <entry>ANDREW</entry>
      <entry>SHARON</entry>
      <entry>MICHELLE</entry>
      <entry>LAURA</entry>
      <entry>SARAH</entry>
      <entry>KIMBERLY</entry>
      <entry>DEBORAH</entry>
      <entry>JESSICA</entry>
      <entry>RAYMOND</entry>
      <entry>SHIRLEY</entry>
      <entry>CYNTHIA</entry>
      <entry>ANGELA</entry>
      <entry>MELISSA</entry>
      <entry>BRENDA</entry>
      <entry>AMY</entry>
      <entry>JERRY</entry>
      <entry>GREGORY</entry>
      <entry>ANNA</entry>
      <entry>JOSHUA</entry>
      <entry>VIRGINIA</entry>
      <entry>REBECCA</entry>
      <entry>KATHLEEN</entry>
      <entry>DENNIS</entry>
      <entry>PAMELA</entry>
      <entry>MARTHA</entry>
      <entry>DEBRA</entry>
      <entry>AMANDA</entry>
      <entry>WALTER</entry>
      <entry>STEPHANIE</entry>
      <entry>WILLIE</entry>
      <entry>PATRICK</entry>
      <entry>TERRY</entry>
      <entry>CAROLYN</entry>
      <entry>PETER</entry>
      <entry>CHRISTINE</entry>
      <entry>MARIE</entry>
      <entry>JANET</entry>
      <entry>FRANCES</entry>
      <entry>CATHERINE</entry>
      <entry>HAROLD</entry>
      <entry>HENRY</entry>
      <entry>DOUGLAS</entry>
      <entry>JOYCE</entry>
      <entry>ANN</entry>
      <entry>DIANE</entry>
      <entry>ALICE</entry>
      <entry>JEAN</entry>
    </dictionary>

  let $dictionaryCountries :=
    <dictionary xmlns="http://marklogic.com/xdmp/redaction">
      <entry>Afghanistan</entry>
      <entry>Albania</entry>
      <entry>Algeria</entry>
      <entry>Andorra</entry>
      <entry>Angola</entry>
      <entry>Argentina</entry>
      <entry>Armenia</entry>
      <entry>Australia</entry>
      <entry>Austria</entry>
      <entry>Azerbaijan</entry>
      <entry>Bahamas</entry>
      <entry>Bahrain</entry>
      <entry>Bangladesh</entry>
      <entry>Barbados</entry>
      <entry>Belarus</entry>
      <entry>Belgium</entry>
      <entry>Belize</entry>
      <entry>Benin</entry>
      <entry>Bhutan</entry>
      <entry>Bolivia</entry>
      <entry>Bosnia Herzegovina</entry>
      <entry>Botswana</entry>
      <entry>Brazil</entry>
      <entry>Brunei</entry>
      <entry>Bulgaria</entry>
      <entry>Burkina</entry>
      <entry>Burundi</entry>
      <entry>Cambodia</entry>
      <entry>Cameroon</entry>
      <entry>Canada</entry>
      <entry>Cape Verde</entry>
      <entry>Central African Rep</entry>
      <entry>Chad</entry>
      <entry>Chile</entry>
      <entry>China</entry>
      <entry>Colombia</entry>
      <entry>Comoros</entry>
      <entry>Congo</entry>
      <entry>Congo Democratic Rep</entry>
      <entry>Costa Rica</entry>
      <entry>Croatia</entry>
      <entry>Cuba</entry>
      <entry>Cyprus</entry>
      <entry>Czech Republic</entry>
      <entry>Denmark</entry>
      <entry>Djibouti</entry>
      <entry>Dominica</entry>
      <entry>Dominican Republic</entry>
      <entry>East Timor</entry>
      <entry>Ecuador</entry>
      <entry>Egypt</entry>
      <entry>El Salvador</entry>
      <entry>Equatorial Guinea</entry>
      <entry>Eritrea</entry>
      <entry>Estonia</entry>
      <entry>Ethiopia</entry>
      <entry>Fiji</entry>
      <entry>Finland</entry>
      <entry>France</entry>
      <entry>Gabon</entry>
      <entry>Gambia</entry>
      <entry>Georgia</entry>
      <entry>Germany</entry>
      <entry>Ghana</entry>
      <entry>Greece</entry>
      <entry>Grenada</entry>
      <entry>Guatemala</entry>
      <entry>Guinea</entry>
      <entry>Guinea-Bissau</entry>
      <entry>Guyana</entry>
      <entry>Haiti</entry>
      <entry>Honduras</entry>
      <entry>Hungary</entry>
      <entry>Iceland</entry>
      <entry>India</entry>
      <entry>Indonesia</entry>
      <entry>Iran</entry>
      <entry>Iraq</entry>
      <entry>Ireland Republic</entry>
      <entry>Israel</entry>
      <entry>Italy</entry>
      <entry>Ivory Coast</entry>
      <entry>Jamaica</entry>
      <entry>Japan</entry>
      <entry>Jordan</entry>
      <entry>Kazakhstan</entry>
      <entry>Kenya</entry>
      <entry>Kiribati</entry>
      <entry>Korea North</entry>
      <entry>Korea South</entry>
      <entry>Kosovo</entry>
      <entry>Kuwait</entry>
      <entry>Kyrgyzstan</entry>
      <entry>Laos</entry>
      <entry>Latvia</entry>
      <entry>Lebanon</entry>
      <entry>Lesotho</entry>
      <entry>Liberia</entry>
      <entry>Libya</entry>
      <entry>Liechtenstein</entry>
      <entry>Lithuania</entry>
      <entry>Luxembourg</entry>
      <entry>Macedonia</entry>
      <entry>Madagascar</entry>
      <entry>Malawi</entry>
      <entry>Malaysia</entry>
      <entry>Maldives</entry>
      <entry>Mali</entry>
      <entry>Malta</entry>
      <entry>Marshall Islands</entry>
      <entry>Mauritania</entry>
      <entry>Mauritius</entry>
      <entry>Mexico</entry>
      <entry>Micronesia</entry>
      <entry>Moldova</entry>
      <entry>Monaco</entry>
      <entry>Mongolia</entry>
      <entry>Montenegro</entry>
      <entry>Morocco</entry>
      <entry>Mozambique</entry>
      <entry>Myanmar, Burma</entry>
      <entry>Namibia</entry>
      <entry>Nauru</entry>
      <entry>Nepal</entry>
      <entry>Netherlands</entry>
      <entry>New Zealand</entry>
      <entry>Nicaragua</entry>
      <entry>Niger</entry>
      <entry>Nigeria</entry>
      <entry>Norway</entry>
      <entry>Oman</entry>
      <entry>Pakistan</entry>
      <entry>Palau</entry>
      <entry>Panama</entry>
      <entry>Papua New Guinea</entry>
      <entry>Paraguay</entry>
      <entry>Peru</entry>
      <entry>Philippines</entry>
      <entry>Poland</entry>
      <entry>Portugal</entry>
      <entry>Qatar</entry>
      <entry>Romania</entry>
      <entry>Russian Federation</entry>
      <entry>Rwanda</entry>
      <entry>St Lucia</entry>
      <entry>Samoa</entry>
      <entry>San Marino</entry>
      <entry>Saudi Arabia</entry>
      <entry>Senegal</entry>
      <entry>Serbia</entry>
    </dictionary>

  let $dictionaryPropertyTypes :=
    <dictionary xmlns="http://marklogic.com/xdmp/redaction">
      <entry>Duet</entry>
      <entry>Condo</entry>
      <entry>TownHome</entry>
      <entry>SingleFamily</entry>
      <entry>Land</entry>
      <entry>Apartment</entry>
      <entry>MultiFamily</entry>
      <entry>Duplex</entry>
      <entry>Deattached</entry>
    </dictionary>

  return (
    xdmp:document-insert(
      "/security/redaction/dictionary/names.xml",
      $dictionaryNames
    )
    ,
    xdmp:document-insert(
      "/security/redaction/dictionary/countries.xml",
      $dictionaryCountries
    )
    ,
    xdmp:document-insert(
      "/security/redaction/dictionary/property-types.xml",
      $dictionaryPropertyTypes
    )
  )}
  ,
      <options xmlns="xdmp:eval">
      <database>{xdmp:schema-database()}</database>
    </options>
  )
  
  ,
  "Dictionaries inserted."
)
else
    'Please select the sec-unit-10 database from the Database drop down box.';
