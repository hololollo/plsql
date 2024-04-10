package org.gangreung.ctrl.notice;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.gangreung.dao.NoticeDAO;
import org.gangreung.dto.Notice;


@WebServlet("/NotiIns.do") // 글 작성
public class NotiInsCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public NotiInsCtrl() {
        super();

    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		Notice noti = new Notice();
		
		noti.setTitle(request.getParameter("title"));
		noti.setContent(request.getParameter("content"));
		
		NoticeDAO dao = new NoticeDAO();
		int cnt = dao.insNotice(noti);
		
		
		if(cnt > 0) {
			System.out.println("공지사항 추가");
		} else {
			System.out.println("공지사항 추가 실패");
		}
		
		// 글 등록 누르면 목록화면으로 이동하는 로직 
		ServletContext application = request.getServletContext();
		String home = application.getContextPath();
		if(cnt>0) {
			response.sendRedirect(home+"/NotiList.do");
		} else {
			response.sendRedirect(home+"/notice/noti_ins.jsp");
		}
		
	}
}
