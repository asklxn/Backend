package controller;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLDecoder;
import java.nio.file.*;

@WebServlet("/uploads/*")
public class ImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String filename = request.getPathInfo(); // 예: /abc.jpg

        if (filename == null || filename.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // ✅ 슬래시 제거 및 URL 디코딩
        filename = URLDecoder.decode(filename.substring(1), "UTF-8"); // abc.jpg

        // ✅ 실제 저장 경로 지정
        String uploadPath = request.getServletContext().getRealPath("/uploads");
        File file = new File(uploadPath, filename); // uploads/abc.jpg

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // ✅ MIME 타입 설정
        String mime = getServletContext().getMimeType(file.getName());
        if (mime == null) {
            mime = "application/octet-stream";
        }
        response.setContentType(mime);

        // ✅ 파일 스트림 전송
        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int length;
            while ((length = in.read(buffer)) != -1) {
                out.write(buffer, 0, length);
            }
        }
    }
}
