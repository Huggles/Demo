/**
 * Created by Hugo on 31/01/2021.
 */

import {LightningElement, api, wire} from 'lwc';

import getOrderDetails from '@salesforce/apex/OrderViewController.getOrderDetails';
import insertOrderItem from '@salesforce/apex/OrderViewController.insertOrderItem';
import updateOrderItem from '@salesforce/apex/OrderViewController.updateOrderItem';

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
    _quoteRecord;

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
     * Returns the quote items attached to the quote.
     * @returns {*|*[]}
     */
    get quoteItems(){
        return this._quoteRecord ? this._quoteRecord['OrderItems'] : [];
    }



    /**
     * Retrieves the available products.
     */
    retrieveOrderDetails() {
        this.isLoading = true;
        getOrderDetails({orderId : this.recordId})
            .then((result)=>{
                this._quoteRecord = result;
                consoleLogDeepCopy(this.quoteItems);
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
    async addProduct(pricebookEntry) {
        this.isLoading = true;
        await insertOrderItem({orderId : this.recordId})
            .then((result)=>{
                this.retrieveOrderDetails();
            })
            .catch((error)=>{

            })
            .finally(()=>{
                this.isLoading = false;
            })
    }
}