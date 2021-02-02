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

    /**
     * When the order is confirmed, make sure the available products lwc is aware.
     * @param event
     */
    handleOrderActivated(event){
        let availableProductsElement = this.template.querySelector("c-available-products");
        availableProductsElement.isDisabled = true;
    }
}