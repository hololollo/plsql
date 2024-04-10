package org.ganreung.ctrl.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.gangreung.dao.MemberDAO;
import org.gangreung.dto.Member;


@WebServlet("/LogInPro.do")
public class LogInProCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public LogInProCtrl() {
        super();
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemberDAO dao = new MemberDAO();
		Member mem = dao.getMember(id);
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		RequestDispatcher view;
		
		if(id.equals(mem.getId()) && pw.equals(mem.getPw()) ) { // 로그인 비교 대상
			session.setAttribute("sid", mem.getId());
			session.setAttribute("sname", mem.getName());
			response.sendRedirect("/pro01"); // 로그인에 성공하면 첫화면으로.
		} else if (id.equals(mem.getId())) { // 둘중 하나만 맞은경우(아이디만)
			// 자바 스크립트
			// response.sendRedirect("/member/login.jsp?msg=해당 회원의 비밀번호가 일치하지 않습니다.");
			 // out.println("<script>history.go(-1);</script>");
			request.setAttribute("msg", "해당 회원의 비밀번호가 일치하지 않습니다.");
			view = request.getRequestDispatcher("/member/login.jsp");
			view.forward(request, response);
		} else {
			request.setAttribute("msg", "해당 회원이 존재하지 않습니다.");
			view = request.getRequestDispatcher("/member/login.jsp");
			view.forward(request, response);
			
			
		}
		
		
	
	}

}
