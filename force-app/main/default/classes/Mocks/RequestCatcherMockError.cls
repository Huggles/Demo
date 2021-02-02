/**
 * Created by Hugo on 02/02/2021.
 */

global class RequestCatcherMockError implements HttpCalloutMock{

    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse httpResponse = new HttpResponse();
        httpResponse.setBody('');
        httpResponse.setStatusCode(500);
        return httpResponse;
    }
}