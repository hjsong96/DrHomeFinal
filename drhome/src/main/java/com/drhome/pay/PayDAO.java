package com.drhome.pay;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PayDAO {

	Map<String, Object> payMoney(Map<String, Object> map);

	Map<String, Object> cardCheck(Map<String, Object> map);

	Map<String, Object> myPoint(Map<String, Object> map);

	void minusCdbalance(Map<String, Object> map);

	void minusPtpoint(Map<String, Object> map);

	void plusPtpoint(Map<String, Object> map);

	int nowPtpoint(Map<String, Object> map);

	void minusMpoint(Map<String, Object> map);

	void plusMpoint(Map<String, Object> map);

	void updatePaystatus(Map<String, Object> map);

}
