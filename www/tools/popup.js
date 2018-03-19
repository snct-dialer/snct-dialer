//*  popup.js
//
//	LICENSE: AGPLv3
//
//	(c) 2018 by Jörg Frings-Fürst (j.frings-fuerst@flyingpenguin.de)
//		2018 by fylingpenguin.de UG (info@flyingpenguin.de)
//
//	This file is part of the suite vicidial-de.
//
//	This modul handles the basic popup window functions.
//
//	2018-03-12 jff   First release
//
//
//	release 0.0.1 
//
//


// Global vars  

// Attribute fuer ein Fenster, das alles dran haben soll
var attribWithAll="location=yes,menubar=yes,toolbar=yes,status=yes";
attribWithAll+=",resizable=yes,scrollbars=yes,width=450,height=200";


// Attribute fuer ein Fenster, das nix, aber auch rein gar nix haben soll
var width  = 300;
var height = 250;
var left   = (screen.width  - width)/2;
var wintop    = (screen.height - height)/2;

var attribWithoutAll = 'width='+width+',height='+height;
attribWithoutAll += ',top='+wintop+',left='+left;
attribWithoutAll += ',directories=no';
attribWithoutAll += ',location=no';
attribWithoutAll += ',menubar=no';
attribWithoutAll += ',resizable=no';
attribWithoutAll += ',scrollbars=no';
attribWithoutAll += ',status=no';
attribWithoutAll += ',toolbar=no';
attribWithoutAll += ',titlebar=no';


// Close the popup window if open
function ClosePopUp(subwindow) {

	if (!subwindow)
		return;
	if (subwindow.closed)
		return;
	subwindow.close();
}


function PopUpWithAll(subwindow, url) {

	ClosePopUp(subwindow);
	subwindow=window.open(url,"popup",attribWithAll);
	subwindow.moveTo(10,50);
	return subwindow;
}

// Open a popup at the center of the screen
function PopUpWithoutAll(subwindow, url, title, text) {

	ClosePopUp(subwindow);
	subwindow=window.open("",title,attribWithoutAll);
	subwindow.document.write("<p><h1><center> " + text +  "</center></h1></p>");
	return subwindow;
}

