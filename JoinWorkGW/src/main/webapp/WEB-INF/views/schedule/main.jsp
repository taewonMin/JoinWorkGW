<%@page import="com.joinwork.emp.dto.EmpVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/fullcalendar/vendor/css/fullcalendar.min.css" />
<%--     <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/fullcalendar/vendor/css/bootstrap.min.css"> --%>
    <link rel="stylesheet" href='<%=request.getContextPath() %>/resources/fullcalendar/vendor/css/select2.min.css' />
    <link rel="stylesheet" href='<%=request.getContextPath() %>/resources/fullcalendar/vendor/css/bootstrap-datetimepicker.min.css' />

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/fullcalendar/css/main.css">
<title></title>
<style>
html, body {
   margin: 0;
   padding: 0;
   font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
   font-size: 14px;
}

#external-events {
   position: fixed;
   z-index: 2;
   top: 20px;
   left: 20px;
   width: 150px;
   padding: 0 10px;
   border: 1px solid #ccc;
   background: #eee;
}

/* .demo-topbar + #external-events { /* will get stripped out */ */
/*    top: 60px; */
/* } */
nav.navbar.navbar-fixed-top{
	border: 0px;
}

#external-events .fc-event {
   cursor: move;
   margin: 3px 0;
}

#calendar-container {
   position: relative;
   z-index: 1;
   margin-left: 200px;
   width: 80%;
}
.fc-event{
   padding-bottom: 5px;
   margin-right: 5px;
   cursor: move;
}

#drag-item{
   float: left;
   width: 20%;
}


.sidebar-scroll{
   padding-left: 10px;
   padding-right: 10px;
}

.panel-body{
   padding: 0px 15px 15px 15px;
}

#type_filter, span.select2-results, .select2-container, .select2-selection, .select2-results__option, .select2-results__options, .select2-type_filter-results, span.select2-dropdown, span.select2-dropdown--below, .groupOption{
   width: 180px;
}

.box-container{
   display: flex;
   justify-content: space-between;
   padding-top: 15px;
}

#getExcelBtn{
   font-size: 1.1em;
   font-weight: bold;
   margin-left: 12px;
}

.text-btn{
   cursor: pointer;
}

.input-group{
   width: 400px;
   margin-left: 0px;
   margin-right: 0px;
}

