package first.sample.controller;

import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import first.common.common.CommandMap;
import first.sample.service.SampleService;


@Controller
public class SampleController {
    Logger log = Logger.getLogger(this.getClass());
    
    @Resource(name="sampleService")
    private SampleService sampleService;
     
    @RequestMapping(value="/sample/openBoardList.do")
    public ModelAndView openBoardList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/sample/boardList");
         
        List<Map<String,Object>> list = sampleService.selectBoardList(commandMap.getMap());
        mv.addObject("list", list);
         
        return mv;
    }
    
    
    @RequestMapping(value="/sample/testMapArgumentResolver.do")
    public ModelAndView testMapArgumentResolver(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("");
         
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
            }
        }
        return mv;
    }
    
    @RequestMapping(value="/sample/openBoardWrite.do")
    public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/sample/boardWrite");
         
        return mv;
    }
    
    @RequestMapping(value="/sample/insertBoard.do")
    public ModelAndView insertBoard(CommandMap commandMap, HttpServletRequest request) throws Exception{
        ModelAndView mv = new ModelAndView("redirect:/sample/openBoardList.do");
         
        sampleService.insertBoard(commandMap.getMap(), request);
         
        return mv;
    }
    
    
    @RequestMapping(value="/sample/openBoardDetail.do")
    public ModelAndView openBoardDetail(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/sample/boardDetail");
         
        Map<String,Object> map = sampleService.selectBoardDetail(commandMap.getMap());
        mv.addObject("map", map.get("map"));
        mv.addObject("list", map.get("list"));
        
        return mv;
    }
   
    @RequestMapping(value="/sample/openBoardUpdate.do")
    public ModelAndView openBoardUpdate(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/sample/boardUpdate");
         
        Map<String,Object> map = sampleService.selectBoardDetail(commandMap.getMap());
        mv.addObject("map", map.get("map"));
        mv.addObject("list", map.get("list"));
         
        return mv;
    }
     
    @RequestMapping(value="/sample/updateBoard.do")
    public ModelAndView updateBoard(CommandMap commandMap, HttpServletRequest request) throws Exception{
        ModelAndView mv = new ModelAndView("redirect:/sample/openBoardDetail.do");
         
        sampleService.updateBoard(commandMap.getMap(), request);
         
        mv.addObject("IDX", commandMap.get("IDX"));
        return mv;
    }
    
    @RequestMapping(value="/sample/deleteBoard.do")
    public ModelAndView deleteBoard(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("redirect:/sample/openBoardList.do");
         
        sampleService.deleteBoard(commandMap.getMap());
         
        return mv;
    }
    
    @RequestMapping(value="/wear/camera.do")
    public ModelAndView camera(HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/camera");
    	request.getSession().getAttribute("closet");
    	request.getSession().getAttribute("user");
    	return mv;
    }
    
    @RequestMapping(value="/wear/closet/uploadImg.do")
    @ResponseBody
    public String uploadImg(@RequestParam("user_id")String id, @RequestParam("main")String main, @RequestParam("small")String small, @RequestParam(value="imgUpload", required=false) String imageBase64, HttpServletRequest request) throws Exception{
    	System.out.println(imageBase64);
    	Map<String,Object> map = new HashMap<String, Object>();
    	map.put("ID", id);
    	map.put("MAIN", main);
    	map.put("SMALL", small);
    	map.put("IMAGE", imageBase64);
    	sampleService.uploadImage(map, request);
    	return "{\"result\":\"" + "true\"}";
    }
    
    @RequestMapping(value="/index.do")
    public ModelAndView initialScreen() throws Exception{
    	ModelAndView mv = new ModelAndView("/index");
    	return mv;
    }
    
    @RequestMapping(value="/user/openSignUp.do")
    public ModelAndView signUp() throws Exception{
    	ModelAndView mv = new ModelAndView("/user/signUp");
    	return mv;
    }
    
    @RequestMapping(value="/user/SignUpPro.do")
    public ModelAndView signUpPro(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/user/SignUpPro");
    	
    	//db에 삽입
        sampleService.insertMember(commandMap.getMap());
        
        mv.addObject("userID", commandMap.get("id"));
        
    	return mv;
    }   
    
    
    @RequestMapping(value="/user/chkDupId.do")
    @ResponseBody
    public String checkId(@RequestParam("user_id")String id, Model model) throws Exception{
    	//RequestParam 값은 Ajax 함수의 던지는 변수명과 일치해야 매핑됨
    	//ResonseBody 어노테이션이 없으면 Ajax 데이터를 못받음
    	
    	int result = sampleService.chkDupId(id);
    	System.out.println("controller : "+result);
    	if(result==0) //중복 데이터 x
    	{
    		model.addAttribute("result","true");
    		return "{\"result\":\"" + "true\"}";
    	}else //중복된 데이터가 있을 때 
    	{
    		model.addAttribute("result","false");
    		return "{\"result\":\"" + "false\"}";
    	}	
    }
    
    
    @RequestMapping(value="/user/loginCheck.do")
    @ResponseBody
    public String loginCheck(@RequestParam("user_id")String id, @RequestParam("user_pwd")String pwd, Model model) throws Exception{
    	String resultstr = sampleService.loginCheck(id,pwd);
    	System.out.println("controller check Id : "+resultstr);
    	model.addAttribute("result", resultstr);
    	return "{\"result\":" + resultstr +"}"; 
    }
    
    @RequestMapping(value="/wear/callRecommendedFileName.do")
    public String recommendedFileNames(@RequestParam("path")String iniPath, Model model) throws Exception{
    	String path=iniPath;
    	List<String> FileNames = new ArrayList<String>();
		
    	File dirFile=new File(path);
		File []fileList=dirFile.listFiles();
		for(File tempFile : fileList) {
			if(tempFile.isFile()) {
				String tempPath=tempFile.getParent();
	    		String tempFileName=tempFile.getName();
	    		System.out.println("Path="+tempPath);
	    		System.out.println("FileName="+tempFileName);
	    		/*** Do something withd tempPath and temp FileName ^^; ***/
	    		FileNames.add(tempFileName);
			}
    	}
		model.addAttribute("list",FileNames);
		return "{\"result\":\"" + "true\"}";
    }
    @RequestMapping(value="/user/LoginPro.do")
    public ModelAndView loginPro(CommandMap commandMap, HttpServletRequest request) throws Exception {    	
    	
    	ModelAndView mv;

    	Map<String, Object> map = sampleService.getUserDetail(commandMap.getMap());
    	map.put("ID", commandMap.get("id"));
    	map.put("PWD", commandMap.get("pwd"));
        request.getSession().setAttribute("user", map);
        mv = new ModelAndView("redirect:/wear/weathertest.do");	
	    
	    return mv;
    }

    @RequestMapping(value="/wear/mycloset.do")
    public ModelAndView mycloset (HttpServletRequest request) throws Exception {
    	ModelAndView mv = new ModelAndView("/wear/mycloset");
    	request.getSession().getAttribute("user");
    	return mv;
    }
    
    @RequestMapping(value="/logout.do")
    public ModelAndView logout (HttpServletRequest request) throws Exception {
    	ModelAndView mv = new ModelAndView("redirect:/index.do");
    	request.getSession().invalidate();
    	
    	return mv;
    }
    
    @RequestMapping(value="/wear/mycloset/top.do")
    public ModelAndView myTop (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/top");
    	request.getSession().getAttribute("user");
 	
    	return mv;
    }
    
    @SuppressWarnings("unchecked")
	@RequestMapping(value="/wear/top/sleeveless.do")
    public ModelAndView sleeveless (HttpServletRequest request) throws Exception{
    	 	
    	ModelAndView mv = new ModelAndView("/wear/sleeveless");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "top");
    	tempMap.put("SMALL", "sleeveless");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    @SuppressWarnings("unchecked")
	@RequestMapping(value="/wear/top/deletesleeveless.do")
    public ModelAndView deletesleeveless (HttpServletRequest request) throws Exception{
    	 	
    	ModelAndView mv = new ModelAndView("/wear/deletesleeveless");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "top");
    	tempMap.put("SMALL", "sleeveless");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/wear/top/Tshirt.do")
    public ModelAndView Tshirt (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/Tshirt");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "top");
    	tempMap.put("SMALL", "Tshirt");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/wear/top/longsleeves.do")
    public ModelAndView longsleeves (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/longsleeves");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "top");
    	tempMap.put("SMALL", "longsleeves");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/wear/top/shirt.do")
    public ModelAndView shirt (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/shirt");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "top");
    	tempMap.put("SMALL", "shirt");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    

    @SuppressWarnings("unchecked")
    @RequestMapping(value="/wear/top/hoodie.do")
    public ModelAndView hoodie (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/hoodie");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "top");
    	tempMap.put("SMALL", "hoodie");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/wear/top/sweater.do")
    public ModelAndView sweater (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/sweater");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "top");
    	tempMap.put("SMALL", "sweater");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    //////////////////////////
    @RequestMapping(value="/wear/mycloset/pants.do")
    public ModelAndView myPants (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/pants");
    	Map<String,Object> map = (Map<String,Object>)request.getSession().getAttribute("user");
    	map.remove("MAIN");
    	map.remove("SMALL");

    	map.put("MAIN", "pants");
    	
    	request.getSession().setAttribute("user", map);
    	request.getSession().getAttribute("user");
    	return mv;
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/wear/pants/shortPants.do")
    public ModelAndView shortPants (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/shortPants");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "pants");
    	tempMap.put("SMALL", "shortPants");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/wear/pants/trousers.do")
    public ModelAndView trousers (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/trousers");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "pants");
    	tempMap.put("SMALL", "trousers");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/wear/pants/cottonPants.do")
    public ModelAndView cottonPants (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/cottonPants");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "pants");
    	tempMap.put("SMALL", "cottonPants");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/wear/pants/fleecelinedPants.do")
    public ModelAndView fleecelinedPants (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/fleece-linedPants");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "pants");
    	tempMap.put("SMALL", "fleece-linedPants");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/wear/pants/icePants.do")
    public ModelAndView icePants (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/icePants");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "pants");
    	tempMap.put("SMALL", "icePants");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/wear/pants/skinnyPants.do")
    public ModelAndView skinnyPants (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/skinnyPants");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "pants");
    	tempMap.put("SMALL", "skinnyPants");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/wear/pants/skirt.do")
    public ModelAndView skirt (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/skirt");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "pants");
    	tempMap.put("SMALL", "skirt");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    ///////
    
    @RequestMapping(value="/wear/mycloset/outerwear.do")
    public ModelAndView myOuterwear (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/outerwear");
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("MAIN", "outerwear");
    	request.getSession().setAttribute("user", map);
    	request.getSession().getAttribute("user");
    	return mv;
    }
    
    
    @RequestMapping(value="/wear/outerwear/BubbleJacket.do")
    public ModelAndView bubbleJacket (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/BubbleJacket");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "outerwear");
    	tempMap.put("SMALL", "bubbleJacket");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    @RequestMapping(value="/wear/outerwear/cardigan.do")
    public ModelAndView cardigan (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/cardigan");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "outerwear");
    	tempMap.put("SMALL", "cardigan");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    @RequestMapping(value="/wear/outerwear/fieldJacket.do")
    public ModelAndView fieldJacket (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/fieldJacket");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "outerwear");
    	tempMap.put("SMALL", "fieldJacket");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    @RequestMapping(value="/wear/outerwear/jacket.do")
    public ModelAndView jacket (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/jacket");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "outerwear");
    	tempMap.put("SMALL", "jacket");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    @RequestMapping(value="/wear/outerwear/letherJacket.do")
    public ModelAndView letherJacket (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/letherJacket");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "outerwear");
    	tempMap.put("SMALL", "letherJacket");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    @RequestMapping(value="/wear/outerwear/shearling.do")
    public ModelAndView shearling (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/shearling");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "outerwear");
    	tempMap.put("SMALL", "shearling");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    @RequestMapping(value="/wear/outerwear/trenchCoat.do")
    public ModelAndView trenchCoat (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/trenchCoat");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "outerwear");
    	tempMap.put("SMALL", "trenchCoat");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    @RequestMapping(value="/wear/outerwear/winterCoat.do")
    public ModelAndView winterCoat (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/winterCoat");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "outerwear");
    	tempMap.put("SMALL", "winterCoat");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    
    @RequestMapping(value="/wear/mycloset/etc.do")
    public ModelAndView myEtc (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/etc");
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("main", "etc");
    	request.getSession().setAttribute("user", map);
    	request.getSession().getAttribute("user");
    	return mv;
    }

    @RequestMapping(value="/wear/etc/longUnderWear.do")
    public ModelAndView longUnderWear (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/etc/longUnderWear");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "etc");
    	tempMap.put("SMALL", "longUnderWear");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    @RequestMapping(value="/wear/etc/winterScarf.do")
    public ModelAndView winterScarf (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/etc/winterScarf");
    	
    	Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
    	tempMap.put("MAIN", "etc");
    	tempMap.put("SMALL", "winterScarf");
    	List<String> list = sampleService.viewSleevelessBoard(tempMap);
    	
    	request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);
    	return mv;
    }
    
    @RequestMapping(value="/wear/geopro.do")
    public ModelAndView gps (HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("/wear/geopro");
    	request.getSession().getAttribute("user");
    	return mv;
    }
    
    /*@RequestMapping(value="/sendMail")
    @ResponseBody//메소드에서 리턴되는 값은 View 를 통해서 출력되지 않고 HTTP Response Body 에 직접  쓰임 //http://ismydream.tistory.com/140
    private boolean sendMail(HttpSession session, @RequestParam String email){
    	int randomCode = new Random().nextInt(10000) + 1000;
    	String joinCode = String.valueOf(randomCode);
    	session.setAttribute("joinCode", joinCode);
    	
    	String subject="[오늘 뭐입지] 회원가입 승인 번호입니다";
    	StringBuilder sb = new StringBuilder();
    	sb.append("회원가입 승인 번호는 ").append(joinCode).append(" 입니다.\n");
    	
    	return sampleService.send(subject, sb.toString(), "rhdtha01@gmail.com", email);
    } */   

    @RequestMapping(value="/wear/weathertest.do")
    public ModelAndView weatherapi (HttpServletRequest request) throws Exception {
    	ModelAndView mv = new ModelAndView("/wear/weathertest");
    	
    	
	    /*Map<String,Object> tempMap = (Map<String,Object>)request.getSession().getAttribute("user");
	    	    
	    List<String> list = sampleService.viewRecommendedClothes(tempMap);
    	
	    
    	//request.getSession().setAttribute("closet", tempMap);
    	request.getSession().getAttribute("user");
    	
    	mv.addObject("list", list);*/
	    
    	    	
    	//5 day / 3 hour forecast
    	String str="";
    	try {
    	    URL url = new URL("http://api.openweathermap.org/data/2.5/forecast?q=Seoul-teukbyeolsi,kr&units=metric&appid=ef8914dd6f00d9966652895e09ebd5af");
    	 
    	    InputStream openStream = url.openStream();
    	    InputStreamReader isr1 = new InputStreamReader(openStream, "UTF-8");
    	    BufferedReader bis1 = new BufferedReader(isr1);
    	    
    	        	    
    	    str = bis1.readLine();
    	    System.out.println(str);
    	      
    	    bis1.close();
    	    isr1.close();
    	 
    	} catch (MalformedURLException e1) {
    	    // TODO Auto-generated catch block
    	    e1.printStackTrace();
    	} catch (IOException e) {
    	    // TODO Auto-generated catch block
    	    e.printStackTrace();
    	}
	    mv.addObject("daywear",str);
	    
	    //Current weather data
	    String str2="";
    	try {
    	    URL url2 = new URL("http://api.openweathermap.org/data/2.5/weather?q=Seoul-teukbyeolsi,kr&units=metric&appid=ef8914dd6f00d9966652895e09ebd5af");
    	 
    	    InputStream openStream2 = url2.openStream();
    	    InputStreamReader isr2 = new InputStreamReader(openStream2, "UTF-8");
    	    BufferedReader bis2 = new BufferedReader(isr2);
    	        	    
    	    str2 = bis2.readLine();
    	    System.out.println(str2);
    	      
    	    bis2.close();
    	    isr2.close();
    	 
    	} catch (MalformedURLException e1) {
    	    // TODO Auto-generated catch block
    	    e1.printStackTrace();
    	} catch (IOException e) {
    	    // TODO Auto-generated catch block
    	    e.printStackTrace();
    	}
	    mv.addObject("currentwear",str2);
    	return mv;
    }
    
     
    
    @RequestMapping(value="/wear/snap.do")
    public ModelAndView snap(CommandMap commandMap, HttpServletRequest request) throws Exception{
        ModelAndView mv = new ModelAndView("redirect:/wear/top.do");
         
        sampleService.insertBoard(commandMap.getMap(), request);
         
        return mv;
    }
    
}