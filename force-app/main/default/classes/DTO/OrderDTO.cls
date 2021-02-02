/**
 * Created by Hugo on 31/01/2021.
 */

public with sharing class OrderDTO {

    @AuraEnabled
    public String Id {get; set;}

    @AuraEnabled
    public String Name {get; set;}

    @AuraEnabled
    public String AccountNumber {get; set;}

    @AuraEnabled
    public String OrderNumber {get; set;}

    @AuraEnabled
    public String Type {get; set;}

    @AuraEnabled
    public String Status {get; set;}

    @AuraEnabled
    public List<OrderItemDTO> OrderItems {get; set;}

    public OrderDTO(Order order){
        this.Id = order.Id;
        this.Name = order.Name;
        this.AccountNumber = order.Account.AccountNumber;
        this.OrderNumber = order.OrderNumber;
        this.Type = order.Type;
        this.Status = order.Status;

        OrderItems = new List<OrderItemDTO>();
        for(OrderItem orderItem : order.OrderItems){
            OrderItemDTO orderItemDTO = new OrderItemDTO(orderItem);
            OrderItems.add(orderItemDTO);
        }
    }
}