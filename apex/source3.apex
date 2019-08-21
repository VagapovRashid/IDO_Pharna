List<clm__Application__c> applications = [SELECT Id FROM clm__Application__c WHERE Name = 'Asthma'];
Http h = new Http();
HttpRequest req = new HttpRequest();
req.setEndpoint('https://raw.githubusercontent.com/VagapovRashid/IDO_Pharna/master/res/Asthma/sources2.zip');
req.setMethod('GET');
HttpResponse res;
try {
    res = h.send(req);
}catch (CalloutException ex){
    res = h.send(req);
}
Blob body = res.getBodyAsBlob();
//System.debug(body.toString());
Attachment att = new Attachment(Name = 'sources2.zip', Body = res.getBodyAsBlob(), ContentType = 'application/zip', ParentId=applications[0].Id);
insert att;