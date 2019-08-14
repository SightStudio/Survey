package com.common.session;

import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class SessionUtil {
	
	/**
	 * 세션을 가져오는 함수
	 * 
	 * @since	2019.02.09
	 */
	public static HttpSession getSession() {
	    ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
	    return attr.getRequest().getSession(true); // true == allow create
	}
}
