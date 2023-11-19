

document.addEventListener('copy', evt => {
	if(user_level < 4) { 
 		evt.preventDefault();
 	
 		try {
    		var txt = "LeadID (copy): " + document.vicidial_form.lead_id.value;
        	navigator.clipboard.writeText(txt);
        	console.log('Content copied via copy: ' + txt);
		} catch (err) {
			console.error('Failed to copy (copy): ', err);
    	}
	}
});


    
    