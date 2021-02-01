/**
 * @author Hugo van Krimpen
 * @date 31-01-2021
 * @description Selector Class for Order.
 */
public with sharing class OrderSelector {

    /**
     * Gets Order details.
     * @param orderIds A list of ids to get.
     *
     * @return A list of Order records.
     */
    public static List<Order> getOrders(List<Id> orderIds){
        List<Order> orders = [
                SELECT  Id,
                        Name,
                        OrderNumber,
                        Account.AccountNumber,
                        Type,
                        Status,
                    (SELECT Id,
                            OrderId,
                            OrderItemNumber,
                            PricebookEntryId,
                            Product2.Name,
                            Product2.ProductCode,
                            UnitPrice,
                            Quantity,
                            TotalPrice
                    FROM OrderItems)
                FROM Order
                WHERE Id IN :orderIds];
        return orders;
    }
}