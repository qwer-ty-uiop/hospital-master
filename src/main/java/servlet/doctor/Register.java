package servlet.doctor;

import bean.Doctor;
import bean.WorkDay;
import dao.DoctorDao;
import dao.WorkDayDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Logger;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
@WebServlet("/doctor/register")
public class Register extends HttpServlet {
    private static final Logger logger = Logger.getLogger(Register.class.getName());

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String message = "";
        try {
            // 1. 获取表单字段
            String account = req.getParameter("account");
            String password = req.getParameter("password");
            String dname = req.getParameter("dname");
            String fee = req.getParameter("fee");
            String gender = req.getParameter("gender");
            String age = req.getParameter("age");
            String office = req.getParameter("office");
            String room = req.getParameter("room");
            String career = req.getParameter("career");
            String description = req.getParameter("description");

            // 2. 构造Doctor对象
            Doctor doctor = new Doctor(
                    null, account, password, dname, fee, gender,
                    age, office, room, career, description, null
            );

            // 3. 插入医生数据
            DoctorDao doctorDao = new DoctorDao();
            boolean insertSuccess = doctorDao.insert(doctor);
            logger.info("插入医生信息结果: " + insertSuccess);

            if (insertSuccess) {
                // 关键修改点：通过账号查询数据库获取真实did
                String did = doctorDao.getDidByAccount(account);
                logger.info("通过账号查询到的医生ID: " + did);

                if (did == null) {
                    message = "注册失败，无法获取医生ID！";
                    req.setAttribute("message", message);
                    req.getRequestDispatcher("/doctor/register.jsp").forward(req, resp);
                    return; // 直接终止后续流程
                }

                // 4. 初始化工作日数据
                WorkDayDao workDayDao = new WorkDayDao();
                for (int i = 0; i < 7; i++) { // 0=周一, 6=周日
                    // 上午
                    WorkDay am = new WorkDay();
                    am.setDid(did);
                    am.setWorktime(String.valueOf(i));
                    am.setAmpm("上午");
                    am.setNsnum("10");
                    am.setState("预约");
                    boolean amInserted = workDayDao.insert(am);
                    logger.info("插入[" + i + "]上午结果: " + amInserted);

                    // 下午
                    WorkDay pm = new WorkDay();
                    pm.setDid(did);
                    pm.setWorktime(String.valueOf(i));
                    pm.setAmpm("下午");
                    pm.setNsnum("10");
                    pm.setState("预约");
                    boolean pmInserted = workDayDao.insert(pm);
                    logger.info("插入[" + i + "]下午结果: " + pmInserted);
                }

                // 5. 处理文件上传（逻辑保持不变）
                Part part = req.getPart("picpath");
                if (part != null && part.getSize() > 0 && part.getSize() < 1024 * 1024) {
                    String fileName = part.getSubmittedFileName();
                    String ext = fileName.substring(fileName.lastIndexOf("."));
                    String realPath = getServletContext().getRealPath("images/docpic");

                    File uploadDir = new File(realPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();

                    String filePath = realPath + File.separator + dname + ext;
                    try (InputStream is = part.getInputStream();
                         FileOutputStream fos = new FileOutputStream(filePath)) {
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = is.read(buffer)) != -1) {
                            fos.write(buffer, 0, bytesRead);
                        }
                        // 更新数据库图片路径
                        String picPath = "/hospital/images/docpic/" + dname + ext;
                        String set = "set picpath=? where did=?";
                        doctorDao.update(set, new Object[]{picPath, did});
                    }
                }

                message = "注册成功！";
                req.getSession().setAttribute("message", message);
                resp.sendRedirect("login.jsp");
            } else {
                message = "注册失败，请重试！";
                req.setAttribute("message", message);
                req.getRequestDispatcher("/doctor/register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            logger.severe("注册异常: " + e.getMessage());
            message = "系统错误: " + e.getMessage();
            req.setAttribute("message", message);
            req.getRequestDispatcher("/doctor/register.jsp").forward(req, resp);
        }
    }
}