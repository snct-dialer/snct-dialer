<?php 




###############################################################################
#
# function CheckFieldsExists
#
# function to check if table fields exists
#
# Parameter: $Table     mysql Table
#            $Field     mysql Field to check
#            $Conn      mysqli Connection
#
# Return: 0     if field not exists
#         1     if field exist
#
# Version 1.0.0
#
###############################################################################
function CheckFieldExists($Table, $Field, $Type, $Conn) {
    
    $sql = "DESCRIBE $Table $Field;";
    
    $res = mysqli_query($Conn, $sql);
    $row_cnt = mysqli_num_rows($res);
    
    if($row_cnt == 0) {
        return 0;
    } else {
        $Field  = mysqli_fetch_array($res, MYSQLI_BOTH);
        if($Field["Type"] == $Type) {
            return 2;
        }
        return 1;
    }
        
}

###############################################################################
#
# function CheckTableExists
#
# function to check if table fields exists
#
# Parameter: $Table     mysql Table
#            $Conn      mysqli Connection
#
# Return: 0     if field not exists
#         1     if field exist
#
# Version 1.0.0
#
###############################################################################
function CheckTableExists($Table, $Conn) {
    
    $sql = "SHOW TABLES LIKE '".$Table."';";
    
    $res = mysqli_query($Conn, $sql);
    $row_cnt = mysqli_num_rows($res);
    
    if($row_cnt == 0) {
        return 0;
    } else {
        return 1;
    }
    
}

###############################################################################
#
# function InsertFields
#
# function to add new table fields
#
# Parameter: $Table     mysql Table
#            $Field     Field Name
#            $Type      Field Typ
#            $Null      Field is NULL
#            $Default   Field default 
#            $Extra     Extra (not used)
#
#            $Conn      mysqli Connection
#
# Return: 0     if field added
#         -1    on error
#
# Version 1.0.0
#
##############################################################################
function InsertFields($Table, $Field, $Type, $Null, $Default, $Extra, $Conn) {

# ALTER TABLE `vicidial_user_log` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
# ALTER TABLE `vicidial_users` ADD `2FA_type` ENUM('SMS','EMail','TOTP') NOT NULL DEFAULT 'TOTP';

    $sql = "ALTER TABLE `".$Table."` ADD `".$Field."` ".$Type." ";
    if($Null  == "false") {
        $sql .= "NOT ";
    }
    $sql .= "NULL ";
    if($Default != "") {
        $sql .= "DEFAULT '".$Default."';";
    }
    if(($res = mysqli_query($Conn, $sql)) === false)
    {
        echo("Invalid query: ". mysqli_error($Conn) . PHP_EOL);
        return -1;
    }
    return 0;
}


###############################################################################
#
# function ChangeFields
#
# function to change table fields
#
# Parameter: $Table     mysql Table
#            $FieldOld  Field Name Old
#            $Field     Field Name New
#            $Type      Field Typ
#            $Null      Field is NULL
#            $Default   Field default
#            $Extra     Extra (not used)
#
#            $Conn      mysqli Connection
#
# Return: 0     if field changed
#         -1    on error
#
# Version 1.0.0
#
##############################################################################
function ChangeFields($Table, $FieldOld, $Field, $Type, $Null, $Default, $Extra, $Conn) {
    
    # ALTER TABLE `vicidial_user_log` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
    # ALTER TABLE `vicidial_users` ADD `2FA_type` ENUM('SMS','EMail','TOTP') NOT NULL DEFAULT 'TOTP';
    
    $sql = "ALTER TABLE `".$Table."` CHANGE `".$FieldOld."` `".$Field."` ".$Type." ";
    if($Null  == "false") {
        $sql .= "NOT ";
    }
    $sql .= "NULL ";
    if($Default != "") {
        $sql .= "DEFAULT '".$Default."';";
    }
    if(($res = mysqli_query($Conn, $sql)) === false)
    {
        echo("Invalid query: ". mysqli_error($Conn) . PHP_EOL);
        return -1;
    }
    return 0;
}

function AddTable($Table, $Tag, $Conn) {
    
    $sql = "CREATE TABLE `".$Table."` ". $Tag.";";
    if(($res = mysqli_query($Conn, $sql)) === false)
    {
        echo("Invalid query: ". mysqli_error($Conn) . PHP_EOL);
        return -1;
    }
    return 0;
}
function AddIndex($Table, $Index, $Conn) {
    
    $sql = "ALTER TABLE `".$Table."` ADD INDEX ". $Index.";";
    if(($res = mysqli_query($Conn, $sql)) === false)
    {
        echo("Invalid query: ". mysqli_error($Conn) . PHP_EOL);
        return -1;
    }
    return 0;
}


