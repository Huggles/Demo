/**
 * Created by Hugo on 02/02/2021.
 */

global class RequestCatcherMock implements HttpCalloutMock{

    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse httpResponse = new HttpResponse();
        httpResponse.setBody('');
        httpResponse.setStatusCode(200);
        return httpResponse;
    }
}