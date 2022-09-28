<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 결재문서 시작 -->
			<table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 1px; border-collapse: collapse;"><!-- Header --><colgroup><col width="310"><col width="490"></colgroup>
				<tbody>
					<tr>
						<td style="padding: 0px !important; border: 0px currentColor; height: 90px; text-align: center; color: black; font-size: 36px; font-weight: bold; vertical-align: middle;" colspan="2" class="dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
							
							휴가 신청서<br><br>
						</td>
					</tr>
					<tr>
					
<td style=" padding: 0px !important; border: currentColor; text-align: left; color: black; font-size: 12px; font-weight: normal; vertical-align: top;">
							
			<table style="border: 1px solid rgb(0, 0, 0); font-family: malgun gothic,dotum,arial,tahoma; margin-top: 1px; border-collapse: collapse;"><!-- User --><colgroup><col width="90"><col width="220"></colgroup>
				<tbody>
					<tr>
						<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
							
			작성일
						</td>
						<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
							<div contenteditable="false" id="recommandDate">기안일</div>
						</td>
					</tr>
					<tr>
						<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
							
			신청자
						</td>
						<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
							<div contenteditable="false" id="empName">기안자</div>
						</td>
					</tr>
					<tr>
						<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
							
			부서
						</td>
						<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
							<div contenteditable="false" id="deptName">기안자 부서</div>
						</td>
					</tr>
					<tr>
						<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
							
			문서번호
						</td>
						<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
							<div contenteditable="false" id="docId">문서번호</div>
						</td>
					</tr>
				</tbody>
			</table>
			
</td>
						<td id="approval-line" style="padding: 0px !important; border: currentColor; text-align: right; color: black; font-size: 12px; font-weight: normal; vertical-align: top;">
							<!-- 에디터 &nbsp; 버그. 개행과 공백을 최소화 시키자. [결재선]-->
							
							
							
							
						</td>
					</tr>
				</tbody>
			</table>

			<table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 10px; border-collapse: collapse;"><!-- Draft --><colgroup><col width="90"></colgroup>
				<tbody>
					<tr>
						<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
							
			수신
						</td>
						<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
							<div contenteditable="false" id="reception">수신자</div>
						</td>
					</tr>
					<tr>
						<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
							
			참조
						</td>
						<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
							<div contenteditable="false" id="refer">참조자</div>
						</td>
					</tr>
				</tbody>
			</table>
			
			<table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 10px; border-collapse: collapse;"><!-- Draft --><colgroup><col width="160"><col width="300"><col width="140"><col width="200"></colgroup>
				<tbody>
					<tr>
						<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
							
			제목
						</td>
						<td id="title" contenteditable="true" style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;" colspan="3">
						</td>
					</tr>
				</tbody>
			</table>
			
			<table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 10px; border-collapse: collapse;"><!-- Data2 --><colgroup><col width="160"><col width="150"><col width="490"></colgroup>
				<tbody>
					<tr>
						<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;" rowspan="3">
							
			신청내용
						</td>
						<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
							
			휴가종류
						</td>
						<td style="text-align: left; background-color: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle; background-position: initial initial; background-repeat: initial initial;">
							<select id="vacationType" onchange="selectOption();" contenteditable="true">
								<option selected="selected">연차</option>
								<option>반차</option>
								<option>보건</option>
								<option>경조</option>
								<option>교육</option>
								<option>훈련</option>
								<option>외출</option>
								<option>조퇴</option>
								<option>기타</option>
							</select>
						</td>
					</tr>
					<tr>
						<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
							
			기간
						</td>
						<td style="text-align: center; background-color: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle; background-position: initial initial; background-repeat: initial initial;">
							<span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="6" data-dsl="{{period}}" data-wrapper="" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;" data-value=""><input class="ipt_editor ipt_editor_date startDt" type="date" > ~ <input class="ipt_editor ipt_editor_date endDt" type="date"><span contenteditable="false" class="comp_active" style="display: none; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"> <span class="Active_dot1" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span class="Active_dot2" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span> <span class="Active_dot3" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span class="Active_dot4" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span> </span> <span contenteditable="false" class="comp_hover" data-content-protect-cover="true" data-origin="6" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"> <a contenteditable="false" class="ic_prototype ic_prototype_trash" data-content-protect-cover="true" data-component-delete-button="true"></a> </span> </span><br>
						</td>
					</tr>
					<tr>
						<td contenteditable="true" style="box-sizing: inherit; text-align: left; background-color: rgb(255, 255, 255); padding: 0.09%; border: 1px solid black; height: 100px; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle; background-position: initial initial; background-repeat: initial initial; border-top:none;" colspan="2" class="dext_table_border_t">
						</td>
					</tr>
				</tbody>
			</table>
			<table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 10px; border-collapse: collapse;"><!-- Draft --><colgroup><col width="160"><col width="300"><col width="140"><col width="200"></colgroup>
				<tbody>
					<tr>
						<td contenteditable="false" style="background: rgb(255, 255, 255); padding: 5px; height: 100px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;" colspan="4">
							
			해당 증빙을 첨부하세요.<br><br>종류 : 연차, 반차, 보건, 경조, 교육, 훈련, 외출, 조퇴, 기타<br>시간 : 연차/보건/경조 =&gt; "전일"<br>&nbsp; &nbsp; &nbsp; &nbsp; 반차 =&gt; "오전","오후"<br>&nbsp; &nbsp; &nbsp; &nbsp; 교육/훈련/외출/조퇴 =&gt; 구체적 시간 기재<br><br type="_moz">
						</td>
					</tr>
				</tbody>
			</table>
			<table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 10px; border-collapse: collapse;"><!-- Draft --><colgroup><col width="160"><col width="300"><col width="140"><col width="200"></colgroup>
				<tbody>
					<tr>
						<td contenteditable="false" style="text-align: center; background-color: rgb(255, 255, 255); padding: 5px; height: 30px; border: 1px solid black; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle; background-position: initial initial; background-repeat: initial initial;" colspan="4">
							
			위와 같이 신청하오니 재가하여 주시기 바랍니다. <br>
						</td>
					</tr>
				</tbody>
			</table>
			<div style="text-align: right; font-family: &quot;맑은 고딕&quot;; font-size: 10pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;" align="right"><br></div></span>
			<p><br></p>
					