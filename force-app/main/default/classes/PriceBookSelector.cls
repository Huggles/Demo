
/**
 * @author Hugo van Krimpen
 * @date 31-01-2021
 * @description Selector Class for Price Book
 */
public with sharing class PriceBookSelector {
    /**
     * @return Gets the price book for order
     */
    public static Id getPriceBookIdForOrder(Id orderId){
        Order order = [SELECT Id, Pricebook2Id FROM Order WHERE Id = :orderId LIMIT 1];
        return order.Id;
    }
}