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
                    <div class="row justify-content-start">
                        <div class="col-md-6 col-sm-8 col-12"> 
                            <div class="user-info-box shadow-lg">
                                <div class="info-header bg-gradient text-white text-center">
                                    <h5 class="mb-0 py-2">Wallet Information</h5>
                                </div>
                                <div class="info-body p-2"> 
                                    <!-- Wallet Info -->
                                    <div class="wallet-info">
                                        <div class="wallet-item">
                                            <small class="text-muted">Amount</small>
                                            <p class="amount-text mb-0">
                                                <fmt:formatNumber value="${sessionScope.walletBalance != null ? sessionScope.walletBalance : 0}" pattern="#,###" groupingUsed="true" /> VND
                                            </p>
                                        </div>
                                        <c:if test="${sessionScope.usernameRole != 'manager'}">
                                            <div class="wallet-item">
                                                <small class="text-muted">Hold</small>
                                                <p class="hold-text mb-0">
                                                    <fmt:formatNumber value="${sessionScope.walletHold != null ? sessionScope.walletHold : 0}" pattern="#,###" groupingUsed="true" /> VND
                                                </p>
                                            </div>
                                            <div class="wallet-item">
                                                <small class="text-muted">Available</small>
                                                <p class="available-text mb-0">
                                                    <fmt:formatNumber value="${sessionScope.walletBalance - sessionScope.walletHold}" pattern="#,###" groupingUsed="true" /> VND
                                                </p>
                                            </div>
                                        </c:if>
                                        <button class="btn btn-gradient mt-2 w-100" data-bs-toggle="modal" data-bs-target="#paymentModal"> 
                                            <i class="fas fa-wallet me-1"></i> Manage Wallet
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-center mt-4">
                            <div class="col-12">
                                <div class="card transaction-card shadow-lg">
                                    <div class="card-header bg-gradient text-white text-center">
                                        <h4 class="mb-0">Recent Transactions</h4>
                                    </div>
                                    <div class="card-body p-4">
                                        <!-- Hiển thị thông báo nếu có -->
                                        <c:if test="${not empty requestScope.msg}">
                                            <div class="alert alert-info mt-3">${requestScope.msg}</div>
                                        </c:if>

                                        <div class="search-section mb-4">
                                            <form id="searchForm" method="GET" action="/HAPPYorSAD/Wallet">
                                                <div class="row g-3 align-items-end">
                                                    <!-- Date Range -->
                                                    <div class="col-md-2">
                                                        <label class="form-label fw-bold">From Date</label>
                                                        <input type="date" class="form-control" name="fromDate" id="fromDate" value="${param.fromDate}">
                                                    </div>
                                                    <div class="col-md-2">
                                                        <label class="form-label fw-bold">To Date</label>
                                                        <input type="date" class="form-control" name="toDate" id="toDate" value="${param.toDate}" max="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                                                    </div>
                                                    <!-- Transaction Type -->
                                                    <div class="col-md-2">
                                                        <label class="form-label fw-bold">Type</label>
                                                        <select class="form-control" name="type" id="type">
                                                            <option value="">All</option>
                                                            <option value="DEPOSIT" ${param.type == 'DEPOSIT' ? 'selected' : ''}>Deposit</option>
                                                            <option value="WITHDRAW" ${param.type == 'WITHDRAW' ? 'selected' : ''}>Withdraw</option>
                                                        </select>
                                                    </div>
                                                    <!-- Description -->
                                                    <div class="col-md-3">
                                                        <label class="form-label fw-bold">Description</label>
                                                        <input type="text" class="form-control" name="description" placeholder="Enter keyword" value="${param.description}">
                                                    </div>
                                                    <!-- Status -->
                                                    <div class="col-md-2">
                                                        <label class="form-label fw-bold">Status</label>
                                                        <select class="form-control" name="status" id="status">
                                                            <option value="">All</option>
                                                            <option value="Completed" ${param.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                                            <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                                        </select>
                                                    </div>
                                                    <!-- Search Button -->
                                                    <div class="col-md-1 d-flex align-items-end">
                                                        <button type="submit" class="btn btn-gradient w-100">
                                                            <i class="fas fa-search"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>

                                        <!-- Transactions Table -->
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
                                                    <c:forEach var="i" items="${requestScope.transactionPage}">
                                                        <tr>
                                                            <td><fmt:formatDate value="${i.transactionDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                                            <td>
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
                                                    <c:if test="${empty requestScope.transactionPage}">
                                                        <tr>
                                                            <td colspan="5" class="text-center">No transactions found.</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>

                                        <!-- Pagination -->
                                        <c:if test="${not empty requestScope.transactionPage}">
                                            <div class="pagination-section mt-4 text-center">
                                                <ul class="pagination justify-content-center">
                                                    <!-- Previous Button -->
                                                    <li class="page-item ${requestScope.currentPage == 1 ? 'disabled' : ''}">
                                                        <a class="page-link" href="/HAPPYorSAD/Wallet?page=${requestScope.currentPage - 1}&fromDate=${param.fromDate}&toDate=${param.toDate}&type=${param.type}&description=${param.description}&status=${param.status}">Previous</a>
                                                    </li>
                                                    <!-- Page Numbers -->
                                                    <c:forEach begin="1" end="${requestScope.totalPages}" var="i">
                                                        <li class="page-item ${requestScope.currentPage == i ? 'active' : ''}">
                                                            <a class="page-link" href="/HAPPYorSAD/Wallet?page=${i}&fromDate=${param.fromDate}&toDate=${param.toDate}&type=${param.type}&description=${param.description}&status=${param.status}">${i}</a>
                                                        </li>
                                                    </c:forEach>
                                                    <!-- Next Button -->
                                                    <li class="page-item ${requestScope.currentPage == requestScope.totalPages ? 'disabled' : ''}">
                                                        <a class="page-link" href="/HAPPYorSAD/Wallet?page=${requestScope.currentPage + 1}&fromDate=${param.fromDate}&toDate=${param.toDate}&type=${param.type}&description=${param.description}&status=${param.status}">Next</a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>                      
                    </div>
                </div>
            </section>

            <!-- Payment Modal -->
            <div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content">
                        <div class="modal-header bg-gradient text-white">
                            <h5 class="modal-title" id="paymentModalLabel">Payment Processing</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="wallet-balance mb-3">
                                <div class="wallet-item">
                                    <h6 class="text-muted">Amount</h6>
                                    <p class="amount-text">
                                        <fmt:formatNumber value="${sessionScope.walletBalance != null ? sessionScope.walletBalance : 0}" pattern="#,###" groupingUsed="true" /> VND
                                    </p>
                                </div>
                                <c:if test="${sessionScope.usernameRole != 'manager'}">
                                    <div class="wallet-item">
                                        <h6 class="text-muted">Hold</h6>
                                        <p class="hold-text">
                                            <fmt:formatNumber value="${sessionScope.walletHold != null ? sessionScope.walletHold : 0}" pattern="#,###" groupingUsed="true" /> VND
                                        </p>
                                    </div>
                                    <div class="wallet-item">
                                        <h6 class="text-muted">Available</h6>
                                        <p class="available-text">
                                            <fmt:formatNumber value="${sessionScope.walletBalance - sessionScope.walletHold}" pattern="#,###" groupingUsed="true" /> VND
                                        </p>
                                    </div>
                                </c:if>
                            </div>
                            <form id="walletForm" method="POST" action="/HAPPYorSAD/Wallet">
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
            .search-section {
                background: #f8f9fa;
                padding: 15px;
                border-radius: 10px;
                box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
            }
            .search-section .form-label {
                font-size: 0.9rem;
                margin-bottom: 5px;
            }
            .search-section .form-control, .search-section .btn {
                height: 38px;
                font-size: 0.9rem;
            }
            .search-section .btn-gradient {
                padding: 0;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .search-section .btn-gradient i {
                font-size: 1.1rem;
            }
            body {
                font-family: 'Poppins', sans-serif;
                background: #f4f7fc;
            }
            .btn-gradient {
                background: linear-gradient(90deg, #00c4cc, #7b3fe4);
                color: white;
                border: none;
                font-size: 0.9rem;
                padding: 8px 12px;
                border-radius: 6px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .btn-gradient:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 196, 204, 0.3);
                color: white;
            }
            .btn-gradient i {
                font-size: 1.1rem;
            }
            .user-info-box {
                border: none;
                border-radius: 12px;
                background: #ffffff;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                overflow: hidden;
                max-width: 320px;
            }
            .info-header {
                background: linear-gradient(90deg, #00c4cc, #7b3fe4);
                padding: 10px;
            }
            .info-header h5 {
                font-size: 1.3rem;
            }
            .info-body {
                padding: 12px;
            }
            .wallet-info {
                padding: 12px;
                background: #f8f9fa;
                border-radius: 8px;
                text-align: left;
            }
            .wallet-item {
                margin-bottom: 8px;
            }
            .wallet-item small {
                font-size: 0.9rem;
                color: #666;
                font-weight: 500;
                display: block;
                margin-bottom: 3px;
            }
            .amount-text, .hold-text, .available-text {
                font-size: 1.6rem;
                font-weight: 600;
                margin: 0;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.05);
                white-space: nowrap;
                overflow: visible;
                max-width: none;
                color: #333;
            }
            .amount-text {
                color: #00c4cc;
            }
            .hold-text {
                color: #ffaa00;
            }
            .available-text {
                color: #28a745;
            }
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
            .payment-section {
                background: linear-gradient(135deg, #f4f7fc, #e8edf5);
                padding: 40px 0;
                min-height: 100vh;
            }
            .modal-content {
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                max-width: 500px;
                margin: auto;
            }
            .modal-header {
                background: linear-gradient(90deg, #00c4cc, #7b3fe4);
                padding: 10px 15px;
            }
            .modal-header .modal-title {
                font-size: 1.3rem;
            }
            .modal-body {
                padding: 15px;
            }
            .wallet-balance {
                text-align: left;
                padding: 10px;
                background: #f8f9fa;
                border-radius: 8px;
                margin-bottom: 15px;
            }
            .wallet-balance .wallet-item {
                margin-bottom: 8px;
            }
            .wallet-balance h6 {
                font-size: 0.9rem;
                color: #666;
                font-weight: 500;
                display: block;
                margin-bottom: 3px;
            }
            .wallet-balance .amount-text,
            .wallet-balance .hold-text,
            .wallet-balance .available-text {
                font-size: 1.6rem;
                font-weight: 600;
                margin: 0;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.05);
                white-space: nowrap;
                overflow: visible;
                max-width: none;
                color: #333;
            }
            .wallet-balance .amount-text {
                color: #00c4cc;
            }
            .wallet-balance .hold-text {
                color: #ffaa00;
            }
            .wallet-balance .available-text {
                color: #28a745;
            }
            .mb-4 {
                margin-bottom: 15px !important;
            }
            .form-label {
                font-size: 0.9rem;
                margin-bottom: 4px;
            }
            .input-group, .form-control {
                font-size: 0.9rem;
            }
            .payment-methods .method-option {
                padding: 10px;
                background: #f8f9fa;
                border-radius: 6px;
                margin-bottom: 8px;
                cursor: pointer;
                transition: background 0.3s ease, transform 0.2s ease;
            }
            .payment-methods .method-option:hover {
                background: #e9ecef;
                transform: translateY(-2px);
            }
            .payment-methods .form-check-label {
                font-size: 0.9rem;
            }
            .payment-methods .form-check-label i {
                font-size: 1rem;
            }
            /* Pagination Styles */
            .pagination-section .pagination {
                margin: 0;
            }
            .pagination-section .page-item .page-link {
                color: #00c4cc;
                border: 1px solid #e9ecef;
                border-radius: 6px;
                margin: 0 4px;
                padding: 6px 12px;
                font-size: 0.9rem;
                transition: background 0.3s ease, color 0.3s ease;
            }
            .pagination-section .page-item.active .page-link {
                background: linear-gradient(90deg, #00c4cc, #7b3fe4);
                color: white;
                border: none;
            }
            .pagination-section .page-item.disabled .page-link {
                color: #6c757d;
                cursor: not-allowed;
                background: #f8f9fa;
            }
            .pagination-section .page-item .page-link:hover:not(.disabled) {
                background: #e9ecef;
                color: #00c4cc;
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