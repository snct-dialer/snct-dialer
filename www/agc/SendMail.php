<?php
header ("Content-type: text/html; charset=utf-8");
header ("Cache-Control: no-cache, must-revalidate");  // HTTP/1.1
header ("Pragma: no-cache");                          // HTTP/1.0

echo "<!DOCTYPE html>" . PHP_EOL;
echo "<html>" . PHP_EOL;
echo "<head>" . PHP_EOL;
echo "<meta charset=\"UTF-8\">" . PHP_EOL;
echo "<title>Send Email</title>" . PHP_EOL;
echo "</head>" . PHP_EOL;
echo "<body>" . PHP_EOL;



if (isset($_GET["MailFrom"]))			{$MailFrom=$_GET["MailFrom"];}
	elseif (isset($_POST["MailFrom"]))	{$MailFrom=$_POST["MailFrom"];}
if (isset($_GET["MailTo"]))				{$MailTo=$_GET["MailTo"];}
	elseif (isset($_POST["MailTo"]))	{$MailTo=$_POST["MailTo"];}
if (isset($_GET["MailTitle"]))			{$MailTitle=$_GET["MailTitle"];}
	elseif (isset($_POST["MailTitle"]))	{$MailTitle=$_POST["MailTitle"];}
if (isset($_GET["MailText"]))			{$MailText=$_GET["MailText"];}
	elseif (isset($_POST["MailText"]))	{$MailText=$_POST["MailText"];}
if (isset($_GET["MailText1"]))			{$MailText1=$_GET["MailText1"];}
	elseif (isset($_POST["MailText1"]))	{$MailText1=$_POST["MailText1"];}
if (isset($_GET["Anzeige"]))			{$Anzeige=$_GET["Anzeige"];}
	elseif (isset($_POST["Anzeige"]))	{$Anzeige=$_POST["Anzeige"];}

echo "<form name=Datum method=\"post\">" .PHP_EOL;
echo "<table>";
echo "<tr>";
echo " <input type=\"hidden\" name=\"Anzeige\" value='1'> " .PHP_EOL;
echo " <input type=\"hidden\" name=\"MailText\" value=\"$MailText\"> " . PHP_EOL;

echo " <td><label for=\"MailFrom\">From :</label></td>" . PHP_EOL;
echo " <td><input type=\"text\" name=\"MailFrom\" id=\"MailFrom\" value=\"$MailFrom\" maxlength=\"50\"></td> " .PHP_EOL;
echo "</tr>";
echo "<tr>";
echo " <td><label for=\"MailTo\">To :</label></td>" . PHP_EOL;
echo " <td><input type=\"text\" name=\"MailTo\" id=\"MailTo\" value=\"$MailTo\" maxlength=\"50\"></td>" .PHP_EOL;
echo "</tr>";
echo "<tr>";

echo " <td><label for=\"MailTitle\">Subject :</label></td>" . PHP_EOL;
echo " <td><input type=\"text\" name=\"MailTitle\" id=\"MailTitle\" value=\"$MailTitle\" maxlength=\"80\"> </td>" .PHP_EOL;
echo "</tr>";
echo "<tr>";

echo " <td><label for=\"MailText1\">Text :</label></td>" . PHP_EOL;
echo " <td><textarea name=\"MailText1\" id=\"MailText1\" cols=\"50\" rows=\"10\" value=\"$MailText1\"> </textarea></td>" .PHP_EOL;
echo "</tr>";

echo "</table>";
echo " <button type=\"submit\">Absenden</button>" . PHP_EOL;
echo "</form>" . PHP_EOL;

if($Anzeige == '1') {
	$Text = $MailText1 . "\n\r" . $MailText;
	$header = 'From: ' . $MailFrom . "\r\n" .
			  'Bcc: ' . $MailFrom . "\r\n" .
		  	  'X-Mailer: PHP/' . phpversion();
	mail ($MailTo, $MailTitle, $Text, $header);
	echo "<script>window.close();</script>";
}

echo "</body>" . PHP_EOL;
echo "</html>" . PHP_EOL;

?>
