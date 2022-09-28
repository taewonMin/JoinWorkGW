<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

setInterval(getDefferTime,1000);
/*받은 밀리세컨즈를 조건에 맞게 계산해서 시간으로 출력*/


var defferTime = 0;
var excessFlag = false;
function getDefferTime(){
   var oneSecMilliSec = (1000);
   var str = "";
   if(!defferTime){
      defferTime = parseInt($("#weeklyDefferTime").attr("value"))
   }
   
   if('${attendenceVO.excessYN}' === 'Y'){
      excessFlag = true;
   }
   
   //초과 근무 x
   if(excessFlag == false){
      defferTime -= oneSecMilliSec;
      
      //남은 근무시간이 -가 되면
      if(defferTime <= 1000){
         excessFlag = true;
      }
      
      var defferHours = Math.floor((defferTime/(1000*60*60)));
      var tempHours  = defferHours*(1000*60*60);
      var defferMinutes  = Math.floor((((defferTime-tempHours) / (1000*60)) % 60));
      
      str = defferHours+"시간 "+defferMinutes+"분";
      $("#weeklyDefferTime").html(str);
   }else{//초과근무 o
      defferTime += oneSecMilliSec;
      var defferHours = Math.floor((defferTime/(1000*60*60)) % 24);
      var tempHours  = defferHours*(1000*60*60);
      var defferMinutes  = Math.floor((((defferTime-tempHours) / (1000*60)) % 60));
      
      str = defferHours+"시간 "+defferMinutes+"분";
      $("#weeklyDefferTime").html("0시간 0분");
      if(!$("span").hasClass("excessTime")){
         var tag = "";
         tag += "<br><span class='badge badge-info'>초과근무 중</span><br><span class='excessTime'></span>"
         $(".attendTime").append(tag);      
      }
      $(".excessTime").html(str);
      
   }
}

//업무게시판 사진
getPicture();
function getPicture(){
   if($("div").hasClass("dutyManagerEmpImg")){
      for(var i = 0; i < $(".dutyManagerEmpImg").length; i++){
         var empId = $(".dutyManagerEmpImg").eq(i).attr("value");
         var imageURL = "/JoinWorkGW/emp/getPicture?picture="+empId+".jpg";
         $(".dutyManagerEmpImg").eq(i).css({'background-image':'url('+imageURL+')',
            'background-position':'center',
            'background-size':'cover',
            'background-repeat':'no-repeat'
         }).trigger("create");
      }
   }
   if($("div").hasClass("dutyEmpImg")){
      for(var i = 0; i < $(".dutyEmpImg").length; i++){
         var empId = $(".dutyEmpImg").eq(i).attr("value");
         var imageURL = "/JoinWorkGW/emp/getPicture?picture="+empId+".jpg";
         $(".dutyEmpImg").eq(i).css({'background-image':'url('+imageURL+')',
            'background-position':'center',
            'background-size':'cover',
            'background-repeat':'no-repeat'
         }).trigger("create");
      }
   }
   
}




<!-- 스케줄러 -->

var calendar = $('#calendar').fullCalendar({
     locale                    : 'ko',    
     timezone                  : "local", 
     nextDayThreshold          : "09:00:00",
     allDaySlot                : false,
     displayEventTime          : true,
     displayEventEnd           : true,
     firstDay                  : 0, //월요일이 먼저 오게 하려면 1
     weekNumbers               : false,
     selectable                : false,
     weekNumberCalculation     : "ISO",
     eventLimit                : true,
     views                     : { 
                                   month : { eventLimit : 12 } // 한 날짜에 최대 이벤트 12개, 나머지는 + 처리됨
                                 },
     eventLimitClick           : 'week', //popover
     navLinks                  : true,
     defaultDate               : moment(), 
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
     dayClick: false,
     header: {
         left: 'prev,today,next'
         ,center: ''
         ,right: 'title'
     },
       
     eventAfterRender: function () {
         // add titles to "+# more links"
         $('.fc-more-cell a').each(function () {
             this.title = this.textContent;
         });
     },

     // add event name to title attribute on mouseover
     eventMouseover: function (event, jsEvent, view) {
         if (view.name !== 'agendaDay') {
             $(jsEvent.target).attr('title', event.title);
         }
     },
     eventClick:function(e){
        alert(e.title+" "+e.url);
     },
     editable: false,
     eventLimit: true // allow "more" link when too many events
   });

//날짜 선택 불가능 
$(".fc-prev-button").click(function(){
   $(".fc-day-number").removeAttr("data-goto");
   countMonthSchedule();
   $(".fc-scroller").css("overflow","");
   $(".fc-scroller").css("height","");
   $(".fc-widget-header").css("margin","");
});
$(".fc-today-button").click(function(){
   $(".fc-day-number").removeAttr("data-goto");
   countMonthSchedule();
   $(".fc-scroller").css("overflow","");
   $(".fc-scroller").css("height","");
   $(".fc-widget-header").css("margin","");
});
$(".fc-next-button").click(function(){
   $(".fc-day-number").removeAttr("data-goto");
   countMonthSchedule();
   $(".fc-scroller").css("overflow","");
   $(".fc-scroller").css("height","");
   $(".fc-widget-header").css("margin","");
});



