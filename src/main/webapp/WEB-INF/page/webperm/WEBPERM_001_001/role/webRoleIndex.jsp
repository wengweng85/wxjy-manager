<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>角色管理</title>
<!-- css头文件  -->
<rc:csshead />
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="col-sm-4">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>角色列表区</h5>
					<div class="ibox-tools">
						<a onclick="web_role_addnewrole()" class="btn btn-primary btn-xs"><i class="fa fa-plus"></i>&nbsp;新增角色</a>
					</div>
				</div>
				<!-- 模型 tpl  -->
	            <script id="tpl" type="text/x-handlebars-template" >
	                <a class="link" onclick="web_role_deleterole('{{roleid}}')" ><i class="fa fa-remove"></i>&nbsp;删除</a> 
                </script>
				<div class="ibox-content">
					<table id="roletable" 
					data-pagination="true" 
					data-url="<c:url value='/web/role/querylist'/>">
						<thead>
						    <tr>
						        <th data-formatter="web_role_indexFormatter">序号</th>
						        <th data-field="systypecode_name" >所属应用类型</th>
			                    <th data-field="name" >角色名称</th>
			                    <th data-field="code" >角色编码</th>
			                    <th data-formatter="web_role_opFormatter">操作</th>
						    </tr>
				        </thead>
					</table>
				</div>
			</div>
		</div>

		<div class="col-sm-4">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>角色编辑区</h5>
					<div class="ibox-tools">
						<a class="btn btn-primary btn-xs " onclick="web_role_saveRoleData()"><i class="fa fa-save"></i>&nbsp;保存</a>
					</div>
				</div>
				<div class="ibox-content" id="role_edit_div">
					<form action="<c:url value='/web/role/saveorupdate'/>" class="form-horizontal" method="post" id="myform">
						<rc:hidden property="roleid"/>
						<div class="form-group">
							 <rc:textedit property="code" label="角色编码 " required="true"  cols="3,9" validate="{required:true,messages:{required:'请输入角色编码'}}" />
						</div>
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<rc:textedit property="name" label="角色名称" required="true"  cols="3,9"   validate="{required:true,messages:{required:'请输入角色名称'}}" />
						</div>
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<rc:select  property="systypecode" label="所属应用类型" required="true"  cols="3,9"  codetype="SYSTYPECODE"  validate="{required:true,messages:{required:'请输入所属应用类型'}}" />
						</div>
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<rc:textedit property="describe" label="角色描述" required="true"  cols="3,9"  validate="{required:true,messages:{required:'请输入角色描述'}}" />
						</div>
					</form>
		       </div>
          </div>
		</div>
		<div class="col-sm-4">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>角色授权</h5>
					<div class="ibox-tools">
					    <a  class="btn btn-success btn-xs J_menuItem " href="<c:url value='sys/perm/index'/>" ><i class="fa fa-share"></i>&nbsp;权限管理</a>
						<a id="btn_role_perm" class="btn btn-primary btn-xs " onclick="web_role_saveRolePermData()"><i class="fa fa-save"></i>&nbsp;保存</a>
					</div>
				</div>
				<div class="ibox-content">
					<div id="tree-div" class="ztree" style="overflow: auto; height: 650px; width: 450px;"></div>
				</div>
			</div>
		</div>
		</div>
	</div>
<rc:jsfooter />
<script type="text/javascript">
   //初始化
   $(function(){
	    $('#roletable').inittable();
   	    //角色编辑
   		rc.validAndAjaxSubmit($("#myform"),web_role_callback);
   	    //权限树加载
    	web_role_treeinit();
   });
   //用户表格监听 
   $('#roletable').on('click-row.bs.table', function (e, row, $element) {
      	rc.evaluation(row);
      	web_role_editrole(row.roleid);
   }); 
   
   //角色-权限树配置
   var web_role_setting = {
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
   		 url: "<c:url value='/web/role/treedata'/>",
   		 autoParam:["id"],
   		 otherParam: {"id":"0"}
   	  }
   };
   
   //回调函数
   function web_role_callback(response){
	  if(response.success){
       	  alert(response.message);
       	  $('#roletable').refreshtable();
	  }
	  else{
		  alert(response.message);
	  }
   }
   
   //format区域
   function web_role_opFormatter(value, row, index) {
        var tpl = $("#tpl").html();  
	  	//预编译模板  
	  	var template = Handlebars.compile(tpl);  
	  	return template(row);
   }
 
   function web_role_indexFormatter(value, row, index) {
       return index+1;
   }
   
    //保存页面配置信息
   function web_role_saveRoleData(){
      $('#myform').submit();
   }

   
   //角色编辑
   function web_role_editrole(roleid){
	   //rc.ajaxQuery("<c:url value='/web/role/getRoleData/'/>"+roleid);
	   var otherParam= { 'id':roleid }
	   web_role_setting.async.otherParam=otherParam;
	   web_role_treeinit();
   }
   
   //新增权限
   function web_role_addnewrole(){
   	   //右边编辑区域清空
	   web_role_edit_div_clean();
   }
   
   function web_role_edit_div_clean(){
	   rc.clean($('#role_edit_div'),$('#role_edit_div'));
   }
   
   //删除角色
   function web_role_deleterole(roleid){
   	  if(roleid){
   		layer.confirm('确定删除要此角色吗？', function(index){
   			var url= "<c:url value='/web/role/deleteRoleDataById/'/>"+roleid;
   			rc.ajax(url, null,function (response) {
   				if(response.success){
   					$('#roletable').refreshtable();
   					web_role_edit_div_clean();
   				}else{
   					alert(response.message);
   				}
   			});
   			layer.close(index);
   		});
   	  }else{
   		layer.alert('请先选择一个你要删除的权限节点');
   	  }
   }
   
   //树初绍化
   function web_role_treeinit(){
	  $.fn.zTree.init($("#tree-div"), web_role_setting);
	  var zTree = $.fn.zTree.getZTreeObj("tree-div");
	  zTree.expandAll(true)
   }
   
   //保存角色-权限数据
   function web_role_saveRolePermData() {
	   var roleid=$('#roleid').val();
	   if(roleid){
		    var zTree = $.fn.zTree.getZTreeObj("tree-div");
		    var nodes = zTree.getCheckedNodes(true);
		    var selectnodes=",";
		    for(i=0;i<nodes.length;i++){
		       selectnodes+= nodes[i].id+",";
		    }
		    rc.ajax("<c:url value='/web/role/saveroleperm'/>", {roleid:roleid,selectnodes:selectnodes},function (response) {
		    	alert(response.message);
		    	if(response.success){
		    		$('#roletable').refreshtable();
		    		web_role_treeinit();
				}
			});  
	   }else{
		   layer.alert('请先选择一个角色');
	   }
	}
</script>
</body>
</html>