#searchType, #keywordInput, #searchBtn{
   height: 36px;
} 
#type_filter.select2{
   width: 180px;
}
#commonHeader{
   margin-top: 100px;
}
.privateSp , .commonSp{
   width: 180px;
   font-size: 20px;
    padding: 13px 15px;
}
.fc .fc-view-container .fc-list-view .fc-list-item {
   color:black;
}
#privateSchedule{
   color: #74c0fc; 
   margin: 3px 10px 10px 50px;
    font-size: large;
    float: right;
}
#importantSchedule{
   color: #D25565;
   margin: 3px 10px 10px 50px;
    font-size: large;
    float: right;
}
#deptSchedule{
   color: #b070db;
   margin: 3px 10px 10px 50px;
    font-size: large;
    float: right;
}
#teamSchedule{
   color: #ffa94d;
   margin: 3px 10px 10px 67px;
    font-size: large;
    float: right;
}
#companySchedule{
   color: #a9e34b;
   margin: 3px 10px 10px 50px;
    font-size: large;
    float: right;
}
strong {
   font-size: 1.2em;
}
.scheduleInfo{
   display: flex;
   vertical-align: middle;
   justify-content: space-between;
}
.fc-center h2{
   padding-left: 10px;
}
.theme-blue #wrapper:before, .theme-blue #wrapper:after, .theme-blue:before, .theme-blue:after{
   background: #449cff00;
}
.form-control{
	font-family: S-CoreDream-7ExtraBold;
}
.selectSearchDate{
	height: 36px;
}
#excelInfo:hover{
	text-decoration: none;
	color:#87cefa;
}
nav:before, nav div:before, div:before, ul:before {
	content:none;
}
.navbar-brand{
    margin-left: 0px;
    margin-right: 16px;
    padding: 15px 0;
}
nav.navbar.navbar-fixed-top{
	border-bottom-width: 0px;
}
.navbar-nav>li>a{
    padding-top: 0px;
    padding-bottom: 0px;
}
a{
	text-decoration: none;
	color:#2980b9;
}
button:hover{
	background-color: #87cefa;
}
#zoomDiv{
	position: relative;
	width: 100%;
}
#zoomDiv:before {
	content: "";
	display: block;
 	padding-top: 100%;
}
#zoomContent{
	position: absolute;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
}
.zoomBtn{
	margin: 0 0 0 10px;
}
.metismenu, .metismenu span{
	list-style: none;
    color: #5a5a5a;
}
.metismenu li{
	margin: 5px 0;
}
.popoverTitleCalendar{
	width: 150px;
	border-radius: 4%;
	text-align: center;
}
.popover-header{
	padding: 5px;
	max-width: 170px;
}
.popover-body{
	max-width: 170px;
}
.importantStrong {
	text-align: center;
}
</style>
<body>
<!-- ???????????? -->
<div id="left-sidebar" class="sidebar" style="border-right:2px solid rgb(0,0,0,0.1); margin-top: 50px; left:0px;">
	<div class="sidebar-scroll">
		<div class="tab-content p-l-0 p-r-0 text-align" style="font-size: 25px; ">
			<button type="button"  id="schedule_go_btn" onclick="schedule_go()" style="background-color: #2980b9; color: white; border: 0px; width: 14rem; height: 3.8rem; margin-left: 3.5%; border-radius: 5%; margin-top: 12%; font-family: InfinitySans-RegularA1">??? ??????</button>
		</div>
	      
		<div class="tab-content p-l-0 p-r-0" style="font-size: 25px; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
			?????? ??????
		</div>
		<ul class="main-menu metismenu">
			<li id="li_mySchedule">
				<a href="javascript:event.preventDefault();"  style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="privateSchedule"></i></i> <span>????????????</span></a>
			</li>
			<li id="li_importantSchedule">
				<a href="javascript:event.preventDefault();" class="" style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="importantSchedule"></i> <span>????????????</span></a>
			</li>
		</ul>
		<div id="commonHeader" class="tab-content p-l-0 p-r-0" style="font-size: 25px; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
			?????? ??????
		</div>
		<ul class="main-menu metismenu">
			<li id="li_companySchedule">
				<a href="javascript:event.preventDefault();" class="" style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="companySchedule"></i> <span>????????????</span></a>
			</li>
			<li id="li_deptSchedule">
				<a href="javascript:event.preventDefault();" class="" style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="deptSchedule"></i> <span>????????????</span></a>
			</li>
			<li id="li_teamSchedule">
				<a href="javascript:event.preventDefault();" class="" style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="teamSchedule"></i> <span>?????????</span></a>
			</li>
		</ul>
   </div>
</div>





