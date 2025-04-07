package com.spring.JspringProject.vo;

import lombok.Data;

@Data
public class QrCodeVo {
	private int idx;
	
	// 개인정보를 담을 필드
	private String mid;
	private String name;
	private String email;
	
	// 소개하고싶은 사이트 필드
	private String moveUrl;
	
	// 영화 티켓 정보를 담는 필드
	private String movieName;
	private String movieDate;
	private String movieTime;
	private String movieAdult;
	private String movieChild;
	
	// DB에 저정(검색)된 정보 확인을 위한 필드
	private String publishDate; // 발행일자(예매일자)
	private String qrCodeName; // 서버에 저장된 QR코드 파일명
}
