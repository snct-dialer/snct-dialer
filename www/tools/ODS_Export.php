<?php

function exportODF($data, $fields, $feet, $name) {


	if(!($file = tempnam("/tmp", "zip"))) {
		return FALSE;
	}
	$zip = new ZipArchive;
	if(!$zip->open($file, ZipArchive::CREATE|ZipArchive::OVERWRITE)) {
		return FALSE;
	}

	if(!$zip->addEmptyDir("META-INF")) {
		return FALSE;
	}
	if(!$zip->addFromString("META-INF/manifest.xml", '<?xml version="1.0" encoding="UTF-8"?><manifest:manifest xmlns:manifest="urn:oasis:names:tc:opendocument:xmlns:manifest:1.0"><manifest:file-entry manifest:media-type="application/vnd.oasis.opendocument.spreadsheet" manifest:version="1.2" manifest:full-path="/"/><manifest:file-entry manifest:media-type="application/vnd.sun.xml.ui.configuration" manifest:full-path="Configurations2/"/><manifest:file-entry manifest:media-type="text/xml" manifest:full-path="content.xml"/></manifest:manifest>')) {
		return FALSE;
	}
	if(!$zip->addFromString("mimetype", "application/vnd.oasis.opendocument.spreadsheet")) {
		return FALSE;
	}

	$buffer = '<?xml version="1.0" encoding="UTF-8"?>'
		.'<office:document-content xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0" xmlns:presentation="urn:oasis:names:tc:opendocument:xmlns:presentation:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0" xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0" xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0" xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0" xmlns:dom="http://www.w3.org/2001/xml-events" xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:of="urn:oasis:names:tc:opendocument:xmlns:of:1.2" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:grddl="http://www.w3.org/2003/g/data-view#" xmlns:field="urn:openoffice:names:experimental:ooo-ms-interop:xmlns:field:1.0" office:version="1.2" grddl:transformation="http://docs.oasis-open.org/office/1.2/xslt/odf2rdf.xsl">'
		.'<office:scripts/>'
		.'<office:font-face-decls>'
		.'<style:font-face style:name="Arial" svg:font-family="Arial" style:font-family-generic="swiss" style:font-pitch="variable"/>'
		.'<style:font-face style:name="Lucida Sans Unicode" svg:font-family="&apos;Lucida Sans Unicode&apos;" style:font-family-generic="system" style:font-pitch="variable"/>'
		.'<style:font-face style:name="Mangal" svg:font-family="Mangal" style:font-family-generic="system" style:font-pitch="variable"/>'
		.'<style:font-face style:name="Tahoma" svg:font-family="Tahoma" style:font-family-generic="system" style:font-pitch="variable"/>'
		.'</office:font-face-decls>'
		.'<office:automatic-styles>'
		.'<style:style style:name="co1" style:family="table-column">'
		.'<style:table-column-properties fo:break-before="auto" style:column-width="2.9cm"/>'
		.'</style:style>'
		.'<style:style style:name="ro1" style:family="table-row">'
		.'<style:table-row-properties style:row-height="0.453cm" fo:break-before="auto" style:use-optimal-row-height="true"/>'
		.'</style:style>'
		.'<style:style style:name="ta1" style:family="table" style:master-page-name="Default">'
		.'<style:table-properties table:display="true" style:writing-mode="lr-tb"/>'
		.'</style:style>'
		.'</office:automatic-styles>'
		.'<office:body>'
		.'<office:spreadsheet>'
		.'<table:table table:name="Tabelle1" table:style-name="ta1" table:print="false">'
		.'<office:forms form:automatic-focus="false" form:apply-design-mode="false"/>';
	$buffer .= '';
	foreach($fields AS $value) {
		$buffer .= '<table:table-column table:style-name="co1" table:default-cell-style-name="Default"/>';
	}
	$buffer .= '';

	$buffer .= '<table:table-row>';
	foreach($fields AS $value) {
		$buffer .= '<table:table-cell office:value-type="string">'
			.'<text:p>'.$value.'</text:p>'
			.'</table:table-cell>';
	}
	$buffer .= '</table:table-row>';

	while($row = mysql_fetch_assoc($data)) {
		$buffer .= '<table:table-row table:style-name="ro1">';
		foreach($fields AS $key => $value) {
			if(preg_match("/^[0-9]+$/", $row[$key])) {
				$buffer .= '<table:table-cell office:value-type="float" office:value="'.$row[$key].'">'
					.'<text:p>'.$row[$key].'</text:p>'
					.'</table:table-cell>';
			} else if(preg_match("/^[0-9]+\.[0-9]+/", $row[$key])) {
				$buffer .= '<table:table-cell office:value-type="float" office:value="'.sprintf("%01.2f", $row[$key]).'">'
					.'<text:p>'.str_replace(".", ",", sprintf("%01.2f", $row[$key])).'</text:p>'
					.'</table:table-cell>';
			} else {
				$buffer .= '<table:table-cell office:value-type="string">'
					.'<text:p>'.htmlspecialchars(utf8_encode(stripslashes($row[$key]))).'</text:p>'
					.'</table:table-cell>';
			}
		}
		$buffer .= '</table:table-row>';
		$buffer .= $feet;
	}


	$buffer .= '</table:table>'
		.'</office:spreadsheet>'
		.'</office:body>'
		.'</office:document-content>';


	if(!$zip->addFromString("content.xml", $buffer))
	{
		return FALSE;
	}

	$zip->close();

	return $file;

}


?>