<!-- ?????? content -->
<div id="main-content">
   <div class="container-fluid">
      <div class="row clearfix">
         <div class="col-12" style="margin-top: 2%;font-family: S-CoreDream-6Bold">
            <h2 style="font-size: 2.3rem;"><i class="fa fa-calendar"></i>&nbsp;?????? ??????</h2>
            <hr>
         </div>
      </div>
      <div class="row clearfix ">
         <div class="col-lg-12 col-md-12">
         	<div class="card">
         		<div class="body schedule_body">
		            <!-- ?????? ?????? ?????? -->
		            <form:form commandName="scheduleFormVO" id="scheduleForm">
		               <h5 style="display:inline-block; font-weight: bold; font-family: S-CoreDream-7ExtraBold">?????? ??????</h5>
		               <div class="alert alert-light" role="alert" style="display:inline-block;padding-top:0;margin-bottom:0; font-family: S-CoreDream-6Bold">
		                  <label class="fancy-checkbox">
		                     <input type="checkbox" ${from eq 'home' ? 'checked':''} id="checkboxSearchDate" class="searchCheck filterCheck" data="selectSearchDate" data-parsley-multiple="checkbox" onchange="changeForm(this);searchSetting(this);"/>
		                     <span>????????????</span>
		                  </label>
		                  <label class="fancy-checkbox">
		                     <input type="checkbox" id="checkboxSearchType" class="searchCheck filterCheck" data="selectSearchType" data-parsley-multiple="checkbox" onchange="changeForm(this);searchSetting(this);"/>
		                     <span>????????????</span>
		                  </label>
		                  <label class="fancy-checkbox">
		                     <input type="checkbox" name="important" id="checkboxImportant" class="searchCheck searchElement filterCheck" data-parsley-multiple="checkbox" value="1" onchange="searchSetting(this);"/>
		                     <span>????????????</span>
		                  </label>
		                  
		                  <!-- ???????????? -->
		                  <button id="resetBtn" type="reset" class="btn btn-default" title="Refresh" style="display: none;"></button>
		                  <label class="searchElement filter" onclick="conditionReset();"  style="cursor: pointer;">
		                     <i class="fa fa-refresh"></i>&nbsp&nbsp?????? ?????? ?????????
		                  </label>
		                  
						  <div class="box float-right" style="font-family: S-CoreDream-7ExtraBold">
							  <p id="getExcelBtn" class="text-btn" onclick="getExcel()">
								  <a class="alert alert-info alert-dismissible" id="excelInfo" href="#" data-toggle="popover" data-trigger="hover" data-placement="left" data-html="true" data-content="???????????? ?????? ??? ?????? ????????? ??????????????? ??????????????? ??? ????????????.<br/>?????? ????????? ??? ?????? ?????? ?????? ????????? ?????????????????????." 
								  style="font-family: InfinitySans-RegularA1;
								      	 padding-right: 16px;
									     padding-top: 7px;
									     padding-bottom: 6px;
									     padding-left: 14px;">
									  <i class="fa fa-download"></i>
									   ?????? ????????????
								  </a>
							  </p>
						  </div>
		               </div>
		                 <div id="keyword" class="box" style="width:350px;">
		                  <div class="input-group row" style="width: 75em;">   
		                     <!-- ?????? ???????????? searchDate ???  searchStart, searchEnd -->
							 <input type="date" value="${not empty today ? today:''}" class="form-control col-md-3 selectSearchDate myConditions searchElement filter  " name="searchStart" id="searchStart"  style="display: none;"/>
							 <input type="date" value="${not empty tomorrow ? tomorrow:''}"  class="form-control col-md-3 selectSearchDate myConditions searchElement filter  " name="searchEnd" id="searchEnd"  style="display: none;"/>
