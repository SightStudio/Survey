package com.common.functional.funtionalIF;

/**
 * Lambda Expression 에서 Exception을 처리하기 위한 
 * 
 * Custom Function Consumer
 * 
 * @since  2019.05.06
 */
@FunctionalInterface
public interface FExceptionConsumerIF<T> {
	void accept() throws Exception;
}

