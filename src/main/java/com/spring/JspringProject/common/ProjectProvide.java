package com.spring.JspringProject.common;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.imageio.ImageIO;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

@Service
public class ProjectProvide {
	
	//구글 리캡차를 위한 처리
	public static final String url = "https://www.google.com/recaptcha/api/siteverify";
	private final static String USER_AGENT = "Mozilla/5.0";
	private static String secret = "";


	//파일 저장하는 메소드 (업로드 파일명, 저장 파일명, 저장경로)
	public void writeFile(MultipartFile fName, String sFileName, String urlPath) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+urlPath+"/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
		
	}
	
	// 파일 삭제처리
	public void deleteFile(String photo, String urlPath) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+urlPath+"/");
		
		File file = new File(realPath + photo);
		if(file.exists()) file.delete();
	}

	// 파일명 중복방지를 위한 처리1
	public String saveFileName(String oFileName) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		return sdf.format(date) + "_" + oFileName;
	}
	
	// 파일명 중복방지를 위한 처리2
	public String newNameCreate(int len) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmm");
		String newName = sdf.format(date);
		newName += RandomStringUtils.randomAlphanumeric(len) + "_";
		return newName;
	}
	
	
	//QR Code 생성하기
	public void qrCodeCreate(String qrCodeName, String qrCodeImage, String urlPath) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+urlPath+"/");
		
		try {
			qrCodeImage = new String(qrCodeImage.getBytes("UTF-8"), "ISO-8859-1");
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeImage, BarcodeFormat.QR_CODE, 200, 200);
			
			int qrCodeColor = 0xFF000000;
			int qrCodeBackColor = 0xFFFFFFFF;
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
	}

	public static boolean verify(String gRecaptchaResponse) throws IOException {
    if (gRecaptchaResponse == null || "".equals(gRecaptchaResponse)) return false;
    
    try {
	    URL obj = new URL(url);
	    HttpsURLConnection conn = (HttpsURLConnection) obj.openConnection();
	
	    conn.setRequestMethod("POST");
	    conn.setRequestProperty("User-Agent", USER_AGENT);
	    conn.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
	
	    String postParams = "secret=" + secret + "&response=" + gRecaptchaResponse;
	
	    conn.setDoOutput(true);
	    DataOutputStream dos = new DataOutputStream(conn.getOutputStream());
	    dos.writeBytes(postParams);
	    dos.flush();
	    dos.close();
	
	    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	    String inputLine;
	    StringBuffer stringBuffer = new StringBuffer();
	
	    while ((inputLine = bufferedReader.readLine()) != null) {
	    	stringBuffer.append(inputLine);
	    }
	    bufferedReader.close();
	     
	    JsonReader jsonReader = Json.createReader(new StringReader(stringBuffer.toString()));
	    JsonObject jsonObject = jsonReader.readObject();
	    jsonReader.close();
	     
	    return jsonObject.getBoolean("success");
    } catch(Exception e) {
      e.printStackTrace();
      return false;
    }
  }

	 public static void setSecretKey(String key){
     secret = key;
	 }
	
	
	
}
