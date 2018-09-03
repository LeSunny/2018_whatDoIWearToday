package first.sample.service;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.DatatypeConverter;

import org.springframework.stereotype.Component;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import first.common.util.FileUtils;
import first.sample.dao.SampleDAO;
import first.sample.dao.UserDAO;
import sun.misc.BASE64Decoder;
import first.common.util.CommonUtils;

import java.util.Iterator;

@Service("sampleService")
public class SampleServiceImpl implements SampleService {
	Logger log = Logger.getLogger(this.getClass());

	private final JavaMailSender javaMailSender;
	
	@Autowired
	public SampleServiceImpl(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Resource(name="sampleDAO")
	private SampleDAO sampleDAO;
	
	@Resource(name="userDAO")
	private UserDAO userDAO;
	
	@Override
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception {
		return sampleDAO.selectBoardList(map);
	}

	private static String filePath = "C:\\dev\\workspace\\first\\src\\main\\webapp\\resources\\images\\file\\";

	@Override
	public void insertBoard(Map<String, Object> map, HttpServletRequest request) throws Exception {
		sampleDAO.insertBoard(map);
		
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(map, request);
		for(int i=0, size=list.size(); i<size; i++){
			sampleDAO.insertFile(list.get(i));
		}
	}

	@Override
	public void uploadImage(Map<String,Object> map, HttpServletRequest request) throws Exception{
		// image : randome 한 32B 이름
		int start = ((String)map.get("IMAGE")).indexOf(",")+1;
		String str = ((String)map.get("IMAGE")).substring(start, ((String)map.get("IMAGE")).length());
		//System.out.println("str = " + str);
		//String result = str.substring(0, str.length());
		byte[] imageBytes = DatatypeConverter.parseBase64Binary(str);
		
		// 저장될 파일 이름
		String storedFileName = CommonUtils.getRandomString()+".png";
		map.put("STORED_FILE_NAME", storedFileName);
		System.out.println("STORED_FILE_NAME = "+map.get("STORED_FILE_NAME"));
		
		userDAO.insertPhotoFile(map);
		
		Iterator<String> iterator = map.keySet().iterator();
	    while (iterator.hasNext()) {
	        String key = (String) iterator.next();
	        System.out.print("key="+key);
	        System.out.println(" value="+map.get(key));
	    }
		
		//저장 위치 디렉토리 만들기
	    String tempLink =map.get("ID")+"\\"+map.get("MAIN")+"\\"+map.get("SMALL")+"\\"; 
		filePath += tempLink;
		File file = new File(filePath);
		if(file.exists() == false){
			file.mkdirs();
		}
		
		//저장
		ByteArrayInputStream bis = new ByteArrayInputStream( imageBytes );
		BufferedImage image = ImageIO.read(bis);
		bis.close();
		System.out.println(image);
		ImageIO.write(image, "png", new File(filePath+storedFileName));
		
		filePath = "C:\\\\dev\\workspace\\first\\src\\main\\webapp\\resources\\images\\file\\";
			
	}
	
	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		sampleDAO.updateHitCnt(map);
		Map<String, Object> resultMap = new HashMap<String,Object>();
		Map<String, Object> tempMap = sampleDAO.selectBoardDetail(map);
		resultMap.put("map", tempMap);
		
		List<Map<String,Object>> list = sampleDAO.selectFileList(map);
		resultMap.put("list", list);
		
		return resultMap;
	}
	
	@Override
	public List<String> viewSleevelessBoard(Map<String,Object> map) throws Exception{
		//링크의 이미지를 반환
		String path = (String)map.get("ID")+"\\"+(String)map.get("MAIN")+"\\"+(String)map.get("SMALL")+"\\";
		List<Map<String,Object>> list= userDAO.selectFileNames(map);
		System.out.println(list);

		List<String> pathArr = new ArrayList<String>();

		for(Map<String,Object> map1 : list) {
			for(Map.Entry<String, Object> entry : map1.entrySet()) {
				//String key = entry.getKey();
				Object value = entry.getValue();
				pathArr.add(path+value);
			}
		}
		
		/*for(int i=0; i<pathArr.size(); i++) {
			System.out.format("[%d] = %s%n",i,pathArr.get(i));
		}*/
		
		return pathArr;
		
	}
	

	@Override
	public void updateBoard(Map<String, Object> map, HttpServletRequest request) throws Exception{
		sampleDAO.updateBoard(map);
		
		sampleDAO.deleteFileList(map);
		List<Map<String,Object>> list = fileUtils.parseUpdateFileInfo(map, request);
		Map<String,Object> tempMap = null;
		for(int i=0, size=list.size(); i<size; i++){
			tempMap = list.get(i);
			if(tempMap.get("IS_NEW").equals("Y")){
				sampleDAO.insertFile(tempMap);
			}
			else{
				sampleDAO.updateFile(tempMap);
			}
		}
	}

	@Override
	public void deleteBoard(Map<String, Object> map) throws Exception {
		sampleDAO.deleteBoard(map);
	}

	
	@Override
    public void insertMember(Map<String, Object> map) throws Exception{
	
		/*
		Iterator<String> iterator = map.keySet().iterator();
	    while (iterator.hasNext()) {
	        String key = (String) iterator.next();
	        System.out.print("key="+key);
	        System.out.println(" value="+map.get(key));
	    }*/
	    
		String encryptPassword = passwordEncoder.encode((String)map.get("pwd"));
		map.remove("pwd");
		map.put("pwd", encryptPassword);
		
	    String mail = map.get("email1")+"@"+(String)map.get("email2");
	    map.put("email", mail);
	    
	    if(map.get("cold")==null) {
	    	map.remove("cold");
	    	map.put("cold", "off");
	    }
	    if(map.get("hot")==null) {
	    	map.remove("hot");
	    	map.put("hot", "off");
	    }
	    userDAO.insertMember(map);
	    
    }
	
	@Override
    public Map<String,Object> getUserDetail(Map<String, Object> map) throws Exception{
		return userDAO.selectMemberDetail(map);
	}
	
	@Override
	public int chkDupId(String id) throws Exception{
		int check=-1;
		int numOfdbID = userDAO.selectUserID(id);
		if(numOfdbID==0) { //중복이 아니라면
			check = 0;
		}
		return check;
	}
	
	@Override
	public String loginCheck(String id, String pwd) throws Exception{
		String result="";
		
		/*회원인지 확인*/
		int numOfdbID = userDAO.selectUserID(id);
		if(numOfdbID==0) // 회원이 아닌 경우(아이디가 없을 때)
			result ="false";
		else //회원일 경우 
		{
			Map<String, Object> tempmap = userDAO.selectUserPWD(id);
			String dbpwd = (String) tempmap.get("PWD");
			if(passwordEncoder.matches(pwd, dbpwd )){ // 비밀번호 일치
				result = "true";
			}else {// 비밀번호 불일치
				result = "false";
			}
		}
		return result;
	}
	
	/*@Override
	public boolean send(String subject, String text, String from, String to) {
		MimeMessage message = javaMailSender.createMimeMessage();
		
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setSubject(subject);
			helper.setText(text);
			helper.setFrom(from);
			helper.setTo(to);
			
			javaMailSender.send(message);
			return true;
		}catch(MessagingException e) {
			e.printStackTrace();
		}
		return false;
	}*/
	
}
