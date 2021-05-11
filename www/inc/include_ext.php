<?php 

if (file_exists('../inc/setup.php')) {
    require_once '../inc/setup.php';
} elseif (file_exists('./inc/setup.php')) {
    require_once './inc/setup.php';
} else {
    require_once 'om/inc/setup.php';
}

if (file_exists('../inc/log_ext.php')) {
    require_once '../inc/log_ext.php';
} elseif (file_exists('./inc/log_ext.php')) {
    require_once './inc/log_ext.php';
} else {
    require_once 'om/inc/log_ext.php';
}

if (file_exists('../inc/db_ng_ext.php')) {
    require_once '../inc/db_ng_ext.php';
} elseif (file_exists('./inc/db_ng_ext.php')) {
    require_once './inc/db_ng_ext.php';
} else {
    require_once 'om/inc/db_ng_ext.php';
}


if (file_exists('../inc/header.php')) {
    require_once '../inc/header.php';
} elseif (file_exists('./inc/header.php')) {
    require_once './inc/header.php';
} else {
    require_once 'om/inc/header.php';
}


if (file_exists('../inc/menue.php')) {
    require_once '../inc/menue.php';
} elseif (file_exists('./inc/menue.php')) {
    require_once './inc/menue.php';
} else {
    require_once 'om/inc/menue.php';
}


if (file_exists('../inc/languages.php')) {
    require_once '../inc/languages.php';
} elseif (file_exists('./inc/languages.php')) {
    require_once './inc/languages.php';
} else {
    require_once 'om/inc/languages.php';
}


?>
