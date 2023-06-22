<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<div id="noticeModal" data-ready>
		<%@ include file="/WEB-INF/html/layout/component/component_search.jsp"%>
		
		<%@ include file="/WEB-INF/html/layout/component/component_list.jsp"%>
		
		<%@ include file="/WEB-INF/html/layout/component/component_detail.jsp"%>	
	</div>
	<script>
		document.querySelector('#noticeModal').addEventListener('ready', function(evt) {
			var popupId = '<c:out value="${popupId}" />';
			
			var createPageObj = getCreatePageObj();
			
			createPageObj.setViewName('noticeModal');
			createPageObj.setIsModal(true);
			
			createPageObj.setSearchList([
				{'type': "text", 'mappingDataInfo': "object.noticeTitle", 'name': "<fmt:message>label.title</fmt:message>", 'placeholder': "<fmt:message>msg.enterTitle</fmt:message>"},
			]);
			
			createPageObj.searchConstructor();
			
			createPageObj.setMainButtonList({
				searchInitBtn: true,
				totalCnt: true,
			    currentCnt: true,
			    importDataBtn: true
			});
			
			createPageObj.mainConstructor();
			
		    var vmSearch = new Vue({
		    	el : '#' + createPageObj.getElementId('ImngSearchObject'),
		    	data : {		    		
		    		object : {
		       			noticeTitle: null,
		       			noticeContent: null,
		       			pageSize : '10'
		    		},
		    	},
		    	methods : {
					search : function() {
						vmList.makeGridObj.noDataHidePage(createPageObj.getElementId('ImngListObject'));
						
						vmList.makeGridObj.search(this.object, function(info) {
			            	vmList.currentCnt = info.currentCnt;
			            	vmList.totalCnt = info.totalCnt;
			            });
		            },
		            importData: function() {
			        	vmList.makeGridObj.importData(this.object, function(info) {
			        		vmList.currentCnt = info.currentCnt;
			        	});			        	
			        },
		            initSearchArea: function() {
	                	this.object.pageSize = '10';
	            		this.object.noticeTitle = null;		
	            		this.object.noticeContent = null;
		            },
		    	},
		    	mounted: function() {
		    		this.initSearchArea();
		    	}
		    });

		    var vmList = new Vue({
		        el: '#' + createPageObj.getElementId('ImngListObject'),
		        data: {
		        	makeGridObj: null,
		        	totalCnt: null,
			        currentCnt: null
		        },        
		        methods : $.extend(true, {}, listMethodOption, {
		        	initSearchArea: function() {
		        		vmSearch.initSearchArea();
		        	}
		        }),
		        mounted: function() {
		        	this.makeGridObj = getMakeGridObj();
		        	
		        	this.makeGridObj.setConfig({
		        		el: document.querySelector('#' + createPageObj.getElementId('ImngSearchGrid')),
			            searchUrl: '/api/entity/notice/search',
			            totalCntUrl: '/api/entity/notice/count',
			    		paging: {
			    			isUse: true,
			    			side: "server"
			    		},
		              	columns : [
		              		{
		              			name : "noticeTitle",
		              			header : "<fmt:message>label.title</fmt:message>",
		              			align : "left",
		                        width: "40%",
		              		},
		              		{
		              			name : "userId",
		              			header : "<fmt:message>label.writer</fmt:message>",
		              			align : "left",
		                        width: "30%",
		              		},
		              		{
		              			name : "pk.createTimestamp",
		              			header : "<fmt:message>label.created.date</fmt:message>",
		              			align : "center",
		                        width: "30%",
		              		},              		
		              	],
		                onGridMounted: function(evt) {
			            	evt.instance.on('click', function(evt) {
			            		if ('undefined' === typeof evt.rowKey) return;
			            		
				                $('#' + popupId).data('callBackFunc')(evt.instance.getRow(evt.rowKey));
				                
				                $('#' + popupId).find('#modalClose').trigger('click');		            		
			            	})
			            }        	    
		        	}, true);
		        }
		    });	
		});
	</script>
</body>
</html>