<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
        /* 모달 팝업의 전체 배경 */
        .modal {
            display: none; /* 초기에는 숨겨진 상태 */
            position: fixed;
            z-index: 1000; /* 다른 콘텐츠 위에 위치 */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto; /* 화면이 작을 경우 스크롤바 표시 */
            background-color: rgba(0, 0, 0, 0.4); /* 반투명한 검정 배경 */
        }

        /* 모달 팝업의 콘텐츠 */
        .modal-content {
            background-color: #fefefe;
            margin: 0 auto; /* 좌우 중앙 정렬 */
            padding: 20px;
            border: 1px solid #888;
            width: fit-content; /* 내부 내용물에 따라 크기 자동 조정 */
            border-radius: 8px; /* 둥근 모서리 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
            position: relative; /* 부모 위치 기준 */
            top: 20%; /* 화면의 상단에서 20% 떨어진 위치 */
            align-items: center; /* 요소들이 수직 중앙에 정렬되도록 설정 */
        }

        /* 닫기 버튼 */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer; /* 커서가 포인터 모양으로 변경 */
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }
        
        /* 모달 내부의 input과 select 필드 */
        .modal-content select,
        .modal-content input[type="text"] {
            display: inline-block;
            margin-right: 10px;
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        /* 버튼 스타일링 */
        .modal-content button {
            font-size: 16px;
            padding: 8px 16px;
            background-color: #3498db;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            margin-right: 5px; /* 버튼 사이 여백 */
        }

        #registerBtn:disabled {
            background-color: gray; /* 비활성화 상태 배경색 */
            color: lightgray;       /* 비활성화 상태 텍스트 색상 */
            cursor: not-allowed;    /* 비활성화 상태 커서 */
        }

        .modal-content button:hover {
            background-color: #2980b9;
        }

        /* 모달을 띄우는 버튼 */
        #openModal {
            font-size: 18px;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        #openModal:hover {
            background-color: #2980b9;
        }
        
        /* 테이블 스타일 */
        table {
            width: 100%;
            border-collapse: collapse; /* 테두리 선 중첩 제거 */
            margin-top: 15px;
        }

        th, td {
            border: 1px solid #ddd; /* 테이블 셀 테두리 */
            padding: 8px;
            text-align: center; /* 중앙 정렬 */
        }

        th {
            background-color: #f4f4f4;
            font-weight: bold;
        }

        /* 테이블을 감싸는 div */
        #tableContainer {
           display: none;
           width: 100%;
           overflow-x: auto; /* 테이블이 클 경우 스크롤바 표시 */
           max-height: 200px; /* 테이블 높이 제한 */
           margin-top: 15px;
        }
    </style>
