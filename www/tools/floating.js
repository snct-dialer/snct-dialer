isIE=document.all;
isNN=!document.all&&document.getElementById;
isN4=document.layers;
isActive=false;

var FloatWidth  = 500;
var FloatHeight = 250;
var FloatLeft   = (screen.width  - FloatWidth)/2;
var FloatTop    = (screen.height - FloatHeight)/2;




function MoveInit(e){
  topOne=isIE ? "BODY" : "HTML";
  whichOne=isIE ? document.all.FloatingLayer : document.getElementById("PauseLayer");  
  ActiveOne=isIE ? event.srcElement : e.target;  
  while (ActiveOne.id!="titleBar"&&ActiveOne.tagName!=topOne){
    ActiveOne=isIE ? ActiveOne.parentElement : ActiveOne.parentNode;
  }
  if (ActiveOne.id=="titleBar"){
    offsetx=isIE ? event.clientX : e.clientX;
    offsety=isIE ? event.clientY : e.clientY;
    nowX=parseInt(whichOne.style.left);
    nowY=parseInt(whichOne.style.top);
    MoveEnabled=true;
    document.onmousemove=Move;
  }
}

function Move(e){
  if (!MoveEnabled) return;
  whichOne.style.left=isIE ? nowX+event.clientX-offsetx : nowX+e.clientX-offsetx; 
  whichOne.style.top=isIE ? nowY+event.clientY-offsety : nowY+e.clientY-offsety;
  return false;  
}

function MoveN4(whatOne){
  if (!isN4) return;
  N4=eval(whatOne);
  N4.captureEvents(Event.MOUSEDOWN|Event.MOUSEUP);
  N4.onmousedown=function(e){
    N4.captureEvents(Event.MOUSEMOVE);
    N4x=e.x;
    N4y=e.y;
  }
  N4.onmousemove=function(e){
    if (isActive){
      N4.moveBy(e.x-N4x,e.y-N4y);
      return false;
    }
  }
  N4.onmouseup=function(){
    N4.releaseEvents(Event.MOUSEMOVE);
  }
}

function ToggleFloatingLayer(DivID, iState) // 1 visible, 0 hidden
{
//	alert(DivID + "|" + iState);
    if(document.layers)	   //NN4+
    {
       document.layers[DivID].visibility = iState ? "show" : "hide";
    }
    else if(document.getElementById)	  //gecko(NN6) + IE 5+
    {
        var obj = document.getElementById(DivID);
        if(obj){
        	obj.style.visibility = iState ? "visible" : "hidden";
//        	obj.style.display = iState ? "block" : "none";
        }
    }
    else if(document.all)	// IE 4
    {
        document.all[DivID].style.visibility = iState ? "visible" : "hidden";
    }
}


function InitFloatingWindow(Name, title, text) {

	document.write("<div id='" + Name + "' style='position:absolute;width:300px;left:300px;top:400px;z-index:100;visibility:hidden;border:solid 1px #FF6600;'>");
	document.write("  <div id='titleBar' style='cursor:move; width:100%; position:relative; border-bottom:solid 1px #FF6600; background-color:#FF9933;'>");
	document.write("    <div id='title' style='margin-right:30px; padding-left:3px;'>");
	document.write("      <font face='Arial' color='#333333'>" + title + "</font>");
	document.write("    </div>");
	document.write("    <div id='closeX' style='cursor:hand; position:absolute; right:5px; top:0px;'>");
	document.write("      <a href='#' onClick='ToggleFloatingLayer('" + Name + "',0);return false'  style='text-decoration:none'><font color='#333333' size='2' face='arial'>X</font></a>");
	document.write("    </div>");
	document.write("  </div>");
	document.write("  <div id='floatingContent' style='padding:3px; background-color:#CCCCCC; color:#333333;'>");
	document.write("    <h1><center>" + text + "</center></h1>");
	document.write("  </div>");
	document.write("</div>");
}


//document.onmousedown=MoveInit;
//document.onmouseup=Function("MoveEnabled=false");

