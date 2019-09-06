public with sharing class ExecAnonymousVikash {
    public ExecAnonymousVikash() {
		StackExchangeAPI.ResponseResource resRes = new StackExchangeAPI.ResponseResource();
        Date fromdate = Date.newInstance(2019, 9, 04);
        Date todate = Date.newInstance(2019, 9, 06);
        resRes = StackExchangeAPI.questionsUnanswered('stackoverflow', 1, 3, fromdate, todate, 'desc', null, null, 'activity', null);
        System.debug('Quota Remaining: ' + resRes.quota_remaining);        
    }
}