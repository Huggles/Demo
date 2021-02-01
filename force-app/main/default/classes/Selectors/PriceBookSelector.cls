
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
        Order order = [SELECT Pricebook2Id FROM Order WHERE Id = :orderId LIMIT 1];
        return order.Pricebook2Id;
    }

    /**
     * @param priceBookEntryIds A list of PriceBookEntry ids
    * @return Gets price book details
    */
    public static List<PricebookEntry> getPriceBookEntryDetails(List<Id> priceBookEntryIds){
        List<PricebookEntry> pricebookEntry = [
                SELECT Id, Product2.Name, Pricebook2Id, UnitPrice
                FROM PricebookEntry
                WHERE Id IN :priceBookEntryIds];
        return pricebookEntry;
    }
}