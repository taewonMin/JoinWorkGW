<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Page Wrapping (start) : Style retention -->
<div id="divCustomWrapper">  <!-- Embededd Style이 적용받는 범위 입니다. 상단의 스타일은 이 요소 안에서만 동작합니다. --> 
							
	<table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 1px; border-collapse: collapse;"><!-- Header --><colgroup><col width="310"><col width="490"></colgroup>
				<tbody>
					<tr>
						<td style="padding: 0px !important; border: 0px currentColor; height: 90px; text-align: center; color: black; font-size: 36px; font-weight: bold; vertical-align: middle;" colspan="2" class="dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
							회계품의서<br><br>
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
	<!-- 3. Detail Section (start) : 내용이 작성되는 영역입니다. -->
	<table class="detailSection">
		<colgroup>
		<!-- ### 테이블의 컬럼 너비는 colGroup을 통해 지정합니다. td에 지정 X ### -->
			<col width="30">
			<col width="50">
			<col width="170">
			<col width="100">
			<col width="60">
			<col width="60">
			<col width="80">
			<col width="100">
			<col width="80">
			<col width="70">
		</colgroup>

		 <tbody id="dynamic_table1"><!--기본 행 추가/삭제 + 자동 연산-->
			<tr>
				<td colspan="2" class="subjectColumn">문서제목</td>
				<td class="detailColumn" id="title" contenteditable="true">
				
				</td>
				<td rowspan="3" class="subjectColumn">납품자</td>
				<td id="content1" colspan="3" class="detailColumn" contenteditable="true">
				
				</td>
				<td class="subjectColumn">작성 일자</td>
				<td id="content2" colspan="2" class="detailColumn">
				
				</td>
			</tr>
			<tr>
				<td colspan="2" class="subjectColumn">프로젝트 번호</td>
				<td id="content3" class="detailColumn" contenteditable="true">
				</td>
				<td class="detailColumn centerCol">TEL:</td>
				<td id="content4" colspan="2" class="detailColumn" contenteditable="true">
				</td>
				<td class="subjectColumn">인도장소</td>
				<td id="content5" colspan="2" class="detailColumn" contenteditable="true">
				</td>
			</tr>
			<tr>
				<td colspan="2" class="subjectColumn">사용 목적</td>
				<td id="content6" class="detailColumn" contenteditable="true">
				</td>
				<td class="detailColumn centerCol">FAX:</td>
				<td id="content7" colspan="2" class="detailColumn" contenteditable="true">
				</td>
				<td class="subjectColumn">희망 납기 일자</td>
				<td id="content8" colspan="2" class="detailColumn" contenteditable="true">
				</td>
			</tr>
			<tr>
				<td class="subjectColumn">품번</td>
				<td colspan="2" class="subjectColumn">품명</td>
				<td class="subjectColumn">규격</td>
				<td class="subjectColumn">단위</td>
				<td class="subjectColumn">수량</td>
				<td class="subjectColumn">단가</td>
				<td class="subjectColumn">금액</td>
				<td class="subjectColumn">수주금액</td>
				<td class="subjectColumn">비고</td>
			</tr>
			<!-- 실제 추가, 삭제되는 행 Start-->
			<tr class="copyRow1">
				<td class="subjectColumn copyRowNo1">1</td>
				<td id="content9" colspan="2" class="detailColumn" contenteditable="true">
				</td>
				<td id="content10" class="detailColumn" contenteditable="true">
				</td>
				<td id="content11" class="detailColumn" contenteditable="true">
				</td>
				<td id="content12" class="detailColumn amount centerCol" contenteditable="true">
				</td>
				<td id="content13" class="detailColumn price rightCol" contenteditable="true">
				</td>
				<td id="content14" class="detailColumn cur rightCol" contenteditable="true">
				</td>
				<td id="content15" class="detailColumn" contenteditable="true">
				</td>
				<td id="content16" class="detailColumn" contenteditable="true">
				</td>
			</tr>
			<tr class="copyRow1">
				<td class="subjectColumn copyRowNo1">2</td>
				<td id="content40" colspan="2" class="detailColumn" contenteditable="true">
				</td>
				<td id="content17" class="detailColumn" contenteditable="true">
				</td>
				<td id="content18" class="detailColumn" contenteditable="true">
				</td>
				<td id="content19" class="detailColumn amount centerCol" contenteditable="true">
				</td>
				<td id="content20" class="detailColumn price rightCol" contenteditable="true">
				</td>
				<td id="content21" class="detailColumn cur rightCol" contenteditable="true">
				</td>
				<td id="content22" class="detailColumn" contenteditable="true">
				</td>
				<td id="content23" class="detailColumn" contenteditable="true">
				</td>
			</tr>
			<tr class="copyRow1">
				<td class="subjectColumn copyRowNo1">3</td>
				<td id="content39" colspan="2" class="detailColumn" contenteditable="true">
				</td>
				<td id="content24" class="detailColumn" contenteditable="true">
				</td>
				<td id="content25" class="detailColumn" contenteditable="true">
				</td>
				<td id="content26" class="detailColumn amount centerCol" contenteditable="true">
				</td>
				<td id="content27" class="detailColumn price rightCol" contenteditable="true">
				</td>
				<td id="content28" class="detailColumn cur rightCol" contenteditable="true">
				</td>
				<td id="content29" class="detailColumn" contenteditable="true">
				</td>
				<td id="content30" class="detailColumn" contenteditable="true">
				</td>
			</tr>
			<tr class="copyRow1">
				<td class="subjectColumn copyRowNo1">4</td>
				<td id="content38" colspan="2" class="detailColumn" contenteditable="true">
				</td>
				<td id="content31" class="detailColumn" contenteditable="true">
				</td>
				<td id="content32" class="detailColumn" contenteditable="true">
				</td>
				<td id="content33" class="detailColumn amount centerCol" contenteditable="true">
				</td>
				<td id="content34" class="detailColumn price rightCol" contenteditable="true">
				</td>
				<td id="content35" class="detailColumn cur rightCol" contenteditable="true">
				</td>
				<td id="content36" class="detailColumn" contenteditable="true">
				</td>
				<td id="content37" class="detailColumn" contenteditable="true">
				</td>
			</tr>
			<tr class="copyRow1">
				<td class="subjectColumn copyRowNo1">5</td>
				<td id="content41"  colspan="2" class="detailColumn" contenteditable="true"> 
				</td>
				<td id="content42"  class="detailColumn" contenteditable="true">
				</td>
				<td id="content43" class="detailColumn" contenteditable="true">
				</td>
				<td id="content44" class="detailColumn amount centerCol" contenteditable="true">
				</td>
				<td id="content45" class="detailColumn price rightCol" contenteditable="true">
				</td>
				<td id="content46" class="detailColumn cur rightCol" contenteditable="true">
				</td>
				<td id="content47" class="detailColumn" contenteditable="true">
				</td>
				<td id="content48" class="detailColumn" contenteditable="true">
				</td>
			</tr>
			<!-- 실제 추가, 삭제되는 행 End-->
			<!-- 합계 행 Start-->
			<tr class="subjectColumn">
				<td colspan="7" class="subjectColumn">합계</td>
				<td id="content49" class="detailColumn sum_cur rightCol" contenteditable="true">
				</td>
				<td colspan="2" class="detailColumn centerCol">VAT 별도</td>
			</tr>
			<!-- 합계 행 End-->
			<tr class="subjectColumn">
				<td colspan="10" class="subjectColumn">구매사유 (구체적 작성)</td>
			</tr>
			<tr>
				<td id="content50" colspan="10" class="detailColumn areaCol" contenteditable="true">
				</td>
			</tr>
			<tr class="subjectColumn">
				<td colspan="10" class="subjectColumn">특이사항</td>
			</tr>
			<tr>
				<td id="content51" colspan="10" class="detailColumn areaCol" contenteditable="true">
				</td>
			</tr>
		</tbody>
	</table>
