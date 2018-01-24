<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户新增</title>
    <rc:csshead/>
</head>
<body class="gray-bg"  style="margin-top:40px" >
     <!-- 固定浮动框  navbar-fixed-top 顶部、navbar-fixed-bottom 底部-->
     <div class="navbar navbar-inverse navbar-fixed-top">
          <div class="navbar-inner">
              <!--fluid 是偏移一部分-->
                  <div class="container-fluid " style="padding: 0px 20px;">
                   <div class="form-group" style="text-align: right;">
		              <a class="btn btn-default " onclick="select_closeframe()"><i class="fa fa-close"></i>&nbsp;取消</a>
		              <a class="btn btn-primary " onclick="api_save_data()"><i class="fa fa-save"></i>&nbsp;保存</a>
		        </div>
              </div>
          </div>
     </div>
     <!-- 浮动框结束 -->
     <div class="wrapper wrapper-content ">
        <form action="${contextpath}/web/userrole/saveWebUser" >
        <div >
	        <!-- 人员选择基本信息开始 -->
	        <div class="ibox ">
	            <div class="ibox-title">
	                <h5>账户信息</h5>
	            </div>
	            <div class="ibox-content">
		            <div class="form-horizontal"  >
				       <div class="form-group">
				           <rc:hidden property="groupid" value="${groupid}"/>
			               <rc:textedit property="username" cols="2,4" required="true" label="用户名"  validate="{required:true,messages:{required:'用户名不能为空'}}" />
			               <rc:textedit property="password" cols="2,4" required="true"  label="密码"  validate="{required:true,messages:{required:'密码不能为空'}}" />
					    </div>
			       </div>
		       </div>
	        </div>
	        <!-- 人员基本信息结束 -->
        </form>
    </div>
    <rc:jsfooter/>
    <script type="text/javascript">
    $(function() {
    	//验证 ajax
    	rc.validAndAjaxSubmit($("form"),_callback);
    })
    
    //关闭
    function select_closeframe(){
    	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
    	parent.layer.close(index); //再执行关闭   
    }
  
    function _callback(response){
    	if(response.success){
           	alert(response.message);
           	var groupid=$('#groupid').val();
           	parent.web_user_role_queryuser(groupid);
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