package com.LearnerAcademy.DBConfig;

public class DBConfig {
	
	String driverName = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String dbName = "learnersacademy";
	String userId = "root";
	String password = "root12345";
	
	

	public String getDriverName() {
		return driverName;
	}



	public String getConnectionUrl() {
		return connectionUrl;
	}



	public String getDbName() {
		return dbName;
	}



	public String getUserId() {
		return userId;
	}



	public String getPassword() {
		return password;
	}


}
