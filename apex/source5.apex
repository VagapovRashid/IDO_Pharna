List<clm__Application__c> applications = [SELECT Id FROM clm__Application__c WHERE Name = 'Medical Devices (en)'];
Http h = new Http();
HttpRequest req = new HttpRequest();
req.setEndpoint('https://raw.githubusercontent.com/VagapovRashid/IDO_Pharna/master/res/MedicalDevices/brochure_CTM.pdf');
req.setMethod('GET');
HttpResponse res;
try {
    res = h.send(req);
}catch (CalloutException ex){
    res = h.send(req);
}
Blob body = res.getBodyAsBlob();
//System.debug(body.toString());
Attachment att = new Attachment(Name = 'brochure_CTM.pdf', Body = res.getBodyAsBlob(), ContentType = 'application/pdf', ParentId=applications[0].Id);
insert att;