<%-- 							 <input type="date" value="${not empty today ? today:''}" class="form-control col-md-3 selectSearchDate myConditions searchElement filter  " name="searchStart" id="searchStart" onchange="searchSetting(this);" style="display: none;"/> --%>
<%-- 							 <input type="date" value="${not empty tomorrow ? tomorrow:''}"  class="form-control col-md-3 selectSearchDate myConditions searchElement filter  " name="searchEnd" id="searchEnd" onchange="searchSetting(this);" style="display: none;"/> --%>
		                     <!-- ?????????????????? searchType -->
		                     <select class="form-control col-md-2 selectSearchType myConditions searchElement filter  " name="searchType" id="searchType" onchange="searchSetting(this);" style="display: none;">
		                        <option value="">????????????</option>
		                        <option value="S01">????????????</option>
		                        <option value="S02">????????????</option>
		                        <option value="S03">????????????</option>
		                        <option value="S04">?????????</option>
		                     </select>               
		                     <!-- ??????????????? ???????????? searchType -->
		                     <select class="form-control col-md-2 filter" name="searchCondition" id="searchCondition" style="font-family: S-CoreDream-7ExtraBold" >
		                        <option value="tc">??????+??????</option>
		                        <option value="t">????????????</option>
		                        <option value="c">????????????</option>
		                     </select>               
		                     <input  class="form-control col-md-2 filter" type="text" name="searchKeyword" id="keywordInput" placeholder="?????????" onkeypress="checkEnter(searchSetting);event.stopPropagation();" autocomplete="off" style="font-family: S-CoreDream-7ExtraBold"/>
		                     <span class="input-group-append col-me-1">
		                        <button class="btn btn-primary searchElement" type="button" id="searchBtn" onclick="searchSetting(this);"  data-card-widget="search" style="background-color: #2980b9; border-color: #2980b9;">
		                           <i class="fa fa-fw fa-search"></i>
		                        </button>
		                     </span>
							 <button type="button" class="btn btn-primary float-left zoomBtn" style="font-family: S-CoreDream-4Regular" onclick="zoomIn();"><i class="icon-magnifier-add"></i>&nbsp;??????</button>
	            			 <button type="button" class="btn btn-primary float-left zoomBtn" style="font-family: S-CoreDream-4Regular" onclick="zoomOut();"><i class="icon-magnifier-remove"></i>&nbsp;??????</button>
		                  </div>
		               </div> 
		               <form:hidden path="scheduleCommand.searchKeyword"/>     
		               <form:hidden path="scheduleCommand.searchCondition"/>     
		               <form:hidden path="scheduleCommand.searchImportant"/>     
		               <form:hidden path="scheduleCommand.searchType"/>     
		            </form:form>
		            <div id="zoomDiv">
		            	<div id="zoomContent">
				            <div class="card mb-4" style="font-family: S-CoreDream-4Regular">
				                  <div id="wrapper">
				                      <div id="loading"></div>
				                      <div id="calendar" style="font-family: S-CoreDream-4Regular"></div>
				                  </div>
				             </div>
		            	</div>
		            </div>
		            <!-- /.container -->
		<!--             </div> -->
		         </div>
		      </div>
      		</div>
       	</div>
   </div>
</div>


<form id="excelForm" name="excelForm" method="post" enctype="multipart/form-data">
	<!-- ?????? ?????? ???????????? ????????? -->
	<input type="hidden" id="startForExcel" name="start" />
	<input type="hidden" id="endForExcel" name="end" />
</form>


<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/moment.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/fullcalendar.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/ko.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/select2.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/bootstrap-datetimepicker.min.js"></script>

<script src="<%=request.getContextPath() %>/resources/js/common.js"></script>

<script src="<%=request.getContextPath() %>/resources/fullcalendar/js/addEvent.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/js/etcSetting.js"></script>
 


<script> // ?????? ??????
//??????, ????????? ?????? ?????? ?????? ???????????? ??????
var viewStart = ''; // ?????? ?????? ?????? ??????
var viewEnd = '';
var setCondition = '';
var setKeyword = '';
var setType = '';
var searchDate = ''; // ???????????? ???????????? ??????
var searchStart = '';
var searchEnd = '';
var setTimezone = '';
var setImportant = '';
var setCallback;
var loginId = '<%=((EmpVO)request.getSession().getAttribute("loginUser")).getEmpId()%>';

$('.filterCheck').on('change',function(){
	filtering();
});

function popoverSchedule(event){
// 	alert('????????? ??????')

}

</script>


<script> // main.js
var inputDate = moment();
//var draggedEventIsAllDay;
var activeInactiveWeekends = true;
// myCalendar();

// function myCalendar(date){
	
