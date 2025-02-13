<%-- 
    Document   : HomePage
    Created on : Jan 19, 2025, 4:50:17 PM
    Author     : Ann
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="assets/js/theme-script.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

        <!-- Owl Carousel CSS -->
        <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="assets/css/owl.theme.default.min.css">

        <!-- Slick CSS -->
        <link rel="stylesheet" href="assets/plugins/slick/slick.css">
        <link rel="stylesheet" href="assets/plugins/slick/slick-theme.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">

        <!-- Aos CSS -->
        <link rel="stylesheet" href="../assets/plugins/aos/aos.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">

        <title>HAPPYorSAD</title>
    </head>
    <body>

        <div class="main-wrapper">
            <%@include file="../sourcesHome/homeHeader.jsp" %>
            <div class="all-container">
                <%@include file="../sourcesHome/homeDetail.jsp" %>
            </div>
            <%@include file="../sourcesHome/homeFooter.jsp" %>
        </div>
    </body>

</html>
