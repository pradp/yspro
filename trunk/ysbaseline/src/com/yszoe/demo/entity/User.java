package com.yszoe.demo.entity;

import java.io.Serializable;

public class User implements Serializable, Cloneable {

	private static final long serialVersionUID = 1L;
	private int id;
	private String name;

	public User(int userId, String username) {
		super();
		this.id = userId;
		this.name = username;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public User() {
		super();
	}
}