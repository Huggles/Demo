/**
 * Created by Hugo on 31/01/2021.
 */

public with sharing class OrderDTO {

    @AuraEnabled
    public String Id {get; set;}

    @AuraEnabled
    public String Name {get; set;}

    @AuraEnabled
    public List<OrderItemDTO> OrderItems {get; set;}

    public OrderDTO(Order order){
        this.Id = order.Id;
        this.Name = order.Name;
        OrderItems = new List<OrderItemDTO>();
        for(OrderItem orderItem : order.OrderItems){
            OrderItemDTO orderItemDTO = new OrderItemDTO(orderItem);
            OrderItems.add(orderItemDTO);
        }
    }
}