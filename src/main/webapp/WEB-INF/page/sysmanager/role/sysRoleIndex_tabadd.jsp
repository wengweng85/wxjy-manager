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
					</div>
				</div>
				<!-- 模型 tpl  -->
	            <script id="tpl" type="text/x-handlebars-template" >
	                <a class="link" onclick="sys_role_deleterole('{{roleid}}')" ><i class="fa fa-remove"></i>&nbsp;删除</a>
                    <a class="link" onclick="sys_role_edit('{{roleid}}','{{name}}')" ><i class="fa fa-edit"></i>&nbsp;编辑</a>  
                </script>
				<div class="ibox-content">
					<table id="roletable" 
					data-pagination="true" 
					data-url="<c:url value='/sys/role/querylist'/>">
						<thead>
						    <tr>
						        <th data-formatter="sys_role_indexFormatter">序号</th>
			                    <th data-field="name" >角色名称</th>
			                    <th data-field="code" >角色编码</th>
			                    <th data-formatter="sys_role_opFormatter">操作</th>
						    </tr>
				        </thead>
					</table>
				</div>
			</div>
		</div>

		<div class="col-sm-8" >
			<!-- 此处是相关代码 -->
		    <ul class="nav nav-tabs" role="tablist">
		    </ul>
		    <div class="tab-content" style="width:100%;height: 800px;">
		    </div>
		    <!-- 相关代码结束 -->
		</div>
		</div>
	</div>
<rc:jsfooter />
<script type="text/javascript">
   //初始化
   $(function(){
	    $('#roletable').inittable();
   		var item = {
 			'id':"0",
 			'name':"新增角色",
 			'url':"<c:url value='/sys/role/toRoleEdit'/>/0",
 			'closable':false
   		};
		closableTab.addTab(item);
   });
   //新增角
   function sys_role_edit(roleid,name){
		var item = {
			'id':roleid,
			'name':name+"角色编辑",
			'url':"<c:url value='/sys/role/toRoleEdit'/>/"+roleid,
			'closable':true
		};
		closableTab.addTab(item);
   }
   
   //回调函数
   function sys_role_callback(response){
	  if(response.success){
       	  alert(response.message);
       	  $('#roletable').refreshtable();
	  }
	  else{
		  alert(response.message);
	  }
   }
   
   //format区域
   function sys_role_opFormatter(value, row, index) {
        var tpl = $("#tpl").html();  
	  	//预编译模板  
	  	var template = Handlebars.compile(tpl);  
	  	return template(row);
   }
 
   function sys_role_indexFormatter(value, row, index) {
       return index+1;
   }
  
   //删除角色
   function sys_role_deleterole(roleid){
   	  if(roleid){
   		layer.confirm('确定删除要此角色吗？', function(index){
   			var url= "<c:url value='/sys/role/deleteRoleDataById/'/>"+roleid;
   			rc.ajax(url, null,function (response) {
   				if(response.success){
   					$('#roletable').refreshtable();
   					sys_role_edit_div_clean();
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
</script>
</body>
</html>