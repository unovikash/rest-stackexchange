public with sharing class StackExchangeAPI {
    public static String BASE_URL = 'https://api.stackexchange.com/2.2/';

    //Method to perform a callout and return an httpResponse
    public static httpResponse callout(String httpMethod, String endpoint, String body) {
        System.debug('Endpoint: ' + endpoint);
        HttpRequest req = new HttpRequest();
        req.setMethod(httpMethod);
        req.setEndpoint(endpoint);

        //Optional attributes
        req.setHeader('Accept-Encoding', 'gzip, deflate');
        req.setTimeout(100000);

        //Send HttpRequest
        HttpResponse res = new http().send(req);

        System.debug(res.toString());
        System.debug(res.getBody());
        return res;
    }

    //Method to deserialize the response body
    public static ResponseResource deserialize(HttpResponse res) {
        return (ResponseResource)JSON.deserialize(res.getBody(), ResponseResource.class);
    }

    //Apex Class to store the deserialized data
    public class ResponseResource {
        public Integer error_id {get; set;}
        public String error_message {get; set;}
        public String error_name {get; set;}
        public Boolean has_more {get; set;}
        public Integer quota_max {get; set;}
        public Integer quota_remaining {get; set;}
        public List<QuestionResource> items {get; set;}
    }

    // Question Item
    public  class QuestionResource {
        public List<String> tags {get; set;}
        public UserResource owner {get; set;}
        public Boolean is_answered {get; set;}
        public Integer view_count {get; set;}
        public Integer answer_count {get; set;}
        public Integer score {get; set;}
        public Long last_activity_date {get; set;}
        public Long creation_date {get; set;}
        public Long last_edit_date {get; set;}
        public Integer question_id {get; set;}
        public String link {get; set;}
        public String title {get; set;}
    }

    // User 
    public class UserResource {
        public String reputation {get; set;}
        public String user_id {get; set;}
        public String user_type {get; set;}
        public String profile_image {get; set;}
        public String display_name {get; set;}
        public String link {get; set;}
    }

//Other Userful Methods
    public static ResponseResource questionsUnanswered(String site, Integer page, Integer pageSize, Date fromdate, Date todate, 
    String order, Date min, Date max, String sortParam, String tagged) {
        HttpResponse res = callout('GET', compileEndPoint('questions/unanswered', site, page, pageSize, fromdate, todate, order, 
                                            min, max, sortParam, tagged), null);
        if (res.getStatusCode() == 200 && String.isNotBlank(res.getBody())) {
            return deserialize(res);
        }   
        return null;
    }

    public static String compileEndpoint (String call, String site, Integer page, Integer pageSize, Date fromdate, Date todate,
    String order, Date min, Date max, String sortParam, String tagged) {
        
        Pagereference endpoint = new Pagereference(BASE_URL + call);
        if (String.isNotBlank(site))
            endpoint.getParameters().put('site', site);
        if (page != null && page > 0)
            endpoint.getParameters().put('page', String.valueOf(page));
        if (pageSize != null && pageSize > 0)
            endpoint.getParameters().put('pageSize', String.valueOf(pageSize));
        if (fromdate != null)
            endpoint.getParameters().put('fromdate',string.valueOf(dateTime.newInstance(fromdate,time.newInstance(0,0,0,0)).getTime()/1000));
        if (todate != null)
            endpoint.getParameters().put('todate',string.valueOf(dateTime.newInstance(todate,time.newInstance(0,0,0,0)).getTime()/1000));
        if (String.isNotBlank(order))
            endpoint.getParameters().put('order', order);
        if (min != null)
            endpoint.getParameters().put('min',string.valueOf(dateTime.newInstance(min,time.newInstance(0,0,0,0)).getTime()/1000));
        if (max != null)
            endpoint.getParameters().put('max',string.valueOf(dateTime.newInstance(max,time.newInstance(0,0,0,0)).getTime()/1000));
        if (String.isNotBlank(sortParam))
            endpoint.getParameters().put('sort', sortParam);
        if (String.isNotBlank(tagged))
            endpoint.getParameters().put('tagged', tagged);
        return endpoint.getURL();
    }
}