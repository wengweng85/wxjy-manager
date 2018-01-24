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
    <title>公共服务网之应用管理</title>
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
			           <div class="col-sm-3" align="right">
		                  <a class="btn btn-info" onclick="param_query()"><i class="fa fa-search"></i>&nbsp;查询</a>
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
            <!-- toolbar -->
            <div id="toolbar" class="btn-group">
				 <button id="btn_add_row" type="button" class="btn btn-info" onclick="addFirstRow()" >
				 <span class="glyphicon glyphicon-plus" aria-hidden="false"></span>新增一行
				 </button>
			</div>
            <div class="ibox-content">
			    <table id="systypetable" data-url="<c:url value='/web/systype/getList'/>" 
			          data-click-to-select="false"
                      data-toolbar="#toolbar"
                      data-show-export="true"
                      data-pagination="true"
                      data-uniqueId="1"
                      data-page-size="10" >
			    <thead>
				    <tr>
				        <th data-checkbox="true" ></th>
				        <th data-formatter="_indexFormatter">序号</th>
				        <th data-formatter="_rowFormatter" data-field="systypeid">行操作</th>
	                    <th data-field="systypecode" data-editable="true" data-editable-type="text">应用编码</th>
	                    <th data-field="sysname" data-editable="true" data-editable-type="text">应用名称</th>
	                    <th data-field="sysdesc" data-editable="true" data-editable-type="text">应用描述</th>
	                    <th data-field="sysurl" data-editable="true" data-editable-type="text">应用地址</th>
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
    var $table=$('#systypetable');
    
    var demo_options={
    	formid:'query_form',
    	editable_url:contextPath+'/web/systype/updatesystype'
    }
    //初始化
    $(function(){
    	$('.collapse-link').click();
    	$('#systypetable').inittable(demo_options);
    });
   
    
    function _indexFormatter(value, row, index) {
        return index+1;
    }
   
    //行操作 
    function _rowFormatter(value, row, index){
       if(!row.systypeid){
    	   row.systypeid=rc.guid();
       }
       return [
           "<a class=\"like\" href='javascript:addRow(" + index + ", " + JSON.stringify(row) + ")' title=\"新增行\">",
           '<i class="glyphicon glyphicon-plus"></i>',
           '</a>  ',
           '<a class="remove" href="javascript:removeRow(\''+row.systypeid+'\')" title="删除行">',
           '<i class="glyphicon glyphicon-remove"></i>',
           '</a>'
       ].join('');
    }
    
    //在表格第一行增加
    function addFirstRow(){
    	var rowObj={
    			systypeid:'',
    			systypecode:'',
    			sysname:'',
    			sysdesc:'',
    			sysurl:''
    	}
    	addRow(-1,rowObj);
    }
    
    //增加一行
    function addRow(insertIndex, rowObj){
        var insertRow = rowObj;
        $.each(insertRow, function(name, value){
            insertRow[name] = '';
        });

        var params = {index:insertIndex + 1, row:insertRow};
        $('#systypetable').bootstrapTable('insertRow', params);
    }
    
    
    //删除一行
    function removeRow(value){
    	layer.confirm('确定要删除此参数吗？', function(index){
   			var url= "<c:url value='/web/systype/deletesystypebyid/'/>"+value;
   			rc.ajax(url, null,function (response) {
   				if(response.success){
   					layer.msg(response.message);
                    //$('#systypetable').refreshtable();
                    var a=[];
                	a.push(value);
                    $table.bootstrapTable('remove', {
                        field: 'systypeid',
                        values: a
                    }); 
   				}else{
   					layer.msg(response.message);
   				}
   			});
   			layer.close(index);
   		});
    }
    
    //查询
    function param_query(){
    	$('#systypetable').refreshtable();
    	$('.collapse-link').click();
    }
    </script>
</body>
</html>