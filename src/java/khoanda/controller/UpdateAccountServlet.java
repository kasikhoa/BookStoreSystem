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
import javax.servlet.http.HttpSession;
import khoanda.registration.RegistrationDAO;
import khoanda.registration.RegistrationDTO;
import khoanda.registration.RegistrationUpdateError;
import khoanda.utils.MyApplicationConstant;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateAccountServlet", urlPatterns = {"/UpdateAccountServlet"})
public class UpdateAccountServlet extends HttpServlet {

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

        ServletContext context = this.getServletContext();
        Properties properties = (Properties) context.getAttribute("SITE_MAP");

        String url = properties.getProperty(MyApplicationConstant.UpdateFeatures.ERROR_PAGE);

        String searchValue = request.getParameter("lastSearchValue");
        String username = request.getParameter("txtUsername");
        String password = request.getParameter("txtPassword");
        String admin = request.getParameter("chkAdmin");
        boolean role = false;
        if (admin != null) {
            role = true;
        }
        String regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,30}$";
        boolean foundErr = false;
        RegistrationUpdateError errors = new RegistrationUpdateError();

        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                if (!password.trim().matches(regex)) {
                    foundErr = true;
                    errors.setPasswordError("password length requires 6 - 30 chars, at least one letter and one number");
                }
                if (foundErr) {
                    request.setAttribute("UPDATE_ERR", errors);
                    url = properties.getProperty(
                            MyApplicationConstant.DeleteFeatures.SEARCH_FULLNAME_CONTROLLER)
                            + "?txtSearchValue=" + searchValue;
                } else {
                    RegistrationDAO dao = new RegistrationDAO();
                    boolean result = dao.updateAccount(username, password.trim(), role);

                    if (result) {
                        RegistrationDTO user = (RegistrationDTO) session.getAttribute("USER");
                        if (username.equals(user.getUsername())) {
                            if (!role) {
                                session.setAttribute("ADMIN", role);
                                RegistrationDTO dto = dao.showProfile(username);
                                session.setAttribute("SHOW_PROFILE", dto);
                            }
                        }
                        url = properties.getProperty(
                                MyApplicationConstant.DeleteFeatures.SEARCH_FULLNAME_CONTROLLER)
                                + "?txtSearchValue=" + searchValue;
                    }
                }
            } else {
                url = properties.getProperty(
                        MyApplicationConstant.UpdateFeatures.LOGIN_PAGE);
            }
        } catch (NamingException ex) {
            log("UpdateAccountServlet_SQL: " + ex.getMessage());
        } catch (SQLException ex) {
            log("UpdateAccountServlet_Naming: " + ex.getMessage());
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
