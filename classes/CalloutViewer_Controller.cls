public with sharing class CalloutViewer_Controller {

    public String requestEndpoint {get; set;}
    public String requestMethod {get; set;}
    public String requestBody {get; set;}
    public String responseStatus {get; set;}
    public Integer responseStatusCode {get; set;}
    public String responseBody {get; set;}
    public StackExchangeAPI.ResponseResource response {get; set;}
    public List<StackExchangeAPI.QuestionResource> deserializedQuestions {get; set;}

    public CalloutViewer_Controller() {
        requestEndpoint = StackExchangeAPI.compileEndpoint('questions/unanswered', 'salesforce', 1, 50, System.today().addDays(-1), System.today(), 
        'desc', System.today().addDays(-1), System.today(), 'activity', '');
    }

    public void callout() {
        HttpResponse res = StackExchangeAPI.callout('GET', requestEndpoint, requestBody);
        responseStatusCode = res.getStatusCode();
        responseStatus = res.getStatus();
        responseBody = res.getBody();
    }

    public void deserializedQuestions() {
        if (String.isNotBlank(responseBody)) {
            response = (StackExchangeAPI.ResponseResource) JSON.deserialize(responseBody, StackExchangeAPI.ResponseResource.class);
            deserializedQuestions = response.items;
        }
    }

    public List<SelectOption> getMethodOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('GET', 'GET'));
        options.add(new SelectOption('POST', 'POST'));
        options.add(new SelectOption('PUT', 'PUT'));
        options.add(new SelectOption('DELETE', 'DELETE'));
        options.add(new SelectOption('HEAD', 'HEAD'));
        return options;
    }
}