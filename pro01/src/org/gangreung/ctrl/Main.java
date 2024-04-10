package org.gangreung.ctrl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.gangreung.dto.Notice;
import org.gangreung.dto.Qna;


@WebServlet("/pro01") // 요청url(주소)
public class Main extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public Main() {
        super();

    }


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String author = "강범준";
		
		// application 객체 (page - trans(request/response) - session - application) : 서버에 올려놨을 때 계속 존재할 수 있게. 
		ServletContext application = request.getServletContext();
		String realPath = request.getSession().getServletContext().getRealPath("/");
		// getsession() : 값불러오기. 어떤걸? context에서 realpath를. => http://127.0.1:8091 -> / 로 명명
		// 즉, http://127.0.1:8091/WebContent/image/이미지.jpg => Webcontent/image/이미지.jpg
		// 상수값이 아니라 어디서든 접속 가능하도록 해주는 역할
		
		application.setAttribute("realPath", realPath);
		// 값 넣어주기..
		
		List<Notice> latestNotiList = new ArrayList<>();
		List<Qna> latestQnaList = new ArrayList<>();
		
		//최근에 등록한 글 ~~개 불러오기위해 값 넣어주기 준비.
		//request.setAttribute("latestNotiList", latestNotiList);
		//request.setAttribute("latestQnaList", latestQnaList);
		
		request.setAttribute("author", author);
		request.setAttribute("exo1", "./images/exo1.jpg"); // 
		request.setAttribute("title", "강릉 경포동 소개");
		
		
		//forward 시키기.
		RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/index.jsp");
		view.forward(request, response);
	}

}
