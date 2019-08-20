List<Document> logo = [SELECT Id, Name, Body FROM Document WHERE DeveloperName = 'Mobile_logo_png'];
Folder folder = [SELECT Id, Name FROM Folder WHERE Name = 'CT CLM'];
if(logo.size() == 0){
    logo.add(new Document(Name = 'CT Mobile Homepage Settings', FolderId = folder.Id));
}

Http h = new Http();
HttpRequest req = new HttpRequest();
req.setEndpoint('https://raw.githubusercontent.com/VagapovRashid/IDO_Pharna/master/res/logo.png');
req.setMethod('GET');
HttpResponse res = h.send(req);
Blob body = res.getBodyAsBlob();

logo[0].Body = body;

upsert logo;