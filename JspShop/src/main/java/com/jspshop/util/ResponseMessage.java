package com.jspshop.util;

public class ResponseMessage {
	public static String getMsgURL(String msg, String url) {

		StringBuilder sb = new StringBuilder();

		sb.append("<script>");

		sb.append("alert('" + msg + "');");
		sb.append("location.href='"+url+"';");

		sb.append("</script>");

		sb.toString();

		return sb.toString();

	}

	public static String getMsgBack(String msg) {

		StringBuilder sb = new StringBuilder();

		sb.append("<script>");

		sb.append("alert('" + msg + "');");
		sb.append("history.back()");

		sb.append("</script>");

		sb.toString();

		return sb.toString();

	}
}
