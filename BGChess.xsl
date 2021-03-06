<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl	= "http://www.w3.org/1999/XSL/Transform"
	xmlns:fo	= "http://www.w3.org/1999/XSL/Format"
	xmlns:fox	= "http://xml.apache.org/fop/extensions">

	<xsl:param name="bg.label" />

	<xsl:param name="page.width"		select="'210mm'"/>
	<xsl:param name="page.height"		select="'297mm'"/>

	<xsl:param name="page.margin.top"	select="'5mm'"/>
	<xsl:param name="page.margin.bottom"	select="'5mm'"/>
	<xsl:param name="page.margin.inner"	select="'15mm'"/>
	<xsl:param name="page.margin.outer"	select="'15mm'"/>

	<xsl:param name="body.margin.top"	select="'10mm'"/>
	<xsl:param name="body.margin.bottom"	select="'8mm'"/>

	<xsl:param name="body.header.align"	select="'after'"/>
	<xsl:param name="body.footer.align"	select="'after'"/>

	<xsl:param name="header.font.name"	select="'DejaVuSans'" />
	<xsl:param name="header.font.size"	select="'16pt'"/>

	<xsl:param name="footer.font.name"	select="'DejaVuSans'" />
	<xsl:param name="footer.font.size"	select="'10pt'"/>

	<xsl:param name="category.font.name"	select="'DejaVuSans'" />
	<xsl:param name="category.font.size"	select="'14pt'"/>

	<xsl:param name="item.font.name"	select="'DejaVuSans'" />
	<xsl:param name="item.font.size"	select="'9.5pt'"/>
	<xsl:param name="split.font.size"	select="'5pt'"/>


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

<xsl:template name="BGChessKPName"
	><fo:inline
			text-decoration = "underline"
		><xsl:choose>
			<xsl:when test="@KP"
				><xsl:text>&#xA0;</xsl:text
				><xsl:value-of select="@KP"
				/><xsl:text>&#xA0;</xsl:text
			></xsl:when>
			<xsl:otherwise
				><xsl:text>&#xA0;</xsl:text
				><xsl:text>&#xA0;</xsl:text
				><xsl:text>&#xA0;</xsl:text
				><xsl:text>&#xA0;</xsl:text
				><xsl:text>&#xA0;</xsl:text
				><xsl:text>&#xA0;</xsl:text
			></xsl:otherwise>
		</xsl:choose
	></fo:inline
></xsl:template>

<xsl:template name="BGChessFooter"
	><fo:inline
		><xsl:choose>
			<xsl:when test="$bg.label"
				><xsl:text>&#xA0;</xsl:text
				><xsl:value-of select="$bg.label"
				/><xsl:text>&#xA0;</xsl:text
			></xsl:when>
			<xsl:otherwise
				><xsl:text>Бегущий Город</xsl:text
			></xsl:otherwise>
		</xsl:choose
	></fo:inline
	><fo:leader
	/><!--КП xsl:call-template name="BGChessKPName"
	--><fo:inline
		>http://www.runcity.org/ru/</fo:inline
></xsl:template>

<xsl:template match="BGChess">
	<fo:page-sequence master-reference="chess-sequence">

	<!--xsl:call-template name="make.footer.even"/>
	<xsl:call-template name="make.footer.odd"/>

	<xsl:call-template name="make.header.even"/>

				border-top-width	= "{$header.border}"
				border-top-style	= "solid">

	<xsl:call-template name="make.header.odd"/-->

	<fo:static-content
			flow-name="header"
		><fo:block
				font-family		= "{$header.font.name}"
				font-size		= "{$header.font.size}"
				text-align		= "left"
		>КП <xsl:call-template name="BGChessKPName"
		/></fo:block
	></fo:static-content>

	<fo:static-content
			flow-name="footer"
		><fo:block
				font-family	= "{$footer.font.name}"
				font-size	= "{$footer.font.size}"
				border-top	= "1pt solid black"
				padding-top	= "3pt"
				text-align	= "justify"
				text-align-last	= "justify"
		><xsl:call-template name="BGChessFooter"
		/></fo:block
	></fo:static-content>

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
				border = "solid black 0.8pt"
				margin = "0pt 1pt"
				padding = "0.8pt 3pt"
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

