/**
 * Created by Hugo on 31/01/2021.
 */

import {LightningElement, api, wire} from 'lwc';

import getAvailableProducts from '@salesforce/apex/OrderViewController.getAvailableProducts';
import {consoleLogAsJSON} from "c/lwcHelper";

export default class AvailableProducts extends LightningElement {

    /**
     * The order record id
     */
    @api recordId;


    @wire(getAvailableProducts, {})
    availableProducts({ error, data }) {
        if (data) {
            consoleLogAsJSON(data);
            this.record = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.record = undefined;
        }
    }
}