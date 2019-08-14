package com.common.collection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Component;

/**
 * 공통 로그 모듈
 * 
 *  
 * @since	2019.02.09
 */
@Component
public class CLog implements InitializingBean{
	
		private Logger log;        
		
		@Override
		public void afterPropertiesSet() throws Exception {
			this.log = LoggerFactory.getLogger(CLog.class);
		}
		
		/**
		 * <pre>
		 * 	Logging debug Message
		 * </pre>
		 * @param   message
		 *  
		 * @since	2019.02.09
		 */
		public void d(String message) {
			log.debug(message);
		}
		
		/**
		 * <pre>
		 * 	Logging info Message
		 * </pre>
		 * @param   message
		 *  
		 * @since	2019.02.09
		 */
		public void i(String message) {
			log.info(message);
		}
		
		/**
		 * <pre>
		 * 	Logging warn Message
		 * </pre>
		 * @param   message
		 *  
		 * @since	2019.02.09
		 */
		public void w(String message) {
			log.warn(message);
		}
		
		/**
		 * <pre>
		 * 	Logging error Message
		 * </pre>
		 * @param   message
		 *  
		 * @since	2019.02.09
		 */
		public void e(String message) {
			log.error(message);
		}
}