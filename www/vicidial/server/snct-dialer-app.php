<?php

namespace SNCTDialerApp;
use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;

class SNCTApp implements MessageComponentInterface {
    protected $clients;
    
    public function __construct() {
        echo "Init system" . PHP_EOL;
        $this->clients = new \SplObjectStorage;
        echo "Init system 2" . PHP_EOL;
    }
    
    public function onOpen(ConnectionInterface $conn) {
        $this->clients->attach($conn);
#        $this->onMessage($conn,$conn->getRemoteAddress());
        echo "New connection! ({$conn->resourceId})\n";
    }

    public function onMessage(ConnectionInterface $from, $msg) { 
        
        echo "\nNew Message: " . $msg . "\n";
        
        foreach($this->clients as $clientSocket) {
            $clientSocket->send("\n$msg\n");
        };
           
        
    }

    public function onClose(ConnectionInterface $conn) {  
        $this->clients->detach($conn);
        echo "Connection {$conn->resourceId} has disconnected\n";
    }

    public function onError(ConnectionInterface $conn, \Exception $e) {
        echo "\nError on Connection: {$e->getMessage()} on line {$e->getLine()} in file {$e->getFile()} \n";
        
        $conn->close();
    }
}

?>
