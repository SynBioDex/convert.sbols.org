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

<!-- This section performs the TYPE mapping -->
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

<!-- This section performs the SEQUENCE mapping -->
<xsl:template name="DnaSequence">
  <xsl:param name="id"/>
  <xsl:param name="prefix"/>
  <s:dnaSequence>
  <s:DnaSequence rdf:about="{concat($prs,concat($prefix,$id))}">
    <s:nucleotides>
      <xsl:value-of select="translate(.,
                  '&#x20;&#x9;&#xD;&#xA;', ' ')"/>
    </s:nucleotides>
  </s:DnaSequence>
  </s:dnaSequence>
</xsl:template>

<xsl:template match="sequences/seq_data">
  <xsl:param name="id"/>
  <xsl:call-template name="DnaSequence">
    <xsl:with-param name="id" select="$id"/>
    <xsl:with-param name="prefix" select="'part'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="scar/scar_sequence">
  <xsl:param name="id"/>
  <xsl:call-template name="DnaSequence">
    <xsl:with-param name="id" select="$id"/>
    <xsl:with-param name="prefix" select="'scar'"/>
  </xsl:call-template>
</xsl:template>

<!-- This section performs the SUBPART mapping -->
<xsl:template match="subpart">
  <xsl:param name="id" select="part_id"/>
  <xsl:param name="prefix" select="'an'"/>
  <s:annotation>
  <s:SequenceAnnotation rdf:about="{concat($pra,concat($prefix,$id))}">
    <xsl:if test="preceding-sibling::*">
    <s:precedes rdf:resource="{concat($pra,concat($prefix,preceding-sibling::subpart[1]/part_id))}"/>
    </xsl:if>
    <s:subComponent>
      <xsl:call-template name="DC">
        <xsl:with-param name="id" select="part_name"/>
        <xsl:with-param name="name" select="part_nickname"/>
        <xsl:with-param name="desc" select="part_short_desc"/>
        <xsl:with-param name="type" select="part_type"/>
      </xsl:call-template>
    </s:subComponent>
  </s:SequenceAnnotation>
  </s:annotation>
</xsl:template>

<!-- This section performs the SCAR mapping -->
<xsl:template match="scar">
  <xsl:param name="id" select="scar_id"/>
  <xsl:param name="prefix" select="'an'"/>
  <s:annotation>
    <s:SequenceAnnotation rdf:about="{concat($pra,concat($prefix,$id))}">
      <xsl:if test="preceding-sibling::*">
      <s:precedes rdf:resource="{concat($pra,concat($prefix,preceding-sibling::subpart[1]/part_id))}"/>
      </xsl:if>
      <s:subComponent>
        <xsl:call-template name="DC">
          <xsl:with-param name="id" select="concat('RFC_',scar_standard)"/>
          <xsl:with-param name="name" select="scar_nickname"/>
          <xsl:with-param name="desc" select="scar_comments"/>
          <xsl:with-param name="type" select="scar_type"/>
        </xsl:call-template>
      </s:subComponent>
    </s:SequenceAnnotation>

  </s:annotation>
</xsl:template>

<!-- This section performs the FEATURE mapping -->
<xsl:template match="feature">
  <xsl:param name="prefix" select="'f'"/>
          <s:annotation>
          <s:SequenceAnnotation rdf:about="{concat($pra,concat($prefix,id))}">
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
                    <xsl:call-template name="DC">
                      <xsl:with-param name="id" select="title"/>
                      <xsl:with-param name="type" select="type"/>
                    </xsl:call-template>
                  </xsl:when>
                  <!-- This feature is not a part -->
                  <xsl:otherwise>
                    <s:DnaComponent rdf:about="{concat($prf,concat($prefix,id))}">
                      <s:displayId><xsl:value-of select="concat($prefix,id)"/></s:displayId>
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
          </s:annotation>
</xsl:template>

<!-- This section defines the DC mapping -->
<xsl:template name="DC">
  <xsl:param name="id"/>
  <xsl:param name="name"/>
  <xsl:param name="desc"/>
  <xsl:param name="type"/>
  <s:DnaComponent rdf:about="{concat($prp,$id)}">
    <s:displayId><xsl:value-of select="$id"/></s:displayId>
    <xsl:if test="normalize-space($name)">
      <rdfs:label><xsl:value-of select="normalize-space($name)"/></rdfs:label>
    </xsl:if>
    <xsl:if test="normalize-space($desc)">
    <rdfs:comment><xsl:value-of select="normalize-space($desc)"/></rdfs:comment>
    </xsl:if>
    <!-- This section performs the TYPE mapping -->
    <xsl:apply-templates select="$type"/>
    <!-- This section performs the SEQUENCE mapping -->
    <!-- DS uri is prs:id+part_id, as DC-DS is strictly 1to1-->
    <xsl:apply-templates select="scar_sequence">
      <xsl:with-param name="id" select="scar_id"/>
    </xsl:apply-templates>
    <xsl:apply-templates select="sequences/seq_data">
      <xsl:with-param name="id" select="part_id"/>
    </xsl:apply-templates>
        <!-- The following dont map to SBOL
        <xsl:value-of select="part_status"/>
        <xsl:value-of select="part_results"/>
        <xsl:value-of select="part_nickname"/>
        <xsl:value-of select="part_rating"/>
        <xsl:value-of select="part_entered"/>
        <xsl:value-of select="part_author"/>
        <xsl:value-of select="best_quality"/>
        <xsl:value-of select="categories/category"/>
        <xsl:for-each select="twins/twin"> <xsl:value-of select="."/> -->
    <!-- This section performs the DEEP sub-part mapping -->
    <xsl:apply-templates select="deep_subparts/subpart"/>
    <!-- This section performs the SPECIFIED sub-part mapping -->
    <xsl:apply-templates select="specified_subparts/subpart"/>
    <!-- This section performs the SUBSCAR sub-part mapping -->
    <xsl:apply-templates select="specified_subscars/subpart"/>
    <!-- This section performs the SCAR mapping -->
    <xsl:apply-templates select="specified_subscars/scar"/>
    <!-- This section performs the FEATURE mapping -->
    <xsl:apply-templates select="features/feature"/>
  </s:DnaComponent>
</xsl:template>

<!-- This section performs the main PART mapping -->
<xsl:template match="part">
  <xsl:param name="id"/>

  <xsl:call-template name="DC">
    <xsl:with-param name="id" select="part_name"/>
    <xsl:with-param name="name">
      <xsl:choose>
        <xsl:when test="normalize-space(part_nickname)">
          <xsl:value-of select="part_nickname"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="part_short_name"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="desc" select="part_short_desc"/>
    <xsl:with-param name="type" select="part_type"/>
  </xsl:call-template>
</xsl:template>

<!-- This section performs the RSBPML mapping -->
<xsl:template match="/">
<rdf:RDF>
  <xsl:apply-templates select="rsbpml/part_list/part"/>
</rdf:RDF>
</xsl:template>

</xsl:stylesheet>

