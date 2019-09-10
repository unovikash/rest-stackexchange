public with sharing class testHttpCalloutMock implements HttpCalloutMock{
    public HttpResponse respond(HttpRequest req) {
        
        //Constructing an object to respond with
        StackExchangeAPI.ResponseResource response = new StackExchangeAPI.ResponseResource();
        response.items = new List<StackExchangeAPI.QuestionResource>{new StackExchangeAPI.QuestionResource()};
        response.items[0].tags = new List<String>{'test'};
        response.items[0].is_answered = true;
        response.items[0].view_count = 0;
        response.items[0].answer_count = 0;
        response.items[0].score = 100;
        response.items[0].last_activity_date = System.now().getTime();
        response.items[0].creation_date = System.now().getTime();
        response.items[0].last_edit_date = System.now().getTime();
        response.items[0].question_id = 1;
        response.items[0].link = 'TestLink';
        response.items[0].title = 'Test Title';

        response.items[0].owner = new StackExchangeAPI.UserResource();
        response.items[0].owner.reputation = 'Test';
        response.items[0].owner.user_id = 'Test';
        response.items[0].owner.user_type = 'Test';
        response.items[0].owner.profile_image = 'Test';
        response.items[0].owner.display_name = 'Test';
        response.items[0].owner.link = 'Test';

        // Initiate a new HttpResponse
        HttpResponse res = new HttpResponse();
        res.setStatus('OK');
        res.setStatusCode(200);
        res.setBody(JSON.serialize(response));

        return res;
    }
}
