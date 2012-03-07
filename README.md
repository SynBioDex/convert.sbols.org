Description
-----------
Convert Part Registry RSBPML (XML) to SBOL:Core:rdf

Use
-----------
Example
http://convert.sbols.org/biobrick/BBa_T9002
* Change BBa_T9002, the Part, in the above URL to any other Part from partsregistry.org 

How it works
-----------
The URL http://convert.sbols.org/biobrick/* maps to a script "biobricks.php" which takes the Part ID and uses it to retrive the Registry XML from "http://partsregistry.org/cgi/xml/part.cgi?part=BBa_T9002".
Then it transforms the XML to SBOL:Core:rdf using an XSLT stylesheet. 

Documentation
-------------
The website for this project is: http://convert.sbols.org/

