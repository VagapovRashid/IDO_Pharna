clm__TopLvlObjects__c newTop = clm__TopLvlObjects__c.getOrgDefaults();
newTop.clm__ConflictManagerAttribute__c = 'false,false,false,false,false,false,false,false,false';
newTop.clm__GroupFields__c = 'null,null,null,null,null,null,null,null,null,null,null,null';
newTop.clm__MenuSettings__c = 'Home,Chatter,RecentItems,Account,CTPHARMA__Activity__c,CTPHARMA__Product__c,Calendar,Routes,NearbyAccounts,Applications,Dashboards,Settings';
newTop.clm__TopLvlObjects__c = 'Sales__c,Account,Contact,CTPHARMA__Activity__c,CTPHARMA__ActivityData__c,CTPHARMA__Product__c,CTPHARMA__Reference__c,Event,Task';
newTop.clm__OnlineAttribute__c = 'false,false,false,false,false,false,false,false,false,false,false,false';
newTop.clm__SortOrder__c = ',,,,,,,,,,,';
upsert newTop;

clm__ApplicationSetup__c newApp = clm__ApplicationSetup__c.getOrgDefaults();
newApp.clm__AccountFullAddressAPIField__c = 'AccountAddress__c';
newApp.clm__AccountGeolocationAPIField__c = 'Geolocation__c';
newApp.clm__ActivityDoneAPI__c = 'CTPHARMA__IsDone__c';
newApp.clm__ActivityIsLockedAPI__c = 'CTPHARMA__IsLocked__c';
newApp.clm__ActivityDescriptionAPI__c = 'CTPHARMA__Description__c,Description,Description';
newApp.clm__ActivityEndDateAPI__c = 'CTPHARMA__EndDate__c,EndDateTime,ActivityDate';
newApp.clm__ActivityGeolocationAPIField__c = 'Geolocation__c,Geolocation__c,Geolocation__c';
newApp.clm__ActivityFieldAPI__c = 'ActivityId__c,EventId__c,TaskId__c';
newApp.clm__ActivityObjectAPIName__c = 'CTPHARMA__Activity__c,Event,Task';
newApp.clm__ActivityDateAPI__c = 'CTPHARMA__StartDate__c,StartDateTime,ActivityDate';
newApp.clm__ActivityStatusAPI__c = 'CTPHARMA__Status__c,Type,Status';
newApp.clm__AllowWebSharing__c = true;
newApp.clm__AppInstallURL__c = 'https://www.ctclm.com/apps/sample/';
newApp.clm__CalendarView__c = 'week';
newApp.clm__CaptureGeoposition__c = true;
newApp.clm__CloudToken__c = '70cca723acce85187321b78f662c021872aa1540546311b6d6';
newApp.clm__DebugLevel__c = 'Error';
newApp.clm__DefaultEventDuration__c = 30;
newApp.clm__GeoTraceInterval__c = 0;
newApp.clm__GoogleMapsAndroidAPIKey__c = null;
newApp.clm__GoogleMapsAPIKey__c = 'AIzaSyC2WS7Ll5W2SRHjfVOYr9kAj3XJ2Fvf6Ns';
newApp.clm__GoogleMapsJSKey__c = 'AIzaSyAJIfOBNIG8DuGTJ6apUcg21Awz0ylSKIY';
newApp.clm__EnableLockUnlock__c = false;
newApp.clm__MetadataLastModifiedDate__c = System.now();
newApp.clm__IsPasscodeEnabled__c = false;
newApp.clm__IsPersonAccountsEnabled__c = false;
newApp.clm__ProductFieldAPI__c = 'CTPHARMA__Product__c';
newApp.clm__ProductObjectAPIName__c = 'CTPHARMA__Product__c';
newApp.clm__PUSHHUBName__c = 'appstore.ctmobile';
newApp.clm__ReferenceObjectAPIName__c = 'CTPHARMA__Reference__c';
newApp.clm__IsWeekSwitchShowed__c = true;
newApp.clm__EnableStartFinish__c = true;
newApp.clm__Theme__c = 'rgb(102,192,196)';
newApp.clm__UpdateDateFields__c = false;
newApp.clm__VisibleHourRange__c = '(9,19)';
newApp.clm__WeekFormat__c = 'mo,mo,fr';
upsert newApp;

List<clm__MobileLayoutSettings__c> settings = new List<clm__MobileLayoutSettings__c>();

List<clm__MobileLayoutSettings__c> newSettings = [SELECT Name FROM clm__MobileLayoutSettings__c WHERE Name = 'New Visit'];
if(newSettings.size() == 0){
	settings.add(new clm__MobileLayoutSettings__c());
}else{
	settings.add(newSettings[0]);
}
settings[0].clm__Action__c = 'New';
settings[0].clm__Fields__c = 'CTPHARMA__AccountId__c,CTPHARMA__ContactId__c,CTPHARMA__StartDate__c';
settings[0].clm__RecordtypeDeveloperName__c = 'Visit';
settings[0].clm__RequiredAttribute__c = 'true,true,true';
settings[0].clm__ReadAttribute__c = 'false,false,false,';
settings[0].clm__SObject__c = 'CTPHARMA__Activity__c';
settings[0].Name = 'New Visit';

newSettings = [SELECT Name FROM clm__MobileLayoutSettings__c WHERE Name = 'New Visit: KAM'];
if(newSettings.size() == 0){
	settings.add(new clm__MobileLayoutSettings__c());
}else{
	settings.add(newSettings[0]);
}
settings[1].clm__Action__c = 'New';
settings[1].clm__Fields__c = 'CTPHARMA__AccountId__c,CTPHARMA__ContactId__c,CTPHARMA__StartDate__c';
settings[1].clm__RecordtypeDeveloperName__c = 'Visit_KAM';
settings[1].clm__RequiredAttribute__c = 'true,true,true';
settings[1].clm__SObject__c = 'CTPHARMA__Activity__c';
settings[1].Name = 'New Visit: KAM';

upsert settings;