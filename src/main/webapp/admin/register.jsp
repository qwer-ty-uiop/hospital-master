<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员注册 - 医院管理系统</title>
    <jsp:include page="include/headtag.jsp"/>
    <style>
        :root {
            --primary-color: #4361ee;
            --success-color: #06d6a0;
            --danger-color: #ef476f;
        }

        .register-container {
            min-height: 100vh;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .register-card {
            background: #fff;
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 420px;
            overflow: hidden;
        }

        .card-header {
            background: var(--primary-color);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .card-header h3 {
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .card-body {
            padding: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            color: #495057;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 2px solid #e9ecef;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
            font-size: 1rem;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
            outline: none;
        }

        .password-match {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .valid .password-match {
            color: var(--success-color);
            opacity: 1;
        }

        .invalid .password-match {
            color: var(--danger-color);
            opacity: 1;
        }

        .btn-register {
            background: var(--primary-color);
            color: white;
            width: 100%;
            padding: 1rem;
            border: none;
            border-radius: 0.5rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-register:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            color: #6c757d;
        }

        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .alert-danger {
            background: #fff5f5;
            color: var(--danger-color);
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid #ffd6d6;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
    </style>
</head>
<body>
<div class="register-container">
    <div class="register-card">
        <div class="card-header">
            <h3>管理员注册</h3>
            <p>请填写注册信息</p>
        </div>

        <div class="card-body">
            <c:if test="${not empty message}">
                <div class="alert-danger">
                    <i class="bi bi-exclamation-circle-fill"></i>
                        ${message}
                </div>
            </c:if>

            <form id="registerForm" method="post" action="<%=request.getContextPath()%>/admin/register">
                <div class="form-group">
                    <label class="form-label">登录账号</label>
                    <input type="text"
                           name="account"
                           class="form-control"
                           placeholder="请输入工作账号"
                           required>
                </div>

                <div class="form-group">
                    <label class="form-label">姓名</label>
                    <input type="text"
                           name="name"
                           class="form-control"
                           placeholder="请输入真实姓名"
                           required>
                </div>

                <div class="form-group">
                    <label class="form-label">登录密码</label>
                    <input type="password"
                           name="password"
                           class="form-control"
                           placeholder="至少8位字符"
                           minlength="8"
                           required>
                </div>

                <div class="form-group">
                    <label class="form-label">确认密码</label>
                    <input type="password"
                           name="passwordConf"
                           class="form-control"
                           placeholder="请再次输入密码"
                           required>
                    <i class="bi bi-check-circle-fill password-match"></i>
                </div>

                <button type="submit" class="btn-register">立即注册</button>
            </form>

            <div class="login-link">
                已有账号？<a href="login.jsp">立即登录</a>
            </div>
        </div>
    </div>
</div>

<script>
    // 实时密码验证
    const password = document.querySelector('input[name="password"]');
    const passwordConf = document.querySelector('input[name="passwordConf"]');
    const formGroup = passwordConf.closest('.form-group');
    const matchIcon = formGroup.querySelector('.password-match');

    function validatePassword() {
        if (password.value && passwordConf.value) {
            if (password.value === passwordConf.value) {
                formGroup.classList.add('valid');
                formGroup.classList.remove('invalid');
                matchIcon.classList.replace('bi-x-circle-fill', 'bi-check-circle-fill');
            } else {
                formGroup.classList.add('invalid');
                formGroup.classList.remove('valid');
                matchIcon.classList.replace('bi-check-circle-fill', 'bi-x-circle-fill');
            }
        }
    }

    passwordConf.addEventListener('input', validatePassword);
    password.addEventListener('input', validatePassword);
</script>
</body>
</html>