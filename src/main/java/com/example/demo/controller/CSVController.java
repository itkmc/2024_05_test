package com.example.demo.controller;

import com.example.demo.service.CSVService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CSVController {

    @Autowired
    private CSVService csvService;

    // CSV임
    @GetMapping("/readAndSaveToDB2")
    @ResponseBody
    public String readAndSaveToDB2() {
        return csvService.readAndSaveToDB2();
    }
}
//csv pom에 설정
//<!-- openCSV -->
//<dependency>
//<groupId>com.opencsv</groupId>
//<artifactId>opencsv</artifactId>
//<version>5.5.2</version> <!-- 버전 명확히 지정 -->
//</dependency>