package cs.dit.member;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.UUID;

@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024,
	    maxFileSize = 1024 * 1024 * 5,
	    maxRequestSize = 1024 * 1024 * 10
	)
public class MemberInsertController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String pwd = request.getParameter("pwd");

        // 📁 업로드할 경로 지정 (webapp/photos 폴더)
        String uploadPath = request.getServletContext().getRealPath("/photos");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // 📷 파일 가져오기
        Part part = request.getPart("photo"); // form input name="photo"

        // 파일명 추출
        String originalFileName = getFileName(part);
        String savedFileName = "";

        if (originalFileName != null && !originalFileName.isEmpty()) {
            // 중복 방지를 위한 UUID 붙이기 (선택사항)
            savedFileName = UUID.randomUUID().toString() + "_" + originalFileName;

            // 서버에 저장
            part.write(uploadPath + File.separator + savedFileName);
        }

        // DTO에 저장된 파일명도 함께 저장
        MemberDTO dto = new MemberDTO(id, name, pwd, savedFileName);
        MemberDAO dao = new MemberDAO();
        dao.insert(dto);

        response.sendRedirect(request.getContextPath() + "/member/list");
    }

    // 파일명 꺼내는 메소드
    private String getFileName(Part part) {
        String header = part.getHeader("Content-Disposition");
        for (String content : header.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return null;
    }
}
