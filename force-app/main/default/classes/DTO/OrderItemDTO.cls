/**
 * Created by Hugo on 31/01/2021.
 */

public with sharing class OrderItemDTO {

    @AuraEnabled
    public String Id {get; set;}

    @AuraEnabled
    public String Name {get; set;}

    @AuraEnabled
    public Double UnitPrice {get; set;}

    @AuraEnabled
    public Double TotalPrice {get; set;}

    @AuraEnabled
    public Decimal Quantity {get; set;}

    @AuraEnabled
    public Id PriceBookEntryId {get; set;}

    /**
     * Constructor
     * @param orderItem The Order Item
     */
    public OrderItemDTO(OrderItem orderItem){
        this.Id = orderItem.Id;
        this.Name = orderItem.Product2.Name;
        this.UnitPrice = orderItem.UnitPrice;
        this.TotalPrice = orderItem.TotalPrice;
        this.Quantity = orderItem.Quantity;
        this.PriceBookEntryId = orderItem.PricebookEntryId;
    }
}