<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/html/layout/header/common_head.jsp"%>
</head>
<body>
    <div id="password" class="login wrap" data-ready>
        <header id="hd">
            <h1 class="logo text-hide">
                <a href="javascript:void(0);"><img id="logoImg" src="${prefixFileUrl}/img/logo_wh.svg" alt="INZENT" />INZENT</a>
            </h1>
        </header>
        <div id="ct">
        	<div class="form-login">
	            <img src="${prefixFileUrl}/img/product-name.svg" alt="ESB">
	            
				<div class="password-label"><fmt:message>label.password.page</fmt:message></div>
				
				<div class="form-group">
					<i class="icon-lock"></i>
					<input id="oldPassword" type="password" class="form-control form-control-lg" placeholder="<fmt:message>label.user.originPassword</fmt:message>" />
					<i class="icon-eye"></i>
				</div>
	            
				<div class="form-group">
					<i class="icon-lock"></i>
					<input id="newPassword" type="password" class="form-control form-control-lg" placeholder="<fmt:message>label.user.newPassword</fmt:message>" />
					<i class="icon-eye"></i>
				</div>	            

				<div id="error" class="alert alert-danger" style="display: none;"></div>
				
				<p style="font-size: 0.73rem;">
                    <fmt:message>msg.user.validationPassCheck</fmt:message>
				</p>
				
	            <button id="passwordBtn" class="btn btn-block btn-danger btn-lg">
                    <fmt:message>label.update</fmt:message>
	            </button>
            </div>
            <p class="copy">&copy; <b>2023 INZENT. All rights reserved</b></p>
        </div>
    </div> 
    
	<script type="text/javascript">
	document.querySelector('#password').addEventListener('ready', function(evt) {
		getLogoFileName();
	
		$("#oldPassword").focus();
		
		initEventBind();
	});	
	
	function passwordValidation() {
		var isError = false;
		var errorTxt = null;
	    
		if(0 == $.trim($("#newPassword").val()).length) {
			window._alert({type: 'warn', message: '<fmt:message>msg.password.noNewPassword</fmt:message>'});
		}else if(0 == $.trim($("#oldPassword").val()).length) {
			window._alert({type: 'warn', message: '<fmt:message>msg.password.noPassword</fmt:message>'});
		} else {
			$.ajax({
				type: 'POST',
				url: "${prefixUrl}/api/entity/user/password",
				dataType: "json",
				traditional: true,
		        xhrFields: {
		        	withCredentials: true
		        },
		        data: JSON.stringify({
					'userId': '<c:out value="${userId}" />',
					'password': encryptPassword($('#oldPassword').val()),
					'newPassword': encryptPassword($('#newPassword').val()),
				}),
				beforeSend: function (request) {
					window.$startSpinner('full');				
				},
				success: function(data, textStatus, jqXHR) {
					if ('error' == data.result) {
						isError = true;
						errorTxt = '<fmt:message>msg.password.entered.incorrectly</fmt:message>';
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					isError = true;
					errorTxt = '<fmt:message>msg.error.contact.administrator</fmt:message>';				
				},
				complete: function(jqXHR, textStatus) {
					window.$stopSpinner();					
					
					if (isError) {
						$("#error").text(errorTxt).show();
					} else {
						window._alert({
							type: 'normal',
							message: '<fmt:message>msg.password.change.success</fmt:message><br><fmt:message>msg.password.go.to.login</fmt:message>', 
							backdropMode: true, 
							isXSSMode: false, 
							callBackFunc: function() {
								document.querySelector('#password').dispatchEvent(new CustomEvent('goLoginPage'));							
		            		}
						});					
					}
				}
			});		
		}
	}
	
	function getLogoFileName() {
		$.ajax({
			type: 'POST',
			url: "${prefixUrl}/api/page/logoFileName",
			dataType: "json",
			data: JSON.stringify({ 'type': 'login' }),
			beforeSend: function (request) {
	            request.setRequestHeader('X-iManager-Method', 'GET');
			},
	        success: function(res) {
				if ('ok' !== res.result || !res.object) return;
				
				$('#logoImg').attr('src', "${prefixFileUrl}/img/" + escapeHtml(res.object));
			}
		});
	}
	
	function initEventBind() {
		$("#oldPassword, #newPassword").keypress(function(evt) {
			if(13 == evt.which) {
				passwordValidation();
			}
		});
		
		$("#passwordBtn").click(function() {
			passwordValidation();
		});
		
		$(".icon-eye").click(function() {
			$(this).prev().attr({'type': ('password' == $(this).prev().attr('type'))? 'text' : 'password'});
		});
	}
	</script>
</body>
</html>