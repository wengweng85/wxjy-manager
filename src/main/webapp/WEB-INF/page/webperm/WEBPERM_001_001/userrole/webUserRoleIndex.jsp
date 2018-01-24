<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>机构及人员管理</title>
<!-- css头文件  -->
<rc:csshead />
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="col-sm-4">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>用户信息</h5>
					<div class="ibox-tools">
			        </div>
				</div>
				<div class="ibox-content">
					<!-- tab 开始-->
		            <div class="ibox-content">
		                <!-- tab nav -->
				        <ul id="myTab" class="nav nav-tabs">
						    <li class="active">
						        <a href="#home" data-toggle="tab">个人用户</a>
						    </li>
						    <li><a href="#ios" data-toggle="tab">企业用户</a></li>
						    <li><a href="#java" data-toggle="tab">培训机构用户</a></li>
						</ul>
						<!-- tab nav 结束 -->
						<!-- tab content开始 -->
						<div id="myTabContent" class="tab-content">
						    <div class="tab-pane fade in active" id="home">
						        <table id="group_person_table" data-url="<c:url value='/web/userrole/getGroupListByType'/>?type=person" 
						          data-click-to-select="false"
			                      data-show-export="true"
			                      data-pagination="true"
			                      data-uniqueId="1"
			                      data-page-size="10"
			                      data-filter-control="false"
				                >
								    <thead>
									    <tr>
									        <th data-checkbox="true" ></th>
									        <th data-formatter="_indexFormatter">序号</th>
						                    <th data-field="description">身份证号码</th>
						                    <th data-field="name" >姓名</th>
									    </tr>
								    </thead>
							    </table>
						    </div>
						    <div class="tab-pane fade" id="ios">
						       <table id="group_company_table" data-url="<c:url value='/web/userrole/getGroupListByType'/>?type=company" 
						          data-click-to-select="false"
			                      data-show-export="true"
			                      data-pagination="true"
			                      data-uniqueId="1"
			                      data-page-size="10"
			                      data-filter-control="false"
				                >
								    <thead>
									    <tr>
									        <th data-checkbox="true" ></th>
									        <th data-formatter="_indexFormatter">序号</th>
						                    <th data-field="description" >统一信用代码</th>
						                    <th data-field="name" >企业名称</th>
									    </tr>
								    </thead>
							    </table>
						    </div>
						    <div class="tab-pane fade" id="java">
						        <div id="tree-div" class="ztree" style="overflow: auto; height: 750px; "></div>
						    </div>
						</div>
					</div>
				  <!-- tab content结束 -->
				</div>
				<!-- tab 结束 -->
			</div>
		</div>
		<div class="col-sm-4">
			<div class="row">
			    <div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>用户明细信息</h5>
						</div>
						<div class="ibox-content" >
							<form class="form-horizontal" id="group_form">
								<!-- 隐藏区域 -->
								<rc:hidden property="groupid"/>
								<div class="form-group">
									<rc:textedit property="name" label="机构名称"  cols="3,9"  readonly="true" />
								</div>
								<div class="hr-line-dashed"></div>
								<div class="form-group">
									<rc:textedit property="description"  label="机构描述"  cols="3,9"  readonly="true" />
								</div>
							</form>
						</div>
					</div>
				</div>
				
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>账户信息列表</h5>
							<div class="ibox-tools">
						         <a  class="btn btn-primary btn-xs" onclick="addSysUser()" ><i class="fa fa-plus"></i>&nbsp;创建账户</a>
					        </div>
						</div>
						<!-- 模型 -->
			            <script id="tpl" type="text/x-handlebars-template" >
                            {{#equals isgrant 'false' }}			                
                                    <span style='color:red;'><i class="fa fa-close"></i></span>
			                {{/equals}} 
			                {{#equals isgrant 'true'}}
                                    <span style='color:blue;'><i class="fa fa-check"></i></span>
			                {{/equals}} 
			            </script>
			            
			            <script id="tpl_ismainaccount" type="text/x-handlebars-template" >
                            {{#equals ismainaccount '0' }}			                
                                 <span style='color:red;'><i class="fa fa-close"></i></span>
			                {{/equals}} 
			                {{#equals ismainaccount '1'}}
                                 <span style='color:blue;'><i class="fa fa-check"></i></span>
			                {{/equals}} 
			            </script>
			            
			            <script id="tpl_isblacklist" type="text/x-handlebars-template" >
                            {{#equals isblacklist '0' }}			                
                                 <span style='color:red;'><i class="fa fa-close"></i></span>
			                {{/equals}} 
			                {{#equals isblacklist '1'}}
                                 <span style='color:blue;'><i class="fa fa-check"></i></span>
			                {{/equals}} 
			            </script>
			            
			            <script id="tpl_op" type="text/x-handlebars-template" >
                             <a class="btn btn-info" onclick="web_user_pass_reset('{{userid}}')">密码重置</a>
                             <a class="btn btn-danger" onclick="web_user_to_blacklist('{{userid}}')">加入黑名单</a>
                             <a class="btn btn-danger" onclick="web_user_delete('{{userid}}')">删除</a>
			            </script>
						<div class="ibox-content" >
							<table id="usertable" 
							data-url="<c:url value='/web/userrole/getUserListDataByid'/>"
							data-click-to-select="true"
                            data-single-select="true"
                            data-page-size="5"
							>
								<thead>
								    <tr>
								        <th data-checkbox="true" ></th>
								        <th data-formatter="web_user_role_indexFormatter">序号</th>
					                    <th data-field="username">用户名</th>
					                    <th data-field="ismainaccount" data-formatter="web_user_role_ismainaccountFormatter">是否主账户</th>
					                    <th data-field="isblacklist" data-formatter="web_user_role_isblacklistFormatter">是否黑名单</th>
					                    <th data-formatter="web_user_role_grantStatusFormatter">是否已授权</th>
					                    <th data-formatter="web_user_role_opFormatter">操作</th>
								    </tr>
						        </thead>
							</table>
						</div>
					</div>
				</div>
			</div>
			</div>
			<div class="col-sm-4">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>账户信息明细</h5>
						<div class="ibox-tools">
						    <a class="btn btn-success btn-xs J_menuItem " href="<c:url value='web/role/index'/>" ><i class="fa fa-share"></i>&nbsp;角色管理</a>
						    <a class="btn btn-primary btn-xs" onclick="web_user_role_batchAddUserRole()"><i class="fa fa-save"></i>&nbsp;保存</a>
					    </div>
					</div>
					<div class="ibox-content" >
						<form class="form-horizontal" id="user_form">
							<!-- 隐藏区域 -->
							<rc:hidden property="userid"/>
							<div class="form-group">
								<rc:textedit property="username" label="用户名"  cols="3,9"  readonly="true" />
							</div>
						</form>
					</div>
				</div>
			</div>
			
			<div class="col-sm-12">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>账户对应角色列表</h5>
				</div>
				<div class="ibox-content" >
					<table id="roletable" data-url="<c:url value='/web/userrole/getRoleByUserId'/>"
					data-page-size="20"
					>
						<thead>
						    <tr>
						        <th data-checkbox="true"  data-formatter="web_user_role_checkedFormatter"></th>
						        <th data-formatter="web_user_role_indexFormatter">序号</th>
						        <th data-field="systypecode">应用系统类型</th>
			                    <th data-field="name">角色名称</th>
			                    <th data-field="code">角色编码</th>
						    </tr>
				        </thead>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<rc:jsfooter />
<script type="text/javascript">
$(function() {
	 $.fn.zTree.init($("#tree-div"), web_user_role_setting);
	 //树默认展开第一级节点
  	 var treeObj = $.fn.zTree.getZTreeObj("tree-div");
     treeObj.expandAll(true);
    
	 $('#usertable').inittable();
	 $('#roletable').inittable();
	 $('#group_person_table').inittable();
	 $('#group_company_table').inittable();
	//tab切换事件
 	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
         // 获取已激活的标签页的名称
         var activeTab = $(e.target).text();
         // 获取前一个激活的标签页的名称
         var previousTab = $(e.relatedTarget).text();
         console.log("当前选中"+activeTab.trim());
         console.log("上一个选中"+previousTab.trim());
     });
})

//用户表格监听 
$('#group_person_table').on('click-row.bs.table', function (e, row, $element) {
   	rc.evaluation(row,$('#group_form'));
   	web_user_role_queryuser(row.groupid);
});

//用户表格监听 
$('#group_company_table').on('click-row.bs.table', function (e, row, $element) {
   	rc.evaluation(row,$('#group_form'));
   	web_user_role_queryuser(row.groupid);
});
function _indexFormatter(value, row, index) {
        return index+1;
}
//用户表格监听 
$('#usertable').on('click-row.bs.table', function (e, row, $element) {
   	rc.evaluation(row,$('#user_form'));
   	web_user_role_grant(row.userid);
});   
//树配置
var web_user_role_setting = {
	  view: {
          dblClickExpand: false,
          showLine: true,
          selectedMulti: false,
          nameIsHTML: true
	  },	
	  check: {
		enable: false
	  },
	  data: {
		simpleData: {
			enable: true
		}
	  },
	  callback: {
			onClick: onClick
		},
	  async: {
		 enable: true,
		 url: "<c:url value='/web/userrole/treedata'/>",
		 autoParam:["id"]
	  }
};
//format
//状态
function web_user_role_grantStatusFormatter(value, row, index) {
	var tpl = $("#tpl").html();  
  	//预编译模板  
  	var template = Handlebars.compile(tpl);  
  	return template(row);
}

function web_user_role_ismainaccountFormatter(value, row, index) {
	var tpl = $("#tpl_ismainaccount").html();  
  	//预编译模板  
  	var template = Handlebars.compile(tpl);  
  	return template(row);
}

function web_user_role_isblacklistFormatter(value, row, index) {
	var tpl = $("#tpl_isblacklist").html();  
  	//预编译模板  
  	var template = Handlebars.compile(tpl);  
  	return template(row);
}
//区域
function web_user_role_opFormatter(value, row, index) {
	var tpl = $("#tpl_op").html();  
  	//预编译模板  
  	var template = Handlebars.compile(tpl);  
  	return template(row);
}

//是否选中
function web_user_role_checkedFormatter(value,row,index){
   if (row.checked == 'true')
       return {
           checked : true//设置选中
       };
   return value;
}
function web_user_role_indexFormatter(value, row, index) {
    return index+1;
}

//点击事件
function onClick(event, treeId, treeNode, clickFlag) {
	//机构信息查询
	rc.ajaxQuery("<c:url value='/web/userrole/getgroupdatabyid/'/>"+treeNode.id);
	web_user_role_queryuser(treeNode.id);
}


//通过机构编号查询用户及授权信息
function web_user_role_queryuser(groupid){
	var url="<c:url value='/web/userrole/getUserListDataByid'/>"+'?groupid='+groupid;
	$('#usertable').refreshtable(url);
}

//刷新用户列表
function query_user_list(){
	$('#usertable').refreshtable();
}
//人员选中加载角色
function web_user_role_grant(userid){
	$('#userid').val(userid);
	var url="<c:url value='/web/userrole/getRoleByUserId'/>"+'?userid='+userid;
	$('#roletable').refreshtable(url);
}


//批量增加用户角色
function web_user_role_batchAddUserRole(){
	var userid=$('#userid').val();
	if(userid){
		var selections=$('#roletable').getAllTableSelections();
	    //选中的值
	    var selectnodes='';
	    if(selections.length>0){
			   for(i=0;i<selections.length;i++){
	     	   var item=selections[i];
	     	   selectnodes+=item.roleid+',';
	       }
		   rc.ajax("<c:url value='/web/userrole/saveUserRole'/>", {userid:userid,selectnodes:selectnodes},function (response) {
		    	alert(response.message);
		    	$('#usertable').refreshtable();
		   }); 
	    }else{
	 	   layer.alert("请至少选中一条记录");                
			   return;
	    }
	}else{
		layer.alert('请先选择要增加角色的用户');
	}
}	 
//创建系统用户
function addSysUser(){
	var groupid=$('#groupid').val();
	if(groupid){
		layer.open({
			  type: 2,
			  title: '创建系统用户',
			  shadeClose: false,
			  maxmin:true,
			  shade: 0.8,
			  area: ['45%', '40%'],
			  content:"<c:url value='/web/userrole/addWebUser/'/>"+groupid     //iframe的url
			});
	}else {
		layer.alert("请先选择要新增账户的机构及人员");
	}
}

//密码
function web_user_pass_reset(userid){
	if(userid){
   		var index=layer.confirm('确定重置此用户密码吗？', function(index){
   			var url= "<c:url value='/web/userrole/passreset'/>/"+userid;
   			rc.ajax(url, null,function (response) {
   				if(response.success){
   					layer.alert(response.message);
   				}else{
   					layer.msg(response.message);
   				}
   			});
   			layer.close(index);
   		});
   	  }else{
   		layer.alert('请先选择你要重置的用户');
   	  }
}
</script>
</body>
</html>