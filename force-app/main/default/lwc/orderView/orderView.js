/**
 * Created by Hugo on 31/01/2021.
 */

import {api, LightningElement} from 'lwc';

export default class OrderView extends LightningElement {

    /**
     * The order record id
     */
    @api recordId;


    /**
     * When the available products view adds
     */
    handleAddButtonClicked(event){
        let pricebookEntries = event.detail['pricebookEntryIds'];
        this.template.querySelector("c-order-products").addPricebookEntries(pricebookEntries);
    }
}