//날짜 클릭시 이벤트
$(document).on("click",".fc-day-top",function(){
   var $date = $(this);
   var clickDate = $date.attr("data-date");
   insertDayName($date.attr("data-date"));
   $(".myShowHiddenDiv").remove();
   $("td").removeClass("fc-highlight");
   $date.addClass("fc-highlight");
   
   
   $.ajax({
      type:"POST",
      url:"<c:url value='getScheduleList' />",
      contentType:"application/json",
      async: false,
      data: clickDate,
      processData:true,
      success: function(data) {
         var scheduleList1 = data.scheduleList1;
         var scheduleList2 = data.scheduleList2;
         var scheduleList3 = data.scheduleList3;
         var str1 = "";
         var str2 = "";
         var str3 = "";
         var preStr1 = "";
         var preStr2 = "";
         var preStr3 = "";
         preStr1 += '<div class="myShowHiddenDiv col-12"><span class="float-right"><span style="background-color: pink; border-radius: 50%;padding: 0 5px 0 5px; margin-right: 3px;" >'+scheduleList1.length+'</span><span class="showHiddenBtn" style="cursor: pointer;"><i class="fa fa-plus"></i></span></span></div>';
         preStr2 += '<div class="myShowHiddenDiv col-12"><span class="float-right"><span style="background-color: pink; border-radius: 50%;padding: 0 5px 0 5px; margin-right: 3px;" >'+scheduleList2.length+'</span><span class="showHiddenBtn" style="cursor: pointer;"><i class="fa fa-plus"></i></span></span></div>';
         preStr3 += '<div class="myShowHiddenDiv col-12"><span class="float-right"><span style="background-color: pink; border-radius: 50%;padding: 0 5px 0 5px; margin-right: 3px;" >'+scheduleList3.length+'</span><span class="showHiddenBtn" style="cursor: pointer;"><i class="fa fa-plus"></i></span></span></div>';
         
         
         if(scheduleList1.length > 0){
            for(var i = 0; i < scheduleList1.length; i++){
               if(i < 1){
                  str1 += "<div><strong style='display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'><i class='fa fa-check-circle'></i>"+scheduleList1[i].scheduleTitle+"</strong><br><span>"+scheduleList1[i].scheduleStartDt+" ~ "+scheduleList1[i].scheduleEndDt+"</span><br><br></div>";
               
               }
               if(i >= 1){
                  str1 += "<div class='hiddenSchedule' style='display:none;'><strong style='display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'><i class='fa fa-check-circle'></i>"+scheduleList1[i].scheduleTitle+"</strong><br><span>"+scheduleList1[i].scheduleStartDt+" ~ "+scheduleList1[i].scheduleEndDt+"</span><br><br></div>";
               }
            }
         }else{
            str1 = '<tr><td colspan="6" style="text-align: center;"><strong>해당 일정이 존재하지 않습니다.</strong></td></tr>';
         }
         
         if(scheduleList2.length > 0){
            for(var i = 0; i < scheduleList2.length; i++){
               if(i < 1){
                  str2 += "<div><strong style='display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'><i class='fa fa-check-circle'></i>"+scheduleList2[i].scheduleTitle+"</strong><br><span>"+scheduleList2[i].scheduleStartDt+" ~ "+scheduleList2[i].scheduleEndDt+"</span><br><br></div>";
               }
               if(i >= 1){
                  str2 += "<div class='hiddenSchedule' style='display:none;'><strong style='display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'><i class='fa fa-check-circle'></i>"+scheduleList2[i].scheduleTitle+"</strong><br><span>"+scheduleList2[i].scheduleStartDt+" ~ "+scheduleList2[i].scheduleEndDt+"</span><br><br></div>";
               }
               
            }
         }else{
            str2 = '<tr><td colspan="6" style="text-align: center;"><strong>해당 일정이 존재하지 않습니다.</strong></td></tr>';
         }
         
         if(scheduleList3.length > 0){
            for(var i = 0; i < scheduleList3.length; i++){
               if(i < 1){
                  str3 += "<div><strong style='display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'><i class='fa fa-check-circle'></i>"+scheduleList3[i].scheduleTitle+"</strong><br><span>"+scheduleList3[i].scheduleStartDt+" ~ "+scheduleList3[i].scheduleEndDt+"</span><br></div>";
               }
               if(i >= 1){
                  str3 += "<div class='hiddenSchedule' style='display:none;'><strong style='display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'><i class='fa fa-check-circle'></i>"+scheduleList3[i].scheduleTitle+"</strong><br><span>"+scheduleList3[i].scheduleStartDt+" ~ "+scheduleList3[i].scheduleEndDt+"</span><br></div>";
               }
            }
         }else{
            str3 = '<tr><td colspan="6" style="text-align: center;"><strong>해당 일정이 존재하지 않습니다.</strong></td></tr>';
         }
         
         $(".list1").prepend(preStr1);
         $(".list2").prepend(preStr2);
         $(".list3").prepend(preStr3);
         $(".scheduleList1").html(str1);
         $(".scheduleList2").html(str2);
         $(".scheduleList3").html(str3);
      }
      
   });
})

