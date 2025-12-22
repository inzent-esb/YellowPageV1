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
	<div id="system" data-ready>
		<sec:authorize var="hasStatisticsViewer" access="hasRole('StatisticsViewer')"></sec:authorize>
			
		<%@ include file="/WEB-INF/html/layout/component/component_search.jsp"%>
		
		<%@ include file="/WEB-INF/html/layout/component/component_list.jsp"%>

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
		document.querySelector('#system').addEventListener('ready', function(evt) {
			var viewer = 'true' == '${hasStatisticsViewer}';
			
			var createPageObj = getCreatePageObj();
			
			createPageObj.setViewName('system');
			createPageObj.setIsModal(false);
			
			createPageObj.setSearchList(
				[
					{
						type: "modal",
						mappingDataInfo: {
							url: '/modal/systemModal',
					        modalTitle: '<fmt:message>label.system</fmt:message>',
					        vModel: "object.pk.systemId",
					        callBackFuncName: "setSearchSystemId"
						},
						regExpType: 'searchId',
						name: "<fmt:message>label.system</fmt:message> <fmt:message>label.id</fmt:message>",
						placeholder: "<fmt:message>msg.enterId</fmt:message>"
					},	
					{	type: 'text',
						mappingDataInfo: 'object.pk.bizId', 
						name: '<fmt:message>label.biz</fmt:message>' + ' ' + '<fmt:message>label.id</fmt:message>',
						placeholder: '<fmt:message>msg.enterId</fmt:message>'
					},
					{
						type: 'select', 
						name: '<fmt:message>label.classification</fmt:message>', 
						placeholder:  '<fmt:message>label.all</fmt:message>',
						mappingDataInfo: {
							id: 'statsTypes',
							selectModel: 'object.pk.statsType',
							optionFor: 'option in statsTypes',
							optionValue: 'option.value',
							optionText: 'option.text',
						},
					},
					{
						type: 'select', 
						name: '<fmt:message>label.interface.type</fmt:message>', 
						placeholder:  '<fmt:message>label.all</fmt:message>',
						mappingDataInfo: {
							id: 'interfaceType',
							selectModel: 'object.pk.interfaceType',
							optionFor: 'option in interfaceTypeList',
							optionValue: 'option.pk.propertyKey',
							optionText: 'option.propertyValue',
						},
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
			    		statsTypes: [
	                        {value: 'S', text: '<fmt:message>label.service</fmt:message>'},
	                        {value: 'I', text: '<fmt:message>label.interface</fmt:message>'}
			    		],
			    		interfaceTypeList: [],
			    		object : {
			    			pk: {		    				
			    				systemId: null,
			    				bizId: null,
			    				statsType: ' ',
			    				interfaceType: ' ',
			    			},
			    			pageSize : '10'
			    		},
			    		letter: {
			    			pk: {
			    				systemId: null,
			    				bizId: null,
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
			                	this.object.pk.systemId = null;
			                	this.object.pk.bizId = null;
			                	this.object.pk.statsType = ' ';
			                	this.object.pk.interfaceType = ' ';
			                	
			                	this.letter.pk.systemId = 0;
			                	this.letter.pk.bizId = 0;
			            	}
			            	
			            	initSelectPicker($('#' + createPageObj.getElementId('ImngSearchObject')).find('#interfaceType'), this.object.pk.interfaceType);
			            	initSelectPicker($('#' + createPageObj.getElementId('ImngSearchObject')).find('#statsTypes'), this.object.pk.statsType);
			            	initSelectPicker($('#' + createPageObj.getElementId('ImngSearchObject')).find('#systemId'), this.object.pk.systemId);
			            },
			            openModal: function(openModalParam, regExpInfo) {
			            	createPageObj.openModal.call(this, openModalParam, regExpInfo) ;		            	
			            },
			            setSearchSystemId: function(param) {
			            	this.object.pk.systemId = param.id;
			            },				            
			    	}),
			    	mounted: function() {
			    		this.interfaceTypeList = interfaceTypeResult.object;
			    		
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
			        },        
			        methods: $.extend(true, {}, listMethodOption, {
			        	initSearchArea: function() {
			        		window.vmSearch.initSearchArea();
			        	},
			        	downloadFile: function() {
			        		downloadFileFunc({ 
			        			url : '/api/statistics/system',  
			        			param : window.vmSearch.object
			        		});			        		
			        	},
			        }),
			        mounted: function() {
			        	this.makeGridObj = getMakeGridObj();
			        	
			        	this.makeGridObj.setConfig({
			        		el: document.querySelector('#' + createPageObj.getElementId('ImngSearchGrid')),
			        		searchUrl: '/api/statistics/system',
			        		paging: {
				    			isUse: true,
				    			side: "client"
				    		},
			              	columns: [
			              		{
									name: 'pk.systemId',
									header: '<fmt:message>label.system</fmt:message>' + ' ' + '<fmt:message>label.id</fmt:message>',
									sortable: true,
								},
								{
									name: 'pk.bizId',
									header: '<fmt:message>label.biz</fmt:message>' + ' ' + '<fmt:message>label.id</fmt:message>',
								},
								{
									name: 'pk.statsType',
									header: '<fmt:message>label.classification</fmt:message>',
									align: 'center',
									formatter: function(info) {
										if ('I' === info.value) return '<fmt:message>label.interface</fmt:message>';
										else if ('S' === info.value) return '<fmt:message>label.service</fmt:message>';
									},
								},
								{
									name: 'pk.interfaceType',
									header: '<fmt:message>label.interface.type</fmt:message>',
									align: 'center',
									formatter: function(info) {
										var interfaceTypeValue = null;
										
										vmSearch.interfaceTypeList.forEach(function(interfaceTypeObj) {
											if (info.row['pk.interfaceType'] === interfaceTypeObj.pk.propertyKey) {
												interfaceTypeValue = interfaceTypeObj.propertyValue;
												return false;
											}
										});
										
										return interfaceTypeValue;
									}
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
			              		evt.instance.sort('pk.systemId', true);
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