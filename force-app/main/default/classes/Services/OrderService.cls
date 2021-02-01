/**
 * @author Hugo van Krimpen
 * @date 31-01-2021
 * @description Service Class for Order
 */
public with sharing class OrderService {



    /**
     * Add a product to the Order.
     * @param orderId The Order id
     * @param priceBookEntryId The Pricebook Entry Id
     * @return OrderItemDTO
     */
    public static OrderItemDTO addNewOrderItem(Id orderId, Id priceBookEntryId){
        PricebookEntry pricebookEntry = PriceBookSelector.getPriceBookEntryDetails(priceBookEntryId);
        OrderItem orderItem = new OrderItem();
        orderItem.OrderId = orderId;
        orderItem.PricebookEntryId = pricebookEntry.Id;
        orderItem.UnitPrice = pricebookEntry.UnitPrice;
        orderItem.Quantity = 1;
        insert orderItem;

        return new OrderItemDTO(orderItem);
    }
}