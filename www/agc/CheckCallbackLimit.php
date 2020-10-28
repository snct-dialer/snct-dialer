<?php 


$CBAgentCount = $SetUp->GetData("Checkcallback", "AgentCount");
$CBAgentDays = $SetUp->GetData("Checkcallback", "AgentDays");
$CBLeadCount = $SetUp->GetData("Checkcallback", "LeadCount");
$CBLeadDays = $SetUp->GetData("Checkcallback", "LeadDays");
$CBAgentNoTestNum = $SetUp->GetData("Checkcallback", "AgentNoCheckNum");
if(!isset($CBAgentNoTestNum)) { $CBAgentNoTestNum = 0;};
$CBAgentNoTest = array ();


if($CBAgentNoTestNum != 0) {
	for ($n = 0; $n != $CBAgentNoTestNum; $n++) {
		$CBName = sprintf("AgentNoCheck%'.04d", $n);
		$CBAgentNoTest[] = $SetUp->GetData("Checkcallback", $CBName);
	}
}


if(!isset($CBAgentCount)) { $CBAgentCount = 0;};
if(!isset($CBAgentDays)) { $CBAgentCount = 0;};
if(!isset($CBLeadCount)) { $CBLeadCount = 0;};
if(!isset($CBLeadDays)) { $CBLeadCount = 0;};


function CheckCallbacks($User, $Lead, $PG) {
	global $MySqlLink, $DB, $CBAgentCount, $CBLeadCount, $CBAgentDays, $CBLeadDays, $Log, $CBAgentNoTest;


	$StartTime = microtime(true);

	if(in_array($user, $CBAgentNoTest)) {
		$Log->Log("GenDispoScreen NoTest: " . $user);
		return 1;
	}

	if(($CBAgentCount != 0) && ($PG != 'G')) {
		$DateTemp = date("Y-m-d");
#		$DateTemp = date("Y-m-d H:i:s", strtotime($CBAgentDays, time())); 
		$sql = "SELECT COUNT(*) FROM `vicidial_agent_log` WHERE `status` = 'CALLBK' AND `user` = '". $User ."' AND DATE (`event_time`) = '". $DateTemp ."';";
		if($DB) { echo $sql; }
		$res = mysqli_query($MySqlLink, $sql);
		$row = mysqli_fetch_row($res);
		$AnzUCB = $row[0];
		if($AnzUCB > $CBAgentCount) {
			$EndTime = microtime(true);
			$RunTime = $EndTime - $StartTime;
			$Log->Log("CheckCallbacks (Agent) Dauer: " . $RunTime ."|". $User . "|" .$Lead . "|" . $PG . "|" .$AnzUCB . "|" . $CBAgentCount);
			return 0;
		} else {
			$EndTime = microtime(true);
			$RunTime = $EndTime - $StartTime;
			$Log->Log("CheckCallbacks (no Agent) Dauer: " . $RunTime ."|". $User . "|" .$Lead . "|" . $PG . "|" .$AnzUCB . "|" . $CBAgentCount);
		}
	}

	if(($CBLeadCount != 0) && ($PG != "G")) {
		$StartTime1 = microtime(true);
		$DateTemp = date("Y-m-d H:i:s", strtotime($CBLeadDays, time()));
		$sql1 = "SELECT COUNT(*) FROM `vicidial_agent_log` WHERE `status` = 'CALLBK' AND `lead_id` = '". $Lead ."' AND `event_time` >= '". $DateTemp ."';";
		if($DB) { echo $sql1; }
		$res1 = mysqli_query($MySqlLink, $sql1);
		$row1 = mysqli_fetch_row($res1);
		$AnzLCB = $row1[0];
		if($AnzLCB > $CBLeadCount) {
			$EndTime = microtime(true);
			$RunTime = $EndTime - $StartTime;
			$Log->Log("CheckCallbacks (Lead) Dauer: " . $RunTime ."|". $User . "|" .$Lead . "|" . $PG . "|" .$AnzLCB . "|" . $CBLeadCount);
			return 0;
		} else {
			$EndTime = microtime(true);
			$RunTime = $EndTime - $StartTime1;
			$Log->Log("CheckCallbacks (no Lead) Dauer: " . $RunTime ."|". $User . "|" .$Lead . "|" . $PG . "|" .$AnzLCB . "|" . $CBLeadCount);
		}
	}
	$EndTime = microtime(true);
	$RunTime = $EndTime - $StartTime;
	$Log->Log("CheckCallbacks (not found) Dauer: " . $RunTime ."|". $User . "|" .$Lead . "|" . $PG);
	return 1;
}


?>