$array = Array (
    "0" => Array (
        "Section" => "field",
        "Action" => "Add",
        "Table" => "vicidial_test",
        "Field" => "test",
        "Typ" => "varchar(100)",
        "Null" => "false",
        "Default" => "ABC",
        "Extra" => ""
    ),
    "1" => Array (
        "Section" => "field",
        "Action" => "Add",
        "Table" => "vicidial_test",
        "Field" => "test1",
        "Typ" => "bigint",
        "Null" => "false",
        "Default" => "0",
        "Extra" => ""
    ),
    "2" => Array (
        "Section" => "field",
        "Action" => "Add",
        "Table" => "vicidial_test1",
        "Field" => "test1",
        "Typ" => "bigint",
        "Null" => "false",
        "Default" => "0",
        "Extra" => ""
    ),
    "3" => Array (
        "Section" => "field",
        "Action" => "Change",
        "Table" => "vicidial_test",
        "FieldOld" => "test1",
        "Field" => "test1a",
        "Typ" => "varchar(50)",
        "Null" => "false",
        "Default" => "0",
        "Extra" => ""
    )
);
$json = json_encode($array);
#$bytes = file_put_contents("update_sql.json", $json);
#echo "The number of bytes written are $bytes." . PHP_EOL;

$Json = file_get_contents("update_sql.json");
#var_dump($Json);
$myarray = json_decode($Json, true);
#var_dump($myarray); // prints array


$Conn = mysqli_connect("10.106.1.1", "dbadmin", "FrzZC7x2voqH", "Test_asterisk");

foreach($myarray AS $Arr) {
    if(($Arr["Section"] == "field") && ($Arr["Action"] == "Add")) {
        if(CheckTableExists($Arr["Table"], $Conn) == 1) {
            echo "Field : ".$Arr["Table"].".".$Arr["Field"]." ";
            if(CheckFieldExists($Arr["Table"], $Arr["Field"], $Arr["Typ"], $Conn) == 0) {
                InsertFields($Arr["Table"], $Arr["Field"], $Arr["Typ"], $Arr["Null"], $Arr["Default"], $Arr["Extra"], $Conn);
                echo "add" .PHP_EOL;
            } else {
                echo "already exists" .PHP_EOL;
            }
        } else {
            echo "Table : ".$Arr["Table"]. " not exists".PHP_EOL;
        }
    }
    if(($Arr["Section"] == "field") && ($Arr["Action"] == "Change")) {
        if(CheckTableExists($Arr["Table"], $Conn) == 1) {
            if($Arr["FieldOld"] != $Arr["Field"]) {
                if(CheckFieldExists($Arr["Table"], $Arr["FieldOld"], $Arr["Typ"], $Conn) == 1) {
                    if(CheckFieldExists($Arr["Table"], $Arr["Field"], $Arr["Typ"], $Conn) == 0) {
                        ChangeFields($Arr["Table"], $Arr["FieldOld"], $Arr["Field"], $Arr["Typ"], $Arr["Null"], $Arr["Default"], $Arr["Extra"], $Conn);
                        echo "Field : ".$Arr["Table"].".".$Arr["FieldOld"]. " changed to ".$Arr["Field"].".".$Arr["Typ"] . PHP_EOL;
                    } else {
                        echo "Field : ".$Arr["Table"].".".$Arr["Field"]. " already exists" . PHP_EOL;
                    }
                } else {
                    echo "Field : ".$Arr["Table"].".".$Arr["FieldOld"]. " not exists" .PHP_EOL;
                }
            } else { # $Arr["FieldOld"] == $Arr["Field"]
                $FieldTest = CheckFieldExists($Arr["Table"], $Arr["FieldOld"], $Arr["Typ"], $Conn);
                if($FieldTest  == 1) {
                    ChangeFields($Arr["Table"], $Arr["FieldOld"], $Arr["Field"], $Arr["Typ"], $Arr["Null"], $Arr["Default"], $Arr["Extra"], $Conn);
                    echo "Field : ".$Arr["Table"].".".$Arr["FieldOld"]. " changed to ".$Arr["Field"].".".$Arr["Typ"]. PHP_EOL;
                } else {
                    if($FieldTest == 2) {
                        echo "Field : ".$Arr["Table"].".".$Arr["FieldOld"]. " allready changed" .PHP_EOL;
                    } else {
                        echo "Field : ".$Arr["Table"].".".$Arr["FieldOld"]. " not exists" .PHP_EOL;
                    }
                }
            }
        } else {
            echo "Table : ".$Arr["Table"]. " not exists".PHP_EOL;
        }
    }
    if(($Arr["Section"] == "table") && ($Arr["Action"] == "Add")) {
        if(CheckTableExists($Arr["Table"], $Conn) == 0) {
            AddTable($Arr["Table"], $Arr["tag"], $Conn);
            echo "Table : ".$Arr["Table"]." add" . PHP_EOL;
        } else {
            echo "Table : ".$Arr["Table"]." already exists" . PHP_EOL;
        }
    }
    if(($Arr["Section"] == "index") && ($Arr["Action"] == "Add")) {
        if(CheckTableExists($Arr["Table"], $Conn) == 1) {
            AddIndex($Arr["Table"], $Arr["Index"], $Conn);
            echo "Index : ".$Arr["Table"]." add" . PHP_EOL;
        } else {
            echo "Index : ".$Arr["Table"]." not exists" . PHP_EOL;
        }
    }
}


?>