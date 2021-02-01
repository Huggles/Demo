/**
 * @author Hugo van Krimpen
 * @date 31-01-2021
 * @description Tests for Order View Controller Class.
 */

@IsTest
public with sharing class OrderViewControllerTest {

    @TestVisible public static final String ACCOUNT_NAME = 'TestAccount';
    @TestVisible public static final String PRODUCT_NAME = 'TestProduct';
    @TestVisible public static final Double PRICE_BOOK_ENTRY_PRICE = 50;
    @TestVisible public static final Double ORDER_ITEM_QUANTITY = 50;

    @TestSetup
    public static void testSetup(){
        Account account = new Account();
        account.Name = ACCOUNT_NAME;
        insert account;

        Product2 product = new Product2();
        product.Name = PRODUCT_NAME;
        insert product;

        PricebookEntry pricebookEntry = new PricebookEntry();
        pricebookEntry.Product2Id = product.Id;
        pricebookEntry.Pricebook2Id = Test.getStandardPricebookId();
        pricebookEntry.UnitPrice = PRICE_BOOK_ENTRY_PRICE;
        pricebookEntry.UseStandardPrice = false;
        pricebookEntry.IsActive = true;
        insert pricebookEntry;

        Order order = new Order();
        order.AccountId = account.Id;
        order.EffectiveDate = Date.today();
        order.Status = 'Draft';
        order.Pricebook2Id = Test.getStandardPricebookId();
        insert order;

        OrderItem orderItem = new OrderItem();
        orderItem.OrderId = order.Id;
        orderItem.UnitPrice = pricebookEntry.UnitPrice;
        orderItem.PricebookEntryId = pricebookEntry.Id;
        orderItem.Quantity = ORDER_ITEM_QUANTITY;
        insert orderItem;
    }

    @IsTest
    public static void testGetOrderDetails(){
        Id orderId = [SELECT Id FROM Order].Id;

        Test.startTest();
        OrderDTO order = OrderViewController.getOrderDetails(orderId);
        Test.stopTest();

        System.assertEquals(1, order.OrderItems.size());
    }
    @IsTest
    public static void testGetAvailableProducts(){
        Id orderId = [SELECT Id FROM Order].Id;

        Test.startTest();
        List<PricebookEntry> pricebookEntries = OrderViewController.getAvailableProducts(orderId);
        Test.stopTest();

        System.assertEquals(1, pricebookEntries.size());
        System.assertEquals(PRICE_BOOK_ENTRY_PRICE, pricebookEntries[0].UnitPrice);
    }

    @IsTest
    public static void testInsertOrderItem(){
        Id orderId = [SELECT Id FROM Order].Id;
        Id pricebookEntry = [SELECT Id FROM PricebookEntry].Id;

        Test.startTest();
        OrderItemDTO orderItemDTO = OrderViewController.insertOrderItem(orderId,pricebookEntry);
        Test.stopTest();
    }

    @IsTest
    public static void testUpdateOrderItem(){
        Id orderId = [SELECT Id FROM Order].Id;
        List<Order> orders = OrderSelector.getOrders(new List<Id>{orderId});
        OrderItemDTO originalOrderItemDTO = new OrderItemDTO(orders[0].OrderItems[0]);
        originalOrderItemDTO.UnitPrice = 1000;

        Test.startTest();
        OrderItemDTO updatedOrderItemDTO = OrderViewController.updateOrderItem(originalOrderItemDTO);
        Test.stopTest();

        System.assertEquals(1000, updatedOrderItemDTO.UnitPrice);
    }

}