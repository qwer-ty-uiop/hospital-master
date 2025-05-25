package dao.impl;

import bean.Admin;
import dao.AdminDao;
import util.DBUtil;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class IAdminimpl implements AdminDao {
    @Override
    public boolean insertAdmin(Admin admin) {
        Object[] params = {
                admin.getAccount(),
                admin.getPassword(),
                admin.getName()
        };
        String sql = "INSERT INTO admin(account, password, name) VALUES(?,?,?)";
        return DBUtil.executeUpdate(sql, params);
    }


    public boolean updateAdmin(String set, Object[] params) {
        String sql = "update admin " + set;
        return DBUtil.executeUpdate(sql, params);
    }

    public String getAidByAccount(String account) {
        String sql = "SELECT aid FROM admin WHERE account = ?";
        ResultSet rs = DBUtil.executeQuery(sql, new Object[]{account});
        try {
            if (rs.next()) {
                return rs.getString("aid");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll();
        }
        return null;
    }

    @Override
    public List<Admin> getAdmin(String account) {
        List<Admin> admins = new ArrayList<>();
        String sql = "SELECT account, name, password FROM admin WHERE account = ?";
        Object[] params = {account};
        ResultSet rs = DBUtil.executeQuery(sql, params);
        try {
            while (rs.next()) {
                admins.add(new Admin(
                        rs.getString("account"),
                        rs.getString("password"),
                        rs.getString("name")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll();
        }
        return admins;
    }
}
