<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!--上面导航栏-->
<nav class="navbar1"
     role="navigation">
    <div class="container1">
        <div style="position: absolute; left: 40px; top: 6px;"></div>
        <div style="position: absolute; left: 150px; top: -2px;">
            <a class="navbar-brand1" href=""><font color="#fff">在线预约挂号系统</font></a>
        </div>
        <div class="navbar-collapse1" id="top-navbar-1">
            <ul class="navbar-right1">
                <li>
                    <div>
                        <c:if test="${sessionScope.patient == null}">
                            <a class="navbar-brand1" style="font-size: 12px;"
                               href="login.jsp"><strong>患者登录</strong></a>
                            <a class="navbar-brand1" style="font-size: 12px;"
                               href="doctor\login.jsp"><strong>医生登录</strong></a>
                            <a class="navbar-brand1" style="font-size: 12px;"
                               href="admin\login.jsp"><strong>管理员登录</strong></a>
                            <a class="navbar-brand1" style="font-size: 12px;"
                               href="register.jsp"><strong>患者注册</strong></a>
                            <a class="navbar-brand1" style="font-size: 12px;"
                               href="doctor\register.jsp"><strong>医生注册</strong></a>
                            <a class="navbar-brand1" style="font-size: 12px;"
                               href="admin\register.jsp"><strong>管理员注册</strong></a>
                        </c:if>
                        <c:if test="${sessionScope.patient != null}">
                            <a class="navbar-brand1" style="font-size: 12px;" href=""><strong><font color="#fff">欢迎您,${sessionScope.patient.name }</font></strong></a>
                            <a class="navbar-brand1" style="font-size: 12px;"
                               href="logout"><strong>注销</strong></a>
                        </c:if>
                            <a class="navbar-brand1" style="font-size: 12px;" href="help.jsp"><strong>帮助中心</strong></a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>

