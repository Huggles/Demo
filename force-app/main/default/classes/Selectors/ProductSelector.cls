/**
 * @author Hugo van Krimpen
 * @date 31-01-2021
 * @description Selector Class for Product2
 */
public with sharing class ProductSelector {


    /**
     * @return Gets a list of available products
     */
    public static List<PricebookEntry> getAvailableProducts(Id orderId){
        Id pricebookId = PriceBookSelector.getPriceBookIdForOrder(orderId);
        System.debug(pricebookId);
        List<PricebookEntry> pricebookEntries = [
                SELECT Id, Name, UnitPrice, Product2Id
                FROM PricebookEntry
                WHERE IsActive = TRUE AND Pricebook2Id = :pricebookId];
        System.debug(pricebookEntries);
        return pricebookEntries;
    }
}