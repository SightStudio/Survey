package com.common.functional.funtionalIF;

/**
 * Lambda Expression에서 Exception을 처리하기 위한 
 * 
 * Custom Function Supplier
 * 
 * @since  2019.05.06
 */
@FunctionalInterface
public interface FExceptionSupplierIF<T> {
	T get() throws Exception;
}