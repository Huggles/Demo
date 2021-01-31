/**
 * @author Hugo van Krimpen
 * @date 31-01-2021
 * @description Selector Class for Order.
 */
public with sharing class OrderSelector {


    public static List<Order> getOrders(List<Id> orderIds){
        List<Order> orders = [
                SELECT  Id,
                        Name,
                (SELECT Id, Product2.Name, UnitPrice, Quantity, TotalPrice FROM OrderItems)
                FROM Order
                WHERE Id IN :orderIds];
        return orders;
    }
}