package com.common.aop;

import java.util.Arrays;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.common.collection.CLog;
import com.common.collection.CommonVO;
import com.common.enumtype.BizExceptionCode;
import com.common.exception.BizException;

@Component
@Aspect
public class CommonAspect {
	
	@Autowired
	CLog log;

	/**
	 * <pre>
	 *     공통 AOP aspect, 모든 서비스 레이어의 비즈니스 로직과 시스템 예외는 이곳에서 처리한다.
	 *     
	 *     적용 범위 : 모든 service 클래스의 public 메서드
	 *     전제 조건 : 모든 서비스 클래스 public 메서드는 CommonVO 수행 결과를 담아서 리턴해야한다.
	 * </pre>
	 * @since  2019. 6. 30.
	 */
	@Around("execution(public * com.app.official.service..*.*(..))||execution(public * com.app.adm.service..*.*(..))")
	public CommonVO aroundMethod(ProceedingJoinPoint pjp) {
		Signature sig = pjp.getSignature();
		
		long startTime = System.currentTimeMillis();
		long endTime   = 0;
		
		// [1] 서비스 로직 결과값 세팅
		String REPL_CD  = "000000";
		String REPL_MSG = "정상";
		CommonVO result = null;
		
		log.i("========================= 서비스 로직 START =============================");
		log.i("호출 서비스명 : " + sig.toString());
		log.i("파라미터: "     + Arrays.toString(pjp.getArgs()));
		
		try {
			
			// [2] 서비스 로직 실행
			result = (CommonVO) pjp.proceed();
			
		} catch (BizException biz) {
			/* CASE 1. Business Logic Exception */
			result   = new CommonVO();
			REPL_CD  = biz.getErrCode();
			REPL_MSG = biz.getErrMsg();
			log.e(biz.getMessage());
			
		} catch (Exception e) {
			/* CASE 2. Unhandled System Exception */
			result   = new CommonVO();
			REPL_CD  = "000001";
			REPL_MSG = BizExceptionCode.search(REPL_CD).getErrMsg();
			e.printStackTrace();
			log.e(e.getMessage());
			
		} catch (Throwable t) {
			/* CASE 3. TOP Level 'ERROR' */
			result   = new CommonVO();
			REPL_CD  = "999999";
			REPL_MSG = "[System Failure Unknown Error]";
			t.printStackTrace();
			log.e(t.getMessage());
		} finally {
			// [3] 최종 결과값 세팅
			result.put("REPL_CD", REPL_CD);
			result.put("REPL_MSG", REPL_MSG);
			endTime = System.currentTimeMillis();
		}

		log.i("서비스 메소드 수행 시간    : " + ( endTime - startTime) + "/ms");
		log.i("서비스 메소드 수행 결과값 : " + result.toJson());
	    log.i("========================= 서비스 로직 END =============================");
	    return result;
	}
}
