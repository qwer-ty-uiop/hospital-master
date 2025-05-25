<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员注册--在线预约挂号系统</title>
    <jsp:include page="include/headtag.jsp"/>
    <style>
        body {
            background-image: url("/images/admin-bg.jpg");
            background-size: cover;
            text-align: center;
        }

        .admin-form-box {
            margin: 2rem auto;
            width: 550px;
            color: #2c3e50;
        }

        .admin-form-top {
            background: rgba(255, 255, 255, 0.9);
            padding: 1.5rem 2rem;
            border-radius: 8px 8px 0 0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .admin-form-bottom {
            background: rgba(255, 255, 255, 0.85);
            padding: 2rem;
            border-radius: 0 0 8px 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .admin-title {
            color: #3498db;
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #bdc3c7;
            border-radius: 4px;
            transition: border-color 0.3s ease;
        }

        input:focus, select:focus {
            border-color: #3498db;
            outline: none;
        }

        .btn-admin {
            background: #3498db;
            color: white;
            padding: 1rem;
            width: 100%;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: opacity 0.3s;
        }

        .btn-admin:hover {
            opacity: 0.9;
        }

        .security-code {
            background: #f8f9fa;
            border: 2px dashed #bdc3c7;
            padding: 1rem;
            margin: 1rem 0;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<div class="admin-form-box">
    <div class="admin-form-top">
        <h3 class="admin-title">🔑 管理员账户注册</h3>
        <p>请输入管理权限信息</p>
        <p class="text-danger" id="errorTip">${message}</p>
    </div>

    <div class="admin-form-bottom">
        <form action="<%=request.getContextPath()%>/admin/register" method="post" id="adminForm">
            <!-- 权限验证 -->
            <div class="form-group">
                <label>授权码 <span class="text-danger">*</span></label>
                <div class="security-code">
                    <input type="text"
                           name="authCode"
                           placeholder="请输入系统提供的安全授权码"
                           required
                           pattern="ADM-\d{4}-[A-Z]{3}">
                    <p class="text-muted" style="margin-top: 0.5rem;">格式：ADM-1234-ABC</p>
                </div>
            </div>

            <!-- 基础信息 -->
            <div class="form-group">
                <label>管理员账号 <span class="text-danger">*</span></label>
                <input type="text"
                       name="account"
                       placeholder="请输入工作账号"
                       required
                       minlength="6">
            </div>

            <div class="form-group">
                <label>姓名 <span class="text-danger">*</span></label>
                <input type="text"
                       name="name"
                       placeholder="请输入真实姓名"
                       required>
            </div>

            <!-- 权限设置 -->
            <div class="form-group">
                <label>管理权限级别 <span class="text-danger">*</span></label>
                <select name="role" required>
                    <option value="">请选择权限级别</option>
                    <option value="super">系统管理员</option>
                    <option value="audit">审计管理员</option>
                    <option value="ops">运维管理员</option>
                </select>
            </div>

            <!-- 安全验证 -->
            <div class="form-group">
                <label>密码 <span class="text-danger">*</span></label>
                <input type="password"
                       name="password"
                       id="adminPassword"
                       placeholder="至少8位，包含字母和数字"
                       required
                       minlength="8"
                       pattern="^(?=.*[A-Za-z])(?=.*\d).+$">
            </div>

            <div class="form-group">
                <label>确认密码 <span class="text-danger">*</span></label>
                <input type="password"
                       name="passwordConf"
                       placeholder="请再次输入密码"
                       required
                       oninput="checkAdminPassword()">
                <span id="adminPwdTip" class="text-danger"></span>
            </div>

            <div class="form-group">
                <button type="submit" class="btn-admin">创建管理员账户</button>
            </div>
        </form>

        <div style="margin-top: 1.5rem; text-align: center;">
            <a href="login.jsp" style="color: #3498db;">已有管理账户？立即登录</a>
        </div>
    </div>
</div>

<script>
    // 增强密码验证
    function checkAdminPassword() {
        const pwd = document.getElementById('adminPassword').value;
        const pwdConf = document.querySelector('input[name="passwordConf"]');
        const tip = document.getElementById('adminPwdTip');

        // 实时验证反馈
        if (pwdConf.value) {
            if (pwd !== pwdConf.value) {
                tip.textContent = "⚠️ 密码不一致";
                pwdConf.setCustomValidity("密码不一致");
            } else if (!/(?=.*[A-Za-z])(?=.*\d)/.test(pwd)) {
                tip.textContent = "⚠️ 需包含字母和数字";
                pwdConf.setCustomValidity("密码复杂度不足");
            } else {
                tip.textContent = "✅ 密码可用";
                pwdConf.setCustomValidity("");
            }
        }
    }

    // 表单提交前最终验证
    document.getElementById('adminForm').onsubmit = function() {
        const authCode = document.querySelector('input[name="authCode"]');
        if (!/^ADM-\d{4}-[A-Z]{3}$/.test(authCode.value)) {
            alert('授权码格式错误');
            return false;
        }
        return true;
    }
</script>
</body>
</html>