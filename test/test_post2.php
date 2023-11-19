<?php
#https://snct6.snct-dialer.de/flyCRM-agent/transaction.php?vendor_ID=2&lead_id=6494846&vendor_id=&list_id=66996699
# &gmt_offset_now=2.00&phone_code=49&phone_number=65319869071&title=Herr&first_name=J%C3%B6rg&middle_initial=G
# &last_name=Frings-F%C3%BCrstX&address1=Auf%20Zevenich%2011&address2=SNCT-GmbH%20IT&address3=&city=Lieser&state=&province=1901
# &postal_code=54470&country_code=&gender=U&date_of_birth=0000-00-00&alt_phone=65319869072&email=j.frings-fuerst%40snct-dialer.de
# &security_phrase=XEDV_IG&comments=&user=6699&campaign=MANUAL&phone_login=1001a&original_phone_login=1001x&fronter=6699
# &closer=6699&group=MANUAL&channel_group=MANUAL&SQLdate=2023-07-11+105845&epoch=1689065926&uniqueid=
# &customer_zap_channel=&customer_server_ip=&server_ip=10.106.1.1&SIPexten=1001&session_id=8600051&phone=65319869071
# &parked_by=6494846&dispo=&dialed_number=65319869071&dialed_label=MANUAL_PREVIEW&source_id=&rank=0&owner=6699&camp_script=
# &in_script=&in_script_two=&script_width=1450&script_height=680&fullname=Admin+Frings-F%C3%BCrst
# &agent_email=admin@snct-dialer.de&recording_filename=&recording_id=&user_custom_one=9010000&user_custom_two=
# &user_custom_three=&user_custom_four=&user_custom_five=&preset_number_a=&preset_number_b=&preset_number_c=&preset_number_d=
# &preset_number_e=&preset_dtmf_a=&preset_dtmf_b=&did_id=&did_extension=&did_pattern=&did_description=&closecallid=&xfercallid=
# &agent_log_id=55447581&entry_list_id=66996699&call_id=&user_group=ADMIN&list_name=Test-Entwicklung&list_description=only%20for%20testing
# &entry_date=2019-10-21+092136&did_custom_one=&did_custom_two=&did_custom_three=&did_custom_four=&did_custom_five=
# &called_count=228&email_row_id=&inOUT=OUT&LOGINvarONE=&LOGINvarTWO=&LOGINvarTHREE=&LOGINvarFOUR=&LOGINvarFIVE=
# &pass=82tq82tq&web_vars=&session_name=1689065722_100114909059

?>

<!DOCTYPE html>
<html>
<body>

<div id="demo1">
<h1>The XMLHttpRequest Object</h1>
<button type="button" onclick="openWindowWithPost('flyCRM-agent/transaction.php', {
    lead_id: "6494846",
    vendor_id: "2",
    vendor_ID:  "2",
    phone_code: "43",
    user: "6699",
    list_id: "66996699",
    SQLdate: "2023-07-11 105845" })">Change Content</button>
</div>


<script>

openWindowWithPost('/flyCRM-agent/transport.php', {
    lead_id: "6494846",
    lead_ID: "6494846",
    vendor_id: "2",
    vendor_ID: "2",
    list_id: "66996699",
    pass: "82tq82tq",
    user: "6699",
    closer: "6699",
    postal_code: "54470",
    city: "Lieser",
    address1: "Auf Zevenich 11",
    phone_number: "65319869071",
    phone: "65319869071",
    phone_code: "49",
    SQLdate: "2023-07-12 193845",
    address2: "SNCT-GmbH",
    email: "test@test.test",
    first_name: "Jörg",
    last_name: "Frings-Fürst",
    wlURL: "flyCRM-agent/transaction.php",
    wlTyp: "GET"
    
     });


function openWindowWithPost(url, data) {
    var form = document.createElement("form");
    form.target = "SNCTWEB1";
    form.method = "POST";
    form.action = url;
    form.style.display = "none"; 

    for (var key in data) {
        var input = document.createElement("input");
        input.type = "hidden";
        input.name = key;
        input.value = data[key];
        form.appendChild(input);
    }
    document.body.appendChild(form);
    form.submit();
    document.body.removeChild(form);
}

</script>

</body>
</html>