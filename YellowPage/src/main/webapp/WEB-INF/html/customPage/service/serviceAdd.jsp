<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/html/layout/header/common_head.jsp"%>
</head>
<body>
<div id="AddServiceRoot" data-ready>
    <div id="serviceIdArea" class="media-dl">
        <div class="item" style="width: 14%;">
			<div class="media align-items-center">
				<dl class="media-body">
					<dt class="title"><fmt:message>label.linked.server</fmt:message></dt> 
					<dd class="h1">
						<div id="ifIdLinkedServer" class="row media-dl">
							<div class="media clear ifId" style="width: 100%;">&nbsp;</div>
						</div>
					</dd>
				</dl>
			</div>         
        </div>
        <div class="item" style="width: 14%;">
			<div class="media align-items-center">
				<dl class="media-body">
					<dt class="title"><fmt:message>label.interface.type</fmt:message></dt> 
					<dd class="h1">
						<div id="ifIdInterfaceType" class="row media-dl">
							<div class="media clear ifId" style="width: 100%;">&nbsp;</div>
						</div>
					</dd>
				</dl>
			</div>         
        </div>  
        <div class="item" style="width: 24%;">
			<div class="media align-items-center">
				<dl class="media-body">
					<dt class="title">Target <fmt:message>label.system</fmt:message></dt> 
					<dd class="h1">
						<div id="ifIdTargetSystem" class="row media-dl">
							<div class="media clear ifId" style="width: 25%;">&nbsp;</div>
							<div class="media clear ifId" style="width: 25%;">&nbsp;</div>
							<div class="media clear ifId" style="width: 25%;">&nbsp;</div>
							<div class="media clear ifId" style="width: 25%;">&nbsp;</div>
						</div>
					</dd>
				</dl>
			</div>           
        </div>
        <div class="item" style="width: 18%;">
			<div class="media align-items-center">
				<dl class="media-body">
					<dt class="title"><fmt:message>label.biz</fmt:message></dt> 
					<dd class="h1">
						<div id="ifIdBiz" class="row media-dl">
							<div class="media clear ifId" style="width: 33%;">&nbsp;</div>
							<div class="media clear ifId" style="width: 33%;">&nbsp;</div>
							<div class="media clear ifId" style="width: 33%;">&nbsp;</div>
						</div>
					</dd>
				</dl>
			</div>         
        </div>
        <div class="item" style="width: 30%;">
			<div class="media align-items-center">
				<dl class="media-body">
					<dt class="title"><fmt:message>label.serial.number</fmt:message></dt> 
					<dd class="h1">
						<div id="ifIdSequence" class="row media-dl">
							<div class="media clear ifId" style="width: 20%;">&nbsp;</div>
							<div class="media clear ifId" style="width: 20%;">&nbsp;</div>
							<div class="media clear ifId" style="width: 20%;">&nbsp;</div>
							<div class="media clear ifId" style="width: 20%;">&nbsp;</div>
							<div class="media clear ifId" style="width: 20%;">&nbsp;</div>
						</div>
					</dd>
				</dl>
			</div>         
        </div>                
    </div>
	
	<div id="serviceIdIndicators">
 		<div class="card" style="width: 25%;">
			<div class="card-header">
				<h5><fmt:message>label.linked.server</fmt:message></h5>
			</div>
			<div class="card-body">
				<div class="form-group">
					<label class="control-label"><fmt:message>label.linked.server</fmt:message></label>
					<select id="linkedServerList" class="form-control clear"></select>
				</div>		
				<div class="form-group">
					<label class="control-label"><fmt:message>label.interface.class</fmt:message></label>
					<select id="interfaceClassList" class="form-control clear"></select>
				</div>						
			</div>
 		</div>
		<div class="card" style="width: 25%;">
			<div class="card-header">
				<h5>Target <fmt:message>label.system</fmt:message></h5>
			</div>
			<div class="card-body">
				<div class="form-group">
					<label class="control-label"><fmt:message>label.system</fmt:message></label>
					<select id="targetSystem" class="form-control clear"></select>
				</div>  	
				<div class="form-group">
					<label class="control-label"><fmt:message>label.interface.type</fmt:message></label>
					<select id="interfaceTypeList" class="form-control view-disabled" readonly="readonly"></select>
				</div>								
			</div>
		</div> 
		<div class="card" style="width: 25%;">
			<div class="card-header">
				<h5><fmt:message>label.biz</fmt:message></h5>
			</div>
			<div class="card-body">
				<div class="form-group">
					<label class="control-label"><fmt:message>label.biz</fmt:message></label>
					<select id="biz" class="form-control clear"></select>
				</div>
			</div>
		</div>
		<div class="card" style="width: 25%;">
			<div class="card-header">
				<h5><fmt:message>label.serial.number</fmt:message></h5>
			</div>
			<div class="card-body">
					<div class="form-group">
						<label class="control-label"><fmt:message>label.serial.number</fmt:message></label>
						<input id="sequence" type="text" class="form-control view-disabled clear" style="display: inline-block; width: calc(100% - 39px)" readonly>
						<a id="generateSequence" href="javascript:void(0);" class="btn" style="min-width: 15px;margin-top: -3px;">
							<i class="icon-srch" style="margin: 0px;"></i>
						</a>
					</div>
				</div>
 			</div>  							
	  	</div>
	</div>
