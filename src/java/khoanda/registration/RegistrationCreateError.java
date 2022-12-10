/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package khoanda.registration;

import java.io.Serializable;

/**
 *
 * @author Admin
 */
public class RegistrationCreateError implements Serializable {

    private String userNameLengthErr;
    private String passwordLengthErr;
    private String confirmNotMatch;
    private String fullNameLengthErr;
    private String userNameIsExisted;

    public RegistrationCreateError() {
    }

    public String getUserNameLengthErr() {
        return userNameLengthErr;
    }

    public void setUserNameLengthErr(String userNameLengthErr) {
        this.userNameLengthErr = userNameLengthErr;
    }

    public String getPasswordLengthErr() {
        return passwordLengthErr;
    }

    public void setPasswordLengthErr(String passwordLengthErr) {
        this.passwordLengthErr = passwordLengthErr;
    }

    public String getConfirmNotMatch() {
        return confirmNotMatch;
    }

    public void setConfirmNotMatch(String confirmNotMatch) {
        this.confirmNotMatch = confirmNotMatch;
    }

    public String getFullNameLengthErr() {
        return fullNameLengthErr;
    }

    public void setFullNameLengthErr(String fullNameLengthErr) {
        this.fullNameLengthErr = fullNameLengthErr;
    }

    public String getUserNameIsExisted() {
        return userNameIsExisted;
    }

    public void setUserNameIsExisted(String userNameIsExisted) {
        this.userNameIsExisted = userNameIsExisted;
    }
}
