package com.spring.JspringProject.vo;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@SuppressWarnings("deprecation")
//@Data
@Getter
@Setter
@ToString
public class TransactionVo {
	private int idx;
	
	@NotEmpty(message = "아이디가 공백입니다./midEmpty")
	@Size(min=2, max=20, message="아이디 길이가 잘못되었습니다./midSizeNo")
	private String mid;
	
	@NotEmpty(message = "이름이 공백입니다./nameEmpty")
	@Size(min=2, max=20, message="이름 길이가 잘못되었습니다./nameSizeNo")
	private String name;
	
	@Range(min=10, max=99, message="나이 범위를 벗어납니다./ageRangeNo")
	private int age;
	
	@Size(min=2, max=10, message="길이가 잘못되었습니다./jobSizeNo")
	private String job;
	
	private String address;
}
