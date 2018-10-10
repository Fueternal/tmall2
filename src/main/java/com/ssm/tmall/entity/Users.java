package com.ssm.tmall.entity;

public class Users {
    private Integer userId;

    private String userName;

    private String password;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }
    
    //增加一个getAnonymousName方法用于在显示评价者的时候进行匿名显示
    public String getAnonymousName() {
		if (userName == null) {
			return null;
		}
		if (userName.length()<=1) {
			return "*";
		}
		if (userName.length()==2) {
			return userName.substring(0, 1) + "*";
		}
		
		char[] ns = userName.toCharArray();
		for (int i = 1; i < ns.length-1; i++) {
			ns[i] = '*';
		}
		return new String(ns);
	}
    
}