<xsl:template name="BGChessCategoryBlockRowSplit"
	><fo:table-row
			margin = "0pt"
			padding = "0pt"
			border = "solid yellow 0pt"
			height="1pt" >
		<fo:table-cell
				margin = "0pt"
				padding = "0pt"
				display-align = "center"
				number-columns-spanned = "11"
				font-size = "{$split.font.size}"
			><fo:block
					font-size = "1pt"
					text-align = "center"
				><xsl:text>&#xA0;</xsl:text
			></fo:block
		></fo:table-cell>
	</fo:table-row
></xsl:template>

<xsl:template name="BGChessCategoryBlockRow"
	><xsl:param name="row"

	/><fo:table-row
			margin = "0pt"
			padding = "0pt"
			border = "solid yellow 0pt"
			height="10.5mm" >

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

<xsl:template match="BGChessCategoryBreak"
	><fo:block
			page-break-before="always"
			font-family = "{$category.font.name}"
			font-size = "{$category.font.size}"
			text-align = "center"
			padding-top = "0pt"
			margin-top = "18pt"
			margin-bottom = "12pt"
			border = "0pt solid green"
			keep-with-next = "always"
		><xsl:value-of select="../BGChessCategoryName"
		/><xsl:text>&#xA0;(&#xA0;</xsl:text
		><xsl:value-of select="../@Prefix"
		/><xsl:text>.xx&#xA0;)</xsl:text
	></fo:block
></xsl:template>

<xsl:template match="BGChessCategoryBlock"
	><fo:table
			margin-bottom = "10pt"
			table-layout = "fixed"
			width = "100%"
			border-collapse = "collapse"
			border = "solid black 0pt"
			keep-together.within-page = "always"
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
			<xsl:call-template name="BGChessCategoryBlockRow" >
				<xsl:with-param name="row" select="3 * ( position() - count( preceding-sibling::BGChessCategoryBreak ) ) - 3" />
			</xsl:call-template >
			<xsl:call-template name="BGChessCategoryBlockRowSplit" />
			<xsl:call-template name="BGChessCategoryBlockRow" >
				<xsl:with-param name="row" select="3 * ( position() - count( preceding-sibling::BGChessCategoryBreak ) ) - 2" />
			</xsl:call-template >
			<xsl:call-template name="BGChessCategoryBlockRowSplit" />
			<xsl:call-template name="BGChessCategoryBlockRow" >
				<xsl:with-param name="row" select="3 * ( position() - count( preceding-sibling::BGChessCategoryBreak ) ) - 1" />
			</xsl:call-template >
		</fo:table-body>
	</fo:table
></xsl:template>

<xsl:template match="BGChessCategory"
	><fo:block
			font-family = "{$category.font.name}"
			font-size = "{$category.font.size}"
			text-align = "center"
			padding-top = "0pt"
			margin-top = "18pt"
			border = "0pt solid green"
			keep-with-next = "always"
		><xsl:value-of select="BGChessCategoryName"
		/><xsl:text>&#xA0;(&#xA0;</xsl:text
		><xsl:value-of select="@Prefix"
		/><xsl:text>.xx&#xA0;)</xsl:text
	></fo:block
	><fo:block
			margin-top = "12pt"
			margin-bottom = "12pt"
		><xsl:if test="../@paginate='yes'"
			><xsl:attribute name="break-after">page</xsl:attribute
		></xsl:if
		><xsl:apply-templates select = "BGChessCategoryBlock|BGChessCategoryBreak"
	/></fo:block
></xsl:template>

</xsl:stylesheet>
