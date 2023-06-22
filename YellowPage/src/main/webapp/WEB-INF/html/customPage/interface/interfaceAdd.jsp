<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/html/layout/header/common_head.jsp"%>
</head>
<body>
<div id="interfaceAddRoot" data-ready>
    <div id="interfaceIdArea" class="media-dl">
        <div class="item" style="width: 22%;">
			<div class="media align-items-center">
				<dl class="media-body">
					<dt class="title">Source <fmt:message>label.system</fmt:message></dt> 
					<dd class="h1">
						<div id="ifIdSourceSystem" class="row media-dl">
							<div class="media clear ifId" style="width: 25%;">&nbsp;</div>
							<div class="media clear ifId" style="width: 25%;">&nbsp;</div>
							<div class="media clear ifId" style="width: 25%;">&nbsp;</div>
							<div class="media clear ifId" style="width: 25%;">&nbsp;</div>
						</div>
					</dd>
				</dl>
			</div>        
        </div>
        <div class="item" style="width: 10%;">
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
        <div class="item" style="width: 22%;">
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
        <div class="item" style="width: 10%;">
			<div class="media align-items-center">
				<dl class="media-body">
					<dt class="title"><fmt:message>label.interface.class</fmt:message></dt> 
					<dd class="h1">
						<div id="ifIdInterfaceClass" class="row media-dl">
							<div class="media clear ifId" style="width: 100%;">&nbsp;</div>
						</div>
					</dd>
				</dl>
			</div>         
        </div>
        <div class="item" style="width: 15%;">
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
        <div class="item" style="width: 21%;">
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
	
	<div id="carouselIndicators" class="carousel slide" data-ride="carousel" data-interval="false">
		<ol class="carousel-indicators">
    		<li data-target="#carouselIndicators" data-slide-to="0" class="active"></li>
    		<li data-target="#carouselIndicators" data-slide-to="1"></li>
  		</ol>
  		<div class="carousel-inner">
  			<div class="carousel-item active">
  				<div class="card-parent">
	  				<div class="card" style="width: 33%;">
	  					<div class="card-header">
	  						<h5>Source <fmt:message>label.system</fmt:message></h5>
	  					</div>
	  					<div class="card-body">
							<div class="form-group">
								<label class="control-label"><fmt:message>label.system</fmt:message></label>
		  						<select id="sourceSystem" class="form-control clear"></select>
							</div>
							<div class="form-group">
								<label class="control-label"><fmt:message>label.interface.type</fmt:message></label>
								<input id="sourceInterfaceType" type="text" class="form-control view-disabled clear" readonly>
							</div>
	  					</div>
	  				</div>
	  				<div class="card" style="width: 33%;">
	  					<div class="card-header">
	  						<h5><fmt:message>label.linked.server</fmt:message> / <fmt:message>label.interface.class</fmt:message></h5>
	  					</div>
	  					<div class="card-body">
							<div class="form-group">
								<label class="control-label"><fmt:message>label.linked.server</fmt:message></label>
		  						<select id="linkedServerList" class="form-control clear"></select>
							</div> 
							<div class="form-group">
								<label class="control-label"><fmt:message>label.interface.class</fmt:message></label>
		  						<select id="interfaceClass" class="form-control clear"></select>
							</div>					
	  					</div>
	  				</div>
	  				<div class="card" style="width: 33%;">
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
								<input id="targetInterfaceType" type="text" class="form-control view-disabled clear" readonly>
							</div>  					
	  					</div>
	  				</div>   				
  				</div>
    		</div>
    		<div class="carousel-item">
    			<div class="card-parent">
	  				<div class="card">
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
	  				<div class="card">
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
  		</div>
  		<a class="carousel-control-prev" href="#carouselIndicators" role="button" data-slide="prev">
    		<i class="icon-left"></i>
  		</a>
  		<a class="carousel-control-next" href="#carouselIndicators" role="button" data-slide="next">
			<i class="icon-right"></i>
  		</a>
  	</div>
</div>

