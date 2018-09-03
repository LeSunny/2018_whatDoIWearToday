package first.common.resolver;
 
import java.util.Enumeration;
 
import javax.servlet.http.HttpServletRequest;
 
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;
 
import first.common.common.CommandMap;
 
public class CustomMapArgumentResolver implements HandlerMethodArgumentResolver{
    @Override //컨트롤러의 파라미터가 CommandMap 클래스인지 검사
    public boolean supportsParameter(MethodParameter parameter) {
        return CommandMap.class.isAssignableFrom(parameter.getParameterType());
    }
 
    @Override //
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
        CommandMap commandMap = new CommandMap(); //CommandMap 객체 생성
         
        HttpServletRequest request = (HttpServletRequest) webRequest.getNativeRequest();
        Enumeration<?> enumeration = request.getParameterNames();
         
        String key = null;
        String[] values = null;
        while(enumeration.hasMoreElements()){
        	//request에 있는 값을 iterator를 이용해 하나씩 가져오는 로직이다.
            key = (String) enumeration.nextElement();
            values = request.getParameterValues(key);
            if(values != null){
            	//request에 담긴 모든 key와 value를 commandMap에 저장하였다.
                commandMap.put(key, (values.length > 1) ? values:values[0] );
            }
        }
        return commandMap; //모든 파라미터가 든 commandMap을 반환
    }
}
