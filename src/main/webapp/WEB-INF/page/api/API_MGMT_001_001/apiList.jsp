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
    <title>服务管理</title>
    <!-- css引入 -->
    <rc:csshead/>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
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
			            <rc:textedit property="interfaceName"  label="服务名称" />
			            <rc:select property="interfaceType" label="服务类型"  filter=" aaa105='0' " codetype="INTERFACE_TYPE" multiple="true" />
			            <rc:select property="interfaceNetwork" label="服务网络"  codetype="INTERFACE_NETWORK" multiple="true" />
			            <rc:select property="interfacepRotocol" label="服务协议"  codetype="INTERFACE_POTOCOL" multiple="true" />
			       </div>
			       <div class="hr-line-dashed"></div>
			       <div class="form-group">
			            <rc:select property="interfacepStatus" label="服务状态"  codetype="INTERFACE_STATUS" multiple="true" />
			            <div class="col-sm-9" align="right">
		                  <a class="btn btn-info" onclick="interface_query()"><i class="fa fa-search"></i>&nbsp;查询</a>
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
                <a class="link" onclick="interface_view_by_id('{{interfaceId}}')"><i class="fa fa-file-o"></i>&nbsp;查看</a> 
                <a class="link" onclick="interface_edit_by_id('{{interfaceId}}')"><i class="fa fa-edit"></i>&nbsp;编辑</a> 

                {{#equals interfaceStatus '-1' }}
                   <a class="link" onclick="interfaceStatus_update_by_id('{{interfaceId}}','1')" ><i class="fa fa-remove"></i>&nbsp;审核</a> 
                {{/equals}} 
                
                {{#equals interfaceStatus '0' }}
                   <a class="link" onclick="interfaceStatus_update_by_id('{{interfaceId}}','1')" ><i class="fa fa-check"></i>&nbsp;恢复</a> 
                {{/equals}}  

                {{#equals interfaceStatus '1' }}
                   <a class="link" onclick="interfaceStatus_update_by_id('{{interfaceId}}','0')" ><i class="fa fa-remove"></i>&nbsp;注销</a> 
                {{/equals}}  
            </script>
            
            <!-- 模型 -->
            <script id="tpl_interfaceStatus" type="text/x-handlebars-template" >
                          {{#equals interfaceStatus '-1' }}
                              <div class="progress progress-striped " style="margin-bottom:0px;">			                
                                 <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
                                                                                                   待审核	                             
                              </div>
                              </div>
			              {{/equals}} 
                          {{#equals interfaceStatus '0' }}
                              <div class="progress progress-striped " style="margin-bottom:0px;">			                
                              <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
                                                                                              注销                          
                              </div>
                              </div>
			              {{/equals}} 
			              {{#equals interfaceStatus '1'}}
                           <div class="progress progress-striped " style="margin-bottom:0px;">
                              <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
                                                                                                     正常                          
                              </div>
                           </div>
			              {{/equals}}
            </script>
            
            <!-- toolbar -->
            <div id="toolbar" class="btn-group">
				 <button id="btn_delete" type="button" class="btn btn-info" onclick="interface_add()">
				 <span class="glyphicon glyphicon-plus" aria-hidden="false"></span>新增
				 </button>
				 <a class="btn  btn-success  J_menuItem " href="<c:url value='/sys/sys/codetype/index'/>?code_type=INTERFACE_TYPE" ><i class="fa fa-share"></i>&nbsp;服务类型管理</a>
			</div>
			
            <div class="ibox-content">
			    <table id="interfacetable" data-url="<c:url value='/api/getList'/>" 
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
				        <th data-formatter="interface_indexFormatter">序号</th>
	                    <th data-field="interfaceCode" >服务编码</th>
	                    <th data-field="interfaceUrl" >服务地址</th>
	                    <th data-field="interfaceType" >服务大类类型 </th>
	                    <th data-field="interfaceDetailType" >服务明细类型 </th>
	                    <th data-field="interfaceName" >服务名称</th>
	                    <th data-field="isoffical">是否正式服务</th>
	                    <th data-field="interfaceNetwork">服务支持网络类型</th>
	                    <th data-field="interfacePotocol">服务支持协议格式</th>
	                    <th data-field="interfaceStatus" data-formatter="interfaceStatus_Formatter" align="center">服务状态</th>
	                    <th data-formatter="interface_Formatter">操作</th>
				    </tr>
			    </thead>
			    </table>
            </div>
        </div>
       <!-- 查询结果结束 -->
    </div>
    <!-- javascript引入 -->
    <rc:jsfooter/>
    <script type="text/javascript">
    var $table=$('#interfacetable');
    
    var interface_options={
    	formid:'query_form'
    }
    //初始化
    $(function(){
    	$('#interfacetable').inittable(interface_options);
    });
  
    
    //用户表格监听,双击 
    $('#interfacetable').on('dbl-click-row.bs.table', function (e, row, $element) {
    	interface_view_by_id(row.interfaceId)
    });  
   
    //操作编辑
    function interface_Formatter(value, row, index) {
        var tpl = $("#tpl").html();  
	  	//预编译模板  
	  	var template = Handlebars.compile(tpl);  
	  	return template(row);
    }
    
    //服务状态渲染
    function interfaceStatus_Formatter(value, row, index) {
        var tpl = $("#tpl_interfaceStatus").html();  
	  	//预编译模板  
	  	var template = Handlebars.compile(tpl);  
	  	return template(row);
    }
   
    function interface_indexFormatter(value, row, index) {
        return index+1;
    }
  
    
    //查询
    function interface_query(){
    	$('#interfacetable').refreshtable();
    	//$('.collapse-link').click();
    }
    
    //删除数据
    function interfaceStatus_update_by_id(interfaceId,interfaceStatus){
   	  if(interfaceId){
   		layer.confirm('确定操作？', function(index){
   			var url= "<c:url value='/api/updatestatus'/>";
   			rc.ajax(url, {interfaceId:interfaceId,interfaceStatus:interfaceStatus},function (response) {
   				if(response.success){
   					//layer.msg(response.message);
                    $('#interfacetable').refreshtable();
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
    function interface_add(){
    	 index=layer.open({
	   		  type: 2,
	   		  title: '服务新增',
	   		  shadeClose: false,
	   		  maxmin:true,
	   		  shade: 0.8,
	   		  area: ['50%', '70%'],
	   		  content: "<c:url value='/api/toAdd'/>" //iframe的url
 		});
    	//layer.full(index);
    }
    
    //编辑
    function interface_edit_by_id(interfaceId){
    	layer.open({
	   		  type: 2,
	   		  title: '服务编辑',
	   		  shadeClose: false,
	   		  maxmin:true,
	   		  shade: 0.8,
	   		  area: ['50%', '70%'],
	   		  content: "<c:url value='/api/toEdit'/>/"+interfaceId //iframe的url
 		});
    }
    
    //查看
    function interface_view_by_id(interfaceId){
    	layer.open({
	   		  type: 2,
	   		  title: '服务查看',
	   		  shadeClose: false,
	   		  maxmin:true,
	   		  shade: 0.8,
	   		  area: ['50%', '70%'],
	   		  content: "<c:url value='/api/toView'/>/"+interfaceId //iframe的url
 		});
    }
    
    
    //批量删除
    function interface_bat_delete(idname){
   		var selections=$('#interfacetable').getAllTableSelections();
   	    //选中的值
   	    var selectnodes='';
   	    if(selections.length>0){
   	    	layer.confirm('确定批量删除这些数据吗？', function(index){
   	    	   for(i=0;i<selections.length;i++){
   	   	     	   var item=selections[i];
   	   	     	   selectnodes+=item[idname]+',';
   	   	       }
   	   		   rc.ajax("<c:url value='/demo/batdelete'/>", {selectnodes:selectnodes},function (response) {
   	   		    	layer.alert(response.message);
   	   		    	//$('#interfacetable').refreshtable();
   	   		   }); 
   	    	});
    	  }else{
    		layer.alert('请先选择你要删除的数据');
    	  }
    }
    </script>
</body>
</html>