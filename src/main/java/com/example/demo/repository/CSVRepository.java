package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import com.example.demo.vo.CSV2;

@Mapper
public interface CSVRepository {

    @Insert({
        "<script>",
        "INSERT INTO city2 (no, cityName, subName, category, address, phoneNumber, description, source) VALUES ",
        "<foreach collection='csvList' item='item' index='index' separator=','>",
        "(#{item.no}, #{item.cityName}, #{item.subName}, #{item.category}, #{item.address}, #{item.phoneNumber}, #{item.description}, #{item.source})",
        "</foreach>",
        "</script>"
    })
    void insertCSVList2(List<CSV2> csvList);
}