// $('#calendar').fullCalendar({
var calendar = $('#calendar').fullCalendar({

 /** ******************
   *  OPTIONS	
   * *******************/
  locale                    : 'ko',    
  timezone                  : "local", 
  nextDayThreshold          : "09:00:00",
  allDaySlot                : false,
  displayEventTime          : true,
  displayEventEnd           : true,
  firstDay                  : 0, //???????????? ?????? ?????? ????????? 1
  weekNumbers               : false,
  selectable                : true,
  weekNumberCalculation     : "ISO",
  eventLimit                : true,
  showNonCurrentDates		: true, // ?????? ?????? ????????? ????????? ??? ????????? ?????? (?????? true)
  views                     : { 
                                month : { eventLimit : 12 } // ??? ????????? ?????? ????????? 12???, ???????????? + ?????????
                              },
  eventLimitClick           : 'popover', 
  navLinks                  : true,
  defaultDate               : inputDate, 
  timeFormat                : 'HH:mm',
  defaultTimedEventDuration : '01:00:00',
  editable                  : true,
  minTime                   : '00:00:00',
  maxTime                   : '24:00:00',
  slotLabelFormat           : 'HH:mm',
  weekends                  : true,
  nowIndicator              : true,
  dayPopoverFormat          : 'MM/DD dddd',
  longPressDelay            : 0,
  eventLongPressDelay       : 0,
  selectLongPressDelay      : 0,  
  header                    : {
                                left   : 'today, prevYear, nextYear',
                                center : 'prev, title, next',
                                right  : 'month, agendaWeek, agendaDay, listWeek'
                              },
  views                     : {
                                month : {
                                  columnFormat : 'dddd'
                                },
                                agendaWeek : {
                                  columnFormat : 'M/D ddd',
                                  titleFormat  : 'YYYY??? M??? D???',
                                  eventLimit   : false
                                },
                                agendaDay : {
                                  columnFormat : 'dddd',
                                  eventLimit   : false
                                },
                                listWeek : {
                                  columnFormat : ''
                                 ,textColor : '#000000'     
                                }
                              },
  visibleRange : function(searchDate){
	return{
		 start: searchDate.clone().subtract(1,'days')
		,end  : searchDate.clone().add(3,'days')
	}
  },


  eventRender: function (event, element, view) {
     var important = event.important;
     var popImportant = '';
     if(important == 'true'){
        popImportant = '<p class="importantStrong"><strong>??????????????</strong></p>';
     }
     
     popoverSchedule(element);
     
     var content = event.description;
     if(!content) content = "?????? ??????";
     var id = event._id;
     
    //????????? hover??? ??????
    $(element).popover({
		title: $('<div />'
		      ,{class: 'popoverTitleCalendar'
		         ,text: event.title}).css({'background': event.backgroundColor
		         							,'color': event.color
		         							,'padding': "15px"
		         							,'margin':"-5px"
		         							,"width":"170px"})
		,content: $('<div />'
		        ,{class: 'popoverInfoCalendar'})
		              .append(popImportant)
		              .append('<p><strong>??????:</strong> ' + getDisplayEventDate(event) + '</p>')
		              .append('<div class="popoverDescCalendar" ><strong>??????:</strong> ' + content + '</div>')
		,delay: { show: "300"
		       ,hide: "50"}
		,trigger: 'hover'
		,placement: 'top'
		,html: true
		,container: 'body'
//     });
    }).popover('show');

    
    
    return true;
  },

	/* ****************
	 *  ?????? ????????? 
	 * ************** */
	events: function (start, end, timezone, callback) {
		viewStart = moment(start).format('YYYY-MM-DD');
		viewEnd = moment(end).format('YYYY-MM-DD');
		setTimezone = timezone;
		setCallback = callback;
		
// 		console.log('?????? ?????? ??? Date (start - end, moment??? ????????? ???)------');
// 		console.log(viewStart);
// 		console.log(viewEnd);
// 		console.log(moment(viewStart).format('YYYY-MM-DD'));
// 		console.log(moment(viewEnd).format('YYYY-MM-DD'));
// 		console.log('?????? ?????? ??? Date END------');
		
		var dateData;
		if(searchStart){
			dateData = {
			// ????????? ????????? Date ????????? start, end ??? ?????????
				 start : moment(searchStart).format('YYYY-MM-DD')
				,end   : moment(searchEnd).format('YYYY-MM-DD')
				,username : loginId
				,searchType:setType
				,searchCondition:setCondition
				,searchKeyword:setKeyword
				,searchImportant:setImportant
				
			};
		}else{
			dateData = {
			// ????????? ????????? Date ????????? start, end ??? ?????????
				 start : moment(start).format('YYYY-MM-DD')
				,end   : moment(end).format('YYYY-MM-DD')
				,username : loginId
				,searchType:setType
				,searchCondition:setCondition
				,searchKeyword:setKeyword
				,searchImportant:setImportant
				
			};
		}
// 		console.log("--- dateData ---");
// 		console.log(dateData);
// 		console.log("searchImportant >> " + setImportant);
// 		console.log("--- dateData end ---");
		 
		$.ajax({
			 type: "POST"
			,url: "list"
			,data:JSON.stringify(dateData)
			,dataType:"json"
			,contentType:"application/json;charset=utf-8"     
			,success: function (response) {
//         console.log(response);
				var fixedDate = response.map(function (array) {
					if (array.allDay && array.start !== array.end) {
						array.end = moment(array.end).add(1, 'days'); // ?????? ?????? AllDay ????????? ?????? ????????? ????????? ????????? ????????? ????????????
					}
					return array;
				});
				callback(fixedDate); 
			}
			,error: function(request, status, error){
				console.log("???????????? >> " + request + " , " + status + "," + error);
			}
		});
	
	},
  
  
	eventAfterAllRender: function (view) {
		if (view.name == "month") $(".fc-content").css('height', 'auto');
	},
	

     //?????? ???????????? ????????????
//      eventResize: function (event, delta, revertFunc, jsEvent, ui, view) {
//        $('.popover.fade.top').remove();

//        /** ??????????????? ????????? ????????????
//         * ????????? ?????? ??????????????? ?????????. */
//        var newDates = calDateWhenResize(event);

//        //??????????????? ?????? ????????????
//        $.ajax({
//          type: "get",
//          url: "",
//          data: {
//            //id: event._id,
//            //....
//          },
//          success: function (response) {
//            alert('??????: ' + newDates.startDate + ' ~ ' + newDates.endDate);
//          }
//        });

//      },

   //  eventDragStart: function (event, jsEvent, ui, view) {
//       draggedEventIsAllDay = event.allDay;
   //  },

     //?????? ??????????????????
      eventDrop: function (event, delta, revertFunc, jsEvent, ui, view) {
       $('.popover.fade.top').remove();

       //???,??? view?????? ?????? <-> ?????? ????????????
//        if (view.type === 'agendaWeek' || view.type === 'agendaDay') {
//         if (draggedEventIsAllDay !== event.allDay) {
//           alert('???????????????????????? ??????<->?????? ????????? ???????????????.');
//           location.reload();
//           return false;
//         }
//        }

       // ????????? ????????? ????????????
       var newDates = calDateWhenDragnDrop(event);
//        console.dir(event);
//        console.dir(newDates);
       
        var selectGroup = '';
		switch(event.type){
			case '????????????':
				selectGroup = 'S01';
				break;
			case '????????????':
				selectGroup = 'S02';
				break;
			case '????????????':
				selectGroup = 'S03';
				break;
			case '?????????':
				selectGroup = 'S04';
				break;
		}
   	
       
       var eventData = {   
			_id:event._id
			,start:newDates.startDate
			,end:newDates.endDate
			,type:selectGroup
       }
       
//        console.log(selectGroup);

       if(confirm(newDates.startDate + ' ~ ' + newDates.endDate + ' ?????????\n????????? ?????? ???????????????????')){
    	   
	       //????????? ?????? ????????????
	        $.ajax({
		    	type:"post"
		    	,url:"<%=request.getContextPath()%>/schedule/modify" 
		    	,data:JSON.stringify(eventData)
		    	,dataType:"json"
		   		,contentType:"application/json;charset=utf-8"
		    	,success:function(response){
					if(selectGroup == 'S02'){
						$(response.empList).each(function(index, item){
							var empId = item.empId;
// 							console.log(empId);
							(function(index, item){
								sendMessage('${pageContext.request.contextPath}',
											empId,
											'?????? ????????? ?????????????????????. ??????????????????.',
											event.title,
											'${pageContext.request.contextPath}/schedule/detail?scheduleId='+response.scheduleId,
											'????????????');
							})(index, item);
						});
					}else if(selectGroup == 'S03'){
						$(response.empList).each(function(index, item){
							var empId = item.empId;
		// 					console.log(empId);
							(function(index, item){
								sendMessage('${pageContext.request.contextPath}',
											empId,
											'?????? ????????? ?????????????????????. ??????????????????.',
											event.title,
											'${pageContext.request.contextPath}/schedule/detail?scheduleId='+response.scheduleId,
											'????????????');
							})(index, item);
						});
					}else if(selectGroup == 'S04'){
						$(response.empList).each(function(index, item){
							var empId = item.empId;
// 							console.log(empId);
							(function(index, item){
								sendMessage('${pageContext.request.contextPath}',
											empId,
											'??? ????????? ?????????????????????. ??????????????????.',
											event.title,
											'${pageContext.request.contextPath}/schedule/detail?scheduleId='+response.scheduleId,
											'????????????');
							})(index, item);
						});
					}
					
					alert('????????? ?????????????????????.');
	// 				window.location.reload(true);
		    	}
		    	,error:function(request, status, error){
		    		console.log("error ?????? >> " + request +", "+ status+", "+error);
		    	}
		    });
       }else{
    	   window.location.reload(true);
       }

     },

     select: function (startDate, endDate, jsEvent, view) {

       $(".fc-body").unbind('click');
       $(".fc-body").on('click', 'td', function (e) {
          //alert('fc-body ??????');
//           e.jsEvent.preventDefault();
          
          var sendStart = moment(startDate).format('YYYY-MM-DDTHH:mm');
          var sendEnd = moment(endDate).format('YYYY-MM-DDTHH:mm');
          
          OpenWindow('registForm?start='+sendStart+'&end='+sendEnd,'????????????','675','700');
          
       });
       $("#scheduleForm").trigger("click");	

       var today = moment();

       if (view.name == "month") {
         startDate.set({
           hours: today.hours(),
           minute: today.minutes()
         });
         startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
         endDate = moment(endDate).subtract(1, 'days');

         endDate.set({
           hours: today.hours() + 1,
           minute: today.minutes()
         });
         endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
       } else {
         startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
         endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
       }
       
		return false;
     },
     
     //????????? ????????? ???????????? ???????????????
     eventClick: function (event, jsEvent, view) {
      //alert('????????? ?????? >> ' + event);
      jsEvent.preventDefault();
      OpenWindow('detail?scheduleId='+event._id,'?????? ????????????','700','715');
//       event.stopPropagation();

      return false;
      
     }

   });

   function getDisplayEventDate(event) {

      var displayEventDate;
      
      var startTimeEventInfo = moment(event.start).format('HH:mm');
      var endTimeEventInfo = moment(event.end).format('HH:mm');
      displayEventDate = startTimeEventInfo + " - " + endTimeEventInfo;

      return displayEventDate;
   }


	function filtering(){

		calendar.fullCalendar('refetchEvents');
		gotoDate(searchStart);
	}
	
	// ?????? ????????? ??????
	function gotoDate(toDate){
		if(toDate){
			calendar.fullCalendar('gotoDate', moment(toDate).format('YYYY-MM'));
		}else{
			calendar.fullCalendar('gotoDate', moment().format('YYYY-MM'));
		}
	}

   function calDateWhenResize(event) {

     var newDates = {
       startDate: '',
       endDate: ''
     };

       newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
       newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');

     return newDates;
   }

   function calDateWhenDragnDrop(event) {
     // ????????? ????????? ????????????
     var newDates = {
       startDate: '',
       endDate: ''
     }

     // ?????? & ????????? ?????? ?????? ??????
     if(!event.end) {
       event.end = event.start;
     }

      newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
      newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');

     return newDates;
   }
