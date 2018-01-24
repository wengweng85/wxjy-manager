<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>渠道新增</title>
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
        <form action="${contextpath}/api/channel/savedata" >
        <div >
	        <!-- 人员选择基本信息开始 -->
	        <div class="ibox ">
	            <div class="ibox-title">
	                <h5>渠道信息</h5>
	            </div>
	            <div class="ibox-content">
		            <div class="form-horizontal"  >
				       <div class="form-group">
			               <rc:textedit  property="channelCode" cols="2,4" required="true" label="渠道编码" validate="{required:true,maxlength:10,messages:{required:'渠道编码不能为空'}}"  />
			               <rc:textedit  property="channelName" cols="2,4" required="true"  label="渠道名称"  validate="{required:true,messages:{required:'渠道名称不能为空'}}"/>
			           </div>
			           <div class="hr-line-dashed"></div>
				       <div class="form-group">
				           <rc:textedit property="channelAppkey" cols="2,4"  label="渠道appkey" value="自动生成" readonly="true"/>
				       </div>
				       <div class="hr-line-dashed"></div>
				       <div class="form-group">
				           <rc:select property="channelType" dynamic="true" cols="2,3" required="true"  label="渠道类型"   codetype="CHANNEL_TYPE" validate="{required:true,messages:{required:'渠道类型不能为空'}}"/>
				           <div class=" col-xs-1  col-sm-1 ">
				              <a class="btn btn-success  J_menuItem " href="<c:url value='sys/codetype/index'/>?code_type=CHANNEL_TYPE" ><i class="fa fa-share"></i>类型管理</a>
				           </div>
				           <rc:textedit property="channelIcon" cols="2,4" required="true"  label="渠道图标"  validate="{required:true,messages:{required:'渠道图标不能为空'}}" onclick="open_font_css_iframe()" />
				       </div>
				       <div class="hr-line-dashed"></div>
				       <div class="form-group">
				           <rc:textedit property="channelDescribe" cols="2,10"  label="渠道描述"  />
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
           	parent.channel_query();
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
    
	//查看
	function open_font_css_iframe(){
		layer.open({
	   		  type: 2,
	   		  title: '图标选择页面',
	   		  shadeClose: false,
	   		  maxmin:true,
	   		  shade: 0.8,
	   		  area: ['60%', '90%'],
	   		  content: "<c:url value='/resource/hplus/fontawesome.html'/>" //iframe的url
			});
	}
	function font_css_choose(font_css_class_name){
		$('#channelIcon').val(font_css_class_name);
		layer.close(layer.index);
	}
    </script>
</body>
</html>