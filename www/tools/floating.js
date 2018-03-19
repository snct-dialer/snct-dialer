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
  whichOne=isIE ? document.all.FloatingLayer : document.getElementById("FloatingLayer");  
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
    if(document.layers)	   //NN4+
    {
       document.layers[DivID].visibility = iState ? "show" : "hide";
    }
    else if(document.getElementById)	  //gecko(NN6) + IE 5+
    {
        var obj = document.getElementById(DivID);
        obj.style.visibility = iState ? "visible" : "hidden";
    }
    else if(document.all)	// IE 4
    {
        document.all[DivID].style.visibility = iState ? "visible" : "hidden";
    }
}

document.onmousedown=MoveInit;
document.onmouseup=Function("MoveEnabled=false");
