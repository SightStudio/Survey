package com.common.util;

import java.io.File;
import java.util.Arrays;

/**
 * 파일 처리 관련 모듈
 * 
 * @since  2019.05.28
 */
public class FileMo {

	/**
	 * 하위 디렉토리/또는 파일을 찾는 함수 1 뎁스만 지원
	 * 해당 파일이 없을 경우, null 리턴
	 *  
	 * @since  2019.05.28
	 */
	public static File findFileIndir(File dir, String fileName) {
		
		// [1] 디렉토리가 아닐경우 null 리턴
		if(!dir.isDirectory()) return null;
		
		return Arrays.stream(dir.listFiles())
					 .filter(file -> fileName.equals(file.getName()))
					 .findFirst()
					 .get();
	}
}
