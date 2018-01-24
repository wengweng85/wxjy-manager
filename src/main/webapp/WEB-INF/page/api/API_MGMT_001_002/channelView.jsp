<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>服务查看</title>
    <rc:csshead/>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content ">
          <table class="table table-bordered table-striped xedittable ">
            <tr>
                 <td><strong>渠道编码</strong></td><td>${sapichannel.channelCode}</a>  </td>
                 <td><strong>渠道名称</strong></td><td>${sapichannel.channelName}</a></td>
            </tr>
            <tr>
                 <td><strong>渠道appkey</strong></td><td>${sapichannel.channelAppkey}</td>
                 <td><strong>渠道类型</strong></td><td>${sapichannel.channelType}</td>
            </tr>
            <tr>
                 <td><strong>渠道图标</strong></td><td><span style="text-align:center;font-size:16px;"><i class="fa ${sapichannel.channelIcon}"></i></span></td>
                 <td><strong>渠道描述</strong></td><td>${sapichannel.channelDescribe}</a> </td>
            </tr>
          </table>
       <!-- 人员附加信息结束-->
       <div class="form-group" style="text-align: right;">
           <a class="btn btn-danger " onclick="closeframe()"><i class="fa fa-remove"></i>&nbsp;关闭</a>
       </div>
    </div>
    <rc:jsfooter/>
    <script type="text/javascript">
    //关闭
    function closeframe(){
    	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
    	parent.layer.close(index); //再执行关闭   
    }
    </script>
</body>
</html>