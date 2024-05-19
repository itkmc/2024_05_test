DROP DATABASE IF EXISTS 2024_05_test;
CREATE DATABASE 2024_05_test;
USE 2024_05_test;

SELECT * FROM city2;

DROP TABLE city2;

SELECT * FROM qna;

CREATE TABLE city2(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `no` CHAR(255),
    cityName CHAR(255),
    subName CHAR(255),
    category CHAR(255),
    address CHAR(255),
    phoneNumber CHAR(255),
    `description` CHAR(255),
    `source` CHAR(255)
);


CREATE TABLE qna (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question TEXT,
    answer TEXT
);

INSERT INTO qna (question, answer) VALUES ('추천장소', '전주입니다');
INSERT INTO qna (question, answer) VALUES ('전주 명소 ', '전주에는 한옥마을, 전동성당, 전주향교 등이 있습니다.');
INSERT INTO qna (question, answer) VALUES ('남원 명소 ', '남원에는 남원종교문화단지, 박물관노원 등이 있습니다.');
INSERT INTO qna (question, answer) VALUES ('부안 명소 ', '부안에는 부안문화재단지, 부안옥당 등이 있습니다.');
INSERT INTO qna (question, answer) VALUES ('군산 명소 ', '군산에는 공룡박물관, 오동도 등이 있습니다.');
INSERT INTO qna (question, answer) VALUES ('김제 명소 ', '김제에는 김제섬진강나루공원, 간월생태공원 등이 있습니다.');
INSERT INTO qna (question, answer) VALUES ('완주 명소 ', '완주에는 완주산성, 완주군립박물관 등이 있습니다.');
INSERT INTO qna (question, answer) VALUES ('순창 명소 ', '순창에는 순창종합체육관, 순창대승사 등이 있습니다.');
INSERT INTO qna (question, answer) VALUES ('고창 명소 ', '고창에는 고창군립박물관, 고창향교 등이 있습니다.');
INSERT INTO qna (question, answer) VALUES ('임실 명소 ', '임실에는 임실마을마당, 청운폭포 등이 있습니다.');

