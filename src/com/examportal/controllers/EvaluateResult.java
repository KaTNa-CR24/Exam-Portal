package com.examportal.controllers;

import com.user.QueAnswers;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Iterator;

//import jdk.nashorn.internal.parser.JSONParser;

/**
 * Servlet implementation class EvaluateResult
 */
@WebServlet("/EvaluateResult")
public class EvaluateResult extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EvaluateResult() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		try {
			//System.out.println(request.getInputStream());
			BufferedReader br = 
					new BufferedReader(new InputStreamReader(request.getInputStream()));	
			String jsonStr = "";
			if(br != null){
				jsonStr = br.readLine();
				System.out.println(jsonStr);
			}			
			JSONObject jsony = new JSONObject(jsonStr);
			HashMap<String, String> answers = QueAnswers.getAnswers();
			
			System.out.println("jsony " + jsony);
			System.out.println("answers " + answers);
			
			String a,b;
			int count = 0;
			Iterator<String> keys = jsony.keys();
			while(keys.hasNext()){
				String key = keys.next();
				//System.out.println(key + " --- " + jsony.get(key).toString());
				a = jsony.get(key).toString();
				b = answers.get(key).toString();
				if(a.equals(b)){
					count++;
				}
			}
			System.out.println(count);
	
			response.getWriter().print(count);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void main(String []a) throws Exception{
		String jsonStr = "{'1':'a','2':'b'}";		
		JSONObject jsony = new JSONObject(jsonStr);
		System.out.println(jsony.get("1"));
		
		HashMap<String, String> answers = QueAnswers.getAnswers();
		System.out.println(answers);

	}
}

