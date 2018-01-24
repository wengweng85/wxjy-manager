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
                 <td><strong>服务编码</strong></td><td>${sApiInterface.interfaceCode}</a>  </td>
                 <td><strong>服务名称</strong></td><td>${sApiInterface.interfaceName}</a></td>
            </tr>
            <tr>
                 <td><strong>服务地址</strong></td><td colspan="3">${sApiInterface.interfaceUrl}</a></td>
            </tr>
            <tr>
                 <td><strong>服务大类</strong></td><td>${sApiInterface.interfaceType}</td>
                 <td><strong>服务小类</strong></td><td>${sApiInterface.interfaceDetailType}</td>
            </tr>
               <tr>
                 <td><strong>是否正式服务</strong></td><td>${sApiInterface.isoffical}</td>
            </tr>
            <tr>
                 <td><strong>网络类型</strong></td><td>${sApiInterface.interfaceNetwork}</a> </td>
                 <td><strong>协议类型</strong></td><td>${sApiInterface.interfacePotocol}</a> </td>
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