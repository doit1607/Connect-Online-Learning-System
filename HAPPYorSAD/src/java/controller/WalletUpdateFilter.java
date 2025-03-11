package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.TransactionDAO;
import java.io.IOException;

@WebFilter(urlPatterns = {"*.jsp", "/*"}) 
public class WalletUpdateFilter implements Filter {
    private TransactionDAO userWallet;


    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        userWallet = new TransactionDAO();
    }


    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(false);


        if (session != null && session.getAttribute("usernameUser") != null) {
            String username = (String) session.getAttribute("usernameUser");
          
            double walletBalance = userWallet.getBalance(username);
            double walletTotalBalance = userWallet.getTotalBalance(username);
            double walletHold = userWallet.getHold(username);
        
            session.setAttribute("walletBalance", walletBalance);
            session.setAttribute("walletTotalbalance", walletTotalBalance);
            session.setAttribute("walletHold", walletHold);
        }

        
        chain.doFilter(request, response);
    }

   
    @Override
    public void destroy() {
     
    }
}