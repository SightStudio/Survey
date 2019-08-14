package com.common.collection;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * ArrayList를 상속한 공통 VO List 
 * 
 *  
 * @snice  2019.03.01
 *
 */
public class CommonVOList<T> extends ArrayList<T>{
	
	// serialVersionID
	private static final long serialVersionUID = 1L;
	
	/**
	 * 생성자 
	 * 
	 *  
	 * @since  2019.04.01
	 */
	public CommonVOList() { super(); }
	
	public CommonVOList(int initSize) { super(initSize); }
	
	public CommonVOList(String json) throws IOException { setJSON(json); }
	
	public CommonVOList(File jsonFile) throws IOException { setJSON(jsonFile); }
	
	@SuppressWarnings("unchecked")
	public CommonVOList(List<CommonVO> list) {
		super(list.size());
		list.forEach(v -> this.add((T) v)); 
	}
	
	/**
	 * jackson 라이브러리 기반 JSON을 파싱하여 List에 삽입하는 함수  - [1] File 파싱
	 * 
	 *  
	 * @since  2019.04.01
	 */
	public void setJSON(File file) throws IOException{
		ObjectMapper mapper = new ObjectMapper();
		this.addAll(mapper.readValue(file, new TypeReference<CommonVOList<CommonVO>>(){}));
	}
	
	/**
	 * jackson 라이브러리 기반 JSON을 파싱하여 List에 삽입하는 함수  - [2] String 파싱
	 * 
	 *  
	 * @since  2019.04.01
	 */
	public void setJSON(String json) throws IOException{
		ObjectMapper mapper = new ObjectMapper();
		this.addAll(mapper.readValue(json, new TypeReference<CommonVOList<CommonVO>>(){}));
	}
	
	/**
	 * jackson 라이브러리 기반 CommonVOList 내용을 JSON string으로 리턴하는 함수
	 * 
	 *  
	 * @since  2019.04.01
	 */
	public String toJson() throws IOException {
		ObjectMapper mapper = new ObjectMapper();
		return mapper.writerWithDefaultPrettyPrinter().writeValueAsString(this);
	}
}
