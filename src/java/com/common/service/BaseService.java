package com.common.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.common.collection.CLog;

/**
 * Service Layer 공통 클래스
 * 
 * @since  2019.05.04
 */
public class BaseService{
	
	@Autowired
	protected CLog log;
}