package com.user;

import org.json.JSONArray;
import org.json.JSONObject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;


@SuppressWarnings("deprecation")
public class QueAnswers {

	public static Connection getConn() throws Exception {
//		Connection conn = null;
		String url = System.getenv("RDS_DB_URL");
		String username = System.getenv("RDS_DB_USERNAME");
		String password = System.getenv("RDS_DB_PASSWORD");

		try {
			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
			return DriverManager.getConnection(url, username, password);
		} catch (Exception e) {
		}

		return null;
	}


	public static org.json.JSONArray getAllQuestions() throws Exception {
		Statement stmt = getConn().createStatement();
		String sqlstr = "SELECT * FROM questions ORDER BY RAND();";
		ResultSet rs = stmt.executeQuery(sqlstr);

		org.json.JSONObject jsonObj = new JSONObject();
		org.json.JSONArray jsonArray = new JSONArray();
		while (rs.next()) {
			JSONObject record = new JSONObject();
			record.put("qid", rs.getString(1));
			record.put("description", rs.getString(2));
			record.put("optionA", rs.getString(3));
			record.put("optionB", rs.getString(4));
			record.put("optionC", rs.getString(5));
			record.put("optionD", rs.getString(6));
			// jsonArray.add(record);
			jsonArray.put(record);
		}
//		jsonObj.put("Questions", jsonArray);


		return jsonArray;
	}

	public static org.json.JSONArray getQuestionPaper() throws Exception {
		org.json.JSONArray jsonArr = new org.json.JSONArray();
		jsonArr = getAllQuestions();
		return jsonArr;

	}

	public static HashMap<String, String> getAnswers() throws Exception {
		Statement stmt = getConn().createStatement();
		String sqlstr = "SELECT * FROM answers";
		ResultSet rs = stmt.executeQuery(sqlstr);
		HashMap<String, String> records = new HashMap<>();
		while (rs.next()) {
			records.put(rs.getString(1), rs.getString(2));
		}
		return records;

	}

}



