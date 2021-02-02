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
    public static OrderDTO confirmOrder(Id orderId){
        Order order = OrderSelector.getOrders(new List<Id>{orderId})[0];
        OrderConfirmationDTO orderConfirmationDTO = new OrderConfirmationDTO(order);

        String endpoint = 'https://hvk-demo.requestcatcher.com/';
        String method = 'POST';
        String body = JSON.serialize(orderConfirmationDTO);
        try {
            String response = CalloutService.sendPayload(endpoint, method, body);
            if(response != null){
                order.Status = 'Activated';
                update order;
            }
        }catch (CustomException ce){
            throw new CustomException('Could not confirm the order. Please try again');
        }
        return new OrderDTO(order);
    }
}