<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>医生注册--在线预约挂号系统</title>
    <jsp:include page="include/headtag.jsp"/>
    <style>
        body {
            background-image: url("/images/1.jpg");
            background-size: 100%;
            text-align: center;
        }

        .form-box {
            margin: 0 auto;
            width: 550px;
            color: #fff;
        }

        .form-box a {
            color: #de615e;
            text-decoration: none;
        }

        .form-top {
            overflow: hidden;
            padding: 0 25px 15px 25px;
            background: #444;
            background: rgba(0, 0, 0, 0.35);
            border-radius: 4px 4px 0 0;
            text-align: left;
        }

        .form-bottom {
            padding: 25px 25px 30px 25px;
            background: rgba(0, 0, 0, 0.3);
            border-radius: 0 0 4px 4px;
            text-align: left;
        }

        .form-top-left {
            float: left;
            width: 75%;
            padding-top: 25px;
        }

        .form-top-left h3 {
            margin-top: 0;
            color: #969696;
        }

        .form-top-left p {
            opacity: 0.8;
            color: #fff;
        }

        .text-danger {
            color: #b94a48;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .col-xs-12 {
            width: 100%;
            padding: 0 15px;
        }

        .sr-only {
            position: absolute;
            clip: rect(0, 0, 0, 0);
        }

        input[type="text"],
        input[type="password"],
        input[type="number"],
        textarea,
        select {
            display: block;
            width: 90%;
            height: 50px;
            padding: 0 20px;
            background: #fff;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            color: #888;
        }

        textarea {
            height: auto;
            padding: 15px;
            line-height: 1.5;
        }

        .btn {
            width: 90%;
            height: 50px;
            background: #de615e;
            color: #fff;
            border: 0;
            border-radius: 4px;
        }

        .pull-right {
            float: right;
        }

        input[type="radio"] {
            margin-right: 5px;
        }
    </style>
</head>
<body>
<div class="form-box">
    <div class="form-top">
        <div class="form-top-left">
            <h3 style="color: #969696;">医生注册</h3>
            <p>请输入执业信息</p>
        </div>
        <div class="pull-right-bottom">
            <p class="text-danger" id="errorTip">${message}</p>
        </div>
    </div>
    <div class="form-bottom">
        <form role="form" action="<%=request.getContextPath()%>/doctor/register" method="post" class="login-form"
              enctype="multipart/form-data">
            <!-- 基础信息 -->
            <div class="form-group col-xs-12">
                <label>账号(*):</label>
                <input type="text" name="account" required>
            </div>

            <div class="form-group col-xs-12">
                <label>姓名(*):</label>
                <input type="text" name="dname" required>
            </div>

            <!-- 医生信息 -->
            <div class="form-group col-xs-12">
                <label>诊费(*):</label>
                <input type="number" name="fee" required>
            </div>

            <div class="form-group col-xs-12">
                <label>年龄(*):</label>
                <input type="number" name="age" required>
            </div>

            <div class="form-group col-xs-12">
                <label>性别(*):</label>
                <div style="margin-top: 8px;">
                    <label><input type="radio" name="gender" value="男" required> 男</label>
                    <label style="margin-left: 20px;"><input type="radio" name="gender" value="女"> 女</label>
                </div>
            </div>

            <div class="form-group col-xs-12">
                <label>科室(*):</label>
                <select name="office" required>
                    <option value="">请选择科室</option>
                    <option>内科</option>
                    <option>外科</option>
                    <option>儿科</option>
                </select>
            </div>

            <div class="form-group col-xs-12">
                <label>诊室:</label>
                <input type="text" name="room">
            </div>

            <div class="form-group col-xs-12">
                <label>职称(*):</label>
                <select name="career" required>
                    <option value="">请选择职称</option>
                    <option>主任医师</option>
                    <option>副主任医师</option>
                    <option>主治医师</option>
                </select>
            </div>

            <div class="form-group col-xs-12">
                <label>个人描述:</label>
                <textarea name="description" rows="3"></textarea>
            </div>

            <div class="form-group col-xs-12">
                <label>上传头像:</label>
                <input type="file" name="picpath" accept="image/*">
                <p class="text-muted">支持格式：jpg/png，大小不超过2MB</p>
            </div>

            <!-- 密码 -->
            <div class="form-group col-xs-12">
                <label>密码(*):</label>
                <input type="password" name="password" required>
            </div>

            <div class="form-group col-xs-12">
                <label>确认密码(*):</label>
                <input type="password" name="passwordConf" required onkeyup="checkPassword()">
                <span id="pwdTip" class="text-danger"></span>
            </div>

            <div class="form-group col-xs-12">
                <button type="submit" class="btn">立即注册</button>
            </div>
        </form>

        <div style="margin-top: 20px;">
            <span><a href="doctor_findPwd.jsp">找回密码</a></span>
            <span><a href="doctor_login.jsp" class="pull-right">医生登录</a></span>
        </div>
    </div>
</div>

<script>
    // 密码一致性验证
    function checkPassword() {
        const pwd1 = document.querySelector('input[name="password"]').value;
        const pwd2 = document.querySelector('input[name="passwordConf"]').value;
        const tip = document.getElementById('pwdTip');

        if (pwd1 !== pwd2) {
            tip.innerHTML = "两次密码不一致！";
            document.querySelector('input[name="passwordConf"]').setCustomValidity("密码不一致");
        } else {
            tip.innerHTML = "";
            document.querySelector('input[name="passwordConf"]').setCustomValidity("");
        }
    }
</script>
</body>
</html>