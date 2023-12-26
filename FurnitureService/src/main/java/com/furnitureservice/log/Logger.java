package com.furnitureservice.log;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

//here the idea is to create a new thread that will write the log to the file while appending the timestamp before the log.
public class Logger extends Thread {
	
	String logpath="/home/ankitborude/Desktop/log.txt";
	String Log="";
	public Logger(String Log)
	{
		Date currentDate = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String formatedDate =dateFormat.format(currentDate);
		this.Log=" [ "+formatedDate+" ] "+Log;
		
		this.run();
	}
	public synchronized void run()
	{
		try
		{		
		System.out.println(this.Log);
		FileWriter fwriter=new FileWriter(logpath,true);
		BufferedWriter writer=new BufferedWriter(fwriter);
		writer.append(this.Log);
		writer.newLine();
		writer.flush();
		writer.close();
		fwriter.close();
		}catch(IOException ie)
		{
			System.out.println(ie.getMessage());
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}

}
