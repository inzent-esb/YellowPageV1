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
	<div id="notice" data-ready>
		<sec:authorize var="hasNoticeEditor" access="hasRole('NoticeEditor')"></sec:authorize>
			
		<%@ include file="/WEB-INF/html/layout/component/component_search.jsp"%>
		
		<%@ include file="/WEB-INF/html/layout/component/component_list.jsp"%>
		
		<%@ include file="/WEB-INF/html/layout/component/component_detail.jsp"%>
	</div>
	<script>
		document.querySelector('#notice').addEventListener('ready', function(evt) {
			var viewer = true;
			var editor = 'true' == '${hasNoticeEditor}';
			
			var createPageObj = getCreatePageObj();
			
			createPageObj.setViewName('notice');
			createPageObj.setIsModal(false);
			
			createPageObj.setSearchList([
				{'type': "text", 'mappingDataInfo': "object.noticeTitle", 'name': "<fmt:message>label.title</fmt:message>", 'placeholder': "<fmt:message>msg.enterTitle</fmt:message>"},
			]);
			
			createPageObj.searchConstructor();
			
			createPageObj.setMainButtonList({
				newTabBtn: viewer,
				searchInitBtn: viewer,
				totalCnt: viewer,
				currentCnt: viewer,
				addBtn: editor,
			});
			
			createPageObj.mainConstructor();
			
			createPageObj.setTabList([
		 		{
					'type': 'custom',
					'id': 'MainBasic',
					'name': '<fmt:message>label.basicInfo</fmt:message>',
					'isSubResponsive' : true,
					'getDetailArea': function() {
						var rtnHtml = '';
						
						rtnHtml += '<span style="width: 100%;">';
						rtnHtml += '	<div class="col-lg-12" style="height: 100%;">';
						rtnHtml += '		<div class="form-group">';
						rtnHtml += '			<label class="control-label">';
						rtnHtml += '				<span><fmt:message>label.title</fmt:message></span>';
						rtnHtml += '				<span class="letterLength">';
						rtnHtml += '					({{ object.noticeTitle? object.noticeTitle.length : 0 }}/{{ titleRegExpInfo.maxLength }})';
						rtnHtml += '				</span>';
						rtnHtml += '			</label>';
						rtnHtml += '			<div class="input-group">';
						rtnHtml += "				<input type='text' class='form-control view-disabled' v-model='object.noticeTitle' :maxlength='titleRegExpInfo.maxLength' @input='inputEvt($event, \"noticeTitle\")'>";
						rtnHtml += '			</div>';
						rtnHtml += '		</div>';
						rtnHtml += '		<div class="form-group" style="height: calc(100% - 72px);">';
						rtnHtml += '			<label class="control-label">';
						rtnHtml += '				<span><fmt:message>label.content</fmt:message></span>';
						rtnHtml += '				<span class="letterLength">';
						rtnHtml += '					({{ object.noticeContent? object.noticeContent.length : 0 }}/{{ contentRegExpInfo.maxLength }})';
						rtnHtml += '				</span>';
						rtnHtml += '			</label>';
						rtnHtml += '			<div class="input-group" style="height: calc(100% - 24px);">';
						rtnHtml += "				<textarea class='form-control view-disabled' v-model='object.noticeContent' style='height: 100%; min-height: 207px;' :maxlength='contentRegExpInfo.maxLength' @input='inputEvt($event, \"noticeContent\")'></textarea>";
						rtnHtml += '			</div>';
						rtnHtml += '		</div>';
						rtnHtml += '	</div>';
						rtnHtml += '</span>';			
						
						return rtnHtml;	
					}
				},
			]);		
			
			createPageObj.setPanelButtonList({
				removeBtn: editor,
				goModBtn: editor,
				saveBtn: editor,
				updateBtn: editor,
			});			
			
			createPageObj.panelConstructor();	
			
		    SaveImngObj.setConfig({
		    	objectUrl : "/api/entity/notice/object"
		    });
		    
		    window.vmSearch = new Vue({
		    	el : '#' + createPageObj.getElementId('ImngSearchObject'),
		    	data : {
		    		letter: {
		       			noticeTitle: 0,
		    		},
		    		object : {
		       			noticeTitle: null,
		       			pageSize : '10',
		    		},
		    	},
		    	methods : $.extend(true, {}, searchMethodOption, {
		    		inputEvt: function (param) {
		    			setLengthCnt.call(this, param);
		    		},
					search : function() {
						vmList.makeGridObj.noDataHidePage(createPageObj.getElementId('ImngListObject'));
						
						vmList.makeGridObj.search(this.object, function(info) {
			            	vmList.currentCnt = info.currentCnt;
			            	vmList.totalCnt = info.totalCnt;
			            });
			        },
		            initSearchArea: function(searchCondition) {
		            	if(searchCondition) {
		            		for(var key in searchCondition) {
		            		    this.$data[key] = searchCondition[key];
		            		}
		            	}else {
		                	this.object.pageSize = '10';
		            		this.object.noticeTitle = null;		
		            		this.object.noticeContent = null;            		
		            	}
		            },
		    	}),
		    	mounted: function() {
		    		this.initSearchArea();
		    	}
		    });

		    var vmList = new Vue({
		        el: '#' + createPageObj.getElementId('ImngListObject'),
		        data: {
		        	makeGridObj: null,
		        	 totalCnt: 0,
				     currentCnt: 0
		        },        
		        methods : $.extend(true, {}, listMethodOption, {
		        	initSearchArea: function() {
		        		window.vmSearch.initSearchArea();
		        	},
		        }),
		        mounted: function() {
		        	this.makeGridObj = getMakeGridObj();
		        	
		        	this.makeGridObj.setConfig({
		        		el: document.querySelector('#' + createPageObj.getElementId('ImngSearchGrid')),
			            searchUrl: '/api/entity/notice/search',
			            totalCntUrl: '/api/entity/notice/count',
			    		paging: {
			    			isUse: true,
			    			side: "server",
			    			setCurrentCnt: function(currentCnt) {
			    				this.currentCnt = currentCnt
			    			}.bind(this)			    			
			    		},
		              	columns : [
		              		{
		              			name : "noticeTitle",
		              			header : "<fmt:message>label.title</fmt:message>",
		              			align : "left",
		                        width: "40%",
		                        sortable: true,
		              		},
		              		{
		              			name : "userId",
		              			header : "<fmt:message>label.writer</fmt:message>",
		              			align : "left",
		                        width: "30%",
		                        sortable: true,
		              		},
		              		{
		              			name : "pk.createTimestamp",
		              			header : "<fmt:message>label.created.date</fmt:message>",
		              			align : "center",
		                        width: "30%",
		                        sortable: true,
		              		},              		
		              	],
			            onGridMounted: function(evt) {
			            	evt.instance.on('click', function(evt) {
			            		SearchImngObj.clicked(evt.instance.getRow(evt.rowKey));
			            	});
			            }  	    
		        	});
		        	
		        	SearchImngObj.searchGrid = this.makeGridObj.getSearchGrid();
		        	
		        	if(!this.newTabSearchGrid()) {
		            	this.$nextTick(function() {
		            		window.vmSearch.search();	
		            	});        		
		        	}
		        }
		    });	
		    
		    window.vmMain = new Vue({
		    	el : '#MainBasic',
		    	data : {
		    		viewMode : 'Open',
		    		object : {
		       			noticeTitle: null,
		       			noticeContent: null,
		       			userId: null,
		       			pk: {
		       				createTimestamp: '',
		       				noticeId: ''
		       			}
		    		},
		    		openWindows : [],
		    		panelMode : null,
		    		titleRegExpInfo: getRegExpInfo('value'),
		    		contentRegExpInfo: getRegExpInfo('desc')
		    	},
		        methods : {
		        	inputEvt: function(event, key) {
		        		var regExpInfo = null;
		        		
		        		if('noticeTitle' === key) {
		        			regExpInfo = this.titleRegExpInfo;
		        		} else if('noticeContent' === key) {
		        			regExpInfo = this.contentRegExpInfo;
		        		}
		        		
		        		this.object[key] = event.target.value;
		    			this.object[key] = this.object[key].replace(new RegExp(regExpInfo.regExp, 'g'), '');
		        	},
					goDetailPanel: function() {
						panelOpen('detail');
					},
		        	initDetailArea: function(object) {
		        		if(object) {
		        			this.object = object;
		        		}else{
		    				this.object.noticeTitle = null;
		    				this.object.noticeContent = null;
		    				this.object.pk.createTimestamp = '';
		    				this.object.pk.noticeId = '';
		        		}
					},
		        },
		    });		    
			
			new Vue({
				el: '#panel-header',
				methods : $.extend(true, {}, panelMethodOption)
			});		
			
			new Vue({
			    el: '#panel-footer',
			    methods: $.extend(true, {}, panelMethodOption, {
			    	saveInfo: function() {
			    		SaveImngObj.insert('<fmt:message>msg.alert.insert</fmt:message>', function(result) {			    			
			    			if(!result.object) return;
			    			
			    			window.vmMain.object.pk.createTimestamp = result.object.pk.createTimestamp;
			    			window.vmMain.object.pk.noticeId = result.object.pk.noticeId;
			    		});
			    	}
			    })
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