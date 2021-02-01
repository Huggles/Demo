/**
 * @author Hugo van Krimpen
 * @date 31-01-2021
 * @description Service Class for Order
 */
public with sharing class OrderService {

    /**
     * Add a product to the Order.
     * @param orderId The Order id
     * @param priceBookEntryIds The Pricebook Entry Ids
     * @return OrderItemDTO
     */
    public static void addPriceBookEntries(Id orderId, List<Id> priceBookEntryIds){
        List<PricebookEntry> pricebookEntriesDetails = PriceBookSelector.getPriceBookEntryDetails(priceBookEntryIds);
        Order order = OrderSelector.getOrders(new List<Id>{orderId})[0];
        List<OrderItem> currentOrderItems = order.OrderItems;
        List<OrderItem> updatedOrderItems = new List<OrderItem>();

        for(PricebookEntry pricebookEntry : pricebookEntriesDetails){

            /** Find the order item linked to this pricebook entry */
            OrderItem foundOrderItem;
            for(OrderItem currentOrderItem : currentOrderItems){

                if(pricebookEntry.Id == currentOrderItem.PricebookEntryId) foundOrderItem = currentOrderItem;
            }

            /** If order item was found, increase quantity with 1 */
            if(foundOrderItem != null){
                foundOrderItem.Quantity += 1;
                updatedOrderItems.add(foundOrderItem);
            }
            else{ /** If order item was -not- found, create new one and set quantity to 1 */
                OrderItem orderItem = new OrderItem();
                orderItem.OrderId = orderId;
                orderItem.PricebookEntryId = pricebookEntry.Id;
                orderItem.UnitPrice = pricebookEntry.UnitPrice;
                orderItem.Quantity = 1;
                updatedOrderItems.add(orderItem);
            }
        }
        upsert updatedOrderItems;
    }

    /**
    * Confirms an order in the external system.
    * @param orderId The Order id to confirm
     * @return Boolean whether or not the callout was successful.
    */
    public static Boolean confirmOrder(Id orderId){
        List<Order> orders = OrderSelector.getOrders(new List<Id>{orderId});
        OrderConfirmationDTO orderConfirmationDTO = new OrderConfirmationDTO(orders[0]);

        String endpoint = 'https://hvk-demo.requestcatcher.com/';

        // Instantiate a new http object
        Http h = new Http();

        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setBody(JSON.serialize(orderConfirmationDTO));

        // Send the request, and return a response
        HttpResponse res = h.send(req);

        if(res.getStatusCode() == 200){
            return true;
        }else{
            return false;
        }
    }
}