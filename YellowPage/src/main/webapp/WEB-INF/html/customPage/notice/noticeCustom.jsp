<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/html/layout/header/common_head.jsp"%>
</head>
<body>
<form id="noticeCustom" data-ready>
	<div class="row frm-row">
		<div class="col-lg-12">
			<div class="form-group">
				<label class="control-label">
					<span><fmt:message>label.title</fmt:message></span>
					<b class="icon-star"></b>
				</label>
				<span>
					<input type="text" name="noticeTitle" class="form-control view-disabled">
				</span>
			</div>
		</div>
	</div>
</form>

<script>
document.querySelector('#noticeCustom').addEventListener('ready', function(evt) {
	this.addEventListener('getDetailData', function(evt) {
		setPanelData({ 
			mode : evt.detail.mode,
			initDataFunc : function() {
				initDetailData(evt.detail.detailData);
			}
		});
	});

	this.addEventListener('getCustomData', function(evt) {
		var formData = $('#noticeCustom').serializeArray();
		var object = {};
		
		formData.forEach(function(data) {
			object[data.name] = data.value;
		});
		
		this.dispatchEvent(new CustomEvent('setCustomData', { detail: object }));
	}.bind(this));
	
	this.addEventListener('destroy', function(evt) {
		$(".daterangepicker").remove();
		$(".ui-datepicker").remove();
		$(".backdrop").remove();
		$(".customType.modal").remove();
		$(".modal-backdrop").remove();
		$('#ct').find('script').remove();
	});	

	function initDetailData(object) {	
		var panelObj = $('#noticeCustom');
		
		if(object && 0 < Object.keys(object).length) {
			for(var key in object) {
				panelObj.find('[name="' + key + '"]').val(object[key]);
			}
		} else {
			var objKeyList = ['noticeTitle'];
			
			objKeyList.forEach(function(key) {
				panelObj.find('[name="' + key + '"]').val(null);				
			});
		}
	}
});
</script>
</body>
</html>