<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="MAIN"></c:set>
<%@ include file="../common/head.jspf"%>

<head>
    <meta charset="UTF-8">
    <title>현재 날씨</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
    <div class="search_box">
        <form id="searchForm" action="/usr/home/main" method="GET">
            <input type="text" id="searchInput" name="searchKeyword" class="SearchBoxTextEditor" placeholder="어디로 떠나시나요?" value="${searchKeyword}" />
            <button type="submit" class="search_btn">검색</button>
        </form>
    </div>

    <div class="content">
        <div class="weather_box">
            <div>현재 날씨는?</div>
            <div>
                <div class="weather-icon"></div>
                <div class="temperature"></div>
                <div class="city"></div>
            </div>
        </div>

        <!-- Q&A 목록 -->
        <div class="qna_list">
            <h2>Q&A 목록</h2>
            <ul>
                <c:forEach var="qna" items="${Qnas}">
                    <c:if test="${fn:containsIgnoreCase(qna.question, searchKeyword) || fn:containsIgnoreCase(qna.answer, searchKeyword)}">
                       	<li>질문: ${qna.question}<br>답변: ${qna.answer}</li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>

        <!-- 도시 목록 표시 부분 -->
        <table border="1">
            <tr>
                <th>순번</th>
                <th>도시명</th>
                <th>상세 보기</th>
            </tr>
            <c:forEach var="city" items="${citys}">
                <tr>
                    <td>${city.no}</td>
                    <td>${city.cityName}</td>
                    <td>${city.subName}</td>
                    <td><button class="show-details search_btn" data-city-id="${city.id}">상세 보기</button></td>
                </tr>
            </c:forEach>
        </table>
        <c:forEach var="city" items="${citys}">
            <div class="city-details" id="city-details-${city.no}" style="display: none;">
                <h3>${city.cityName}의 세부 정보</h3>
                <ul>
                    <li>순번: ${city.no}</li>
                    <li>세부 이름: ${city.subName}</li>
                    <li>카테고리: ${city.category}</li>
                    <li>주소: ${city.address}</li>
                    <li>전화번호: ${city.phoneNumber}</li>
                    <li>설명: ${city.description}</li>
                    <li>출처: ${city.source}</li>
                </ul>
            </div>
        </c:forEach>
    </div>

    <script>
        $(document).ready(function () {
            var apiKey = '57f7f1899a50b5e3d375cf64fdce856e';
            var weatherApiUrl = 'https://api.openweathermap.org/data/2.5/weather';

            var cityNames = {
                '대전': 'Daejeon',
                '서울': 'Seoul',
                '부산': 'Busan',
                '인천': 'Incheon',
                '대구': 'Daegu',
                '전주': 'Jeonju',
                '군산': 'Gunsan',
                '익산': 'Iksan',
                '남원': 'Namwon',
                '김제': 'Gimje',
                '완주': 'Wanju',
                '무주': 'Muju',
                '장수': 'Jangsu',
                '임실': 'Imsil',
                '순창': 'Sunchang',
                '고창': 'Gochang',
                '부안': 'Buan',
                '광주': 'Gwangju'
            };

            var englishToKoreanCityNames = {};
            for (var key in cityNames) {
                englishToKoreanCityNames[cityNames[key]] = key;
            }

            function getWeather(cityName) {
                var cityNameInEnglish = cityNames[cityName] || cityName;
                var params = {
                    q: cityNameInEnglish,
                    appid: apiKey,
                    units: 'metric',
                    lang: 'kr'
                };

                $.ajax({
                    url: weatherApiUrl,
                    data: params,
                    dataType: 'json',
                    success: function (data) {
                        var weatherIcon = data.weather[0].icon;
                        var iconUrl = 'http://openweathermap.org/img/wn/' + weatherIcon + '.png';
                        $('.weather-icon').html('<img src="' + iconUrl + '">');

                        var temperature = Math.round(data.main.temp);
                        $('.temperature').text('온도: ' + temperature + '°C');

                        var cityNameInEnglish = data.name;
                        var cityNameInKorean = englishToKoreanCityNames[cityNameInEnglish] || cityNameInEnglish;
                        $('.city').text('지역: ' + cityNameInKorean);
                    },
                    error: function (xhr, status, error) {
                        console.error('날씨 데이터 가져오기 오류:', error);
                    }
                });
            }

            // 상세 정보 버튼 클릭 시
            $('.show-details').on('click', function () {
                var cityNo = $(this).data('city-id');
                $('.city-details').hide();
                $('#city-details-' + cityNo).show();
                $('.qna_list').hide();

                var cityName = $('#city-details-' + cityNo + ' h3').text().replace('의 세부 정보', '').trim();
                getWeather(cityName);
            });

        });
    </script>
</body>
<style>
    .search_box {
        position: absolute;
        top: 17%;
        left: 15%;
        width: 800px;
        height: 80px;
        background-color: #ffffff;
        opacity: 0.93;
        border-radius: 50px;
        margin-left: 100px;
        box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.8);
        z-index: 2;
    }

    .SearchBoxTextEditor {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 400px;
        height: 70px;
        padding: 10px;
        font-size: 16px;
        border-radius: 32px;
        transform: translate(-50%, -50%);
        background-color: orange;
        z-index: 5;
    }

    .search_btn {
        width: 90px;
        height: 30px;
        margin-top: 14px;
        margin-left: 600px;
        font-size: 16px;
        border-radius: 30px;
        background-color: orange;
        z-index: 6;
    }

    .content {
        display: flex;
        flex-wrap: wrap;
        margin-top: 150px;
    }

    .weather_box {
        margin-right: 10px;
        height: 200px;
        border: 2px solid green;
        top: 20px;
    }

    .city-details {
        flex-basis: 30%;
        margin-top: 20px;
        margin-left: auto;
        margin-right: 0;
    }

    .city_list {
        flex: 2;
        margin-left: 20px;
        margin-top: 0;
    }
</style>

<%@ include file="../common/foot.jspf"%>