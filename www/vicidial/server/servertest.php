<?php 



?>

<!DOCTYPE html>
<script>
"use strict";

alert("Test");

const conn = new WebSocket('wss://snct6.snct-dialer.de:8877/vicidial/server/server.php');


conn.onopen = function(e) {
  alert("[open] Connection established");
  alert("Sending to server");
  conn.send("My name is John");
  console.log("Connection established!");
};

conn.onmessage = function(e) {
    console.log(e.data);
};

conn.onerror = function(error) {
  alert(error.data);
};
</script>