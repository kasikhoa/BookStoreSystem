/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package khoanda.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Properties;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import khoanda.registration.RegistrationCreateError;
import khoanda.registration.RegistrationDAO;
import khoanda.registration.RegistrationDTO;
import khoanda.utils.MyApplicationConstant;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SignUpServlet", urlPatterns = {"/SignUpServlet"})
public class SignUpServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("txtUsername");
        String password = request.getParameter("txtPassword");
        String confirm = request.getParameter("txtConfirm");
        String fullname = request.getParameter("txtFullname");
        boolean foundErr = false;
        RegistrationCreateError errors = new RegistrationCreateError();

        ServletContext context = this.getServletContext();
        Properties properties = (Properties) context.getAttribute("SITE_MAP");

        String url = properties.getProperty(
                MyApplicationConstant.SignUpFeatures.SIGN_UP_JSP);
        String regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,30}$";

        try {

            if (username.trim().length() < 6 || username.trim().length() > 30) {
                foundErr = true;
                errors.setUserNameLengthErr("UserID length requires 6 - 20 chars");
            }
            if (!password.trim().matches(regex)) {
                foundErr = true;
                errors.setPasswordLengthErr("Password length requires 6 - 30 chars, at least one letter and one number");

            } else if (!password.trim().equals(confirm.trim())) {
                foundErr = true;
                errors.setConfirmNotMatch("Confirm must be matched password");
            }
            if (fullname.trim().length() < 2 || fullname.trim().length() > 20) {
                foundErr = true;
                errors.setFullNameLengthErr("FullName length requires 2 - 50 chars");
            }

            if (foundErr) {
                request.setAttribute("SIGNUP_ERROR", errors);

            } else {
                RegistrationDAO dao = new RegistrationDAO();
                username = username.trim();
                password = password.trim();
                RegistrationDTO dto = new RegistrationDTO(username, password, fullname, false);
                boolean result = dao.createNewAcccount(dto);

                if (result) {
                    url = properties.getProperty(
                            MyApplicationConstant.SignUpFeatures.LOGIN_PAGE);
                }
            }
        } catch (SQLException ex) {
            String msg = ex.getMessage();
            log("SignUpServlet_SQL: " + ex.getMessage());
            if (msg.contains("duplicate")) {
                errors.setUserNameIsExisted(username + " is existed");
                request.setAttribute("SIGNUP_ERROR", errors);
            }
        } catch (NamingException ex) {
            log("SignUpServlet_Naming: " + ex.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
