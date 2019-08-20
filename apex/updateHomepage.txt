List<Document> documents = [SELECT Id, Name, Body FROM Document WHERE Name = 'CT Mobile Homepage Settings'];
Folder folder = [SELECT Id, Name FROM Folder WHERE Name = 'CT CLM'];
if(documents.size() == 0){
    documents.add(new Document(Name = 'CT Mobile Homepage Settings', FolderId = folder.Id));
}
String orgId = UserInfo.getOrganizationId();
String newBlob = '[{"size":{"x":4,"y":1},"position":[0,0],"widget":{"id":1,"name":"Logo","type":"logo"},"profile":{"id":"';
newBlob += orgId;
newBlob += '","profileName":"General Settings"},"$$hashKey":"7I2"},{"size":{"x":4,"y":1},"position":[1,0],"widget":{"id":3,"name":"Calendar Presentation (carousel)","type":"calendarPresentationCarousel"},"profile":{"id":"';
newBlob += orgId;
newBlob += '","profileName":"General Settings"},"$$hashKey":"7ME"},{"size":{"x":4,"y":1},"position":[2,0],"widget":{"id":2,"name":"Calendar Week (carousel)","type":"calendarWeekCarousel"},"profile":{"id":"';
newBlob += orgId;
newBlob += '","profileName":"General Settings"},"$$hashKey":"7QS"}]';
documents[0].Body = Blob.valueOf(newBlob);
documents[0].DeveloperName = 'CTMobileHomepageSettings_1223334444';

upsert documents;