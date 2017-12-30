package com.bus.sender;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;


//처음 출발하는 버스 -> 7211 153 110B
class ThreadClass_1 implements Runnable { // Runnable Interface 구현 
    String thread_name; 
    int time, kookmin, cnt;

	private static String url = ActiveMQConnection.DEFAULT_BROKER_URL;
	
	private static String subject = "JCG_QUEUE";

	
	//시간은 좀 더 늘이기 -> 30초
	public ThreadClass_1(String name, int num, int start) { 
		System.out.println(name + " Thread Start"); 
		this.thread_name = name; 
		this.kookmin = num;
		this.cnt = start;
		time=0;
	} 

	public void run() { 
	  
		ConnectionFactory connectionFactory;
		Connection connection;
		Session session;
		Destination destination;
		MessageProducer producer;
	  
		while(cnt!=kookmin) {
			try{
				connectionFactory = new ActiveMQConnectionFactory(url);
				connection = connectionFactory.createConnection();
				connection.start();
    	  		
				session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);	

				destination = session.createQueue(subject);	
    	  		
				producer = session.createProducer(destination);
    	  		
    	      	if(time%6000==0) {
    	      		cnt++;
    	      		time=0;
    	      	}
    	      	if(cnt==kookmin-1) {
    	      		TextMessage message = session.createTextMessage("곧 도착 : "+thread_name+"번 버스 "+(6000-time)+" 후");
    	      		
    	      		producer.send(message);
    	      		
    	      		//System.out.println("JCG printing@@ '" + message.getText() + "'");
    	      		
    	      	}else {
    	      		TextMessage message = session.createTextMessage(thread_name+"번 버스 "+cnt+"번째 정류장 지난지 "+time+" 경과");
    	      		
    	      		producer.send(message);
    	      		
    	      		//System.out.println("JCG printing@@ '" + message.getText() + "'");

    	      	}  
    	      	
    	      	connection.close();
    	  }catch(JMSException e) {}
  		
      	// thread가 중단되었을 때 발생하는 예외 -> sleep() 함수를 썼다가 대기상태에서 빠져나오지 못했을 때 발생하는 예외
      	try { 
              Thread.sleep(10000); 
              time+=10000;
          } catch (InterruptedException e) { e.printStackTrace(); } //에러가 발생한 메써드의 호출 기록을 출력! (StackTrace : Stack에 메써드가 호출된 기록을 남기는 것. )
      } 
      	System.out.println(thread_name + " Thread End");

      } 
}