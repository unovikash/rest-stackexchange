@isTest
private class StackExchangeAPI_Test {
    @isTest public static void testCallout() {
        test.startTest();
            //Setup Mock
            test.setMock(HttpCalloutMock.class, new testHttpCalloutMock());

            CalloutViewer_Controller controller = new CalloutViewer_Controller();
            controller.getMethodOptions();
            controller.requestEndpoint = 'https://api.stackexchange.com/2.2/questions/unanswered?site=salesforce';
            controller.requestMethod = 'GET';
            controller.requestBody = '';
            controller.callout();
            controller.deserializeQuestionsFromResponse();

            System.assertEquals(1, controller.deserializedQuestions.size());
            
            // StackExchangeAPI.ResponseResource resRes = new StackExchangeAPI.ResponseResource();
            // Date fromdate = Date.newInstance(2019, 9, 06);
            // Date todate = Date.newInstance(2019, 9, 09);
            // resRes = StackExchangeAPI.questionsUnanswered('stackoverflow', 1, 3, fromdate, todate, 'desc', null, null, 'activity', null);
            // System.assetEquals(True, resRes.items.size() > 0);
        test.stopTest();
    }
}