<script>
document.querySelector('#AddServiceRoot').addEventListener('ready', function(evt) {
	getLinkedServerList();
	
	getBizList();
	
	var useSystemList = [];
	
	function getLinkedServerList() {
		new HttpReq("/api/entity/server/search").read(
			{
				object: {},
				limit: null,
				next: null,
				reverseOrder: false				
			}, 
			function(result) {
				if (result.object) {
					result.object.forEach(function(object, idx) {
						$('#linkedServerList').append($('<option/>').attr({value: escapeHtml(object.id)}).text(object.name));
					});	
					
					new HttpReq("/api/entity/system/search").read(
						{
							object: {},
							limit: null,
							next: null,
							reverseOrder: false				
						}, 
						function(result) {
							useSystemList = result.object.filter(function(info) {
								return "Y" === info.useYn;
							});
						}
					);
				}
				
				$('#linkedServerList').trigger('change');	
			}
		);
	}
	
	function getBizList() {
		(new HttpReq('/api/page/properties')).read(
			{
				pk: {
					propertyId: 'List.Biz',	
				},
				orderByKey: true
			}, 		
			function(result) {
				if (result.object) { 
					result.object.forEach(function(object, idx) {
						$('#biz').append( $('<option/>').attr({value: escapeHtml(object.pk.propertyKey)}).text(object.propertyValue) );
					});					
				}
				
				$('#biz').trigger('change');	
			}
		);
	}	
	
	function setSubIfId(elementId, subIfParentId) {
		var subIfId = $('#' + elementId).val().trim().substring(0, $('#' + subIfParentId).find('.media').length).toUpperCase();
		
		$('#' + subIfParentId).find('.media').each(function(index, element) {
			if(!subIfId.charAt(index)) return;
			$(element).text(subIfId.charAt(index));	
		});
	}
	
	function clearData(predicateFunc) {
		$('.clear').each(function(index, element) {
			if(predicateFunc && predicateFunc(element)) return;
			
			if ('DIV' == element.tagName) 			$(element).html('&nbsp;');  
			else if('SELECT' == element.tagName) 	$(element).empty();
			else if('INPUT' == element.tagName) 	$(element).val(null);
			else									$(element).empty();
		});		
	}
	
	function getServiceId(predicateFunc) {
		var isValidate = true;
		var interfaceId = '';

		$('.ifId').parent().each(function(index, element) {
			if(predicateFunc && predicateFunc(element)) return true;
				
			var subIfId = $(element).find('.ifId').text().trim();
			
			if (0 == subIfId.length) {
				isValidate = false;
				return false;
			} else {
				interfaceId += subIfId;
			}
		});
		
		return {
			isValidate: isValidate,
			interfaceId: isValidate? interfaceId : null,
		}
	}
	
	$('#linkedServerList').on('change', function(evt) {
		clearData(function(element) {
			return 'linkedServerList' == $(element).attr('id') || 'biz' == $(element).attr('id') || 'ifIdBiz' == $(element).parent().attr('id');
		});
		
		if (0 < $('#linkedServerList').find('option').length)
			setSubIfId('linkedServerList', 'ifIdLinkedServer');
		
		(new HttpReq("/api/entity/server/object")).read(
			{
				id: $('#linkedServerList').val()
			},
			function(result) {
				if (result.object) {
					var systemTargets = result.object.systemTargets;
					
					new HttpReq("/api/entity/interfaceClass/search").read({
						object: {},
						limit: null,
						next: null,
						reverseOrder: false						
					}, function(interfaceClassResult) {
						if (interfaceClassResult.object) {
							result.object.serverInterfaces.forEach(function(object) {
								var property = interfaceClassResult.object.filter(function(property) { 
									return object.pk.interfaceClass === property.id;
								})[0];
								
								var option = $('<option/>').attr({
														       value: escapeHtml(property.id)
														   })
														   .data({
															   targetType: property.targetInterfaceType, 
															   systemTargets: systemTargets.filter(function(systemTarget) {
																	return systemTarget.pk.interfaceClass == property.id;
															   })
														   })
														   .text(property.name);
								
								$('#interfaceClassList').append(option);
							});			
							
							$('#interfaceClassList').trigger('change');	
						}
					});
				}
			});
	});
	
	$('#interfaceClassList').on('change', function(evt) {
		$('#interfaceTypeList, #targetSystem').empty();
		
		if (0 < $('#interfaceClassList').find('option').length) {
			new HttpReq('/api/page/properties').read({ pk: { propertyId: 'Interface.Type' }, orderByKey: true }, function(propertyResult) {
	        	var propertyObj = propertyResult.object;
	        	
	        	for (var i = 0; i < propertyObj.length; i++) {
	        		if (propertyObj[i].pk.propertyKey === $('#interfaceClassList option:selected').data('targetType')) {
	        			$('#interfaceTypeList').append($('<option/>').attr({value: escapeHtml(propertyObj[i].pk.propertyKey)}).text(propertyObj[i].propertyValue));
	        			break;
	        		} 
	        	}
	        	
	        	$('#interfaceTypeList').trigger('change');
	        });
	        
	        var systemTargets = $('#interfaceClassList option:selected').data('systemTargets');
	        
	        systemTargets.forEach(function(systemTarget) {
	        	console.log(systemTarget);
	        	
	        	var usersystemTarget = useSystemList.find(function(system) {
					return systemTarget.pk.id === system.id;
				});
				
				if (usersystemTarget) $('#targetSystem').append($('<option/>').attr({value: escapeHtml(systemTarget.pk.id)}).text(systemTarget.pk.id));
	        });
	        
	        $('#targetSystem').trigger('change');		
		} else {
			$('#interfaceTypeList').trigger('change');
			$('#targetSystem').trigger('change');			
		}
	});
	
	$('#interfaceTypeList').on('change', function(evt) {
		clearData(function(element) {
			return 'ifIdInterfaceType' != $(element).parent().attr('id') && 'sequence' != $(element).attr('id') && 'ifIdSequence' != $(element).parent().attr('id');
		});
		
		if (0 < $('#interfaceTypeList').find('option').length)
			setSubIfId('interfaceTypeList', 'ifIdInterfaceType');
	});
	
	$('#targetSystem').on('change', function(evt) {
		clearData(function(element) {
			return 'ifIdTargetSystem' != $(element).parent().attr('id') && 'sequence' != $(element).attr('id') && 'ifIdSequence' != $(element).parent().attr('id');
		});
		
		if (0 < $('#targetSystem').find('option').length)
			setSubIfId('targetSystem', 'ifIdTargetSystem');
	});
	
	$('#biz').on('change', function(evt) {
		clearData(function(element) {
			return 'ifIdBiz' != $(element).parent().attr('id') && 'sequence' != $(element).attr('id') && 'ifIdSequence' != $(element).parent().attr('id');
		});
		
		if (0 < $('#biz').find('option').length)
			setSubIfId('biz', 'ifIdBiz');
	});
	
	$('#generateSequence').on('click', function(evt) {
		var result = getServiceId(function(element) {
			return 'ifIdSequence' == $(element).attr('id');
		});
		
		if(!result.isValidate) {
			window._alert({ type: 'warn', message: '<fmt:message>msg.please.complete.all.fields.service.id.serial.number</fmt:message>' });
			return;	
		}
		
		clearData(function(element) {
			return 'sequence' != $(element).attr('id') && 'ifIdSequence' != $(element).parent().attr('id');
		});
		
		(new HttpReq("/api/page/nextSequence?sequencePrefix=" + result.interfaceId)).read(
			null,
			function(result) {
				if (result.object) {
					$('#sequence').val(String(result.object).padStart(5, '0'));
					setSubIfId('sequence', 'ifIdSequence');					
				}
			}
		);
	});
	
	this.addEventListener('resize', function(evt) {
		$('#serviceIdIndicators').height('calc(100% - ' + $('.media-dl').outerHeight(true) + 'px)');
	});	
	
	this.dispatchEvent(new CustomEvent('resize'));
	
	this.addEventListener('destroy', function(evt) {
		$(".daterangepicker").remove();
		$(".ui-datepicker").remove();
		$(".backdrop").remove();
		$(".customType.modal").remove();
		$(".modal-backdrop").remove();
		$('#ct').find('script').remove();
	});
	
	this.addEventListener('getCustomData', function(evt) {
		var result = getServiceId();
		
		if(!result.isValidate) {
			window._alert({ type: 'warn', message: '<fmt:message>msg.please.complete.all.fields.service.id</fmt:message>' });
		}
		
		this.dispatchEvent(new CustomEvent('setCustomData', { detail: {
			isValidate: result.isValidate,
			id: result.interfaceId,
			serverId: $('#linkedServerList').val(),
			interfaceType: $('#interfaceTypeList').val(),
			targetSystemId: $('#targetSystem').val(),
			bizId: $('#biz').val(),
		}}));
	});	
});
</script>
</body>

</html>