<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS - Checkout</title>

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- CSS Links -->
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/boxicons/css/boxicons.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">
    </head>
    <body>
        <div class="main-wrapper">
            <!-- Header -->
            <c:if test="${usernameRole != 'manager'}">
                <%@include file="../sourcesHome/homeHeader.jsp" %>
            </c:if>
            <c:if test="${usernameRole == 'manager'}">
                <%@include file="../sourcesHome/headerManager.jsp" %>
            </c:if>

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

            <!-- Main Content -->
            <section class="payment-section py-5">
                <div class="container">
                    <!-- User Info Box (Top Left, Normal Flow) -->
                    <div class="row justify-content-start">
                        <div class="col-md-4 col-sm-6 col-12">
                            <div class="user-info-box shadow-lg">
                                <div class="info-header bg-gradient text-white text-center">
                                    <h5 class="mb-0 py-2">Wallet Information</h5>
                                </div>
                                <div class="info-body p-3">
                                    <!-- Wallet Info (Adjusted Size) -->
                                    <div class="wallet-info text-center">
                                        <div class="row">
                                            <div <c:if test="${sessionScope.usernameRole != 'manager'}">class="col-6"</c:if>>
                                                    <small class="text-muted">Amount</small>
                                                    <p class="amount-text mb-0">
                                                    <fmt:setLocale value="vi_VN"/>
                                                    <fmt:formatNumber value="${sessionScope.walletBalance != null ? sessionScope.walletBalance : 0}" type="currency" groupingUsed="true"/>
                                                </p>
                                            </div>
                                            <c:if test="${sessionScope.usernameRole != 'manager'}">
                                                <div class="col-6">
                                                    <small class="text-muted">Hold</small>
                                                    <p class="hold-text mb-0">
                                                        <fmt:setLocale value="vi_VN"/>
                                                        <fmt:formatNumber value="${sessionScope.walletHold != null ? sessionScope.walletHold : 0}" type="currency" groupingUsed="true"/>
                                                    </p>
                                                </div>
                                            </c:if>
                                        </div>
                                        <button class="btn btn-gradient mt-3 w-100" data-bs-toggle="modal" data-bs-target="#paymentModal">
                                            <i class="fas fa-wallet me-1"></i> Manage Wallet
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Transactions Table (Full Width) -->
                        <div class="row justify-content-center mt-4">
                            <div class="col-12">
                                <div class="card transaction-card shadow-lg">
                                    <div class="card-header bg-gradient text-white text-center">
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
                                                        <th>Description</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="i" items="${requestScope.transaction}">
                                                        <tr>
                                                            <td><fmt:formatDate value="${i.transactionDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>                                                        <td>
                                                                <c:choose>
                                                                    <c:when test="${i.type == 'DEPOSIT'}">
                                                                        <span class="deposit-tag">${i.type}</span>
                                                                    </c:when>
                                                                    <c:when test="${i.type == 'WITHDRAW'}">
                                                                        <span class="withdraw-tag">${i.type}</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ${i.type}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td><fmt:formatNumber value="${i.amount}" pattern="#,###"/>₫</td>
                                                            <td>${i.description}</td>
                                                            <td><span class="status-badge">${i.status}</span></td>
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
                </div>
            </section>

            <!-- Payment Modal -->
            <div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-gradient text-white">
                            <h5 class="modal-title" id="paymentModalLabel">Payment Processing</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="wallet-balance mb-4 text-center">
                                <div class="row">
                                    <div <c:if test="${sessionScope.usernameRole != 'manager'}">class="col-6"</c:if>>
                                            <h6 class="text-muted">Amount</h6>
                                            <p class="amount-text">
                                            <fmt:setLocale value="vi_VN"/>
                                            <fmt:formatNumber value="${sessionScope.walletBalance != null ? sessionScope.walletBalance : 0}" type="currency" groupingUsed="true"/>
                                        </p>
                                    </div>
                                    <c:if test="${sessionScope.usernameRole != 'manager'}">
                                        <div class="col-6">
                                            <h6 class="text-muted">Hold</h6>
                                            <p class="hold-text">
                                                <fmt:setLocale value="vi_VN"/>
                                                <fmt:formatNumber value="${sessionScope.walletHold != null ? sessionScope.walletHold : 0}" type="currency" groupingUsed="true"/>
                                            </p>
                                        </div>
                                    </c:if>
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
                                                <i class="fas fa-wallet me-2"></i> Deposit
                                            </label>
                                        </div>
                                    </div>
                                    <div class="method-option p-3 rounded" onclick="document.getElementById('withdrawRadio').click()">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" id="withdrawRadio" name="optradio" value="withdraw" onclick="toggleCardInput()">
                                            <label class="form-check-label" for="withdrawRadio">
                                                <i class="fas fa-credit-card me-2"></i> Withdraw
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-4" id="cardNumberInput" style="display: none;">
                                    <label class="form-label fw-bold">Card Number</label>
                                    <input type="text" class="form-control" name="cardNumber" placeholder="xxxx-xxxx-xxxx-xxxx">
                                </div>
                                <button class="btn btn-gradient w-100 py-2" type="submit">
                                    <i class="fas fa-check me-2"></i> Proceed with Payment
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <%@include file="../sourcesHome/homeFooter.jsp" %>
        </div>

        <!-- Custom CSS -->
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background: #f4f7fc;
            }

            /* Gradient Button */
            .btn-gradient {
                background: linear-gradient(90deg, #00c4cc, #7b3fe4);
                color: white;
                border: none;
                font-size: 0.9rem;
                padding: 8px 12px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .btn-gradient:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0, 196, 204, 0.4);
                color: white;
            }

            /* User Info Box */
            .user-info-box {
                border: none;
                border-radius: 12px;
                background: #ffffff;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                overflow: hidden;
            }
            .info-header {
                background: linear-gradient(90deg, #00c4cc, #7b3fe4);
            }
            .info-body {
                padding: 15px;
            }

            /* Wallet Info (Adjusted Size for Balance) */
            .wallet-info {
                padding: 15px 0;
                background: #f8f9fa;
                border-radius: 10px;
            }
            .wallet-info small {
                font-size: 0.85rem;
                color: #666;
                font-weight: 500;
            }
            .amount-text {
                color: #00c4cc;
                font-size: 1.5rem; /* Giảm xuống 1.5rem để cân đối */
                font-weight: 600;
                margin: 5px 0;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
            }
            .hold-text {
                color: #ffaa00;
                font-size: 1.5rem; /* Giảm xuống 1.5rem để cân đối */
                font-weight: 600;
                margin: 5px 0;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
            }

            /* Transaction Card (Full Width) */
            .transaction-card {
                border: none;
                border-radius: 15px;
                background: #ffffff;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            }
            .bg-gradient {
                background: linear-gradient(90deg, #00c4cc, #7b3fe4);
                padding: 15px;
            }
            .table {
                margin-bottom: 0;
            }
            .table th, .table td {
                padding: 12px 15px;
                vertical-align: middle;
            }
            .table-hover tbody tr:hover {
                background: #f8f9fa;
                transition: background 0.2s ease;
            }
            .deposit-tag {
                color: #00cc00;
                font-weight: 600;
                background: #e6ffe6;
                padding: 4px 8px;
                border-radius: 12px;
            }
            .withdraw-tag {
                color: #ff0000;
                font-weight: 600;
                background: #ffe6e6;
                padding: 4px 8px;
                border-radius: 12px;
            }
            .status-badge {
                background: #00c4cc;
                color: white;
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 0.85rem;
            }

            /* Payment Section */
            .payment-section {
                background: linear-gradient(135deg, #f4f7fc, #e8edf5);
                padding: 40px 0;
                min-height: 100vh;
            }

            /* Modal */
            .modal-content {
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            }
            .method-option {
                background: #f8f9fa;
                cursor: pointer;
                transition: background 0.3s ease, transform 0.2s ease;
            }
            .method-option:hover {
                background: #e9ecef;
                transform: translateY(-2px);
            }
        </style>

        <!-- Scripts -->
        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/ckeditor.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"></script>
        <script src="/HAPPYorSAD/assets/js/script.js"></script>

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
    </body>
</html>