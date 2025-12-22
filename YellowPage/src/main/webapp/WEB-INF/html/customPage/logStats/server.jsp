<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/html/layout/header/common_head.jsp"%>
</head>
<body>
	<div id="server" data-ready>
		<sec:authorize var="hasStatisticsViewer" access="hasRole('StatisticsViewer')"></sec:authorize>
			
		<%@ include file="/WEB-INF/html/layout/component/component_search.jsp"%>
		
		<%@ include file="/WEB-INF/html/layout/component/component_list.jsp"%>
		
		<%@ include file="/WEB-INF/html/layout/component/component_detail.jsp"%>

		<ul id="summaryTemplate" class="row media-dl" style="display: none;">
			<li class="col-4">
				<div class="media align-items-center">
					<img src="${prefixFileUrl}/img/call.svg" class="media-icon" />
					<dl class="media-body">
						<dt><fmt:message>label.editCount</fmt:message></dt>
						<dd class="h1">{{ editCount }}</dd>
					</dl>
				</div>
			</li>
			<li class="col-4">
				<div class="media align-items-center">
					<img src="${prefixFileUrl}/img/complete.svg" class="media-icon" />
					<dl class="media-body">
						<dt><fmt:message>label.publishDoneCount</fmt:message></dt>
						<dd class="h1">{{ publishDoneCount }}</dd>
					</dl>
				</div>
			</li>
			<li class="col-4">
				<div class="media align-items-center">
					<img src="${prefixFileUrl}/img/danger.svg" class="media-icon" />
					<dl class="media-body">
						<dt><fmt:message>label.publishErrorCount</fmt:message></dt>
						<dd class="h1">{{ publishErrorCount }}</dd>
					</dl>
				</div>
			</li>
		</ul>
	</div>
	<script>
		document.querySelector('#server').addEventListener('ready', function(evt) {
			var viewer = 'true' == '${hasStatisticsViewer}';
			
			var createPageObj = getCreatePageObj();
			
			createPageObj.setViewName('server');
			createPageObj.setIsModal(false);
			
			createPageObj.setSearchList(
				[
					{
						type: 'modal',
						mappingDataInfo: {
							url: '/modal/serverModal',
					        modalTitle: '<fmt:message>label.server</fmt:message>',
					        vModel: "object.pk.serverId",
					        callBackFuncName: "setSearchServerId"
						},
						regExpType: 'searchId',
						name: "<fmt:message>label.server</fmt:message> <fmt:message>label.id</fmt:message>",
						placeholder: '<fmt:message>msg.enterId</fmt:message>'
					},
					{
						type: 'select', 
						name: 'Source <fmt:message>label.interface.type</fmt:message>', 
						placeholder:  '<fmt:message>label.all</fmt:message>',
						mappingDataInfo: {
							id: 'sourceInterfaceType',
							selectModel: 'object.pk.sourceType',
							optionFor: 'option in sourceInterfaceTypeList',
							optionValue: 'option.pk.propertyKey',
							optionText: 'option.propertyValue',
						},
					},
					{
						type: 'select', 
						name: 'Target <fmt:message>label.interface.type</fmt:message>', 
						placeholder:  '<fmt:message>label.all</fmt:message>',
						mappingDataInfo: {
							id: 'targetInterfaceType',
							selectModel: 'object.pk.targetType',
							optionFor: 'option in targetInterfaceTypeList',
							optionValue: 'option.pk.propertyKey',
							optionText: 'option.propertyValue',
						},
					},
					{
						type: "modal",
						mappingDataInfo: {
							url: '/modal/systemModal',
					        modalTitle: '<fmt:message>label.system</fmt:message>',
					        vModel: "object.pk.sourceSystemId",
					        callBackFuncName: "setSearchSourceSystemId"
						},
						regExpType: 'searchId',
						name: "Source <fmt:message>label.system</fmt:message> <fmt:message>label.id</fmt:message>",
						placeholder: "<fmt:message>msg.enterId</fmt:message>"
					},
					{
						type: "modal",
						mappingDataInfo: {
							url: '/modal/systemModal',
					        modalTitle: '<fmt:message>label.system</fmt:message>',
					        vModel: "object.pk.targetSystemId",
					        callBackFuncName: "setSearchTargetSystemId"
						},
						regExpType: 'searchId',
						name: "Target <fmt:message>label.system</fmt:message> <fmt:message>label.id</fmt:message>",
						placeholder: "<fmt:message>msg.enterId</fmt:message>"
					},					
				]
			);
			
			createPageObj.searchConstructor();
			
			createPageObj.setMainButtonList({
				newTabBtn: viewer,
				searchInitBtn: viewer,
				totalCnt: viewer,
				downloadBtn: viewer,
			});
			
			createPageObj.mainConstructor();
			
			$('.empty').after($('#summaryTemplate'));			
			
			new HttpReq('/api/page/properties').read({ pk: { propertyId: 'Interface.Type' }, orderByKey: true }, function(interfaceTypeResult) {
			
				window.vmSearch = new Vue({
					el: '#' + createPageObj.getElementId('ImngSearchObject'),
			    	data: {
		    			sourceInterfaceTypeList: [],
		    			targetInterfaceTypeList: [],			    		
			    		object : {
			    			pk: {		    				
			    				serverId: null,
			    				sourceType: ' ',
			    				targetType: ' ',
			    				sourceSystemId: null,
			    				targetSystemId: null,
			    			},
			    			pageSize : '10'
			    		},
			    		letter: {
			    			pk: {
			    				serverId: null,
			    				sourceSystemId: null,
			    				targetSystemId: null,
			    			}
			    		}
			    	},
			    	methods: $.extend(true, {}, searchMethodOption, {
			    		inputEvt: function(info) {
			    			setLengthCnt.call(this, info);
			    		},				    		
						search: function() {
							$('#summaryTemplate').removeAttr('id').show();
							
							vmList.makeGridObj.noDataHidePage(createPageObj.getElementId('ImngListObject'));
							
							vmList.makeGridObj.getSearchGrid().setPerPage(Number(this.object.pageSize));
							
							vmList.makeGridObj.search(this.object, function(result) {
								vmList.totalCnt = result.object.length;
	
					        	vmList.editCount = 0;
					        	vmList.publishDoneCount = 0;
					        	vmList.publishErrorCount = 0;
					        	
								result.object.forEach(function(info) {
						        	vmList.editCount += Number(info.editCount);
						        	vmList.publishDoneCount += Number(info.publishDoneCount);
						        	vmList.publishErrorCount += Number(info.publishErrorCount);	
								});
	
					        	vmList.editCount = numberWithComma(vmList.editCount);
					        	vmList.publishDoneCount = numberWithComma(vmList.publishDoneCount);
					        	vmList.publishErrorCount = numberWithComma(vmList.publishErrorCount);
				            }.bind(this));
						},					
			            initSearchArea: function(searchCondition) {
			            	if(searchCondition) {
			            		for(var key in searchCondition) {
			            		    this.$data[key] = searchCondition[key];
			            		}
			            	}else {
			                	this.object.pageSize = '10';
			                	this.object.pk.serverId = null;
			                	this.object.pk.sourceType = ' ';
			                	this.object.pk.targetType = ' ';
			                	this.object.pk.sourceSystemId = null;
			                	this.object.pk.targetSystemId = null;
			                	
			                	this.letter.pk.serverId = 0;
			                	this.letter.pk.sourceSystemId = 0;
			                	this.letter.pk.targetSystemId = 0;
			            	}
			            	
			            	initSelectPicker($('#' + createPageObj.getElementId('ImngSearchObject')).find('#sourceInterfaceType'), this.object.pk.sourceType);
			            	initSelectPicker($('#' + createPageObj.getElementId('ImngSearchObject')).find('#targetInterfaceType'), this.object.pk.targetType);
			            },
			            openModal: function(openModalParam, regExpInfo) {
			            	createPageObj.openModal.call(this, openModalParam, regExpInfo) ;		            	
			            },
			            setSearchServerId: function(param) {
			            	this.object.pk.serverId = param.id;
			            },
			            setSearchSourceSystemId: function(param) {
			            	this.object.pk.sourceSystemId = param.id;
			            },
			            setSearchTargetSystemId: function(param) {
			            	this.object.pk.targetSystemId = param.id;
			            },			            
			    	}),
			    	mounted: function() {
			    		this.sourceInterfaceTypeList = JSON.parse(JSON.stringify(interfaceTypeResult.object));
			    		this.targetInterfaceTypeList = JSON.parse(JSON.stringify(interfaceTypeResult.object));
			    		
		    			this.$nextTick(function() {
		    				this.initSearchArea();
		    			});
			    	}
			    });				
				
			    var vmList = new Vue({
			        el: '#' + createPageObj.getElementId('ImngListObject'),
			        data: {
			        	makeGridObj: null,
			        	totalCnt: 0,
			        	editCount: 0,
			        	publishDoneCount: 0,
			        	publishErrorCount: 0,
			        	interfaceClassList : [],
			        },        
			        methods: $.extend(true, {}, listMethodOption, {
			        	initSearchArea: function() {
			        		window.vmSearch.initSearchArea();
			        	},
			        	downloadFile: function() {
			        		downloadFileFunc({ 
			        			url : '/api/statistics/server',  
			        			param : window.vmSearch.object
			        		});
			        	}
			        }),
			        mounted: function() {
			        	this.makeGridObj = getMakeGridObj();
			        	
			        	this.makeGridObj.setConfig({
			        		el: document.querySelector('#' + createPageObj.getElementId('ImngSearchGrid')),
			        		searchUrl: '/api/statistics/server',
			        		paging: {
				    			isUse: true,
				    			side: "client"
				    		},
			              	columns: [
								{
									name: 'pk.serverId',
									header: '<fmt:message>label.server</fmt:message>' + ' ' + '<fmt:message>label.id</fmt:message>',
									sortable: true,
								},
								{
									name: 'pk.sourceType',
									header: 'Source <fmt:message>label.interface.type</fmt:message>',
									align: 'center',
									formatter: function(info) {
										var interfaceTypeValue = null;
										
										vmSearch.sourceInterfaceTypeList.forEach(function(interfaceTypeObj) {
											if (info.row['pk.sourceType'] === interfaceTypeObj.pk.propertyKey) {
												interfaceTypeValue = interfaceTypeObj.propertyValue;
												return false;
											}
										});
										
										return interfaceTypeValue;
									}
								},
								{
									name: 'pk.targetType',
									header: 'Target <fmt:message>label.interface.type</fmt:message>',
									align: 'center',
									formatter: function(info) {
										var interfaceTypeValue = null;
										
										vmSearch.targetInterfaceTypeList.forEach(function(interfaceTypeObj) {
											if (info.row['pk.targetType'] === interfaceTypeObj.pk.propertyKey) {
												interfaceTypeValue = interfaceTypeObj.propertyValue;
												return false;
											}
										});
										
										return interfaceTypeValue;
									}									
								},
								{
									name: 'pk.sourceSystemId',
									header: 'Source <fmt:message>label.system</fmt:message>' + ' ' + '<fmt:message>label.id</fmt:message>',
									align: 'left',
									width: '10%',
								},
								{
									name: 'pk.targetSystemId',
									header: 'Target <fmt:message>label.system</fmt:message>' + ' ' + '<fmt:message>label.id</fmt:message>',
								},
								{
									name: 'editCount',
									header: '<fmt:message>label.editCount</fmt:message>',
									align: 'right',
									sortable: true,
									formatter: function(info) {
										return numberWithComma(info.row.editCount);
									}
								},
								{
									name: 'publishDoneCount',
									header: '<fmt:message>label.publishDoneCount</fmt:message>',
									align: 'right',
									sortable: true,
									formatter: function(info) {
										return numberWithComma(info.row.publishDoneCount);
									}								
								},
								{
									name: 'publishErrorCount',
									header: '<fmt:message>label.publishErrorCount</fmt:message>',
									align: 'right',
									sortable: true,
									formatter: function(info) {
										return numberWithComma(info.row.publishErrorCount);
									}								
								},							
			              	],
			              	onGridUpdated: function(evt) {
			              		evt.instance.sort('pk.serverId', true);
			              	}
			        	});
			        	
			        	SearchImngObj.searchGrid = this.makeGridObj.getSearchGrid();			        	

			        	if(this.newTabSearchGrid()) {
			            	this.$nextTick(function() {
			            		window.vmSearch.search();	
			            	});        		
			        	}		        	
			        }
			    });        
		    });
		    
			this.addEventListener('destroy', function(evt) {
				$(".daterangepicker").remove();
				$(".ui-datepicker").remove();
				$(".backdrop").remove();
				$(".modal").remove();
				$(".modal-backdrop").remove();
				$('#ct').find('script').remove();
			});
		});	
	</script>
</body>
</html>