// }
//------------------------------------------------------ ?????? main.js ??? -------------------------------------------------------
</script>
             
<script>
// ???????????? ??? ?????? ??????
function schedule_go(){
	
    OpenWindow('registForm','????????????','675','700');
   
}

// ?????????????????? ???????????? ?????? hidden??? ??????
function searchSetting(searchOptions){ 
	setKeyword = $('#keywordInput').val();
	setCondition = $('#searchCondition option:selected').val();
	var typeCheckBox = $('#checkboxSearchType').is(':checked');
	if(typeCheckBox == false){
		setType = '';
	}
	
	setType = $('#searchType option:selected').val();
	setImportant = $('#checkboxImportant').is(':checked');
	if(setImportant == false){
		setImportant = '';
	}
	
	searchDate = $('#checkboxSearchDate').is('checked'); // true false
	searchStart = $('#searchStart').val();
	searchEnd = $('#searchEnd').val();
	
	$('#calendar').fullCalendar('gotoDate', '2021-03');
	filtering();
}

//?????? ?????? ?????? ??????
function changeForm(obj){
	var searchCri = $(obj).attr('data');
	
	if($(obj).is(':checked')==true){
		$('.'+searchCri).css('display','');
	}else{
		$('.'+searchCri).css('display','none');
		$('.'+searchCri).val('');
	}
}