</head>
<body>
	<h1>createStep1.jsp</h1>
	 <h2>Simple Modal Popup Example</h2>
    <!-- 모달 팝업을 열기 위한 버튼 -->
    <button id="openModal">Open Modal</button>

    <!-- 모달 팝업의 구조 -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3>Modal Popup Title</h3>
             <select id="selectField">
                <option value="userid">사번</option>
                <option value="username">이름</option>
                <input type="text" id="textInput" placeholder="이름/사번을 입력하세요">
            </select>
             <!-- 조회 및 등록 버튼을 나란히 배치 -->
            <button id="searchBtn">조회</button>
            <button id="registerBtn" disabled>등록</button>
            
            <div id="tableContainer">
                <table id="dataTable">
                    <thead>
                        <tr>
                            <th>구분</th>
                            <th>사번</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>가입일시</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 조회된 데이터가 여기에 추가될 예정 -->
                    </tbody>
                </table>
            </div>
        </div>
    </div> <!-- 모달창 -->
    
    <div id="resulttableContainer">
                <table id="resultdataTable">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="selectAll"></th>
                            <th>사번</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>가입일시</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 등록된 데이터가 여기에 추가될 예정 -->
                    </tbody>
                </table>
            </div>
    

    <!-- jQuery 및 JavaScript 스크립트 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            // 모달 팝업 열기
            $('#openModal').on('click', function () {
            	$('#tableContainer').empty();
                $('#myModal').fadeIn(); // 모달을 페이드 인 효과로 표시
            });

            // 모달 닫기 (X 버튼 클릭 시)
            $('.close').on('click', function () {
                $('#myModal').fadeOut(); // 모달을 페이드 아웃 효과로 닫음
            });
            
         	// '조회' 버튼 클릭 이벤트
            $('#searchBtn').on('click', function () {
            	
            	// 테이블 초기화 (기존 데이터 삭제)
                $('#dataTable tbody').empty();
            	
            	var requestData = {
            			'selectValue': $('#selectField').val(),
            			'inputValue': $('#textInput').val()
            	};
            	
            	$.ajax({
            		url: '/web/member/getMemberInfo',
            		type: 'POST',
            		data: JSON.stringify(requestData),
            		contentType: 'application/json',
            		dataType: 'json',
            		success: function (response){
            			console.log(response); // response의 내용을 확인
            			
            			response.forEach(function (item) {
            				$('#dataTable tbody').append(
           						'<tr>' +
            				        '<td>' +
            				            '<input type="checkbox" data-id="' + item.userid + '">' +
            				        '</td>' +
            				        '<td>' + item.userid + '</td>' +
            				        '<td>' + item.username + '</td>' +
            				        '<td>' + item.useremail + '</td>' +
            				        '<td>' + item.regdate + '</td>' +
            				    '</tr>'
            				);
                        });
            		}
            	});
            	
            	$('#tableContainer').fadeIn(); // 테이블 div를 페이드 인 효과로 표시
            });
         
         	// 체크박스 클릭 이벤트 리스너
            $('#dataTable').on('change', 'input[type="checkbox"]', function() {
                // 체크박스가 하나라도 체크되었는지 확인
                var anyChecked = $('#dataTable input[type="checkbox"]:checked').length > 0;
                
                // 체크된 상태에 따라 버튼 활성화/비활성화
                $('#registerBtn').prop('disabled', !anyChecked);
            });
         
         
         	// '등록' 버튼 클릭 이벤트
            $('#registerBtn').on('click', function () {
            	
            	var requestData = [];
     			$('#dataTable input[type="checkbox"]:checked').each(function() {
     				requestData.push($(this).data('id')); // data-id 값 추가
      	        });
     			
     			var exsitData = [];
     			$('#resultdataTable input[type="checkbox"]:not(:checked)').each(function() {
     				exsitData.push($(this).data('id')); // data-id 값 추가
      	        });
     			
     			//중복확인
     			var duplicates = requestData.filter(id => exsitData.includes(id));
     			
     			if(duplicates.length > 0){
     			    alert('이미 등록된 값이 있습니다');
     			} else {
     			
            	$.ajax({
            		url: '/web/member/getMemberListInfo',
            		type: 'POST',
            		data: JSON.stringify(requestData),
            		contentType: 'application/json',
            		success: function (response){
            			
            			response.forEach(function (item) {
            				$('#resultdataTable tbody').append(
           						'<tr>' +
            				        '<td>' +
            				            '<input type="checkbox" data-id="' + item.userid + '">' +
            				        '</td>' +
            				        '<td>' + item.userid + '</td>' +
            				        '<td>' + item.username + '</td>' +
            				        '<td>' + item.useremail + '</td>' +
            				        '<td>' + item.regdate + '</td>' +
            				    '</tr>'
            				);
                        });
            		}
            	});
            	
	            	$('#dataTable input[type="checkbox"]').prop('checked', false); // 모든 체크박스 비활성화
	                $('#registerBtn').prop('disabled', true); // 버튼 비활성화
	            	$('#tableContainer').fadeOut(); // 테이블 div를 페이드 인 효과로 표시
     			}
            });
        });
        
        
        
    </script>
	
	
	
	
</body>
</html>