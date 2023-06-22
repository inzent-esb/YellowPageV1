<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
/* days Of Week */
var weekMon = "<fmt:message>label.date.mon</fmt:message>";
var weekThes = "<fmt:message>label.date.tue</fmt:message>";
var weekWednes = "<fmt:message>label.date.wed</fmt:message>";
var weekThur = "<fmt:message>label.date.thu</fmt:message>";
var weekFri = "<fmt:message>label.date.fri</fmt:message>";
var weekSatur = "<fmt:message>label.date.sat</fmt:message>";
var weekSun = "<fmt:message>label.date.sun</fmt:message>";

/* month Names */
var monthJanuary = "<fmt:message>label.date.january</fmt:message>";
var monthFebruary = "<fmt:message>label.date.february</fmt:message>";
var monthMarch = "<fmt:message>label.date.march</fmt:message>";
var monthApril = "<fmt:message>label.date.april</fmt:message>";
var monthMay = "<fmt:message>label.date.may</fmt:message>";
var monthJune = "<fmt:message>label.date.june</fmt:message>";
var monthJuly = "<fmt:message>label.date.july</fmt:message>";
var monthAugust = "<fmt:message>label.date.august</fmt:message>";
var monthSeptember = "<fmt:message>label.date.september</fmt:message>";
var monthOctober = "<fmt:message>label.date.october</fmt:message>";
var monthNovember = "<fmt:message>label.date.november</fmt:message>";
var monthDecember = "<fmt:message>label.date.december</fmt:message>";

/* button */
var okBtn = "<fmt:message>label.ok</fmt:message>";
var closeBtn = "<fmt:message>label.close</fmt:message>";
var cancelBtn = "<fmt:message>label.cancel</fmt:message>";
var searchBtn = "<fmt:message>label.search</fmt:message>";

/* msg */
var validateToken = "<fmt:message>msg.validateToken</fmt:message>";
var loadDataWarn = "<fmt:message>msg.load.data.warn</fmt:message>";
var totalCountLabel = function(value) {
	return '<fmt:message key="label.totalCount"><fmt:param value="'+ numberWithComma(value) +'"/></fmt:message>'
};
	
/* time Names */
var timeHour = "<fmt:message>label.hours.before</fmt:message>";
var timeMinute = "<fmt:message>label.minutes.before</fmt:message>";
var timeSecond = "<fmt:message>label.seconds.before</fmt:message>";

</script>