//???????????? ?????????
function conditionReset() {
	$("#resetBtn").click();
	$('.myConditions').css("display","none");
	$('input[name="searchKeyword"]').val("");
	$('#checkboxSearchDate').removeAttr('checked');
	$('#searchStart').val('');
	$('#searchEnd').val('');
	searchStart = '';
	searchEnd = '';
	setType = '';
	setCondition = '';
	setImportant = false;
	
	filtering();
}

//?????? ????????????
function getExcel(){
// 	alert("getExcel click");
	$('#startForExcel').val(searchStart);
	$('#endForExcel').val(searchEnd);
	$('#typeForExcel').val(setType);
	$('#importantForExcel').val(setImportant);
	
// 	console.log("?????? ?????? ??? ????????? ?????? >> " + viewStart + " ~ " + viewEnd);
	
	var excelForm = $('<form></form>');
	
	excelForm.attr("name","excelForm");
	excelForm.attr("method","post");
	excelForm.attr("action","<%=request.getContextPath()%>/schedule/getExcel");
	
	
	if(searchStart && searchEnd){
		excelForm.append($('<input/>',{type:"hidden", name:"start", value:searchStart}));
		excelForm.append($('<input/>',{type:"hidden", name:"end", value:searchEnd}));
		excelForm.append($('<input/>',{type:"hidden", name:"username", value:loginId}));
	}else{
		excelForm.append($('<input/>',{type:"hidden", name:"start", value:viewStart}));
		excelForm.append($('<input/>',{type:"hidden", name:"end", value:viewEnd}));
		excelForm.append($('<input/>',{type:"hidden", name:"username", value:loginId}));
	}

	excelForm.appendTo('body');
	
	excelForm.submit();
}

