<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
xmlns:s="http://sbols.org/v1#"
xmlns:so="http://purl.obolibrary.org/obo/"
xmlns:map="http://convert.sbols.org/xml/"
xmlns:pr="http://partsregistry.org/"
xmlns:prt="http://partsregistry.org/type/"
xmlns:prp="http://partsregistry.org/part/"
xmlns:pra="http://partsregistry.org/anot/"
xmlns:prs="http://partsregistry.org/seq/"
xmlns:prf="http://partsregistry.org/feat/"
>
<xsl:param name="so" select="'http://purl.obolibrary.org/obo/'"/>
<xsl:param name="prt" select="'http://partsregistry.org/type/'"/>
<xsl:param name="prp" select="'http://partsregistry.org/part/'"/>
<xsl:param name="pra" select="'http://partsregistry.org/anot/'"/>
<xsl:param name="prs" select="'http://partsregistry.org/seq/'"/>
<xsl:param name="prf" select="'http://partsregistry.org/feat/'"/>
<!-- prp is the Partsregistry Part URI
prp could potentially be resolvable at this url
xmlns:prd="http://partsregistry.org/cgi/xml/part.cgi?part="
-->

<xsl:strip-space elements="*"/>
<xsl:output indent="yes"/>
<xsl:variable name="lc">abcdefghijklmnopqrstuvwxyz</xsl:variable>
<xsl:variable name="uc">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
<xsl:key name="parts" match="subpart" use="part_name"/>

<!-- This section performs the type mapping -->
<map:typelist>
  <entry><rsbpml>cds</rsbpml><so>SO_0000316</so></entry>
  <entry><rsbpml>coding</rsbpml><so>SO_0000316</so></entry>
  <entry><rsbpml>conserved</rsbpml><so>SO_0000856</so></entry>
  <entry><rsbpml>polya</rsbpml><so>SO_0000553</so></entry>
  <entry><rsbpml>promoter</rsbpml><so>SO_0000167</so></entry>
  <entry><rsbpml>rbs</rsbpml><so>SO_0000552</so></entry>
  <entry><rsbpml>regulatory</rsbpml><so>SO_0005836</so></entry>
  <entry><rsbpml>s_mutation</rsbpml><so>SO_0001017</so></entry>
  <entry><rsbpml>stem_loop</rsbpml><so>SO_0000313</so></entry>
  <entry><rsbpml>terminator</rsbpml><so>SO_0000141</so></entry>
  <entry><rsbpml>binding</rsbpml><so>SO_0000409</so></entry>
  <entry><rsbpml>mutation</rsbpml><so>SO_0001060</so></entry>
  <entry><rsbpml>operator</rsbpml><so>SO_0000057</so></entry>
  <entry><rsbpml>plasmid</rsbpml><so>SO_0000155 </so></entry>
  <entry><rsbpml>plasmid_backbone</rsbpml><so>SO_0000155</so></entry>
  <entry><rsbpml>primer</rsbpml><so>SO_0000112</so></entry>
  <entry><rsbpml>primer_binding</rsbpml><so>SO_0005850</so></entry>
  <entry><rsbpml>protein</rsbpml><so>SO_0000104</so></entry>
  <entry><rsbpml>protein_domain</rsbpml><so>SO_0000417</so></entry>
  <entry><rsbpml>start</rsbpml><so>SO_0000323</so></entry>
  <entry><rsbpml>stop</rsbpml><so>SO_0000327</so></entry>
  <entry><rsbpml>tag</rsbpml><so>SO_0000324</so></entry>
</map:typelist>
<xsl:key name="types" match="entry" use="rsbpml"/>

<xsl:template name="type">
  <xsl:variable name="type">
    <xsl:value-of select="translate(.,$uc,$lc)"/>
  </xsl:variable>
  <xsl:variable name="so_type">
    <xsl:for-each select="document('')/xsl:stylesheet/map:typelist">
      <xsl:value-of select="key('types',$type)/so"/>
    </xsl:for-each>
  </xsl:variable>
  <xsl:choose>
    <xsl:when test="normalize-space($so_type)">
      <rdf:type rdf:resource="{concat($so,$so_type)}"/>
    </xsl:when>
    <xsl:otherwise>
      <rdf:type rdf:resource="{concat($prt,$type)}"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="part_type">
  <xsl:call-template name="type"/>
</xsl:template>
<xsl:template match="scar_type">
  <xsl:call-template name="type"/>
</xsl:template>
<xsl:template match="type">
  <xsl:call-template name="type"/>
</xsl:template>


