<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="ImngListObject" class="ct-content" style="display: none;">
	<div class="sub-bar">
        <div style="display: none;" afterload>
			<div id="currentCnt" class="form-inline m-full" v-if="null !== currentCnt && currentCnt !== totalCnt" style="margin-right: 5px;">
			<fmt:message key="label.currentCount"><fmt:param value="{{ currentCnt }}" /></fmt:message> /
			</div>
	        <div id="totalCnt" class="form-inline m-full" v-if="null !== totalCnt">
	        	<fmt:message key="label.totalCount"><fmt:param value="{{ totalCnt }}" /></fmt:message>
	        </div>
		</div>
		<div class="ml-auto form-inline m-full">
			<a id="newTabBtn" href="javascript:void(0);" class="btn btn-m" v-on:click="goNewTab" style="display: none;"><i class="icon-info"></i><span class="hide"><fmt:message>label.newTab</fmt:message></span></a>
			<span id="timerRange">
				<select v-model="rangeMinute" class="form-control" style="min-width: 0px; width: 80px;">
					<option v-for="minutes in rangeMinuteList" v-bind:value="minutes">{{minutes}}</option>
				</select> <fmt:message>label.minutes</fmt:message>
			</span>
			<span id="refreshArea">
				<span v-if="!isStartRefresh">
					<select v-model="timerSeconds" class="form-control" style="min-width: 0px; width: 80px;">
						<option v-for="seconds in timerSecondsList" v-bind:value="seconds">{{seconds}}</option>
					</select> <fmt:message>label.seconds</fmt:message>
				</span>
				<span v-if="isStartRefresh">
					<input type="text" class="form-control" style="min-width: 0px; width: 80px;" readonly="readonly" v-model="displayTimerSeconds"> <fmt:message>label.seconds</fmt:message>
				</span>
				<a id="refreshBtn" href="javascript:void(0);" class="btn btn-m" v-on:click="refresh"><i v-bind:class="{ 'icon-play' : !isStartRefresh, 'icon-pause' : isStartRefresh }"></i><span class="hide"><fmt:message>label.refresh</fmt:message></span></a>			
			</span>
			<a id="importBtn"       href="javascript:void(0);" class="btn btn-m btn-primary" 		      	v-on:click="goImport" style="display: none;"><fmt:message>label.import</fmt:message></a>
			<a id="downloadBtn"     href="javascript:void(0);" class="btn btn-m btn-primary" 			  	v-on:click="downloadFile" style="display: none;"><i class="icon-result"></i><span class="hide"><fmt:message>label.excel.output</fmt:message></span></a>			
			<a id="makeBtn"         href="javascript:void(0);" class="viewGroup btn btn-m btn-primary"    	v-on:click="make" style="display: none;"><fmt:message>label.make</fmt:message></a>
			<a id="startBtn"        href="javascript:void(0);" class="viewGroup btn btn-m"    				v-on:click="start" style="display: none;"><i class="icon-play"></i><fmt:message>label.execute</fmt:message></a>
			<a id="stopBtn"         href="javascript:void(0);" class="viewGroup btn btn-m"    				v-on:click="stop" style="display: none;"><i class="icon-pause"></i><fmt:message>label.stop</fmt:message></a>
			<a id="stopForceBtn"    href="javascript:void(0);" class="viewGroup btn btn-m"    				v-on:click="stopForce" style="display: none;"><i class="icon-x"></i><fmt:message>label.stop.force</fmt:message></a>
			<a id="interruptBtn"    href="javascript:void(0);" class="viewGroup btn btn-m"    				v-on:click="interrupt" style="display: none;"><fmt:message>label.interrupt</fmt:message></a>
			<a id="blockBtn" 	    href="javascript:void(0);" class="viewGroup btn btn-m"    				v-on:click="block" style="display: none;"><fmt:message>label.block</fmt:message></a>
			<a id="unblockBtn" 	    href="javascript:void(0);" class="viewGroup btn btn-m"   				v-on:click="unblock" style="display: none;"><fmt:message>label.unblock</fmt:message></a>
			<a id="updateReadyBtn" 	href="javascript:void(0);" class="btn btn-m" 		      				v-on:click="updateReady" style="display: none;"><fmt:message>label.retry</fmt:message></a>
			<a id="updateCancelBtn"	href="javascript:void(0);" class="btn btn-m" 		      				v-on:click="updateCancel" style="display: none;"><fmt:message>label.cancel</fmt:message></a>
			<a id="searchInitBtn" 	href="javascript:void(0);" class="btn btn-m" 		      				v-on:click="initSearchArea" style="display: none;"><i class="icon-reset"></i><span class="hide"><fmt:message>label.initialize</fmt:message></span></a>
			<a id="addBtn"		    href="javascript:void(0);" class="btn btn-m btn-primary"  				v-on:click="goSavePanel" style="display: none;"><i class="icon-plus"></i><span class="hide"><fmt:message>label.insert</fmt:message></span></a>			
		</div>
	</div>

	<div class="empty">
		<p><fmt:message>msg.coditions</fmt:message></p>
		<img src="${prefixFileUrl}/img/empty.svg" class="center-block" alt="">
	</div>
		
	<div class="table-responsive" style="display: none;">
		<div id="ImngSearchGrid"></div>
	</div>		
</div>

<script type="text/javascript">
var listMethodOption = {
    goSavePanel: function () {
        panelOpen('add');
    },
    goNewTab: function () {
    	var info = validateOpenNewTabUrl(location.href);
    	
    	if (!info.isValidate) return false;
    	
        localStorage.setItem(this.$el.id + '-newTabSearchCondition', JSON.stringify(window.vmSearch.$data));

        window.open(info.url);
    },
    newTabSearchGrid: function () {
        if (!localStorage.getItem(this.$el.id + '-newTabSearchCondition')) return false;

        var newTabSearchCondition = JSON.parse(localStorage.getItem(this.$el.id + '-newTabSearchCondition'));

        localStorage.removeItem(this.$el.id + '-newTabSearchCondition');

        window.vmSearch.$nextTick(function () {
        	window.vmSearch.initSearchArea(newTabSearchCondition);
        });

        return true;
    }
};
</script>