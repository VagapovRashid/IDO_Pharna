List<Document> documents = [SELECT Id, Name, Body FROM Document WHERE Name = 'CT Mobile Homepage Settings'];
Folder folder = [SELECT Id, Name FROM Folder WHERE Name = 'CT CLM'];
if(documents.size() == 0){
    documents.add(new Document(Name = 'CT Mobile Homepage Settings', FolderId = folder.Id));
}
String orgId = UserInfo.getOrganizationId();
Report statusReport = [SELECT Id, Name, FolderName FROM Report WHERE DeveloperName='ActivitiesbyStatus'];
Report typeReport = [SELECT Id, Name, FolderName FROM Report WHERE DeveloperName='ActivitiesbyType'];

String newBlob = '[{"size":{"x":4,"y":1},"position":[0,0],"widget":{"id":1,"name":"Logo","type":"logo"},"profile":{"id":"';
newBlob += orgId;
newBlob += '","profileName":"General Settings"},"$$hashKey":"7I2"},{"size":{"x":4,"y":1},"position":[1,0],"widget":{"id":3,"name":"Calendar Presentation (carousel)","type":"calendarPresentationCarousel"},"profile":{"id":"';
newBlob += orgId;
newBlob += '","profileName":"General Settings"},"$$hashKey":"7ME"},{"size":{"x":4,"y":1},"position":[2,0],"widget":{"id":2,"name":"Calendar Week (carousel)","type":"calendarWeekCarousel"},"profile":{"id":"';
newBlob += orgId;
newBlob += '","profileName":"General Settings"},"$$hashKey":"7QS"},{"size":{"x":2,"y":2},"position":[3,0],"widget":{"id":"';
newBlob += typeReport.Id;
newBlob += '","name":"Activities by Type","type":"report","folderId":"00l2o000001apDFAAY"},"profile":{"id":"';
newBlob += orgId;
newBlob += '","profileName":"General Settings"},"$$hashKey":"2NX"},{"size":{"x":2,"y":2},"position":[3,2],"widget":{"id":"';
newBlob += statusReport.Id;
newBlob += '","name":"Activities by Status","type":"report","folderId":"00l2o000001apDFAAY"},"profile":{"id":"';
newBlob += orgId;
newBlob += '","profileName":"General Settings"},"$$hashKey":"2QG"}]';
documents[0].Body = Blob.valueOf(newBlob);
documents[0].DeveloperName = 'CTMobileHomepageSettings_1223334444';



upsert documents;