<?php 


# realtime_report_ng   version 0.0.1
#
# LICENSE: AGPLv3
#
# Copyright (©) 2020      SNCT GmbH <info@snct-dialer.de>
#               2019      Jörg Frings-Fürst <open_source@jff.email>
#
#
# SNCT - Changelog
#
# 2020-06-10 0.0.1 jff  first work
#
# ToDo:
#
#
#
# Replace Realtime view
#
#
# 
#


require_once '../inc/start_head.php';

PrintHeader("Realtime Report NG");

?>

    <div style="margin:20px 0;"></div>
    <div id="tt" class="easyui-tabs" data-options="tools:'#tab-tools'" style="width:100%;height:920px">
    </div>
    <div id="tab-tools">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'" onclick="addPanel()"></a>
<!--    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-remove'" onclick="removePanel()"></a> --> 
    </div>
    <script type="text/javascript">
        var index = 0;
        function addPanel1(){
            index++;
            $('#tt').tabs('add',{
                title: 'RTV-'+index,
                href: '/snct-monitor/monitortab.php?MonID='+index,
                closable: false,
                justified: true
            });
        }
        function addPanel(){
            index++;
            $('#tt').tabs('add',{
                title: 'RTV-'+index,
                href: '/snct-monitor/monitortab.php?MonID='+index,
                closable: true,
                justified: true
            });
        }
        function removePanel(){
            var tab = $('#tt').tabs('getSelected');
            if (tab){
                var index = $('#tt').tabs('getTabIndex', tab);
                $('#tt').tabs('close', index);
            }
        }
        $(document).ready(function() {
			addPanel1();
		});
    </script>
</body>
</html>