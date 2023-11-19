<?php 

#print_r($_POST);

$line = '?';
$pos  = 0;
foreach($_POST AS $label => $para) {
#    echo "$label $para <br>";
    if($pos == 0) {
        $line .= $label . '=' . $para;
    } else {
        $line .= '&' . $label . '=' . $para;
    }
    $pos++;
}

#echo $line;


?>

<script src="js/jquery-1.7.1.min.js" type="text/javascript"></script>
<script>

//$.ajax({
//    type: 'get',
//    url: 'flycrm-agent/transaction.php',
//    data: '<?php echo $line; ?>',
//    success: function(response) {
//        alert(response);
//    }
//});

var  ars= '<?php echo json_encode($_POST); ?>';
//document.write(ars);

var line = '<?php echo $line; ?>';
//document.write(line);

//Object.keys(ars).forEach(key => {
//	console.log(key, ars[key]);
//});
	
//Object.entries(ars).forEach(entry => {
//	const [key, value] = entry;
//	console.log(key, value);
//});

//window.location = '/flyCRM-agent/transaction.php' + line;

var test = $.get('https://snct1.snct-dialer.de/flyCRM-agent/transaction.php' + line, '', function(data)
				{console.log(test.responseText)});

//console.log(test);
document.write(test.responseText);

</script>