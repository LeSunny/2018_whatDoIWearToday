package com.bus.sender;

/*import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;
*/
import java.util.ArrayList; 
//import org.apache.log4j.Logger;

public class BusLocationNode { 
    public static void main(String[] args) {
    	
    	ArrayList<Thread> array_th_1 = new ArrayList<Thread>();
        String[] bus = {"7211","153","110B"};
        int[] kookmin = {10,18,23};
        //초기화할 위치
        int[] start1 = {5,12,8};
        int[] start2 = {1,3,2};
        
        for (int i=0; i<6; i++) { 
        	ThreadClass_1 tc;
        	if(i<3) {
        		tc = new ThreadClass_1("Thread "+bus[i]+" 1",kookmin[i],start1[i]);}
        	else {
        		tc = new ThreadClass_1("Thread "+bus[i-3]+" 2",kookmin[i-3],start2[i-3]);
        	}
            Thread th = new Thread(tc); 

            th.start(); 
            array_th_1.add(th);
        }
        
        for (int i=0; i<6; i++) {
        	Thread th = array_th_1.get(i);
        	try { 
        		th.join();
        	} catch (Exception e) { } 
        }

        System.out.println("Main End"); 
    } 
}
