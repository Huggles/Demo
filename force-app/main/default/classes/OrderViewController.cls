
/**
 * @author Hugo van Krimpen
 * @date 31-01-2021
 * @description Controller Class for order view functions.
 */
public with sharing class OrderViewController {


    @AuraEnabled(Cacheable=true)
    public static List<PricebookEntry> getAvailableProducts(){
        try {
            return ProductSelector.getAvailableProducts();
        }
        catch(Exception e){
            //Log error;
            throw e;
        }
    }
}