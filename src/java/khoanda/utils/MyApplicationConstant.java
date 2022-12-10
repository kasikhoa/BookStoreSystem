/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package khoanda.utils;

/**
 *
 * @author Admin
 */
public class MyApplicationConstant {

    public class DispatchFeatures {

        public static final String FIRST_TIME_CONTROLLER = "";
        public static final String LOGIN_PAGE = "loginPage";

        public static final String LOGIN_CONTROLLER = "loginAction";
        public static final String LOGOUT_CONTROLLER = "logoutAction";
        public static final String SIGN_UP_CONTROLLER = "signUpAction";

        public static final String SEARCH_FULLNAME_CONTROLLER = "searchAction";
        public static final String CONFIRM_DELETE_CONTROLLER = "confirmDeleteAction";
        public static final String DELETE_ACCOUNT_CONTROLLER = "deleteAction";
        public static final String UPDATE_ACCOUNT_CONTROLLER = "updateAction";

        public static final String BUY_BOOK_CONTROLLER = "showBookAction";
        public static final String ADD_BOOK_TO_CART_CONTROLLER = "addBookToCartAction";
        public static final String VIEW_CART_PAGE = "viewCartPage";

        public static final String REMOVE_BOOK_FROM_CART = "removeBookFromCartAction";
        public static final String CHECK_OUT_ORDER_CONTROLLER = "checkOutAction";
        public static final String CONFIRM_CHECK_OUT_CONTROLLER = "confirmCheckOutAction";
    }

    public class StartUpApp {

        public static final String LOGIN_PAGE = "loginPage";
        public static final String SEARCH_PAGE = "searchPage";
    }

    public class LoginFeatures {

        public static final String INVALID = "invalid";
        public static final String SEARCH_PAGE = "searchPage";
    }

    public class LogoutFeatures {

        public static final String LOGIN_PAGE = "loginPage";
    }

    public class SignUpFeatures {

        public static final String SIGN_UP_JSP = "signUpJSP";
        public static final String LOGIN_PAGE = "loginPage";
    }

    public class SearchFeatures {

        public static final String LOGIN_PAGE = "loginPage";
        public static final String SEARCH_PAGE = "searchPage";
        public static final String SEARCH_ACTION = "searchAction";

    }

    public class ConfirmDeleteFetures {

        public static final String ERROR_PAGE = "error";
        public static final String LOGIN_PAGE = "loginPage";
        public static final String CONFIRM_DELETE_PAGE = "confirmDeletePage";
    }

    public class DeleteFeatures {

        public static final String ERROR_PAGE = "error";
        public static final String LOGIN_PAGE = "loginPage";
        public static final String SEARCH_FULLNAME_CONTROLLER = "searchAction";
    }

    public class UpdateFeatures {

        public static final String ERROR_PAGE = "error";
        public static final String LOGIN_PAGE = "loginPage";
        public static final String SEARCH_FULLNAME_CONTROLLER = "searchAction";
    }

    public class ShowBookFeatures {

        public static final String LOGIN_PAGE = "loginPage";
        public static final String SHOPPING_PAGE = "shoppingPage";
    }

    public class AddBookToCartFeatures {

        public static final String ERROR_PAGE = "error";
        public static final String SHOW_BOOK_CONTROLLER = "showBookAction";
    }

    public class CartFeatures {

        public static final String ERROR_PAGE = "error";
        public static final String REMOVE_BOOK_FROM_CART = "removeBookFromCartAction";
        public static final String CONFIRM_CHECK_OUT_CONTROLLER = "confirmCheckOutAction";
    }

    public class RemoveBookFeatures {

        public static final String VIEW_CART_PAGE = "viewCartPage";
    }

    public class ConfirmCheckOutFeatures {

        public static final String VIEW_CART_PAGE = "viewCartPage";
        public static final String CONFIRM_CHECK_OUT_PAGE = "confirmCheckOutPage";
    }

    public class CheckOutFeatures {

        public static final String CONFIRM_CHECK_OUT_PAGE = "confirmCheckOutPage";
        public static final String CHECK_OUT_SUCCESS_PAGE = "checkOutSuccessPage";
    }
}
