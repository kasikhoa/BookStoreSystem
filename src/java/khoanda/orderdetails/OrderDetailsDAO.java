/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package khoanda.orderdetails;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import javax.naming.NamingException;
import khoanda.product.ProductDTO;
import khoanda.utils.DBHelpers;

/**
 *
 * @author Admin
 */
public class OrderDetailsDAO implements Serializable {

    private List<OrderDetailsDTO> orderDetailsList;

    public List<OrderDetailsDTO> getOrderDetailsList() {
        return orderDetailsList;
    }

    public boolean createOrderDetails(int orderID, Map<ProductDTO, Integer> checkedItems)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                con.setAutoCommit(false);
                String sql = "Insert Into OrderDetails"
                        + "(OrderID, SKU, Name, Price, Quantity, Total) "
                        + "Values (?, ?, ?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                BigDecimal price;
                BigDecimal total;
                int quantity;
                int effectedRows = 0;
                for (ProductDTO dto : checkedItems.keySet()) {
                    quantity = checkedItems.get(dto);
                    price = dto.getPrice();
                    total = price.multiply(new BigDecimal(quantity));
                    stm.setInt(1, orderID);
                    stm.setString(2, dto.getSKU());
                    stm.setString(3, dto.getName());
                    stm.setBigDecimal(4, price);
                    stm.setInt(5, quantity);
                    stm.setBigDecimal(6, total);
                    effectedRows += stm.executeUpdate();
                }
                con.commit();
                if (effectedRows == checkedItems.size()) {
                    result = true;
                }
                con.rollback();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return result;
    }
}
