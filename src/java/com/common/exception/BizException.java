package com.common.exception;

/**
 * 공통 비즈니스 로직 Exception Class
 * @since	2019.02.03
 *
 */
public class BizException extends Exception {
	
	// defatul serial ID
	private static final long serialVersionUID = 1L;

	// 최종 error message
	private String errMsg = "";
	
	// 최종 error code
	private String errCode = "";
	
	/**
	 * <pre>
	 * Biz Exception Constructor
	 * </pre>
	 * 
     * 공통 비즈니스 로직 Exception Class
     * @since	2019.02.03
	 */
	public BizException() {
		super();
	}
	
	public BizException(String errCode, String errMsg) {
		this.errCode = errCode;
		this.errMsg = errMsg;
	}

	public String getErrMsg() {
		return errMsg;
	}

	public String getErrCode() {
		return errCode;
	}
	
}
