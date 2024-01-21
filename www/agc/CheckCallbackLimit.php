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
		$Log->Log("Add NoTestAgent: " . $CBName . "|" . $SetUp->GetData("Checkcallback", $CBName));
	}
}


if(!isset($CBAgentCount)) { $CBAgentCount = 0;};
if(!isset($CBAgentDays)) { $CBAgentCount = 0;};
if(!isset($CBLeadCount)) { $CBLeadCount = 0;};
if(!isset($CBLeadDays)) { $CBLeadCount = 0;};


function CheckCallbacks($User, $Lead, $PG) {
	global $MySqlLink, $DB, $CBAgentCount, $CBLeadCount, $CBAgentDays, $CBLeadDays, $Log, $CBAgentNoTest;


	$StartTime = microtime(true);

	if(in_array($User, $CBAgentNoTest)) {
		$Log->Log("GenDispoScreen NoTest: " . $User);
		return 1;
	}
	#
	# Check Elite
	#
#	$sqlElite = "SELECT `owner` FROM `vicidial_list` WHERE `lead_id` = '".$Lead."';";
	$sqlElite  = "SELECT `owner` FROM `vicidial_list` VL, `vicidial_lists` VLS WHERE VL.`lead_id` = '".$Lead."' ";
	$sqlElite .= " AND VL.`list_id` = VLS.`list_id` AND VLS.`base_campaign_id` LIKE 'Elite%';";
	if($DB) { echo $sqlElite; }
	$resElite = mysqli_query($MySqlLink, $sqlElite);
#	$rowElite = mysqli_fetch_row($resElite);
#	if(($rowElite[0] == '2005') || ($rowElite[0] == '2025') || ($rowElite[0] == '2015')) {
	if(mysqli_num_rows($resElite) > 0) {
	    $EndTime = microtime(true);
	    $RunTime = $EndTime - $StartTime;
	    $Log->Log("CheckCallbacks (Elite NG) Dauer: " . $RunTime ."|" .$Lead  );
	    return 0;
	}
	if(($CBAgentCount != 0) && ($PG != 'G')) {
		$DateTemp = date("Y-m-d");
#		$DateTemp = date("Y-m-d H:i:s", strtotime($CBAgentDays, time())); 
#		$sql = "SELECT COUNT(*) FROM `vicidial_agent_log` WHERE `status` = 'CALLBK' AND `user` = '". $User ."' AND DATE (`event_time`) = '". $DateTemp ."';";
		$sql = "SELECT COUNT(*) FROM `vicidial_agent_log` WHERE `status` = 'CALLBK' AND `user` = '". $User ."' AND DATE (`event_time`) = '". $DateTemp ."' AND `campaign_id` NOT IN ('ALTSNCT1','ALTSNCT2');";
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
