<?php


$link = mysqli_connect("localhost", "my_user", "my_password", "world");

if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

$stmt="SELECT * FROM information_schema.columns where `TABLE_NAME` = 'vicidial_list' AND `TABLE_SCHEMA` = 'asterisk_snct';";
echo $stmt . PHP_EOL;

$res = mysqli_query($link, $stmt);
if ($res === false ) {
    printf("Invalid query: %s\nWhole query: %s\n", $mysqli->error, $stmt);
    exit();
}


while($row = mysqli_fetch_array($res, MYSQLI_BOTH)) {
    
    $stmt2 = "SELECT * FROM `snctdialer_agent_interface` WHERE `List_Field` = '".$row['COLUMN_NAME']."';";
    
    echo $stmt2 . PHP_EOL;
    $res2 = mysqli_query($link, $stmt2);
    if ($res2 === false ) {
        printf("Invalid query: %s\nWhole query: %s\n", $mysqli->error, $stmt2);
        exit();
    }
    
    $row2_cnt = mysqli_num_rows($res2);
    
    if($row2_cnt == 0) {
        $row2 = mysqli_fetch_all($res2);
        $MaxLen = 1;
        if($row['DATA_TYPE'] == 'varchar') {
            $MaxLen = $row['CHARACTER_MAXIMUM_LENGTH'];
        }
            
        $stmt3 = "INSERT INTO snctdialer_agent_interface VALUES (NULL, '".$row['COLUMN_NAME']."', 0, 0, 0, '".$row['COLUMN_NAME']."', '".$row['DATA_TYPE']."', 1, '".$MaxLen."', 1, '', '',1,0);";

        echo $stmt3 . PHP_EOL;
        $res3 = mysqli_query($link, $stmt3);
    }
}




?>