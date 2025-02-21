<!DOCTYPE html>
<html lang="en">


    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/checkout.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:05:02 GMT -->
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="4ceffc0a57d87cf445fa44d1-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">

    </head>

    <body>

        <!-- Main Wrapper -->
        <div class="main-wrapper">

            <!-- Header -->
            <%@include file="../sourcesHome/homeHeader.jsp" %>
            <!-- /Header -->

            <!-- Breadcrumb -->
            <div class="breadcrumb-bar">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-12">
                            <div class="breadcrumb-list">
                                <nav aria-label="breadcrumb" class="page-breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index-2.html">Home</a></li>
                                        <li class="breadcrumb-item" aria-current="page">Pages</li>
                                        <li class="breadcrumb-item" aria-current="page">Checkout</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Breadcrumb -->

            <!-- Cart -->
            <section class="course-content checkout-widget">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8">

                            <!-- /Payment Method -->
                            <div class="student-widget pay-method">
                                <div class="student-widget-group add-course-info">
                                    <div class="cart-head">
                                        <h4>Payment</h4>
                                    </div>
                                    <div class="checkout-form">
                                        <form id="walletForm" method="POST">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="wallet-method">
                                                        <label class="radio-inline custom_radio me-4">
                                                            <input type="radio" name="optradio" value="deposit" checked="" onclick="toggleCardInput()">
                                                            <span class="checkmark"></span> Deposit
                                                        </label>
                                                        <label class="radio-inline custom_radio">
                                                            <input type="radio" name="optradio" value="withdraw" onclick="toggleCardInput()">
                                                            <span class="checkmark"></span> Withdraw
                                                        </label>
                                                    </div>
                                                    <div class="input-block">
                                                        <label class="form-control-label">Amount(VND)</label>
                                                        <input type="text" class="form-control" name="amount" required>
                                                    </div>
                                                    <div class="input-block" id="cardNumberInput" style="display: none;">
                                                        <label class="form-control-label">Card Number</label>
                                                        <input type="text" class="form-control" name="cardNumber">
                                                    </div>
                                                    <c:if test = "${param.msg != null}">
                                                        ${param.msg}
                                                    </c:if>
                                                </div>
                                                <div class="payment-btn">
                                                    <button class="btn btn-primary" type="submit">Proceed</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <!-- /Payment Method -->

                        </div>

                    </div>
                </div>
            </section>
            <script>
                function toggleCardInput() {
                    var withdrawRadio = document.querySelector('input[name="optradio"][value="withdraw"]');
                    var cardInputDiv = document.getElementById("cardNumberInput");
                    var form = document.getElementById("walletForm");

                    if (withdrawRadio.checked) {
                        cardInputDiv.style.display = "block";
                        form.action = "/../HAPPYorSAD/VNPayReturnServlet?service=withdraw"; 
                    } else {
                        cardInputDiv.style.display = "none";
                        form.action = "/../HAPPYorSAD/ajaxServlet";
                    }
                }

                document.getElementById("walletForm").onsubmit = function () {
                    toggleCardInput();
                };
            </script>
            <!-- /Cart -->

            <%@include file="../sourcesHome/homeFooter.jsp" %>
        </div>
        <!-- /Main Wrapper -->

        <!-- jQuery -->
        <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="4ceffc0a57d87cf445fa44d1-text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="4ceffc0a57d87cf445fa44d1-text/javascript"></script>

        <!-- Select2 JS -->
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js" type="4ceffc0a57d87cf445fa44d1-text/javascript"></script>

        <!-- Sticky Sidebar JS -->
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="4ceffc0a57d87cf445fa44d1-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="4ceffc0a57d87cf445fa44d1-text/javascript"></script>

        <!-- Custom JS -->
        <script src="/HAPPYorSAD/assets/js/script.js" type="4ceffc0a57d87cf445fa44d1-text/javascript"></script>

        <script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="4ceffc0a57d87cf445fa44d1-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"91074476db81e2ec","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
    </body>


    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/checkout.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:05:02 GMT -->
</html>