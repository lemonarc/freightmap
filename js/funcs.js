  var displaymode=0
  function gourl(selectedurl,elemid)
    {
    if (document.getElementById&&displaymode==0)
      {
      document.getElementById("nav1").className = "NavButton";
      document.getElementById("nav2").className = "NavButton";
      document.getElementById("nav3").className = "NavButton";
      //document.getElementById("nav4").className = "NavButton";
      document.getElementById("nav5").className = "NavButton";
      document.getElementById("nav6").className = "NavButton";
      document.getElementById("nav7").className = "NavButton";
      document.getElementById(elemid).className = "NavButtonActive";
      document.getElementById("external").src=selectedurl
      }
    else if (document.all&&displaymode==0)
      {
      document.all.nav1.className = "NavButton";
      document.all.nav2.className = "NavButton";
      document.all.nav3.className = "NavButton";
      //document.all.nav4.className = "NavButton";
      document.all.nav5.className = "NavButton";
      document.all.nav6.className = "NavButton";
      document.all.nav7.className = "NavButton";
      document.all.external.src=selectedurl
      }
    else
      {
      if (!window.win2||win2.closed)
        win2=window.open(selectedurl)
      else
        {
        win2.location=selectedurl
        win2.focus()
        }
      }
    }
        
  function findPosY(obj)
    {
	 var curtop = 0;
	 if (obj.offsetParent)
      {
      while (obj.offsetParent)
		  {
        curtop += obj.offsetTop
        obj = obj.offsetParent;
        }
      }
    else if (obj.y)
      curtop += obj.y;
    return curtop;
    }        

  function iFrameHeight() 
    {
    if(document.getElementById && !(document.all)) 
      {
      document.getElementById('external').style.height = 100;
      Upper = findPosY( document.getElementById('tiframe') );
      Lower = findPosY( document.getElementById('lopos') );
      h = document.getElementById('external').contentDocument.body.scrollHeight;
      if(h<(Lower-Upper))
         {
         h=(Lower-Upper);
         }
      document.getElementById('external').style.height = h;
      }
    else if(document.all) 
      {
      document.all.external.style.height = 100;
      Upper = findPosY( document.getElementById('tiframe') );
      Lower = findPosY( document.getElementById('lopos') );
      h = document.frames('external').document.body.scrollHeight;
      if(h<(Lower-Upper))
         {
         h=(Lower-Upper);
         }
      document.all.external.style.height = h+5;
      }
    }         
