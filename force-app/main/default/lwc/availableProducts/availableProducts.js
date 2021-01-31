/**
 * Created by Hugo on 31/01/2021.
 */

import {LightningElement, api, wire} from 'lwc';

import getAvailableProducts from '@salesforce/apex/OrderViewController.getAvailableProducts';

export default class AvailableProducts extends LightningElement {

    /**
     * The order record id
     */
    @api recordId;


    get availableProductColumns(){
        const columns = [
            { label: 'Name', fieldName: 'Name' },
            { label: 'List Price', fieldName: 'UnitPrice', type: 'currency' },
        ]
        return columns;
    }

    /**
     * Stores the available product data.
     * @type {[]}
     * @private
     */
    _availableProductData = [];


    /**
     * Gets the available product data in lightning datatable format.
     * In this scenario, its equal to the actual data.
     * Reloads the table when the data is updated.
     * @type {[]}
     * @private
     */
    get availableProductData(){
        return this._availableProductData;
    }


    /**
     * Retrieves the available products.
     * @param error
     * @param data
     */
    @wire(getAvailableProducts, {orderId : '$recordId'})
    retrieveAvailableProducts({ error, data }) {
        if (data) {
            this._availableProductData = data;
        } else if (error) {
            console.log(error);
        }
    }
}