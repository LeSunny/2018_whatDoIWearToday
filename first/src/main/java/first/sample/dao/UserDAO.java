package first.sample.dao;

import java.util.Map;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Repository;
import first.common.dao.AbstractDAO;


@Repository("userDAO")
public class UserDAO extends AbstractDAO {

	public void insertMember(Map<String,Object> map) throws Exception{
		/*Iterator<String> iterator = map.keySet().iterator();
	    while (iterator.hasNext()) {
	        String key = (String) iterator.next();
	        System.out.print("key="+key);
	        System.out.println(" value="+map.get(key));
	    }*/
	    
		insert("user.insertMember", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String,Object> selectMemberDetail(Map<String,Object> map) throws Exception{
		
		return (Map<String, Object>)selectOne("user.selectMemberDetail", map);
		
	}

	@SuppressWarnings("unchecked")
	public Map<String,Object> selectUserPWD(String id) throws Exception{
		return (Map<String,Object>) selectOne("user.selectUserPWD", id);
	}
	
	public int selectUserID(String id) throws Exception{
		return (int)selectOne("user.selectNumOfUserID", id);
	}
	
	public void insertPhotoFile(Map<String,Object> map) throws Exception{
		Iterator<String> iterator = map.keySet().iterator();
	    while (iterator.hasNext()) {
	        String key = (String) iterator.next();
	        System.out.print("key="+key);
	        System.out.println(" value="+map.get(key));
	    }
		insert("user.insertPhoto", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> selectFileNames(Map<String,Object> map) throws Exception{
		Iterator<String> iterator = map.keySet().iterator();
	    while (iterator.hasNext()) {
	        String key = (String) iterator.next();
	        System.out.print("key="+key);
	        System.out.println(" value="+map.get(key));
	    }
		List<Map<String,Object>> list = (List<Map<String,Object>>)selectList("user.selectFileNames", map);
		System.out.println(list);
		return list;
	}
	
	
}
