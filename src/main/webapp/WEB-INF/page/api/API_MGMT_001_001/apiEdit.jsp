<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>服务新增</title>
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
        <form action="${contextpath}/api/savedata" >
        <div >
	        <!-- 人员选择基本信息开始 -->
	        <div class="ibox ">
	            <div class="ibox-title">
	                <h5>服务信息</h5>
	            </div>
	            <div class="ibox-content">
		            <div class="form-horizontal"  >
				       <div class="form-group">
				           <rc:hidden property="interfaceId" value="${sApiInterface.interfaceId }"/>
			               <rc:textedit  property="interfaceCode" cols="2,4" readonly="true"  value="${sApiInterface.interfaceCode }" label="服务编码" validate="{required:true,maxlength:10,messages:{required:'服务编码不能为空'}}"  />
			               <rc:textedit  property="interfaceName" cols="2,4" required="true"  value="${sApiInterface.interfaceName }" label="服务名称"  validate="{required:true,messages:{required:'服务名称不能为空'}}"/>
			           </div>
				       <div class="hr-line-dashed"></div>
				       <div class="form-group">
				           <rc:textedit property="interfaceUrl" cols="2,10" required="true"  value="${sApiInterface.interfaceUrl }" label="服务地址"    validate="{required:true,messages:{required:'服务地址不能为空'}}"/>
				       </div>
				       <div class="hr-line-dashed"></div>
				       <div class="form-group">
				           <rc:select property="interfaceType" filter=" aaa105='0' " cols="2,3" required="true"  label="服务大类类型"  value="${sApiInterface.interfaceType }"  onchange="rc.code_value_select_data_change(this.value,'INTERFACE_TYPE',['#interfaceDetailType'])"  codetype="INTERFACE_TYPE" validate="{required:true,messages:{required:'服务大类型不能为空'}}"/>
				           <rc:select property="interfaceDetailType" cols="2,3" filter="aaa102='${sApiInterface.interfaceDetailType }'" required="true"  label="服务明细类型" value="${sApiInterface.interfaceDetailType }"  codetype="INTERFACE_TYPE" validate="{required:true,messages:{required:'服务明细类型不能为空'}}"/>
				           <div class=" col-xs-2 col-sm-2 ">
				          	   <a class="btn  btn-success  J_menuItem " href="<c:url value='sys/codetype/index'/>?code_type=INTERFACE_TYPE" ><i class="fa fa-share"></i>类型管理</a>
		                   </div>
				       </div>
				       <div class="form-group">
				           <rc:checkboxswitch label="是否正式服务" property="isoffical"  cols="2,4" value="${sApiInterface.isoffical }"/> 
				       </div>
				       <div class="hr-line-dashed"></div>
				       <div class="form-group">
				           <rc:select property="interfaceNetwork" cols="2,4" required="true"  value="${sApiInterface.interfaceNetwork }" label="网络类型"   codetype="INTERFACE_NETWORK" validate="{required:true,messages:{required:'网络类型不能为空'}}"/>
				           <rc:select property="interfacePotocol" cols="2,4" required="true" value="${sApiInterface.interfacePotocol }" label="协议类型"  codetype="INTERFACE_POTOCOL"  validate="{required:true,messages:{required:'协议类型不能为空'}}"/>
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