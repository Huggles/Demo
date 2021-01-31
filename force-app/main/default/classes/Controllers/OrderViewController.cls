
/**
 * @author Hugo van Krimpen
 * @date 31-01-2021
 * @description Controller Class for order view functions.
 */
public with sharing class OrderViewController {


    /**
     * Gets the available products for the provided order id.
     * @param orderId The order id.
     *
     * @return List of Price Book Entries
     */
    @AuraEnabled(Cacheable=true)
    public static List<PricebookEntry> getAvailableProducts(Id orderId){
        try {
            return ProductSelector.getAvailableProducts(orderId);
        }
        catch(Exception e){
            //Log error;
            throw e;
        }
    }


    /**
     * Gets the Order and Attached Order Items
     * @param orderId The order id.
     *
     * @return Order record.
     */
    @AuraEnabled
    public static OrderDTO getOrderDetails(Id orderId){
        try {
            List<Order> orders = OrderSelector.getOrders(new List<Id>{orderId});
            OrderDTO orderDTO = new OrderDTO(orders[0]);
            return orderDTO;
        }
        catch (ListException listException){
            //Catch for when a wrong id is passed.
            throw new CustomException('Order not found.');
        }
        catch(Exception e){
            //Log error;
            throw e;
        }
    }

}