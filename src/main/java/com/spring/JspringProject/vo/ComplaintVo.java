package com.spring.JspringProject.vo;

import lombok.Data;

@Data
public class ComplaintVo {
	private int idx;
	private String part;
	private int partIdx;
	private String cpMid;
	private String cpContent;
	private String cpDate;
}
