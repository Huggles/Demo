/**
 * @author Hugo van Krimpen
 * @date 31-01-2021
 * @description Controller Class for product functions.
 */
public with sharing class ProductSelector {


    /**
     * @return Gets a list of available products
     */
    public static List<PricebookEntry> getAvailableProducts(){
        List<PricebookEntry> pricebookEntries = [
                SELECT Id, UnitPrice, Product2.Id, Product2.Name
                FROM PricebookEntry
                WHERE IsActive = TRUE AND Pricebook2.IsStandard = TRUE];
        return pricebookEntries;
    }
}