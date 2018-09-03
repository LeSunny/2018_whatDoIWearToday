package first.common.logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import first.common.logger.LoggerInterceptor;

public class LoggerInterceptor extends HandlerInterceptorAdapter {
    protected Log log = LogFactory.getLog(LoggerInterceptor.class);
     
    
    
    /**
     * 전처리기
     * client -> 실행 -> controller
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (log.isDebugEnabled()) {
            log.debug("======================================          START         ======================================");
            log.debug(" Request URI \t:  " + request.getRequestURI());
        }
        /*
        try {
            //admin이라는 세션key를 가진 정보가 널일경우 로그인페이지로 이동
            if(request.getSession().getAttribute("admin") == null ){
                    response.sendRedirect("/");
                    return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        //admin 세션key 존재시 main 페이지 이동
        */
        return super.preHandle(request, response, handler);
    }
     
    
    /**
     * 후처리기
     * controller -> 실행 -> client
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (log.isDebugEnabled()) {
            log.debug("======================================           END          ======================================\n");
        }
        super.postHandle(request, response, handler, modelAndView);
    }
    
   
    /**
     * controller + view 페이지 모두 출력 후
     * */ 
}
