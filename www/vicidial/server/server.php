<?php 

#require($_SERVER['DOCUMENT_ROOT'].'/var/www/html/vendor/autoload.php');
#require_once($_SERVER['DOCUMENT_ROOT']."/var/www/html/bin/chat.php");

use Ratchet\Server\IoServer;
use Ratchet\Http\HttpServer;
use Ratchet\WebSocket\WsServer;
use React\EventLoop\Factory;
use React\Socket\SecureServer;

use SNCTDialerApp\SNCTApp;

#require($_SERVER['DOCUMENT_ROOT'].'/var/www/html/vendor/autoload.php');
require dirname(__DIR__) . '/vendor/autoload.php';
require dirname(__DIR__) . '/server/snct-dialer-app.php';
       

#$loop = Factory::create();
$loop = React\EventLoop\Loop::get();
$wsServer = new WsServer(new SNCTApp());
$wsServer->enableKeepAlive($loop, 5);
$app = new HttpServer($wsServer);


$secure_websockets = new React\Socket\SocketServer('tls://0.0.0.0:8877/',
    array( 'tls' => array(
    'local_cert' => '/etc/letsencrypt/live/snct-dialer.de/cert.pem', // path to your cert
    'local_pk' => '/etc/letsencrypt/live/snct-dialer.de/privkey.pem', // path to your server private key
    'allow_self_signed' => FALSE, // Allow self signed certs (should be false in production)
    'verify_peer' => false))
, $loop);


$secure_websockets->on('error', function (Exception $e) {
    echo 'error: ' . $e->getMessage() . PHP_EOL;
});

#$secure_websockets->on('connection', function (React\Socket\ConnectionInterface $connection) {
#    $connection->write("Hello " . $connection->getRemoteAddress() . "!\n");
#    $connection->write("Welcome to this amazing server!\n");
#    $connection->write("Here's a tip: don't say anything.\n");
        
#    $connection->on('data', function ($data) use ($connection) {
#      $connection->close();
#    });
#});

$secure_websockets->on('connection', function (React\Socket\ConnectionInterface $connection) {
       echo 'Plaintext connection from ' . $connection->getRemoteAddress() . PHP_EOL;
        
#       $connection->write('hello there!' . PHP_EOL);
});

$secure_websockets_server = new IoServer($app, $secure_websockets, $loop);

$secure_websockets_server->run();





?>