//숨겨진 나머지 스케쥴 나오는 함수
$(document).on("click",".showHiddenBtn",function(){
   console.log($(this).find("i"));
   if(!$(this).hasClass("myBlock")){
      $(this).parent().parent().parent().find(".hiddenSchedule").css("display","block");
      $(this).addClass("myBlock");
      $(this).find("i").removeClass();
      $(this).find("i").addClass("fa fa-minus");
      return false;
   }
   
   
   if($(this).hasClass("myBlock")){
      $(this).parent().parent().parent().find(".hiddenSchedule").css("display","none");
      $(this).removeClass("myBlock");
      $(this).find("i").removeClass();
      $(this).find("i").addClass("fa fa-plus");
      return false;
   }
   
});
   




insertDayName();
function insertDayName(date){
   var week = new Array('일', '월', '화', '수', '목', '금', '토'); 
   var today;
   var year;
   var month;
   var day;
   var dayName;
   
   //처음 로딩시 
   if(!date){
      today = new Date();
      day = today.getDate();
      dayName = week[today.getDay()];
      
      $(".oneDate").html(day);
      $(".oneDayName").html(dayName);
      
      today.setDate(today.getDate() + 1);
      day = today.getDate();
      dayName = week[today.getDay()];
      $(".twoDate").html(day);
      $(".twoDayName").html(dayName);
      
      today.setDate(today.getDate() + 1);
      day = today.getDate();
      dayName = week[today.getDay()];
      $(".threeDate").html(day);
      $(".threeDayName").html(dayName);
   }else{
      //일정 클릭시
      today = new Date(date);
      day = today.getDate();
      dayName = week[today.getDay()];
      
      $(".oneDate").html(day);
      $(".oneDayName").html(dayName);
      
      today.setDate(today.getDate() + 1);
      day = today.getDate();
      dayName = week[today.getDay()];
      $(".twoDate").html(day);
      $(".twoDayName").html(dayName);
      
      today.setDate(today.getDate() + 1);
      day = today.getDate();
      dayName = week[today.getDay()];
      $(".threeDate").html(day);
      $(".threeDayName").html(dayName);
   }
   
}


//월별 일정 갯수를 가져와주는 함수
//개발을 위해 잠시 주석 (너무  느림)
// countMonthSchedule();
function countMonthSchedule(){
   var dayLength = $(".fc-day-top").length;
   var dayArr = [];
   
   for(var i = 0; i < dayLength; i++){
      var clickDate = $(".fc-day-top").eq(i).attr("data-date");
      dayArr.push(clickDate);
   }
   
   $.ajax({
      type:"POST",
      url:"<c:url value='getScheduleListCnt' />",
      contentType:"application/json",
      async: false,
      data: JSON.stringify(dayArr),
      processData:true,
      success: function(data) {
         console.log(data);
         for(var i = 0; i < data.length; i++){
            if(data[i].cnt != 0){
               var str = "";
               str += "<i class='fa fa-circle ' style='color: pink;'></i>"; 
               $(".fc-day-top").eq(i).append(str);
            }
         }
      }
   });

}



<!-- 날씨 -->
$(document).ready(function(){
    let weatherIcon = {
            '01' : 'wi wi-day-sunny',
            '02' : 'wi wi-day-cloudy',
            '03' : 'wi wi-cloud',
            '04' : 'wi wi-cloud',
            '09' : 'wi wi-day-rain-wind',
            '10' : 'wi wi-rain',
            '11' : 'wi wi-thunderstorm',
            '13' : 'wi wi-snow',
            '50' : 'wi wi-fog'
        };
    $.ajax({
        url: 'http://api.openweathermap.org/data/2.5/weather?q=Daejeon&appid=ed02097d34cd1177020c9fc159bdb3f8&units=metric',
        dataType: 'json',
        type: 'GET',
        success: function(data){
           var $Icon = (data.weather[0].icon).substr(0,2);
            var $Temp ='<span>' + Math.floor(data.main.temp) + ' <i class="wi wi-celsius"></i></span>';
            var $city = "대전"; 
			if($Icon == '01'){
	            $('.CurrIcon').append('<span class="float-left" style="cursor:pointer;margin-right: 40px; "><i class="fa fa-chevron-left "></i></span><i style="color:#FF4000;" class="' + weatherIcon[$Icon] +'"></i>'); 
			}else{
	            $('.CurrIcon').append('<span class="float-left" style="cursor:pointer;margin-right: 40px; "><i class="fa fa-chevron-left"></i></span><i  class="' + weatherIcon[$Icon] +'"></i>'); 
			}
            $('.CurrTemp').prepend($Temp+'<span class="float-right" style="cursor:pointer;margin-left: 40px;"><i class="fa fa-chevron-right"></i></span>'); 
            $('.City').append($city);

        }
    })
});






<!-- 캘린더 css 스크립트 -->
$(".fc-scroller").css("overflow","");
$(".fc-scroller").css("height","");
$(".fc-widget-header").css("margin","");

    