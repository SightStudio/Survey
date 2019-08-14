package com.common.functional;

import com.common.functional.funtionalIF.FExceptionConsumerIF;
import com.common.functional.funtionalIF.FExceptionSupplierIF;

/**
 * 
 * 커스텀 Functon Util
 * 
 * @since  2019.05.06
 *
 */
public class FUtil {
	
	/**
	 * Stream Operation 내에서 Exception을 처리하기 위한 
	 * 
	 * Custom Supplier Wrapper 함수  
	 * 
	 * @since  2019.05.06
	 */
	public static <T> T exSupplier(FExceptionSupplierIF<T> supplier) {
		try {
			return supplier.get();
		} catch (Exception e) {
			throw new RuntimeException();
		}
	}
	
	/**
	 * Stream Operation 내에서 Exception을 처리하기 위한 
	 * 
	 * Custom Consumer Wrapper 함수  
	 * 
	 * @since  2019.05.06
	 */
	public static <T> void exConsumer(FExceptionConsumerIF<T> consumer) {
		try {
			consumer.accept();
		} catch (Exception e) {
			throw new RuntimeException();
		}
	}
}
