ContentWorkspace contentWorkspace = [SELECT Id FROM ContentWorkspace WHERE Name = 'CT Library'];

Http h = new Http();
HttpRequest req = new HttpRequest();
req.setMethod('GET');
req.setEndpoint('https://raw.githubusercontent.com/VagapovRashid/IDO/master/res/einstein.png');
HttpResponse res = h.send(req);
Blob body = res.getBodyAsBlob();

ContentVersion contentVersion = new ContentVersion();
contentVersion = new ContentVersion();
contentVersion.Title = 'einstein';
contentVersion.VersionData = body;
contentVersion.PathOnClient = 'einstein.png';

insert contentVersion;

contentVersion = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion.Id];

ContentWorkspaceDoc doc = new ContentWorkspaceDoc();
doc.ContentDocumentId = contentVersion.ContentDocumentId;
doc.ContentWorkspaceId = contentWorkspace.Id;

insert doc;