/**
 * Created by Hugo on 02/02/2021.
 */

import {LightningElement, api} from 'lwc';

export default class MessageBox extends LightningElement {


    /**
     * The type of the message box
     */
    @api type;

    /**
     * The message in the box
     */
    @api message;

}