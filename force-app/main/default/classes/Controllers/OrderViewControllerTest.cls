/**
 * @author Hugo van Krimpen
 * @date 31-01-2021
 * @description Tests for Order View Controller Class.
 */

@IsTest
public with sharing class OrderViewControllerTest {

    @TestVisible public static final String ACCOUNT_NAME = 'TestAccount';
    @TestVisible public static final String PRODUCT_NAME = 'TestProduct';
    @TestVisible public static final String PRODUCT_NAME_2 = 'TestProduct_2';
    @TestVisible public static final Double PRICE_BOOK_ENTRY_PRICE = 50;
    @TestVisible public static final Double PRICE_BOOK_ENTRY_PRICE_2 = 100;
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
    public static void testGetOrderDetailsError(){
        Test.startTest();
        try {
            OrderDTO order = OrderViewController.getOrderDetails(null);
            System.assert(false);

        }
        catch (Exception e){
            System.assert(true);
        }
        Test.stopTest();
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
    public static void testGetAvailableProductsError(){
        Test.startTest();
        try {
            List<PricebookEntry> pricebookEntries = OrderViewController.getAvailableProducts(null);
            System.assert(false);

        }
        catch (Exception e){
            System.assert(true);
        }
        Test.stopTest();
    }

    @IsTest
    public static void testAddExistingPriceBookEntries(){
        Id orderId = [SELECT Id FROM Order].Id;

        Product2 product = new Product2();
        product.Name = PRODUCT_NAME_2;
        insert product;

        PricebookEntry pricebookEntry = new PricebookEntry();
        pricebookEntry.Product2Id = product.Id;
        pricebookEntry.Pricebook2Id = Test.getStandardPricebookId();
        pricebookEntry.UnitPrice = PRICE_BOOK_ENTRY_PRICE_2;
        pricebookEntry.UseStandardPrice = false;
        pricebookEntry.IsActive = true;
        insert pricebookEntry;


        Test.startTest();
        OrderDTO orderDTO = OrderViewController.addPriceBookEntries(orderId, new List<Id>{pricebookEntry.Id});
        Test.stopTest();

        System.assertEquals(2, orderDTO.OrderItems.size());
    }
    @IsTest
    public static void testAddNewPriceBookEntries(){
        Id orderId = [SELECT Id FROM Order].Id;
        Map<Id,PricebookEntry> pricebookEntriesMap  = new Map<Id,PricebookEntry>([SELECT Id, Name FROM PricebookEntry]);
        List<Id> pricebookEntryKeys = new List<Id>(pricebookEntriesMap.keySet());

        Test.startTest();
        OrderDTO orderDTO = OrderViewController.addPriceBookEntries(orderId, pricebookEntryKeys);
        Test.stopTest();

        System.assertEquals(1, orderDTO.OrderItems.size());
    }
    @IsTest
    public static void testAddPriceBookEntriesError(){
        Test.startTest();
        try {
            OrderDTO orderDTO = OrderViewController.addPriceBookEntries(null, null);
            System.assert(false);
        }
        catch (Exception e){
            System.assert(true);
        }
        Test.stopTest();
    }

    @IsTest
    public static void testConfirmOrder(){
        Test.setMock(HttpCalloutMock.class, new RequestCatcherMock());
        Id orderId = [SELECT Id FROM Order].Id;
        Test.startTest();
        OrderDTO orderDTO = OrderViewController.confirmOrder(orderId);
        Test.stopTest();
        System.assertEquals('Activated',orderDTO.Status);
    }

    @IsTest
    public static void testConfirmOrderError(){
        Test.setMock(HttpCalloutMock.class, new RequestCatcherMockError());
        Id orderId = [SELECT Id FROM Order].Id;
        Test.startTest();
        try {
            OrderDTO orderDTO = OrderViewController.confirmOrder(orderId);
            System.assert(false);
        }
        catch (Exception e){
            System.assert(true);
        }
        Test.stopTest();
    }


}