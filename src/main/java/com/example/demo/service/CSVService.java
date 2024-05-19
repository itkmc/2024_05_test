package com.example.demo.service;

import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.CSVRepository;
import com.example.demo.vo.CSV2;
import com.opencsv.CSVReader;

@Service
public class CSVService {

	@Autowired
	private CSVRepository csvRepository;

	public String readAndSaveToDB2() {
        try {
            List<CSV2> csvList = new ArrayList<>();

            // 예시 파일들을 배열에 추가
            String[] fileNames = {"city1.csv"};


            for (String fileName : fileNames) {
                InputStreamReader is = new InputStreamReader(getClass().getClassLoader().getResourceAsStream("CSV/" + fileName), "EUC-KR");
                CSVReader reader = new CSVReader(is);


                    // 첫 번째 줄(헤더) 건너뛰기
                    reader.skip(1);

                    List<String[]> list = reader.readAll();

                    for (String[] csvRow : list) {
                        CSV2 csv = new CSV2();
                        
                        csv.setNo(csvRow[0]);
                        csv.setCityName(csvRow[1]);
                        csv.setSubName(csvRow[2]);
                        csv.setCategory(csvRow[3]);
                        csv.setAddress(csvRow[4]);
                        csv.setPhoneNumber(csvRow[5]);
                        csv.setDescription(csvRow[6]);
                        csv.setSource(csvRow[7]);

                        csvList.add(csv);
                    }

            }

            // CSV 데이터를 데이터베이스에 저장
            csvRepository.insertCSVList2(csvList);

            return "CSV2 데이터가 성공적으로 데이터베이스에 저장되었습니다.";

        }catch(

	Exception e)
	{
		e.printStackTrace();
		return "CSV2 데이터를 데이터베이스에 저장하는 중 오류가 발생했습니다.";
	}
}
	}