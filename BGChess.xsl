<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl	= "http://www.w3.org/1999/XSL/Transform"
	xmlns:fo	= "http://www.w3.org/1999/XSL/Format"
	xmlns:fox	= "http://xml.apache.org/fop/extensions">

	<xsl:param name="page.width"		select="'210mm'"/>
	<xsl:param name="page.height"		select="'297mm'"/>

	<xsl:param name="page.margin.top"	select="'5mm'"/>
	<xsl:param name="page.margin.bottom"	select="'5mm'"/>
	<xsl:param name="page.margin.inner"	select="'15mm'"/>
	<xsl:param name="page.margin.outer"	select="'15mm'"/>

	<xsl:param name="body.margin.top"	select="'10mm'"/>
	<xsl:param name="body.margin.bottom"	select="'10mm'"/>

	<xsl:param name="body.header.align"	select="'after'"/>
	<xsl:param name="body.footer.align"	select="'after'"/>

	<xsl:param name="header.font.name"	select="'DejaVuSans'" />
	<xsl:param name="header.font.size"	select="'18pt'"/>
	<xsl:param name="header.padding"	select="'3pt'"/>
	<xsl:param name="header.border"		select="'1pt'"/>

	<xsl:param name="footer.font.name"	select="'DejaVuSans'" />
	<xsl:param name="footer.font.size"	select="'10pt'"/>
	<xsl:param name="footer.padding"	select="'3pt'"/>
	<xsl:param name="footer.border"		select="'1pt'"/>

	<xsl:param name="item.font.name"	select="'DejaVuSans'" />
	<xsl:param name="item.font.size"	select="'8pt'"/>


<xsl:attribute-set	name		= "pagesize">
	<xsl:attribute name = "page-width">	<xsl:value-of select="$page.width"/></xsl:attribute>
	<xsl:attribute name = "page-height">	<xsl:value-of select="$page.height"/></xsl:attribute>
	<xsl:attribute name = "margin-top">	<xsl:value-of select="$page.margin.top"/></xsl:attribute>
	<xsl:attribute name = "margin-bottom">	<xsl:value-of select="$page.margin.bottom"/></xsl:attribute>
	<xsl:attribute name = "margin-left">	<xsl:value-of select="$page.margin.inner"/></xsl:attribute>
	<xsl:attribute name = "margin-right">	<xsl:value-of select="$page.margin.outer"/></xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set	name		= "region.footer">
	<xsl:attribute name = "region-name">footer</xsl:attribute>
	<xsl:attribute name = "extent">		<xsl:value-of select="$body.margin.bottom"/></xsl:attribute>
	<xsl:attribute name = "display-align">	<xsl:value-of select="$body.footer.align"/></xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set	name		= "region.header">
	<xsl:attribute name = "region-name">header</xsl:attribute>
	<xsl:attribute name = "extent">		<xsl:value-of select="$body.margin.top"/></xsl:attribute>
	<xsl:attribute name = "display-align">	<xsl:value-of select="$body.header.align"/></xsl:attribute>
</xsl:attribute-set>


<!-- document -->
<xsl:template name="Setup.Pages">
	<fo:layout-master-set>
	<fo:simple-page-master
			master-name	= "chesspage"
			xsl:use-attribute-sets	= "pagesize">

		<fo:region-body
				region-name	= "page-body"
				display-align	= "center"
				vertical-align	= "top"
				margin-bottom	= "{$body.margin.bottom}"
				margin-top	= "{$body.margin.top}" />

		<fo:region-before
				xsl:use-attribute-sets	= "region.header" />
		<fo:region-after
				xsl:use-attribute-sets	= "region.footer" />

	</fo:simple-page-master>

	<fo:page-sequence-master master-name="chess-sequence">
		<fo:repeatable-page-master-reference master-reference = "chesspage"/>
	</fo:page-sequence-master>
	</fo:layout-master-set>

</xsl:template>


<xsl:template match="/">

	<xsl:processing-instruction name="cocoon-format">type="text/xslfo"</xsl:processing-instruction>
	<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<xsl:call-template name="Setup.Pages"/>

	<xsl:apply-templates select="BGChess"/>

	</fo:root>
</xsl:template>

<xsl:template match="BGChess">
	<fo:page-sequence master-reference="chess-sequence">

	<!--xsl:call-template name="make.footer.even"/>
	<xsl:call-template name="make.footer.odd"/>

	<xsl:call-template name="make.header.even"/>

				border-top-width	= "{$header.border}"
				border-top-style	= "solid">

	<xsl:call-template name="make.header.odd"/-->

	<!--fo:static-content flow-name="header">
	</fo:static-content-->

	<fo:flow flow-name	= "page-body">
		<!--fo:block	font-family		= "{$header.font.name}"
				font-size		= "{$header.font.size}"
				text-align		= "center"
				padding-top		= "{$header.padding}"
				border-top-width	= "{$header.border}"
				border-top-style	= "solid">
			-
		</fo:block-->
		<xsl:apply-templates select="BGChessCategory" />
	</fo:flow>

	</fo:page-sequence>

</xsl:template>

