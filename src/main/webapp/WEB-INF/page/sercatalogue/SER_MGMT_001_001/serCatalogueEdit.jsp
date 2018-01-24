<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>服务目录新增</title>
    <rc:csshead/>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="col-sm-12">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>角色列表区</h5>
					<div class="ibox-tools">
					</div>
				</div>
	            <div class="ibox-content">
	                <form action="${contextpath}/api/savedata" >
			            <div class="form-horizontal"  >
					       <div class="form-group">
					           <rc:hidden property="cataId" />
					           <rc:textedit cols="1,3"  property="cataCode" label="服务事项编码"/>
					           <rc:select   cols="1,3"  codetype="cataConsumer" property="cataConsumer" label="服务对象"/>
					           <div class=" col-xs-4 col-sm-4 ">
					          	   <a class="btn  btn-success  J_menuItem " href="<c:url value='sys/codetype/index'/>?code_type=INTERFACE_TYPE" ><i class="fa fa-share"></i>服务对象管理</a>
			                   </div>
				           </div>
					       <div class="hr-line-dashed"></div>
					       <div class="form-group">
					       </div>
				        </div>
			        </form>
		       </div>
	        </div>
       </div>
    </div>
    <rc:jsfooter/>
    <script type="text/javascript">
    $(function() {
    	//验证 ajax
    	rc.validAndAjaxSubmit($("form"),api_callback);
    })
    
    //关闭
    function select_closeframe(){
    	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
    	parent.layer.close(index); //再执行关闭   
    }
  
    function api_callback(response){
    	if(response.success){
           	alert(response.message);
           	parent.interface_query();
           	select_closeframe();
    	}
    	else{
    		alert(response.message);
    	}
    }
    
    //保存页面配置信息
	function api_save_data(){
	    $('form').submit();
	}
    </script>
</body>
</html>