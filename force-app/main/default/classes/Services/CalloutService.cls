/**
 * Created by Hugo on 02/02/2021.
 */

public with sharing class CalloutService {
    /**
        * Confirms an order in the external system.
        * @param endpoint The endpoint
        * @param httpMethod The method to use
        * @param body The body to send
        * @return Response string.
        */
    public static String sendPayload(String endpoint, String httpMethod, String body){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod(httpMethod);
        req.setBody(body);

        HttpResponse res = h.send(req);

        if(res.getStatusCode() == 200){
            return res.getBody();
        }else{
            throw new CustomException('Callout failed');
        }
    }
}