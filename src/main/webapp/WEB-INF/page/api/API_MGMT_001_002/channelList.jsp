<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <title>渠道管理</title>
    <!-- css引入 -->
    <rc:csshead/>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
         <!-- 渠道列表开始 -->
         <div class="col-sm-8">
         <!-- 查询条件开始 -->
         <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>查询条件</h5>
                <div class="ibox-tools">
                    <a class="collapse-link">
                        <i class="fa fa-chevron-up"></i>
                    </a>
                </div>
            </div>
            <div class="ibox-content">
	            <form class="form-horizontal" id="query_form" >
			        <div class="form-group">
			            <rc:textedit property="channelName"  label="渠道名称" />
			            <rc:select property="channelType" label="渠道类型"  codetype="CHANNEL_TYPE" multiple="true" />
			            <rc:select property="channelStatus" label="渠道状态"  codetype="CHANNEL_STATUS" multiple="true" />
			            <div class="col-sm-3" align="right">
		                  <a class="btn btn-info" onclick="channel_query()"><i class="fa fa-search"></i>&nbsp;查询</a>
		                  <a class="btn btn-info" onclick="rc.clean($('query_form'))"><i class="fa fa-refresh"></i>&nbsp;重置</a>
		                </div>
			       </div>
		       </form>
	       </div>
        </div>
        <!-- 查询条件结束 -->
        <!-- 查询结果开始 -->    
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>查询结果列表</h5>
                <div class="ibox-tools">
                </div>
            </div>
            <!-- 模型 -->
            <script id="tpl" type="text/x-handlebars-template" >
                <a class="link" onclick="channel_view_by_id('{{channelId}}')"><i class="fa fa-file-o"></i>&nbsp;查看</a> 
                <a class="link" onclick="channel_edit_by_id('{{channelId}}')"><i class="fa fa-edit"></i>&nbsp;编辑</a> 
                {{#equals channelStatus '-1' }}
                   <a class="link" onclick="channelStatus_update_by_id('{{channelId}}','1')" ><i class="fa fa-remove"></i>&nbsp;审核</a> 
                {{/equals}} 
                
                {{#equals channelStatus '0' }}
                   <a class="link" onclick="channelStatus_update_by_id('{{channelId}}','1')" ><i class="fa fa-check"></i>&nbsp;恢复</a> 
                {{/equals}}  

                {{#equals channelStatus '1' }}
                   <a class="link" onclick="channelStatus_update_by_id('{{channelId}}','0')" ><i class="fa fa-remove"></i>&nbsp;注销</a> 
                {{/equals}}  
            </script>
            
            <!-- 模型 -->
            <script id="tpl_channelStatus" type="text/x-handlebars-template" >
                          {{#equals channelStatus '-1' }}
                              <div class="progress progress-striped " style="margin-bottom:0px;">			                
                                 <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
                                                                                                   待审核	                             
                              </div>
                              </div>
			              {{/equals}} 
                          {{#equals channelStatus '0' }}
                              <div class="progress progress-striped " style="margin-bottom:0px;">			                
                              <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
                                                                                              注销                          
                              </div>
                              </div>
			              {{/equals}} 
			              {{#equals channelStatus '1'}}
                           <div class="progress progress-striped " style="margin-bottom:0px;">
                              <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
                                                                                                     正常                          
                              </div>
                           </div>
			              {{/equals}}
            </script>
            
            <!-- toolbar -->
            <div id="toolbar" class="btn-group">
				 <button id="btn_delete" type="button" class="btn btn-info" onclick="channel_add()">
				 <span class="glyphicon glyphicon-plus" aria-hidden="false"></span>新增
				 </button>
				 <a class="btn btn-success  J_menuItem " href="<c:url value='/sys/sys/codetype/index'/>?code_type=CHANNEL_TYPE" ><i class="fa fa-share"></i>&nbsp;渠道类型管理</a>
			</div>
			
            <div class="ibox-content">
			    <table id="channeltable" data-url="<c:url value='/api/channel/getList'/>" 
			          data-click-to-select="false"
                      data-toolbar="#toolbar"
                      data-show-export="true"
                      data-pagination="true"
                      data-uniqueId="1"
                      data-page-size="50"
                      data-filter-control="false"
                 >
			    <thead>
				    <tr>
				        <th data-checkbox="true" ></th>
				        <th data-formatter="channel_indexFormatter">序号</th>
	                    <th data-field="channelCode" >渠道编码</th>
	                    <th data-field="channelType" >渠道类型 </th>
	                    <th data-field="channelName" >渠道名称</th>
	                    <th data-field="channelDescribe">渠道描述</th>
	                    <th data-field="channelIcon" data-formatter="channelIcon_Formatter">渠道图标</th>
	                    <th data-field="channelAppkey">渠道appkey</th>
	                    <th data-field="channelStatus" data-formatter="channelStatus_Formatter" align="center">渠道状态</th>
	                    <th data-formatter="channel_Formatter">操作</th>
				    </tr>
			    </thead>
			    </table>
            </div>
        </div>
       <!-- 查询结果结束 -->
       </div>
       <!-- 渠道列表结束 -->
       <!-- 服务树开始 -->
       <div class="col-sm-4">
           <div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>服务明细</h5>
					<div class="ibox-tools">
					    <a  class="btn btn-success btn-xs J_menuItem " href="<c:url value='api/index'/>" ><i class="fa fa-share"></i>&nbsp;服务管理</a>
						<a id="btn_role_perm" class="btn btn-primary btn-xs " onclick="save_channel_interface_data()"><i class="fa fa-save"></i>&nbsp;保存</a>
					</div>
				</div>
				<div class="ibox-content">
				    <!-- 隐藏域 -->
					<rc:hidden  property="channelId"/>
					<div id="tree-div" class="ztree" style="overflow: auto; height: 650px; width: 450px;"></div>
				</div>
			</div>
       </div>
       <!-- 服务树结束 -->
    </div>
    <!-- javascript引入 -->
    <rc:jsfooter/>
    <script type="text/javascript">
    var $table=$('#channeltable');
    
    var channel_options={
    	formid:'query_form'
    }
    //初始化
    $(function(){
    	$('#channeltable').inittable(channel_options);
    	  //权限树加载
    	api_interface_treeinit();
    });
  
    //树初绍化
    function api_interface_treeinit(){
 	   $.fn.zTree.init($("#tree-div"), api_interface_setting);
 	   var zTree = $.fn.zTree.getZTreeObj("tree-div");
 	   zTree.expandAll(true)
    }
    
    //服务树配置
    var api_interface_setting = {
 	  view: {
           showLine: true
 	  },	   
       check: {
 		  enable: true
 	  },
   	  data: {
   		simpleData: {
   			enable: true,
   			pIdKey: "pid",
   			rootPId: '0'
   		}
   	  },
   	  async: {
   		 enable: true,
   		 url: "<c:url value='/api/channel/treedata'/>",
   		 autoParam:["id"],
   		 otherParam: {"id":"0"}
   	  }
    };
    
    //用户表格监听,双击 
    $('#channeltable').on('click-row.bs.table', function (e, row, $element) {
      	$('#channelId').val(row.channelId);
      	tree_edit(row.channelId);
    }); 
    
    //服务编辑
    function tree_edit(channelId){
 	   //rc.ajaxQuery("<c:url value='/sys/role/getRoleData/'/>"+channelId);
 	   var otherParam= { 'id':channelId }
 	   api_interface_setting.async.otherParam=otherParam;
 	   api_interface_treeinit();
    }
   
    //操作编辑
    function channel_Formatter(value, row, index) {
        var tpl = $("#tpl").html();  
	  	//预编译模板  
	  	var template = Handlebars.compile(tpl);  
	  	return template(row);
    }
    
    //服务状态渲染
    function channelIcon_Formatter(value, row, index) {
        return '<span style="text-align:center;font-size:16px;"><i class="fa '+value+'"></i></span>'
    }
    
    //服务状态渲染
    function channelStatus_Formatter(value, row, index) {
        var tpl = $("#tpl_channelStatus").html();  
	  	//预编译模板  
	  	var template = Handlebars.compile(tpl);  
	  	return template(row);
    }
   
    function channel_indexFormatter(value, row, index) {
        return index+1;
    }
  
    
    //查询
    function channel_query(){
    	$('#channeltable').refreshtable();
    	//$('.collapse-link').click();
    }
    
    //删除数据
    function channelStatus_update_by_id(channelId,channelStatus){
   	  if(channelId){
   		layer.confirm('确定操作？', function(index){
   			var url= "<c:url value='/api/channel/updatestatus'/>";
   			rc.ajax(url, {channelId:channelId,channelStatus:channelStatus},function (response) {
   				if(response.success){
   					//layer.msg(response.message);
                    $('#channeltable').refreshtable();
   				}else{
   					layer.msg(response.message);
   				}
   			});
   			layer.close(index);
   		});
   	  }else{
   		layer.alert('请先选择数据');
   	  }
    }
    
    //编辑
    function channel_add(){
    	 index=layer.open({
	   		  type: 2,
	   		  title: '服务新增',
	   		  shadeClose: false,
	   		  maxmin:true,
	   		  shade: 0.8,
	   		  offset: ['100px', '50px'],
	   		  area: ['50%', '70%'],
	   		  content: "<c:url value='/api/channel/toAdd'/>" //iframe的url
 		});
    	//layer.full(index);
    }
    
    //编辑
    function channel_edit_by_id(channelId){
    	layer.open({
	   		  type: 2,
	   		  title: '服务编辑',
	   		  shadeClose: false,
	   		  maxmin:true,
	   		  shade: 0.8,
	   		  area: ['50%', '70%'],
	   		  area: ['50%', '70%'],
	   		  content: "<c:url value='/api/channel/toEdit'/>/"+channelId //iframe的url
 		});
    }
    
    //查看
    function channel_view_by_id(channelId){
    	layer.open({
	   		  type: 2,
	   		  title: '服务查看',
	   		  shadeClose: false,
	   		  maxmin:true,
	   		  shade: 0.8,
	   		  area: ['50%', '70%'],
	   		  area: ['50%', '70%'],
	   		  content: "<c:url value='/api/channel/toView'/>/"+channelId //iframe的url
 		});
    }
    
    //渠道及服务关联保存
    function save_channel_interface_data() {
 	   var channelId=$('#channelId').val();
 	   if(channelId){
 		    var zTree = $.fn.zTree.getZTreeObj("tree-div");
 		    var nodes = zTree.getCheckedNodes(true);
 		    var selectnodes=",";
 		    for(i=0;i<nodes.length;i++){
 		       selectnodes+= nodes[i].id+",";
 		    }
 		    console.log(selectnodes);
 		    rc.ajax("<c:url value='/api/channel/saveChannelInterface'/>", {channelId:channelId,selectnodes:selectnodes},function (response) {
 		    	layer.msg(response.message);
 			}); 
 	   }else{
 		   layer.alert('请先选择一个渠道');
 	   }
 	}
    </script>
</body>
</html>