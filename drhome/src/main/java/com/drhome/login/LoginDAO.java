package com.drhome.login;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginDAO {

	int IDresult(Map<String, Object> map);

	int PWresult(Map<String, Object> map);

	Map<String, Object> loginCheck(Map<String, Object> map);

	Map<String, Object> findID(Map<String, Object> map);

	Map<String, Object> findPW(Map<String, Object> map);

	int getMno(Map<String, Object> map);

	int getDno(Map<String, Object> map);

	void registerHealthRecord(int getMno);

	int selectHealthRecord(int getMno);

}