<!-- 3. Detail Section (end) -->

</div>
<!-- Page Wrapping (end) -->

<!----------------------------------------Style Start---------------------------------------->
<!-- Common style (Don't modify) --><style type="text/css">
/* 1. Essential style : 반드시 적용되어야 하는 스타일입니다. 문서작성 시, Sample에서 제거불가 한 스타일 */
#divCustomWrapper { word-break: break-all;  font-family: malgun gothic, dotum, arial, tahoma; font-size: 9pt; width:800px !important; }
#divCustomWrapper * { max-width: 800px !important; }
/* (1) Section(제목, 결재선, 내용) */
#divCustomWrapper #titleSection,
#divCustomWrapper #draftSection,
#divCustomWrapper .detailSection { width:800px !important; clear:both; margin-top: 20px !important; vertical-align: middle; }
#divCustomWrapper #titleSection { text-align: center; font-size: 25px; font-weight: bold; margin-bottom: 10px !important; margin-top: 20px !important; }
#divCustomWrapper #draftSection { display: inline-block; }
#divCustomWrapper .detailSection > * { margin-bottom: 10px; }
/* (2) Table */
#divCustomWrapper table { border-collapse: collapse; table-layout:fixed; word-break:break-all; }
</style>
<style type="text/css">
/* 2. Option style : 용도에 따라 적용합니다.*/
/* (1) Table option : 2Type(subject / detail), Affacted elements(td), Range('divCustomWrapper' 하단요소) */
#divCustomWrapper td.subjectColumn { border: 1px solid black !important; font-size: 9pt !important; height:22px; padding: 3px 1px 3px 1px;/*top right bottom left*/}
#divCustomWrapper td.detailColumn { border: 1px solid black !important; font-size: 9pt !important; height:22px; padding: 3px 5px 3px 5px; vertical-align: middle;/*top right bottom left*/ }
#divCustomWrapper td.detailColumn { text-align: left; }
#divCustomWrapper td.subjectColumn { background: rgb(221, 221, 221); font-weight: bold; text-align: center; vertical-align: middle; }
/* (2) detailColumn :  3Type(center / right / high), Affacted elements(All), Range('detailColumn' 하단요소) */
/* 설명 : detailColumn 커스텀 시 사용 */
/* 사용방법 : 번호와 중앙정렬 텍스트 작성 시 'centerCol' CLASS 적용, 숫자와 금액 작성 시 'rightCol' CLASS 적용,
editor 작성 시 'editorCol' CLASS 적용, textarea 작성 시 'areaCol' CLASS 적용 */
#divCustomWrapper td.detailColumn.centerCol { text-align: center; }
#divCustomWrapper td.detailColumn.rightCol { text-align: right; }
#divCustomWrapper td.detailColumn.editorCol { height: 300px; vertical-align: top;}
#divCustomWrapper td.detailColumn.areaCol { height: 120px; vertical-align: top; }
/* (3) Partition option : 2Type (left / right), Affacted elements(div), Range('partition'div영역 하단요소) */
/* 설명 : 좌,우로 분할되는 레이아웃 작성시 사용, 1라인에 1개 요소만 배치(줄바뀜 동반) */
/* 사용방법 : 분할할 영역에 partition CLASS를 적용 -> 분할배치하고자하는 하위요소에 'left, right' CLASS 적용 */
#divCustomWrapper div.partition .left { display: inline-block; clear: left; float: left; }
#divCustomWrapper div.partition .right { display: inline-block; clear: right; float: right; }
/* (4) In a row option : 2Type(left / right), Affacted elements(All), Range('inaRowRight or inRowLeft'div영역 하단요소) */
/* 설명 : 좌,우 끝에 정렬되는 레이아웃 작성 시 사용, 1라인에 여러개 요소 배치, Partition option과 조합(줄바뀜 없이 배치) */
/* 사용방법 : 나란히 정렬하고자 하는 요소들을, 'in a row'div 영역 내에 배치 */
#divCustomWrapper div.inaRowRight { text-align: right; }
#divCustomWrapper div.inaRowLeft { text-align: left;  }
/* (5) button :  2Type(td / div), Affacted elements(All) */
/* 설명 : 행 추가, 행 삭제 버튼 작성 시 'viewModeHiddenPart'(기안 시 버튼 가려주는 클래스)와 조합해서 사용 */
/* 사용방법 : 테이블에 한줄로 사용 시 td에 'viewModeHiddenPart .td_button' CLASS 적용 -> 각 버튼에 'button' CLASS 적용 td 내 텍스트 아래에 쓰이거나 테이블 밖에서 사용 시 div에 viewModeHiddenPart .div_button CLASS 적용 -> 각 버튼에 button CLASS 적용 */
#divCustomWrapper .td_button { word-break:break-all; padding: 3px; border: none; width: 800px; height: 22px; text-align: right; vertical-align: middle; }
#divCustomWrapper .div_button { word-break:break-all; padding: 3px; border: none; margin-top:2px; margin-bottom:2px; height: 22px; vertical-align: middle;}
#divCustomWrapper a.button { background: rgb(102, 102, 102); color: rgb(255, 255, 255); padding: 2px 5px; border-radius: 3px; margin-right: 0px; margin-left: 0px; font-size: 9pt !important; }
/* (6) p :  2Type(titleP / freeP), Affacted elements(All) */
/* 설명 : 테이블 별 소제목과 테이블 아래 설명 작성 시 사용*/
p.titleP{font-weight: bold; font-size: 12px; margin: 15px 1px 5px 5px;/*top right bottom left*/}
p.freeP{font-weight: normal; font-size: 12px; margin: 1px 1px 3px 5px;/*top right bottom left*/}
</style><!-- Common style (Don't modify) -->
<!-- Print style (Don't modify) --><style type="text/css">
/* 인쇄시에만 적용되는 스타일입니다. 순서대로 1.양식 인쇄 시 중앙으로 위치 2.테이블 테두리 고정 3.버튼 가리기 */
@media print {
.viewModeHiddenPart {display: none;}
h1, h2, h3, h4, h5, dl, dt, dd, ul, li, ol, th, td, p, blockquote, form, fieldset, legend, div,body { -webkit-print-color-adjust:exact; }
}
</style><!-- Print style (Don't modify)-->
<!-- Custom style --><style>
/* 추가적인 스타일이 필요한 경우, 하단의 style에서 정의하여야 합니다. 상단의 Common style은 변경하지 않습니다. */
/* (스타일이 중복되는 경우, 기본적으로 하단에 작성한 style이 우선적으로 적용됩니다.) */
</style><!-- Custom style -->