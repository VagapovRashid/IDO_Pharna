List<CTPHARMA__Activity__c> activities = new List<CTPHARMA__Activity__c>();

Account acc = [SELECT Id FROM Account WHERE Name = '*United Facility Network' LIMIT 1];
Contact con = [SELECT Id FROM Contact WHERE Name = '*Lauren Boyle' LIMIT 1];

Id visitId = Schema.SObjectType.CTPHARMA__Activity__c.getRecordTypeInfosByName().get('1:1 Visit').getRecordTypeId();
Id visitKamId = Schema.SObjectType.CTPHARMA__Activity__c.getRecordTypeInfosByName().get('Visit KAM').getRecordTypeId();
Id consumerHealthId = Schema.SObjectType.CTPHARMA__Activity__c.getRecordTypeInfosByName().get('Consumer Health').getRecordTypeId();

CTPHARMA__Activity__c newActivity = new CTPHARMA__Activity__c();
newActivity.CTPHARMA__StartDate__c = System.now().addHours(1);

activities.add(new CTPHARMA__Activity__c(RecordTypeId = visitId, CTPHARMA__Status__c = 'Planned', CTPHARMA__StartDate__c = System.now().addHours(1), CTPHARMA__AccountId__c = acc.Id, CTPHARMA__ContactId__c = con.Id));
activities.add(new CTPHARMA__Activity__c(RecordTypeId = visitId, CTPHARMA__Status__c = 'Planned', CTPHARMA__StartDate__c = System.now().addHours(2), CTPHARMA__AccountId__c = acc.Id, CTPHARMA__ContactId__c = con.Id));
activities.add(new CTPHARMA__Activity__c(RecordTypeId = visitId, CTPHARMA__Status__c = 'Planned', CTPHARMA__StartDate__c = System.now().addHours(3), CTPHARMA__AccountId__c = acc.Id, CTPHARMA__ContactId__c = con.Id));
activities.add(new CTPHARMA__Activity__c(RecordTypeId = visitKamId, CTPHARMA__Status__c = 'In Progress', CTPHARMA__StartDate__c = System.now().addHours(4), CTPHARMA__AccountId__c = acc.Id, CTPHARMA__ContactId__c = con.Id));
activities.add(new CTPHARMA__Activity__c(RecordTypeId = visitKamId, CTPHARMA__Status__c = 'In Progress', CTPHARMA__StartDate__c = System.now().addHours(5), CTPHARMA__AccountId__c = acc.Id, CTPHARMA__ContactId__c = con.Id));
activities.add(new CTPHARMA__Activity__c(RecordTypeId = consumerHealthId, CTPHARMA__Status__c = 'Finished', CTPHARMA__StartDate__c = System.now().addHours(6), CTPHARMA__AccountId__c = acc.Id, CTPHARMA__ContactId__c = con.Id));

insert activities;