package com.examportal.controllers;

import com.user.QueAnswers;
import org.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class MakeQuestionPaper
 */
@SuppressWarnings("deprecation")
@WebServlet("/MakeQuestionPaper")
public class MakeQuestionPaper extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MakeQuestionPaper() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		System.out.println("In servlet MakeQuestionPaper");
		
			 
			try {
				 JSONArray res = QueAnswers.getQuestionPaper();
				 System.out.println(res);
				 System.out.println(res.toString());

				 response.setContentType("application/json");
				 
				 response.getWriter().write(QueAnswers.getQuestionPaper().toString());
					
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		 
		
		

		
	}

}
