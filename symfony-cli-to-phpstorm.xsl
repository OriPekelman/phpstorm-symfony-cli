<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:plt="http://www.platform.sh/integrations" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="plt xs">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:param name="alias" select="/.."/>
	<xsl:param name="command" select="/.."/>
	<xsl:template name="plt:Argument">
		<xsl:param name="var2_current"/>
		<params>
			<xsl:value-of select="string($var2_current/@name)"/>
		</params>
	</xsl:template>
	<xsl:template name="plt:Arguments">
		<xsl:param name="argument"/>
		<xsl:for-each select="$argument/argument">
			<xsl:call-template name="plt:Argument">
				<xsl:with-param name="var2_current" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="plt:Description">
		<xsl:param name="description"/>
		<help>
			<xsl:value-of select="string($description)"/>
		</help>
	</xsl:template>
	<xsl:template name="plt:Command">
		<xsl:param name="single_command"/>
		<command>
			<xsl:variable name="var1_name">
				<xsl:if test="$single_command/@name">
					<xsl:value-of select="'1'"/>
				</xsl:if>
			</xsl:variable>
			<xsl:if test="string(boolean(string($var1_name))) != 'false'">
				<name>
					<xsl:value-of select="string($single_command/@name)"/>
				</name>
			</xsl:if>
			<xsl:for-each select="$single_command/arguments">
				<xsl:call-template name="plt:Arguments">
					<xsl:with-param name="argument" select="."/>
				</xsl:call-template>
			</xsl:for-each>
			<xsl:for-each select="$single_command/description">
				<xsl:call-template name="plt:Description">
					<xsl:with-param name="description" select="."/>
				</xsl:call-template>
			</xsl:for-each>
		</command>
	</xsl:template>
	<xsl:template name="plt:Commands">
		<xsl:param name="cli_alias"/>
		<xsl:param name="cli_command"/>
		<xsl:param name="command_name"/>
		<xsl:attribute name="alias">
			<xsl:value-of select="$cli_alias"/>
		</xsl:attribute>
		<xsl:attribute name="enabled">true</xsl:attribute>
		<xsl:attribute name="invoke">
			<xsl:value-of select="$cli_command"/>
		</xsl:attribute>
		<xsl:attribute name="name">
			<xsl:value-of select="string($command_name/@name)"/>
		</xsl:attribute>
		<xsl:attribute name="version">1</xsl:attribute>
		<xsl:attribute name="xsi:noNamespaceSchemaLocation" namespace="http://www.w3.org/2001/XMLSchema-instance">true</xsl:attribute>
		<xsl:for-each select="$command_name/commands/command">
			<xsl:call-template name="plt:Command">
				<xsl:with-param name="single_command" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="/">
		<framework xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<xsl:for-each select="symfony">
				<xsl:call-template name="plt:Commands">
					<xsl:with-param name="cli_alias" select="$alias"/>
					<xsl:with-param name="cli_command" select="$command"/>
					<xsl:with-param name="command_name" select="."/>
				</xsl:call-template>
			</xsl:for-each>
		</framework>
	</xsl:template>
</xsl:stylesheet>
