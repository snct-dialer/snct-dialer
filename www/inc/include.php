<?php 

if (file_exists('../inc/setup.php')) {
    require_once '../inc/setup.php';
} elseif (file_exists('./inc/setup.php')) {
    require_once './inc/setup.php';
} else {
    require_once 'om/inc/setup.php';
}

if (file_exists('../inc/log.php')) {
    require_once '../inc/log.php';
} elseif (file_exists('./inc/log.php')) {
    require_once './inc/log.php';
} else {
    require_once 'om/inc/log.php';
}

if (file_exists('../inc/db.php')) {
    require_once '../inc/db.php';
} elseif (file_exists('./inc/db.php')) {
    require_once './inc/db.php';
} else {
    require_once 'om/inc/db.php';
}


?>
