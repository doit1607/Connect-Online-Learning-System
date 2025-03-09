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
            <section class="payment-section py-5">
                <div class="container">
                    <div class="row justify-content-center">
                        <!-- Payment Form with Balance -->
                        <div class="col-lg-5 col-md-6">
                            <div class="card payment-card shadow-lg">
                                <div class="card-header bg-primary text-white text-center">
                                    <h4 class="mb-0">Payment Processing</h4>
                                </div>
                                <div class="card-body">
                                    <div class="wallet-balance mb-4 text-center">
                                        <div class="row">
                                            <div class="col-6">
                                                <h5 class="fw-bold text-muted">Total Balance</h5>
                                                <p class="text-primary fs-4 mb-0">
                                                    <fmt:setLocale value="vi_VN"/>
                                                    <fmt:formatNumber value="${sessionScope.walletBalance != null ? sessionScope.walletTotalbalance : 0}" type="currency" groupingUsed="true"/>
                                                </p>
                                            </div>
                                            <div class="col-6">
                                                <h5 class="fw-bold text-muted">Available Balance</h5>
                                                <p class="text-success fs-4 mb-0">
                                                    <fmt:setLocale value="vi_VN"/>
                                                    <fmt:formatNumber value="${sessionScope.walletBalance != null ? sessionScope.walletBalance : 0}" type="currency" groupingUsed="true"/>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <form id="walletForm" method="POST">
                                        <div class="mb-4">
                                            <label class="form-label fw-bold">Amount (VND)</label>
                                            <div class="input-group">
                                                <span class="input-group-text">₫</span>
                                                <input type="number" class="form-control" name="amount" min="1000" step="1000" required>
                                            </div>
                                        </div>

                                        <div class="mb-4 payment-methods">
                                            <label class="form-label fw-bold">Payment Method</label>
                                            <div class="method-option p-3 mb-2 rounded" onclick="document.getElementById('depositRadio').click()">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" id="depositRadio" name="optradio" value="deposit" checked onclick="toggleCardInput()">
                                                    <label class="form-check-label" for="depositRadio">
                                                        <i class="fas fa-wallet me-2"></i>Deposit
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="method-option p-3 rounded" onclick="document.getElementById('withdrawRadio').click()">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" id="withdrawRadio" name="optradio" value="withdraw" onclick="toggleCardInput()">
                                                    <label class="form-check-label" for="withdrawRadio">
                                                        <i class="fas fa-credit-card me-2"></i>Withdraw
                                                    </label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-4" id="cardNumberInput" style="display: none;">
                                            <label class="form-label fw-bold">Card Number</label>
                                            <input type="text" class="form-control" name="cardNumber" placeholder="xxxx-xxxx-xxxx-xxxx">
                                        </div>

                                        <c:if test="${requestScope.msg != null}">
                                            <div class="alert alert-info">${requestScope.msg}</div>
                                        </c:if>

                                        <button class="btn btn-primary w-100 py-2" type="submit">
                                            <i class="fas fa-check me-2"></i>Proceed with Payment
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Transactions Table -->
                        <div class="col-lg-7 col-md-6 mt-4 mt-md-0">
                            <div class="card transaction-card shadow-lg">
                                <div class="card-header bg-success text-white text-center">
                                    <h4 class="mb-0">Recent Transactions</h4>
                                </div>
                                <div class="card-body p-0">
                                    <div class="table-responsive">
                                        <table class="table table-hover mb-0">
                                            <thead class="bg-light">
                                                <tr>
                                                    <th>Date</th>
                                                    <th>Type</th>
                                                    <th>Amount</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="i" items="${requestScope.transaction}">
                                                    <tr>
                                                        <td><fmt:formatDate value="${i.transactionDate}" pattern="yyyy-MM-dd"/></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${i.type == 'DEPOSIT'}">
                                                                    <span class="deposit-color" style="font-weight: bold">${i.type}</span>
                                                                </c:when>
                                                                <c:when test="${i.type == 'WITHDRAW'}">
                                                                    <span class="withdraw-color" style="font-weight: bold">${i.type}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${i.type}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>₫<fmt:formatNumber value="${i.amount}" pattern="#,###"/></td>
                                                        <td><span class="badge bg-success">${i.status}</span></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- /Payment Section -->

            <!-- Footer -->
            <%@include file="../sourcesHome/homeFooter.jsp" %>
            <!-- /Footer -->

            <!-- Custom CSS -->
            <style>
                .deposit-color {
                    color: #00cc00; /* Xanh tùy chỉnh */
                }
                .withdraw-color {
                    color: #ff0000; /* Đỏ tùy chỉnh */
                }
                .payment-section {
                    background: #f8f9fa;
                }

                .payment-card, .transaction-card {
                    border: none;
                    border-radius: 10px;
                    transition: transform 0.3s ease;
                }

                .payment-card:hover, .transaction-card:hover {
                    transform: translateY(-5px);
                }

                .payment-methods .method-option {
                    background: #fff;
                    border: 2px solid #dee2e6;
                    cursor: pointer;
                    transition: all 0.3s ease;
                }

                .payment-methods .method-option:hover {
                    border-color: #007bff;
                    background: #f8f9fa;
                }

                .payment-methods .form-check-input:checked + .form-check-label {
                    color: #007bff;
                    font-weight: bold;
                }

                .table-hover tbody tr:hover {
                    background-color: #f1f3f5;
                }

                .badge {
                    padding: 5px 10px;
                    border-radius: 12px;
                }

                .wallet-balance .row {
                    align-items: center;
                }

                .wallet-balance .col-6 {
                    padding: 0 15px;
                }

                .wallet-balance h5 {
                    font-size: 1rem;
                    margin-bottom: 0.3rem;
                }

                .wallet-balance p {
                    font-weight: bold;
                    margin-bottom: 0;
                }
            </style>

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

            <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
            <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

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
        </div>
    </body>
</html>