window.onload = function(){
// 	searchSetting();
	
	//????????? ????????? ??????????????? ?????????
	if('${from}' && $("#searchStart").val()){
		changeForm($("#checkboxSearchDate"));
		searchSetting();
		setTimeout(function(){
			$(".fc-day[data-date="+$("#searchStart").val()+"]")[0].scrollIntoView();
			history.pushState(null, null, "/JoinWorkGW/schedule/main");//?????? ?????? ????????? ???????????? ?????????

		},200)
	
	}else{
		$("#searchStart").val('');
		$("#searchEnd").val('');
	}
}

var nowZoom = 100;
function zoomOut(){
	nowZoom = nowZoom - 10;
	if(nowZoom > 100 ) nowZoon = 150;
	zooms();
}

function zoomIn(){
	nowZoom = nowZoom + 10;
	if(nowZoom < 50) nowZoom = 50;
	zooms();
}

function zooms(){
	$('#zoomDiv').css('width', nowZoom+'%');
	if(nowZoom > 100){
		alert('??? ?????? ????????? ??? ????????????.');
		nowZoom = 100;
		$('#zoomDiv').css('width', nowZoom+'%');
		return;
	}
	if(nowZoom < 50){
		alert('??? ?????? ????????? ??? ????????????.');
		nowZoom = 50;
		$('#zoomDiv').css('width', nowZoom+'%');
		return;
	}
	
}

</script>







</body>