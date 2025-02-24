<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

        <!-- CSS Links -->
        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">


        <!-- Theme Settings Js -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">

        <!-- Dropzone -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.css">

        <!-- Boxioons CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/boxicons/css/boxicons.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">
    </head>
    <body>
        <div class="main-wrapper">

            <!-- Header -->
            <%@include file="../sourcesHome/homeHeader.jsp" %>
            <!-- /Header -->

            <!-- Breadcrumb -->
            <div class="breadcrumb-bar">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-12">
                            <nav aria-label="breadcrumb" class="page-breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="index-2.html">Home</a></li>
                                    <li class="breadcrumb-item">Pages</li>
                                    <li class="breadcrumb-item active" aria-current="page">Checkout</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Breadcrumb -->

            <!-- Payment Section -->
            <!DOCTYPE html>
            <html lang="en">
                <head>
                    <meta charset="utf-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
                    <title>Dreams LMS</title>

                    <!-- CSS Links -->
                    <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">
                    <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">
                </head>
                <body>
                    <div class="main-wrapper">

                        <!-- Header -->
                        <%@include file="../sourcesHome/homeHeader.jsp" %>
                        <!-- /Header -->

                        <!-- Breadcrumb -->
                        <!-- /Breadcrumb -->

                        <!-- Payment Section -->
                        <section class="d-flex justify-content-center align-items-center" style="min-height: 80vh;">
                            <div class="card p-4 shadow" style="width: 400px;">
                                <h4 class="text-center mb-4">Payment</h4>
                                <form id="walletForm" method="POST">
                                    <div class="mb-3">
                                        <label class="form-label">Amount (VND)</label>
                                        <input type="text" class="form-control" name="amount" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Payment Method</label>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" id="depositRadio" name="optradio" value="deposit" checked onclick="toggleCardInput()">
                                            <label class="form-check-label" for="depositRadio">Deposit</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" id="withdrawRadio" name="optradio" value="withdraw" onclick="toggleCardInput()">
                                            <label class="form-check-label" for="withdrawRadio">Withdraw</label>
                                        </div>
                                    </div>
                                    <div class="mb-3" id="cardNumberInput" style="display: none;">
                                        <label class="form-label">Card Number</label>
                                        <input type="text" class="form-control" name="cardNumber">
                                    </div>
                                    <c:if test="${param.msg != null}">
                                        <div class="alert alert-info">${param.msg}</div>
                                    </c:if>
                                    <button class="btn btn-primary w-100" type="submit">Proceed</button>
                                </form>
                            </div>
                        </section>
                        <!-- /Payment Section -->

                        <!-- Footer -->
                        <%@include file="../sourcesHome/homeFooter.jsp" %>
                        <!-- /Footer -->

                        <script>
                            function toggleCardInput() {
                                const withdrawRadio = document.querySelector('input[name="optradio"][value="withdraw"]');
                                const cardInputDiv = document.getElementById("cardNumberInput");
                                const form = document.getElementById("walletForm");

                                if (withdrawRadio.checked) {
                                    cardInputDiv.style.display = "block";
                                    form.action = "/HAPPYorSAD/VNPayReturnServlet?service=withdraw";
                                } else {
                                    cardInputDiv.style.display = "none";
                                    form.action = "/HAPPYorSAD/ajaxServlet";
                                }
                            }

                            document.getElementById("walletForm").onsubmit = function () {
                                toggleCardInput();
                                return true;
                            };


                            window.onload = toggleCardInput;
                        </script>
                    </div>











                    <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

                    <!-- Bootstrap Core JS -->
                    <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

                    <!-- Select2 JS -->
                    <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

                    <!-- Ckeditor JS -->
                    <script src="/HAPPYorSAD/assets/js/ckeditor.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

                    <!-- Dropzone JS -->
                    <script src="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

                    <!-- Sticky Sidebar JS -->
                    <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
                    <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

                    <!-- Custom JS -->
                    <script src="/HAPPYorSAD/assets/js/script.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

                    <script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" 
                    data-cf-settings="d693b69077856eb34d3f2643-|49" defer></script>
                    <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"91074a70ad7f06b9","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
                </body>
            </html>
