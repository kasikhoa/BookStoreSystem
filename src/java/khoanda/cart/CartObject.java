/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package khoanda.cart;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.naming.NamingException;
import khoanda.orderdetails.OrderDetailsDAO;
import khoanda.orderdetails.OrderDetailsDTO;
import khoanda.orders.OrdersDAO;
import khoanda.product.ProductDAO;
import khoanda.product.ProductDTO;

/**
 *
 * @author Admin
 */
public class CartObject implements Serializable {
    private Map<ProductDTO, Integer> items;
    
    public Map<ProductDTO, Integer> getItems() {
        return items;
    }
    
    public void addItemToCart(String SKU) 
        throws SQLException, NamingException{
        if (SKU == null) {
            return;
        }
        
        if (SKU.trim().isEmpty()) {
            return;
        }
        
        if (this.items == null) {
            this.items = new HashMap<>();
        }
        int quantity = 1;
        ProductDAO dao = new ProductDAO();
        ProductDTO dto = dao.getProductBySKU(SKU);
        
        if (this.items.containsKey(dto)) {
            quantity = this.items.get(dto) + 1;
        }
        this.items.put(dto, quantity);
    }
    
    public void removeItemBySKU(String SKU) 
        throws SQLException, NamingException{
        
        if (this.items == null) {
            return;
        }
        ProductDAO dao = new ProductDAO();
        ProductDTO dto = dao.getProductBySKU(SKU);
        
        if (this.items.containsKey(dto)) {
            this.items.remove(dto);
            if (this.items.isEmpty()) {
                this.items = null;
            }
        }
    }
    
    public void removeItemsForCheckOut(ProductDTO dto) {
        if (this.items == null) {
            return;
        }
        
        if (this.items.containsKey(dto)) {
            this.items.remove(dto);
            if (this.items.isEmpty()) {
                this.items = null;
            }
        }
    }
    
    public Map<ProductDTO, Integer> showCheckedItems(String[] SKU) 
        throws SQLException, NamingException{
        if (this.items == null) {
            return null;
        }       
        Map<ProductDTO, Integer> list = new HashMap<>();
        ProductDAO dao = new ProductDAO();
        ProductDTO dto = new ProductDTO();
        for (String sku : SKU) {
            dto = dao.getProductBySKU(sku);
            list.put(dto, items.get(dto));
        }
        return list;
    }
    
    public int checkOutItemsOfCart(String name, String address, String total, 
            Map<ProductDTO, Integer> checkedItems) 
        throws SQLException, NamingException{
        if (this.items == null) {
            return -1;
        }        
        OrdersDAO ordersDAO = new OrdersDAO();
        int orderID = ordersDAO.createNewOrder(name, address, total);
        
        if (orderID > 0) {
            OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
            boolean result = orderDetailsDAO.createOrderDetails(orderID, checkedItems);
            if (result) {
                return orderID;
            }
        }
        return -1;
    }
    
    public int getQuantityBySKU(String SKU) {
        if (SKU == null) {
            return 0;
        }
        if (SKU.trim().isEmpty()){
            return 0;
        }
        if (this.items == null) {
            return 0;
        }
        
        int quantity = 0;
        
        for (ProductDTO dto : this.items.keySet()) {
            if (SKU.equals(dto.getSKU())) {
                quantity = this.items.get(dto);
                return quantity;
            }
        }       
        return 0;
    }
    
    public List<OrderDetailsDTO> addItemsToOrderDetailsDTO
        (Map<ProductDTO, Integer> checkedItems, int orderID) {
            
        List<OrderDetailsDTO> list = new ArrayList<>();
       
        for (ProductDTO dto : checkedItems.keySet()) {
            String SKU = dto.getSKU();
            String name = dto.getName();
            BigDecimal price = dto.getPrice();
            int quantity = checkedItems.get(dto);
            BigDecimal total = price.multiply(new BigDecimal(quantity));
            
            OrderDetailsDTO orderDetailsDTO = new OrderDetailsDTO(orderID, SKU, name, price, quantity, total);
            
            list.add(orderDetailsDTO);
        }
        
        return list;
    }

}
