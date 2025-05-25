package servlet.admin;

import bean.Admin;
import dao.AdminDao;
import dao.impl.IAdminimpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/admin/register")
public class AdminRegister extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AdminRegister.class.getName());

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String message = "";
        try {
            // 获取表单参数
            String account = req.getParameter("account");
            String password = req.getParameter("password");
            String name = req.getParameter("name");

            // 创建Admin对象
            Admin admin = new Admin(account, password, name);

            // 插入数据库
            AdminDao adminDao = new IAdminimpl();
            boolean success = adminDao.insertAdmin(admin);

            if (success) {
                message = "管理员注册成功！";
                req.getSession().setAttribute("message", message);
                resp.sendRedirect("login.jsp");
            } else {
                message = "注册失败，请检查输入信息";
                req.setAttribute("message", message);
                req.getRequestDispatcher("/admin/register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            logger.severe("管理员注册异常: " + e.getMessage());
            message = "系统错误: " + e.getMessage();
            req.setAttribute("message", message);
            req.getRequestDispatcher("/admin/register.jsp").forward(req, resp);
        }
    }
}