<xsl:template name="BGChessCategoryBlockItem"
	><xsl:param name="row"
	/><xsl:param name="num"

	/><fo:table-cell
			margin = "0pt"
			padding = "0pt"
			border = "solid red 0pt"
			display-align = "center"
		><fo:block
				border = "solid blue 1pt"
				margin = "0pt"
				padding = "1pt 4pt"
			><fo:block
					line-height = "1.2"
					border-bottom = "solid black 0.2pt"
					margin = "0pt"
					padding = "0pt"
					font-family		= "{$item.font.name}"
					font-size		= "{$item.font.size}"
					text-align="center"
				><xsl:value-of select="../@Prefix"
				/><xsl:value-of select="$row"
				/><xsl:value-of select="$num"
			/></fo:block
			><fo:block
					line-height = "1.5"
					border = "solid blue 0pt"
					margin = "0pt"
					padding = "0pt"
					font-family		= "{$item.font.name}"
					font-size		= "{$item.font.size}"
					text-align="center"
			>&#xA0;</fo:block
		></fo:block
	></fo:table-cell
></xsl:template>

<xsl:template name="BGChessCategoryBlockRow"
	><xsl:param name="row"

	/><fo:table-row
			keep-with-next = "always"
			margin = "0pt"
			padding = "0pt"
			border = "solid yellow 0pt"
			height="11mm" >

		<xsl:call-template name="BGChessCategoryBlockItem">
			<xsl:with-param name="row" select="$row" />
			<xsl:with-param name="num" select="0" />
		</xsl:call-template>
		<xsl:call-template name="BGChessCategoryBlockItem">
			<xsl:with-param name="row" select="$row" />
			<xsl:with-param name="num" select="1" />
		</xsl:call-template>
		<xsl:call-template name="BGChessCategoryBlockItem">
			<xsl:with-param name="row" select="$row" />
			<xsl:with-param name="num" select="2" />
		</xsl:call-template>
		<xsl:call-template name="BGChessCategoryBlockItem">
			<xsl:with-param name="row" select="$row" />
			<xsl:with-param name="num" select="3" />
		</xsl:call-template>
		<xsl:call-template name="BGChessCategoryBlockItem">
			<xsl:with-param name="row" select="$row" />
			<xsl:with-param name="num" select="4" />
		</xsl:call-template>

		<fo:table-cell
				display-align = "center"
			><fo:block
					text-align = "center"
				><xsl:text>&#xA0;</xsl:text
			></fo:block
		></fo:table-cell>

		<xsl:call-template name="BGChessCategoryBlockItem">
			<xsl:with-param name="row" select="$row" />
			<xsl:with-param name="num" select="5" />
		</xsl:call-template>
		<xsl:call-template name="BGChessCategoryBlockItem">
			<xsl:with-param name="row" select="$row" />
			<xsl:with-param name="num" select="6" />
		</xsl:call-template>
		<xsl:call-template name="BGChessCategoryBlockItem">
			<xsl:with-param name="row" select="$row" />
			<xsl:with-param name="num" select="7" />
		</xsl:call-template>
		<xsl:call-template name="BGChessCategoryBlockItem">
			<xsl:with-param name="row" select="$row" />
			<xsl:with-param name="num" select="8" />
		</xsl:call-template>
		<xsl:call-template name="BGChessCategoryBlockItem">
			<xsl:with-param name="row" select="$row" />
			<xsl:with-param name="num" select="9" />
		</xsl:call-template>

	</fo:table-row>
</xsl:template>

<xsl:template match="BGChessCategoryBlock"
	><fo:table
			table-layout = "fixed"
			width = "100%"
			border-collapse = "collapse"
			border = "solid black 0pt"
		><fo:table-column column-width="proportional-column-width(20)" />
		<fo:table-column column-width="proportional-column-width(20)" />
		<fo:table-column column-width="proportional-column-width(20)" />
		<fo:table-column column-width="proportional-column-width(20)" />
		<fo:table-column column-width="proportional-column-width(20)" />
		<fo:table-column column-width="proportional-column-width(4)" />
		<fo:table-column column-width="proportional-column-width(20)" />
		<fo:table-column column-width="proportional-column-width(20)" />
		<fo:table-column column-width="proportional-column-width(20)" />
		<fo:table-column column-width="proportional-column-width(20)" />
		<fo:table-column column-width="proportional-column-width(20)" />
		<fo:table-body>
			<xsl:call-template name="BGChessCategoryBlockRow"><xsl:with-param name="row" select="3 * position() - 3"/></xsl:call-template>
			<xsl:call-template name="BGChessCategoryBlockRow"><xsl:with-param name="row" select="3 * position() - 2"/></xsl:call-template>
			<xsl:call-template name="BGChessCategoryBlockRow"><xsl:with-param name="row" select="3 * position() - 1"/></xsl:call-template>
			<fo:table-row
					margin = "0pt"
					padding = "0pt"
					border = "solid yellow 0pt"
					height="1mm" >
				<fo:table-cell display-align="center" number-columns-spanned="11">
					<fo:block text-align="center"><xsl:text>&#xA0;</xsl:text></fo:block>
				</fo:table-cell>
			</fo:table-row>
		</fo:table-body>
	</fo:table
></xsl:template>

<!-- document -->
<xsl:template match="BGChessCategory"
	><fo:block
			font-family = "{$header.font.name}"
			font-size = "{$header.font.size}"
			text-align = "center"
			padding-top = "{$header.padding}"
			border = "0pt solid green"
			keep-with-next = "always"
		><xsl:value-of select="BGChessCategoryName"
		/><xsl:text>&#xA0;(&#xA0;</xsl:text
		><xsl:value-of select="@Prefix"
		/><xsl:text>.xx&#xA0;)</xsl:text
	></fo:block
	><fo:block
			keep-together.within-page = "always"
		><xsl:apply-templates select = "BGChessCategoryBlock"
	/></fo:block
></xsl:template>

</xsl:stylesheet>
