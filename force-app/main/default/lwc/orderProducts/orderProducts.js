/**
 * Created by Hugo on 31/01/2021.
 */

import {LightningElement, api, wire} from 'lwc';

import getOrderDetails from '@salesforce/apex/OrderViewController.getOrderDetails';
import addPriceBookEntries from '@salesforce/apex/OrderViewController.addPriceBookEntries';
import confirmOrder from '@salesforce/apex/OrderViewController.confirmOrder';

import {consoleLogDeepCopy} from "c/lwcHelper";

export default class AvailableProducts extends LightningElement {

    /**
     * The order record id
     */
    @api recordId;

    /**
     * Stores the quote record and its items
     * @private
     */
    _orderRecord;

    /**
     * Whether the component is loading or not.
     * @type {boolean}
     */
    isLoading = false;

    /**
     * Gets the available product column names
     * @returns {[{}]}
     */
    get orderedItemsColumns(){
        const columns = [
            { label: 'Name', fieldName: 'Name' },
            { label: 'Unit Price', fieldName: 'UnitPrice', type: 'currency' },
            { label: 'Quantity', fieldName: 'Quantity', type: 'number' },
            { label: 'Total Price', fieldName: 'TotalPrice', type: 'currency' }
        ]
        return columns;
    }


    /**
     * lifecycle hook
     */
    connectedCallback() {
        this.retrieveOrderDetails();
    }


    /**
     * Returns the order items attached to the quote.
     * @returns {*|*[]}
     */
    get orderItems(){
        return this._orderRecord ? this._orderRecord['OrderItems'] : [];
    }



    /**
     * Retrieves the available products.
     */
    retrieveOrderDetails() {
        this.isLoading = true;
        getOrderDetails({orderId : this.recordId})
            .then((result)=>{
                this._orderRecord = result;
                consoleLogDeepCopy(this._orderRecord);
            })
            .catch((error)=>{
                console.log(error);
            })
            .finally(()=>{
                this.isLoading = false;
            })
    }
    /**
     * Adds the provided price book entry as an Order Item to the Order this lwc represents.
     * @param productId
     */
    @api
    addPricebookEntries(pricebookEntryIds) {
        if(this.isLoading === false){
            this.isLoading = true;
            addPriceBookEntries({ orderId : this.recordId, priceBookEntryIds : pricebookEntryIds })
                .then((result)=>{
                    this._orderRecord = result;
                })
                .catch((error)=>{
                    console.log(error);
                })
                .finally(()=>{
                    this.isLoading = false;
                })
        }
    }



    /**
     * When the confirm order button has been clicked.
     */
    handleConfirmOrderClicked(event){
        if(this.isLoading === false){
            this.isLoading = true;
            confirmOrder({ orderId : this.recordId })
                .then((result)=>{
                    consoleLogDeepCopy(result);

                })
                .catch((error)=>{
                    console.log(error);
                })
                .finally(()=>{
                    this.isLoading = false;
                })
        }

    }
}