<xsl:template match="/">
<rdf:RDF>

  <xsl:for-each select="rsbpml/part_list/part">
    <s:DnaComponent rdf:about="{concat($prp,part_name)}">
      <s:displayId><xsl:value-of select="part_name"/></s:displayId>
        <xsl:choose>
          <xsl:when test="normalize-space(part_nickname)">
            <rdfs:label><xsl:value-of select="part_nickname"/></rdfs:label>
          </xsl:when>
          <xsl:otherwise>
            <rdfs:label><xsl:value-of select="part_short_name"/></rdfs:label>
          </xsl:otherwise>
        </xsl:choose>
      <rdfs:comment>
        <xsl:value-of select="normalize-space(part_short_desc)"/>
          </rdfs:comment>
          <xsl:apply-templates select="part_type"/>
          <!-- 
          <xsl:value-of select="part_status"/>
          <xsl:value-of select="part_results"/>
          <xsl:value-of select="part_nickname"/>
          <xsl:value-of select="part_rating"/>
          <xsl:value-of select="part_entered"/>
          <xsl:value-of select="part_author"/>
          <xsl:value-of select="best_quality"/>
          <xsl:value-of select="categories/category"/>
          <xsl:for-each select="twins/twin">
            <xsl:value-of select="."/>
          -->
      <s:dnaSequence>
        <s:DnaSequence rdf:about="{concat($prs,generate-id())}">
          <s:nucleotides>
            <xsl:value-of select="translate(sequences/seq_data, 
                        '&#x20;&#x9;&#xD;&#xA;', ' ')"/>
          </s:nucleotides>
        </s:DnaSequence>
      </s:dnaSequence>

         <xsl:for-each select="deep_subparts/subpart">
         <s:annotations>
          <s:SequenceAnnotation rdf:about="{concat($pra,generate-id())}">
            <xsl:if test="preceding-sibling::*">
            <s:precedes rdf:resource="{concat($pra,generate-id(preceding-sibling::*))}"/>
            </xsl:if>
            <s:subComponent>
              <s:DnaComponent rdf:about="{concat($prp,part_name)}"> 
                <s:displayId><xsl:value-of select="part_name"/></s:displayId>
                <xsl:choose>
                  <xsl:when test="normalize-space(part_nickname)">
                     <rdfs:label><xsl:value-of select="part_nickname"/></rdfs:label>
                  </xsl:when>
                </xsl:choose>
                <rdfs:comment><xsl:value-of select="normalize-space(part_short_desc)"/></rdfs:comment>
                <xsl:apply-templates select="part_type"/>
         </s:DnaComponent> 
            </s:subComponent>
          </s:SequenceAnnotation>
          </s:annotations>
          </xsl:for-each>

          <xsl:for-each select="specified_subparts/subpart">
          <s:annotations>

          <s:SequenceAnnotation rdf:about="{concat($pra,generate-id())}">
            <xsl:if test="preceding-sibling::*">
            <s:precedes rdf:resource="{concat($pra,generate-id(preceding-sibling::*))}"/>
            </xsl:if>
            <s:subComponent>

              <s:DnaComponent rdf:about="{concat($prp,part_name)}"> 
                <s:displayId><xsl:value-of select="part_name"/></s:displayId>
                <xsl:choose>
                  <xsl:when test="normalize-space(part_nickname)">
                  <rdfs:label><xsl:value-of select="part_nickname"/></rdfs:label>
                  </xsl:when>
                </xsl:choose>
                <rdfs:comment><xsl:value-of select="normalize-space(part_short_desc)"/></rdfs:comment>
                <xsl:apply-templates select="part_type"/>
              </s:DnaComponent> 
            </s:subComponent>
          </s:SequenceAnnotation>
          </s:annotations>
          </xsl:for-each>

          <xsl:for-each select="specified_subscars/subpart">
          <s:annotations>

          <s:SequenceAnnotation rdf:about="{concat($pra,generate-id())}">
            <xsl:if test="preceding-sibling::*">
            <s:precedes rdf:resource="{concat($pra,generate-id(preceding-sibling::*))}"/>
            </xsl:if>
            <s:subComponent>

              <s:DnaComponent rdf:about="{concat($prp,part_name)}"> 
                <s:displayId><xsl:value-of select="part_name"/></s:displayId>
                <xsl:choose>
                  <xsl:when test="normalize-space(part_nickname)">
                  <rdfs:label><xsl:value-of select="part_nickname"/></rdfs:label>
                  </xsl:when>
                </xsl:choose>
                <rdfs:comment><xsl:value-of select="normalize-space(part_short_desc)"/></rdfs:comment>
                <xsl:apply-templates select="scar_type"/>
         </s:DnaComponent> 
            </s:subComponent>
          </s:SequenceAnnotation>
          </s:annotations>
          </xsl:for-each>

          <xsl:for-each select="specified_subscars/scar">
          <s:annotations>
          <s:SequenceAnnotation rdf:about="{concat($pra,generate-id())}">
            <xsl:if test="preceding-sibling::*">
            <s:precedes rdf:resource="{concat($pra,generate-id(preceding-sibling::*))}"/>
            </xsl:if>
            <s:subComponent>
              <s:DnaComponent rdf:about="{concat($prp,concat('RFC_',scar_standard))}"> 
                <s:displayId><xsl:value-of select="concat('RFC_',scar_standard)"/></s:displayId>
                <xsl:choose>
                  <xsl:when test="normalize-space(scar_nickname)">
                  <rdfs:label><xsl:value-of select="scar_nickname"/></rdfs:label>
                  </xsl:when>
                  <xsl:otherwise>
                  <rdfs:label><xsl:value-of select="scar_name"/></rdfs:label>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="normalize-space(scar_comments)">
                  <rdfs:comment><xsl:value-of select="normalize-space(scar_comments)"/></rdfs:comment>
                </xsl:if>
                <xsl:apply-templates select="scar_type"/>
                <s:dnaSequence>
                <s:DnaSequence rdf:about="{concat($prs,generate-id(scar_sequence))}">
                  <s:nucleotides>
                    <xsl:value-of select="translate(scar_sequence, 
                      '&#x20;&#x9;&#xD;&#xA;', ' ')"/>
                    </s:nucleotides>
                  </s:DnaSequence>
           </s:dnaSequence>
              </s:DnaComponent> 
            </s:subComponent>
          </s:SequenceAnnotation>
          </s:annotations>
          </xsl:for-each>
    
        <xsl:for-each select="features/feature">
          <s:annotations>
          <s:SequenceAnnotation rdf:about="{concat($pra,generate-id())}">
