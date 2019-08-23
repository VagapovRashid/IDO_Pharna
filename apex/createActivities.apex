List<CTPHARMA__Activity__c> activities = new List<CTPHARMA__Activity__c>();

List<String> statuses = new List<String>();
statuses.add('Planned');
statuses.add('In Progress');
statuses.add('Finished');
statuses.add('Canceled');

List<Id> recordTypeIds = new List<Id>();
recordTypeIds.add(Schema.SObjectType.CTPHARMA__Activity__c.getRecordTypeInfosByName().get('Visit KAM').getRecordTypeId());
recordTypeIds.add(Schema.SObjectType.CTPHARMA__Activity__c.getRecordTypeInfosByName().get('Consumer Health').getRecordTypeId());
recordTypeIds.add(Schema.SObjectType.CTPHARMA__Activity__c.getRecordTypeInfosByName().get('Mobile Consumer Health').getRecordTypeId());
recordTypeIds.add(Schema.SObjectType.CTPHARMA__Activity__c.getRecordTypeInfosByName().get('Mobile Visit KAM').getRecordTypeId());
recordTypeIds.add(Schema.SObjectType.CTPHARMA__Activity__c.getRecordTypeInfosByName().get('Mobile Visit').getRecordTypeId());

for(Id recordTypeId : recordTypeIds){
    for(String status : statuses){
        CTPHARMA__Activity__c newActivity = new CTPHARMA__Activity__c();
        newActivity.RecordTypeId = recordTypeId;
        newActivity.CTPHARMA__Status__c = status;
        activities.add(newActivity);
    }
}

insert activities;