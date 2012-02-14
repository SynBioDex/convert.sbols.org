<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
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
-->


<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
  <html>
  <body>
  <h2><xsl:value-of select="rsbpml/part_list/part/part_name"/></h2>
  <table border="1" width="100%">
    <tr bgcolor="#9acd32">
    <th>part_id</th> <th>part_name</th> <th>part_short_name</th> <th>part_short_desc</th> <th>part_type</th> <th>part_status</th> <th>part_results</th> <th>part_nickname</th> <th>part_rating</th> <th>part_url</th> <th>part_entered</th> <th>part_author</th> <th>best_quality</th>
    </tr>
    <xsl:for-each select="rsbpml/part_list/part">
    <tr>
      <td style="width: 100px"><xsl:value-of select="part_id"/></td>
      <td><xsl:value-of select="part_name"/></td>
      <td><xsl:value-of select="part_short_name"/></td>
      <td><xsl:value-of select="part_short_desc"/></td>
      <td><xsl:value-of select="part_type"/></td>
      <td><xsl:value-of select="part_status"/></td>
      <td><xsl:value-of select="part_results"/></td>
      <td><xsl:value-of select="part_nickname"/></td>
      <td><xsl:value-of select="part_rating"/></td>
      <td style="word-break: break-all"><xsl:value-of select="part_url"/></td>
      <td><xsl:value-of select="part_entered"/></td>
      <td><xsl:value-of select="part_author"/></td>
      <td><xsl:value-of select="best_quality"/></td>
    </tr>
    <tr>
      <th colspan="13">sequences/seq_data</th>
    </tr>
    <tr>
      <td colspan="13" style="word-break: break-all"><xsl:value-of select="sequences/seq_data"/></td>
    </tr>
    <tr>
      <th>categories/category</th> <th>twins/twin</th>
    </tr>
    <tr>
      <td><xsl:value-of select="categories/category"/></td>
      <td><xsl:for-each select="twins/twin">
		      <xsl:value-of select="."/>;
      </xsl:for-each></td>
    </tr>
    <tr><td colspan="13">
      <table border="1">
        <tr bgcolor="#9acd32">
	<th>subpart</th> <th>part_id</th> <th>part_name</th> <th>part_short_desc</th> <th>part_type</th> <th>part_nickname</th> <th>standard</th> <th>comments</th>
        </tr>
        <xsl:for-each select="deep_subparts/subpart">
        <tr>
          <td>&#160;</td>
          <td><xsl:value-of select="part_id"/></td>
          <td><xsl:value-of select="part_name"/></td>
          <td><xsl:value-of select="part_short_desc"/></td>
          <td><xsl:value-of select="part_type"/></td>
          <td><xsl:value-of select="part_nickname"/></td>
        </tr>
        </xsl:for-each>
        <xsl:for-each select="specified_subparts/subpart">
        <tr>
          <td>&#160;</td>
          <td><xsl:value-of select="part_id"/></td>
          <td><xsl:value-of select="part_name"/></td>
          <td><xsl:value-of select="part_short_desc"/></td>
          <td><xsl:value-of select="part_type"/></td>
          <td><xsl:value-of select="part_nickname"/></td>
        </tr>
        </xsl:for-each>
        <xsl:for-each select="specified_subscars/subpart">
        <tr>
          <td>&#160;</td>
          <td><xsl:value-of select="part_id"/></td>
          <td><xsl:value-of select="part_name"/></td>
          <td><xsl:value-of select="part_short_desc"/></td>
          <td><xsl:value-of select="part_type"/></td>
          <td><xsl:value-of select="part_nickname"/></td>
        </tr>
        </xsl:for-each>
        <xsl:for-each select="specified_subscars/scar">
        <tr>
          <td>&#160;</td>
          <td><xsl:value-of select="scar_id"/></td>
          <td><xsl:value-of select="scar_name"/></td>
          <td><xsl:value-of select="scar_sequence"/></td>
          <td><xsl:value-of select="scar_type"/></td>
          <td><xsl:value-of select="scar_nickname"/></td>
          <td><xsl:value-of select="scar_standard"/></td>
          <td><xsl:value-of select="scar_comments"/></td>
        </tr>
        </xsl:for-each>
      </table>
    </td></tr>
    <tr><td>
      <table border="1">
        <tr bgcolor="#9acd32">
          <th>feature</th> <th>id</th> <th>title</th> <th>type</th> <th>direction</th> <th>startpos</th> <th>endpos</th>
        </tr>
        <xsl:for-each select="features/feature">
        <tr>
          <td>&#160;</td>
          <td><xsl:value-of select="id"/></td>
          <td><xsl:value-of select="title"/></td>
          <td><xsl:value-of select="type"/></td>
          <td><xsl:value-of select="direction"/></td>
          <td><xsl:value-of select="startpos"/></td>
          <td><xsl:value-of select="endpos"/></td>
        </tr>
        </xsl:for-each>
      </table>
    </td></tr>
    </xsl:for-each>
  </table>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>

