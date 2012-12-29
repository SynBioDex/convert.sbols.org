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

/** 
 * @param  $xml 
 * @param  $xsl 
 * @return string xml 
 */ 
function transform($xml_file, $xsl_file) { 
    $xalan_path = "/usr/bin/xalan";
    $xalan_error="/tmp/xalan/xalan_error_".rand();
    $xalan_cmd = $xalan_path." "."-in ".$xml_file." -xsl ".$xsl_file." -indent 1 2> ".$xalan_error;
    exec($xalan_cmd,$out,$status);
    $sout = "";
    //echo "status ".$status."\n";
    if (count($out)>0){
        foreach($out as $line){
            $sout.=$line."\n";
        }
    }else{
        //if(filesize($xalan_error)>1){
            $f=fopen($xalan_error,"r");
            $error=fread($f, filesize($xalan_error));
            fclose($f);
            $sout = "XALAN ERROR: ".$error;
        //}else{
            //$sout = "No output and no error\n";
        //}
    }
    return $sout;
    //return $xalan_cmd;
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
function parseArgs($argv){
    array_shift($argv);
    $out = array();
    foreach ($argv as $arg){
        if (substr($arg,0,2) == '--'){
            $eqPos = strpos($arg,'=');
            if ($eqPos === false){
                $key = substr($arg,2);
                $out[$key] = isset($out[$key]) ? $out[$key] : true;
            } else {
                $key = substr($arg,2,$eqPos-2);
                $out[$key] = substr($arg,$eqPos+1);
            }
        } else if (substr($arg,0,1) == '-'){
            if (substr($arg,2,1) == '='){
                $key = substr($arg,1,1);
                $out[$key] = substr($arg,3);
            } else {
                $chars = str_split(substr($arg,1));
                foreach ($chars as $char){
                    $key = $char;
                    $out[$key] = isset($out[$key]) ? $out[$key] : true;
                }
            }
        } else {
            $out[] = $arg;
        }
    }
    return $out;
}
function if_http($argv)
{
        if ($_GET['part']) {
            $part_id = $_GET['part'];
        } else {
            $expl = explode("/",$_SERVER["REQUEST_URI"]);
            $part_id = $expl[count($expl)-1];
        }
        $host = $_SERVER["SERVER_NAME"];
        $clean_part_id = clean($part_id);
        //$x = transform($part.".xml","sbol_biobrick.xsl");
        $x = transform("http://".$host."/mit/xml/".$clean_part_id.".xml","http://".$host."/xslt/sbol_biobrick.xsl");
        print $x;
}

//MAIN
if(empty($_SERVER["REQUEST_URI"])) {
        if (PHP_SAPI === 'cli'){
           $opt = parseArgs($argv); 
           $part_file = $opt[0];
           $x = transform($part_file,__DIR__."/../xslt/sbol_biobrick.xsl");
           print $x;
        } 
    } else {
        if_http();
    }

?>
