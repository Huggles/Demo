/**
 * Created by Hugo on 31/01/2021.
 */

public with sharing class OrderConfirmationDTO {

    @AuraEnabled
    public String accountNumber {get; set;}

    @AuraEnabled
    public String orderNumber {get; set;}

    @AuraEnabled
    public String type {get; set;}

    @AuraEnabled
    public String status {get; set;}

    @AuraEnabled
    public List<OrderItemConfirmationDTO> orderProducts { get; set;}

    public OrderConfirmationDTO(Order order){
        this.accountNumber = order.Account.AccountNumber;
        this.orderNumber = order.orderNumber;
        this.type = order.type;
        this.status = order.status;

        orderProducts = new List<OrderItemConfirmationDTO>();
        for(OrderItem orderItem : order.OrderItems){
            orderProducts.add(new OrderItemConfirmationDTO(orderItem));
        }
    }



    public class OrderItemConfirmationDTO{

        @AuraEnabled
        public String name {get; set;}

        @AuraEnabled
        public String code {get; set;}

        @AuraEnabled
        public Decimal unitPrice {get; set;}

        @AuraEnabled
        public Decimal quantity {get; set;}


        public OrderItemConfirmationDTO(OrderItem orderItem){
            this.name = orderItem.Product2.Name;
            this.code = orderItem.Product2.ProductCode;
            this.unitPrice = orderItem.UnitPrice;
            this.quantity = orderItem.Quantity;
        }


    }
}