<!--
            <xsl:if test="preceding-sibling::*">
            <s:precedes rdf:resource="{concat($pra,generate-id(preceding-sibling::*))}"/>
            </xsl:if>
-->
            <s:bioStart><xsl:value-of select="startpos"/></s:bioStart>
            <s:bioEnd><xsl:value-of select="endpos"/></s:bioEnd>
            <xsl:choose>
              <xsl:when test="starts-with(direction,'forward')">
                <s:strand>+</s:strand>
              </xsl:when>
              <xsl:when test="starts-with(direction,'reverse')">
                <s:strand>-</s:strand>
              </xsl:when>
            </xsl:choose>
            <s:subComponent>
                <xsl:choose>
                  <!-- There is a subpart with the same BBa_ as this feature -->
                  <xsl:when test="starts-with(title,'BBa_') and key('parts',title)">
                    <s:DnaComponent rdf:about="{concat($prp,title)}">
                      <xsl:apply-templates select="type"/>
                    </s:DnaComponent>
                  </xsl:when>
                  <!-- This BBa_ feature is a part, not listed as subpart -->
                  <xsl:when test="starts-with(title,'BBa_') and not(key('parts',title))">
                    <s:DnaComponent rdf:about="{concat($prp,title)}">
                      <s:displayId><xsl:value-of select="title" /></s:displayId>
                      <xsl:apply-templates select="type"/>
                    </s:DnaComponent>
                  </xsl:when>
                  <!-- This feature is not a part -->
                  <xsl:otherwise>
                    <s:DnaComponent rdf:about="{concat($prf,generate-id(id))}">
                      <s:displayId><xsl:value-of select="generate-id(id)"/></s:displayId>
                      <xsl:choose>
                       <xsl:when test="normalize-space(title)">
                         <rdfs:label><xsl:value-of select="title"/></rdfs:label>
                       </xsl:when>
                       <xsl:otherwise>
                         <rdfs:label><xsl:value-of select="type"/></rdfs:label>
                       </xsl:otherwise>
                     </xsl:choose>
                      <xsl:apply-templates select="type"/>
                    </s:DnaComponent>
                  </xsl:otherwise>
                </xsl:choose>
            </s:subComponent>
          </s:SequenceAnnotation>
          </s:annotations>

        </xsl:for-each>
 

  </s:DnaComponent>
  </xsl:for-each>

</rdf:RDF>
</xsl:template>

</xsl:stylesheet>

