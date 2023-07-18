<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/html/layout/header/common_head.jsp"%>
</head>
<body>
	<div id="systemModal" data-ready>
		<%@ include file="/WEB-INF/html/layout/component/component_search.jsp"%>
		
		<%@ include file="/WEB-INF/html/layout/component/component_list.jsp"%>		
	</div>
	<script>
	$(document).ready(function() {
		var popupId = '<c:out value="${popupId}" />';
	
		var modalParam = $("#" + popupId).data('modalParam');
		
		<%-- search init --%>
		var createPageObj = getCreatePageObj();
		
		createPageObj.setViewName('userModal');
		createPageObj.setIsModal(true);
		
		createPageObj.setSearchList([
			{ type: 'text', mappingDataInfo: 'object.userId', name: '<fmt:message>label.id</fmt:message>', placeholder: '<fmt:message>msg.enterId</fmt:message>', regExpType: 'searchId' },
			{ type: 'text', mappingDataInfo: 'object.userName', name: '<fmt:message>label.name</fmt:message>', placeholder: '<fmt:message>msg.enterName</fmt:message>', regExpType: 'name' },
		]);
		
		createPageObj.searchConstructor();	
		
		createPageObj.setMainButtonList({
			searchInitBtn: true,
			totalCnt: true,
		    currentCnt: true,
		});
		
		createPageObj.mainConstructor();
		
		var vmSearch = new Vue({
			el : '#' + createPageObj.getElementId('ImngSearchObject'),
			data : {				
				object : {
					userId: null,
					userName: null,
					pageSize : '10'
				},
				letter : {
					userId: null,
					userName: null
				}
			},
			methods: $.extend(true, {}, searchMethodOption, {
				search : function() {
					vmList.makeGridObj.noDataHidePage(createPageObj.getElementId('ImngListObject'));
					
					vmList.makeGridObj.search(this.object, function(info) {
		            	vmList.currentCnt = info.currentCnt;
		            	vmList.totalCnt = info.totalCnt;
		            });
	            },
				initSearchArea: function() {
					this.object.pageSize = '10';
					this.object.userId = null;
					this.object.userName = null;
					this.letter.userId = 0;
					this.letter.userName = 0;
				},
				inputEvt: function(info) {
	    			setLengthCnt.call(this, info);
	    		},
			 }),
			 mounted: function() {
				 this.initSearchArea();
			 },
		});	
		
		var vmList = new Vue({
			el: '#' + createPageObj.getElementId('ImngListObject'),
	        data: {
	        	makeGridObj: null,
	        	totalCnt: null,
		        currentCnt: null
	        },			
			methods: {
				initSearchArea: function() {
					vmSearch.initSearchArea();
				},
			},
	        mounted: function() {
	        	
	        	this.makeGridObj = getMakeGridObj();
	        	
	        	this.makeGridObj.setConfig({
	        		el: document.querySelector('#' + createPageObj.getElementId('ImngSearchGrid')),
		            searchUrl: '/api/entity/user/search',
		            totalCntUrl: '/api/entity/user/count',
		    		paging: {
		    			isUse: true,
		    			side: "server"
		    		},
	        		columns : [
	        			{
	        				name : "userId",
	        				header : "<fmt:message>label.id</fmt:message>",
	        				align : "left"
	        			}, 
	        			{
	        				name : "userName",
	        				header : "<fmt:message>label.name</fmt:message>",
	        				align : "left"
	        			}, 
	        			{
	        				name : "department",
	        				header : "<fmt:message>label.user.department</fmt:message>",
	        				align : "left"
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