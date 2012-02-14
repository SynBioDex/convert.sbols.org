<?php header('Content-Type: text/xml'); ?>
<?php 
/**
Copyright 2012 Michal Galdzicki

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and

   limitations under the License.
*/

//to trigger download use the following line:
//header('Content-Disposition: attachment; filename="example.xml"'); 
/** 
 * @param  $xml 
 * @param  $xsl 
 * @return string xml 
 */ 
function transform($xml, $xsl) { 
   $xsl_doc = new DomDocument;
   $xsl_doc->load($xsl); 
   $xml_doc = new DomDocument;
   $xml_doc->load($xml); 

   $xslt = new XSLTProcessor(); 
   $xslt->importStylesheet($xsl_doc); 
   
   if ($out = $xslt->transformToXML($xml_doc)) {
      return $out;
  } else {
      trigger_error('XSL transformation failed.', E_USER_ERROR);
  } // if 
} 
function clean($elem) 
{ 
    if(!is_array($elem)) 
        $elem = htmlentities($elem,ENT_QUOTES,"UTF-8"); 
    else 
        foreach ($elem as $key => $value)
            $elem[$key] = clean($value); 
    return $elem; 
} 
function ifget()
{
    if(empty($_SERVER["REQUEST_URI"])) {
        echo "Not a server request\n"; 
    } else {
        $expl = explode("/",$_SERVER["REQUEST_URI"]);
        $part_id = $expl[count($expl)-1];
        $clean_part_id = clean($part_id);
        //$x = transform($part.".xml","sbol_biobrick.xsl");
        $x = transform("http://convert.sbols.org/mit/xml/".$clean_part_id.".xml","http://convert.sbols.org/xslt/sbol_biobrick.xsl");
        print $x;
    }
}

ifget();


?>