<script>
document.querySelector('#interfaceAddRoot').addEventListener('ready', function(evt) {
	getIsPublishService();
	
	getLinkedServerList();
	
	getBizList();
	
	function getIsPublishService() {
		var carouselItem = $('#carouselIndicators').find('.carousel-item')[1];
		
		if (constants.isPublishService) {
			$(carouselItem).find('.card').width('47%');
		} else {
			$(carouselItem).find('.card-parent').append(
				'<div class="card">' +
				'	<div class="card-header">' + 
				'		<h5><fmt:message>label.automatically.create.service</fmt:message></h5>' +
				'	</div>' +
				'	<div class="card-body">' + 
				'		<div class="form-group">' +
				'			<label class="control-label"><fmt:message>label.automatically.create.service</fmt:message></label>' +
				'			<select id="serviceAutoGenerated" class="form-control">' +
				'				<option value="Y"><fmt:message>label.yes</fmt:message></option>' + 
				'				<option value="N"><fmt:message>label.no</fmt:message></option>' + 
				'			</select>' + 
				'		</div>' + 
				'	</div>' + 
				'</div>' 
			);
			
			$(carouselItem).find('.card').width('31%');
		}		
	}
	
	function getLinkedServerList() {
		(new HttpReq("/api/entity/server/search")).read(
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
				}
				
				$('#linkedServerList').trigger('change');	
			}
		);
	}
	
	function getLinkedServerInfo(id) {	
		(new HttpReq("/api/entity/server/object")).read(
			{
				id: id
			},
			function(result) {
				if (result.object) {
					var systemSources = result.object.systemSources;
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
															   sourceType: property.sourceInterfaceType,
															   targetType: property.targetInterfaceType, 
															   systemSources: systemSources.filter(function(systemSource) {
																   return systemSource.pk.interfaceClass == property.id;
		 													   }), 
															   systemTargets: systemTargets.filter(function(systemTarget) {
																	return systemTarget.pk.interfaceClass == property.id;
															   })
														   })
														   .text(property.name);
								
								$('#interfaceClass').append(option); 
							});							
						}
						
						$('#interfaceClass').trigger('change');
					});
				}
			});
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
		if(null == $('#' + elementId).val()) return;
		
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
	
	function getInterfaceId(predicateFunc) {
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
		
		if (0 < $('#linkedServerList').find('option').length) {
			setSubIfId('linkedServerList', 'ifIdLinkedServer');	
		}
		
		getLinkedServerInfo($('#linkedServerList').val());
	});
	
	$('#interfaceClass').on('change', function(evt) {
 		clearData(function(element) {
			return 'linkedServerList' == $(element).attr('id') || 'ifIdLinkedServer' == $(element).parent().attr('id') || 'interfaceClass' == $(element).attr('id') || 'biz' == $(element).attr('id') || 'ifIdBiz' == $(element).parent().attr('id');
		});
 		
		setSubIfId('interfaceClass', 'ifIdInterfaceClass');
		
		var systemSources = $('#interfaceClass option:selected').data('systemSources');
		var systemTargets = $('#interfaceClass option:selected').data('systemTargets');
		
		var sourceType = $('#interfaceClass option:selected').data('sourceType');
		var targetType = $('#interfaceClass option:selected').data('targetType');
		
		if(systemSources)
			systemSources.forEach(function(systemSource) {
				$('#sourceSystem').append( $('<option/>').attr({value: escapeHtml(systemSource.pk.id)}).text(systemSource.pk.id) );
			});
		
		if(systemTargets)
			systemTargets.forEach(function(systemTarget) {
				$('#targetSystem').append( $('<option/>').attr({value: escapeHtml(systemTarget.pk.id)}).text(systemTarget.pk.id) );
			});
		
		new HttpReq('/api/page/properties').read({
			pk: {
				propertyId: 'Interface.Type',				
			},
			orderByKey: true
		}, function(propertyResult) {
			if (propertyResult.object) {
				['source', 'target'].forEach(function(type) {
					var property = propertyResult.object.filter(function(property) { 
						return ('source' === type? sourceType : targetType) === property.pk.propertyKey;
					})[0];
					
					if(!property) return;
					
					$('#' + type + 'InterfaceType').val(property.propertyValue).data('value', property.pk.propertyKey);
				});
			}
			
			$('#sourceSystem').trigger('change');
			$('#targetSystem').trigger('change');
		});
	});	
	
	$('#sourceSystem').on('change', function(evt) {
		clearData(function(element) {
			return 'ifIdSourceSystem' != $(element).parent().attr('id') && 'sequence' != $(element).attr('id') && 'ifIdSequence' != $(element).parent().attr('id');
		});
		
		if(0 < $('#sourceSystem').find('option').length)
			setSubIfId('sourceSystem', 'ifIdSourceSystem');
	});
	
	$('#targetSystem').on('change', function(evt) {
		clearData(function(element) {
			return 'ifIdTargetSystem' != $(element).parent().attr('id') && 'sequence' != $(element).attr('id') && 'ifIdSequence' != $(element).parent().attr('id');
		});
		
		if(0 < $('#targetSystem').find('option').length)
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
		var result = getInterfaceId(function(element) {
			return 'ifIdSequence' == $(element).attr('id');
		});
		
		if(!result.isValidate) {
			window._alert({ type: 'warn', message: '<fmt:message>msg.please.complete.all.fields.interface.id.serial.number</fmt:message>' });
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
		$('#carouselIndicators').height('calc(100% - ' + $('.media-dl').outerHeight(true) + 'px)');
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
		var result = getInterfaceId();
		
		if(!result.isValidate) {
			window._alert({ type: 'warn', message: '<fmt:message>msg.please.complete.all.fields.interface.id</fmt:message>' });
		}
		
		this.dispatchEvent(new CustomEvent('setCustomData', { detail: {
			isValidate: result.isValidate,
			id: result.interfaceId, //interfaceId
			serverId: $('#linkedServerList').val(),
			sourceSystemId: $('#sourceSystem').val(),
			interfaceClass: $('#interfaceClass').val(),
			sourceInterfaceType: $('#sourceInterfaceType').data('value'),
			targetSystemId: $('#targetSystem').val(),
			targetInterfaceType: $('#targetInterfaceType').data('value'),
			bizId: $('#biz').val(),
			serviceId: 'IZT_' + result.interfaceId,
			serviceAutoGenerated: $('#serviceAutoGenerated').val(),
		}}));
	});	
});
</script>
</body>
</html>