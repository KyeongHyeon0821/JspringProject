package com.spring.JspringProject.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardVo {
	private int idx;
	private String mid;
	private String nickName;
	private String title;
	private String content;
	private String hostIp;
	private String openSw;
	private String readNum;
	private String wDate;
	private String good;
	private String complaint;
	
	private int hoursDiff;
	
	private int replyCnt; // 댓글의 갯수를 저장하는 변수
}
