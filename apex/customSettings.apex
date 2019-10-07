clm__TopLvlObjects__c newTop = clm__TopLvlObjects__c.getOrgDefaults();
newTop.clm__ConflictManagerAttribute__c = 'false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false';
newTop.clm__GroupFields__c = 'null,null,null,null,null,null,null,null,null,null,null,null';
newTop.clm__MenuSettings__c = 'Home,Chatter,RecentItems,Account,CTPHARMA__Activity__c,CTPHARMA__Product__c,Calendar,Routes,NearbyAccounts,Applications,Dashboards,Settings';
newTop.clm__TopLvlObjects__c = 'Account,Contact,CTPHARMA__Activity__c,CTPHARMA__ActivityData__c,CTPHARMA__Product__c,CTPHARMA__Reference__c,SampleDrop__c,License__c,LicenseType__c,ProductLicense__c,Store__c,StoreProduct__c,UserAppMenuItem,Lot__c,Address__c,CORE_AssortmentLineItem__c';
newTop.clm__OnlineAttribute__c = 'false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false';
newTop.clm__SortOrder__c = ',,,,,,,,,,,,,,,';
upsert newTop;

clm__ApplicationSetup__c newApp = clm__ApplicationSetup__c.getOrgDefaults();
newApp.clm__AccountFullAddressAPIField__c = 'BillingAddress';
newApp.clm__AccountGeolocationAPIField__c = 'PHARMA_Geolocation__c';
newApp.clm__ActivityDoneAPI__c = 'CTPHARMA__IsDone__c';
newApp.clm__ActivityIsLockedAPI__c = 'CTPHARMA__IsLocked__c';
newApp.clm__ActivityDescriptionAPI__c = 'CTPHARMA__Description__c';
newApp.clm__ActivityEndDateAPI__c = 'CTPHARMA__EndDate__c';
newApp.clm__ActivityGeolocationAPIField__c = 'Geolocation__c';
newApp.clm__ActivityFieldAPI__c = 'ActivityId__c';
newApp.clm__ActivityObjectAPIName__c = 'CTPHARMA__Activity__c';
newApp.clm__ActivityDateAPI__c = 'CTPHARMA__StartDate__c';
newApp.clm__ActivityStatusAPI__c = 'CTPHARMA__Status__c';
newApp.clm__AllowWebSharing__c = true;
newApp.clm__AppInstallURL__c = 'https://www.ctclm.com/apps/sample/';
newApp.clm__CalendarView__c = 'week';
newApp.clm__CaptureGeoposition__c = true;
newApp.clm__CloudToken__c = '70cca723acce85187321b78f662c021872aa1540546311b6d6';
newApp.clm__DebugLevel__c = 'Error';
newApp.clm__DefaultEventDuration__c = 60;
newApp.clm__GeoTraceInterval__c = 0;
newApp.clm__GoogleMapsAndroidAPIKey__c = null;
newApp.clm__GoogleMapsAPIKey__c = 'AIzaSyC2WS7Ll5W2SRHjfVOYr9kAj3XJ2Fvf6Ns';
newApp.clm__GoogleMapsJSKey__c = 'AIzaSyAJIfOBNIG8DuGTJ6apUcg21Awz0ylSKIY';
newApp.clm__EnableLockUnlock__c = false;
newApp.clm__MetadataLastModifiedDate__c = System.now();
newApp.clm__IsPasscodeEnabled__c = true;
newApp.clm__IsPersonAccountsEnabled__c = false;
newApp.clm__ProductFieldAPI__c = 'CTPHARMA__Product__c';
newApp.clm__ProductObjectAPIName__c = 'CTPHARMA__Product__c';
newApp.clm__PUSHHUBName__c = 'appstore.ctmobile';
newApp.clm__ReferenceObjectAPIName__c = 'CTPHARMA__Reference__c';
newApp.clm__IsWeekSwitchShowed__c = true;
newApp.clm__EnableStartFinish__c = true;
newApp.clm__Theme__c = 'rgb(108, 94, 145)';
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

newSettings = [SELECT Name FROM clm__MobileLayoutSettings__c WHERE Name = 'New Audit'];
if(newSettings.size() == 0){
	settings.add(new clm__MobileLayoutSettings__c());
}else{
	settings.add(newSettings[0]);
}
settings[2].clm__Action__c = 'New';
settings[2].clm__Fields__c = 'CTPHARMA__AccountId__c,CTPHARMA__StartDate__c,CTPHARMA__EndDate__';
settings[2].clm__RecordtypeDeveloperName__c = 'DemoAudit';
settings[2].clm__RequiredAttribute__c = 'true,true,true';
settings[2].clm__SObject__c = 'CTPHARMA__Activity__c';
settings[2].Name = 'New Audit';

upsert settings;

List<clm__MobileActivityDataCustomization__c> activityCustomizations = new List<clm__MobileActivityDataCustomization__c>();
List<clm__MobileActivityDataCustomization__c> newActivityCustomizations = [SELECT Name, clm__CustomFieldsLayout__c, clm__DataObjectName__c, clm__IsDrilldownEnabled__c, clm__IsRecordAdditionAllowed__c, clm__IsRecordDeleteAllowed__c, clm__IsRelatedListLayout__c, clm__LookupFieldAPI__c, clm__OrgProfileId__c, clm__ParentObject__c, clm__ParentObjectRecordType__c, clm__ReadonlyAttribute__c, clm__RequiredAttribute__c, clm__isApplicationLaunchEnabled__c, clm__TabLabel__c FROM clm__MobileActivityDataCustomization__c WHERE Name = 'Add Samples'];
if(newActivityCustomizations.size() == 0){
    activityCustomizations.add(new clm__MobileActivityDataCustomization__c());
} else{
    activityCustomizations.add(newActivityCustomizations[0]);
}
activityCustomizations[0].Name = 'Add Samples';
activityCustomizations[0].clm__CustomFieldsLayout__c = 'PharmaProductId__c,StoreProductId__c,Quantity__c';
activityCustomizations[0].clm__DataObjectName__c = 'SampleDrop__c';
activityCustomizations[0].clm__IsDrilldownEnabled__c = true;
activityCustomizations[0].clm__IsRecordAdditionAllowed__c = true;
activityCustomizations[0].clm__IsRecordDeleteAllowed__c = true;
activityCustomizations[0].clm__IsRelatedListLayout__c = false;
activityCustomizations[0].clm__LookupFieldAPI__c = 'ActivityId__c';
activityCustomizations[0].clm__OrgProfileId__c = UserInfo.getOrganizationId();
activityCustomizations[0].clm__ParentObject__c = 'CTPHARMA__Activity__c';
activityCustomizations[0].clm__ParentObjectRecordType__c = 'Visit';
activityCustomizations[0].clm__ReadonlyAttribute__c = 'false,false,false';
activityCustomizations[0].clm__RequiredAttribute__c = 'false,false,false';
activityCustomizations[0].clm__isApplicationLaunchEnabled__c = false;
activityCustomizations[0].clm__TabLabel__c = 'Add Samples';

newActivityCustomizations = [SELECT Name, clm__CustomFieldsLayout__c, clm__DataObjectName__c, clm__IsDrilldownEnabled__c, clm__IsRecordAdditionAllowed__c, clm__IsRecordDeleteAllowed__c, clm__IsRelatedListLayout__c, clm__LookupFieldAPI__c, clm__OrgProfileId__c, clm__ParentObject__c, clm__ParentObjectRecordType__c, clm__ReadonlyAttribute__c, clm__RequiredAttribute__c, clm__isApplicationLaunchEnabled__c, clm__TabLabel__c FROM clm__MobileActivityDataCustomization__c WHERE Name = 'Visit KAM: inventory_med device'];
if(newActivityCustomizations.size() == 0){
    activityCustomizations.add(new clm__MobileActivityDataCustomization__c());
} else{
    activityCustomizations.add(newActivityCustomizations[0]);
}
activityCustomizations[1].Name = 'Visit KAM: inventory_med device';
activityCustomizations[1].clm__CustomFieldsLayout__c = 'CTPHARMA__ProductId__c,Assessment__c,Diagnostic__c,Repair__c,After_sales_service__c';
activityCustomizations[1].clm__DataObjectName__c = 'CTPHARMA__ActivityData__c';
activityCustomizations[1].clm__DataRecordType__c = 'inventory';
activityCustomizations[1].clm__IsDrilldownEnabled__c = false;
activityCustomizations[1].clm__IsRecordAdditionAllowed__c = true;
activityCustomizations[1].clm__IsRecordDeleteAllowed__c = true;
activityCustomizations[1].clm__IsRelatedListLayout__c = false;
activityCustomizations[1].clm__LookupFieldAPI__c = 'CTPHARMA__ActivityId__c';
activityCustomizations[1].clm__OrgProfileId__c = UserInfo.getOrganizationId();
activityCustomizations[1].clm__ParentObject__c = 'CTPHARMA__Activity__c';
activityCustomizations[1].clm__ParentObjectRecordType__c = 'Visit_KAM';
activityCustomizations[1].clm__ReadonlyAttribute__c = 'false,false,false,false,false';
activityCustomizations[1].clm__RequiredAttribute__c = 'false,false,false,false,false';
activityCustomizations[1].clm__isApplicationLaunchEnabled__c = false;
activityCustomizations[1].clm__TabLabel__c = 'Inventories';

newActivityCustomizations = [SELECT Name, clm__CustomFieldsLayout__c, clm__DataObjectName__c, clm__IsDrilldownEnabled__c, clm__IsRecordAdditionAllowed__c, clm__IsRecordDeleteAllowed__c, clm__IsRelatedListLayout__c, clm__LookupFieldAPI__c, clm__OrgProfileId__c, clm__ParentObject__c, clm__ParentObjectRecordType__c, clm__ReadonlyAttribute__c, clm__RequiredAttribute__c, clm__isApplicationLaunchEnabled__c, clm__TabLabel__c FROM clm__MobileActivityDataCustomization__c WHERE Name = 'Visit KAM: new models_med devices'];
if(newActivityCustomizations.size() == 0){
    activityCustomizations.add(new clm__MobileActivityDataCustomization__c());
} else{
    activityCustomizations.add(newActivityCustomizations[0]);
}
activityCustomizations[2].Name = 'Visit KAM: new models_med devices';
activityCustomizations[2].clm__CustomFieldsLayout__c = 'CTPHARMA__ProductId__c,Number_of_new_models__c';
activityCustomizations[2].clm__DataObjectName__c = 'CTPHARMA__ActivityData__c';
activityCustomizations[2].clm__DataRecordType__c = 'new_models';
activityCustomizations[2].clm__IsDrilldownEnabled__c = false;
activityCustomizations[2].clm__IsRecordAdditionAllowed__c = true;
activityCustomizations[2].clm__IsRecordDeleteAllowed__c = true;
activityCustomizations[2].clm__IsRelatedListLayout__c = false;
activityCustomizations[2].clm__LookupFieldAPI__c = 'CTPHARMA__ActivityId__c';
activityCustomizations[2].clm__OrgProfileId__c = UserInfo.getOrganizationId();
activityCustomizations[2].clm__ParentObject__c = 'CTPHARMA__Activity__c';
activityCustomizations[2].clm__ParentObjectRecordType__c = 'Visit_KAM';
activityCustomizations[2].clm__ReadonlyAttribute__c = 'false,false';
activityCustomizations[2].clm__RequiredAttribute__c = 'false,false';
activityCustomizations[2].clm__isApplicationLaunchEnabled__c = false;
activityCustomizations[2].clm__TabLabel__c = 'New Models';

newActivityCustomizations = [SELECT Name, clm__CustomFieldsLayout__c, clm__DataObjectName__c, clm__IsDrilldownEnabled__c, clm__IsRecordAdditionAllowed__c, clm__IsRecordDeleteAllowed__c, clm__IsRelatedListLayout__c, clm__LookupFieldAPI__c, clm__OrgProfileId__c, clm__ParentObject__c, clm__ParentObjectRecordType__c, clm__ReadonlyAttribute__c, clm__RequiredAttribute__c, clm__isApplicationLaunchEnabled__c, clm__TabLabel__c FROM clm__MobileActivityDataCustomization__c WHERE Name = 'Visit KAM: order supplies'];
if(newActivityCustomizations.size() == 0){
    activityCustomizations.add(new clm__MobileActivityDataCustomization__c());
} else{
    activityCustomizations.add(newActivityCustomizations[0]);
}
activityCustomizations[3].Name = 'Visit KAM: order supplies';
activityCustomizations[3].clm__CustomFieldsLayout__c = 'CTPHARMA__ProductId__c,number_of_terminals__c';
activityCustomizations[3].clm__DataObjectName__c = 'CTPHARMA__ActivityData__c';
activityCustomizations[3].clm__DataRecordType__c = 'order_supplies';
activityCustomizations[3].clm__IsDrilldownEnabled__c = false;
activityCustomizations[3].clm__IsRecordAdditionAllowed__c = true;
activityCustomizations[3].clm__IsRecordDeleteAllowed__c = true;
activityCustomizations[3].clm__IsRelatedListLayout__c = false;
activityCustomizations[3].clm__LookupFieldAPI__c = 'CTPHARMA__ActivityId__c';
activityCustomizations[3].clm__OrgProfileId__c = UserInfo.getOrganizationId();
activityCustomizations[3].clm__ParentObject__c = 'CTPHARMA__Activity__c';
activityCustomizations[3].clm__ParentObjectRecordType__c = 'Visit_KAM';
activityCustomizations[3].clm__ReadonlyAttribute__c = 'false,false';
activityCustomizations[3].clm__RequiredAttribute__c = 'false,false';
activityCustomizations[3].clm__isApplicationLaunchEnabled__c = false;
activityCustomizations[3].clm__TabLabel__c = 'Consumables';

upsert activityCustomizations;

List<clm__MobileCustomization__c> mobileCustomizations = new List<clm__MobileCustomization__c>();
List<clm__MobileCustomization__c> newMobileCustomizations = [SELECT Name, clm__Colors__c, clm__CriteriaField__c, clm__Object__c, clm__OrgProfileId__c, clm__Values__c FROM clm__MobileCustomization__c WHERE Name = 'Influence__c'];

if(newMobileCustomizations.size() == 0){
    mobileCustomizations.add(new clm__MobileCustomization__c());
} else{
    mobileCustomizations.add(newMobileCustomizations[0]);
}
mobileCustomizations[0].Name = 'Influence__c';
mobileCustomizations[0].clm__Colors__c = 'rgb(35,219,131);rgb(222,18,79);rgb(29,63,240);rgb(232,224,30)';
mobileCustomizations[0].clm__CriteriaField__c = 'Type__c';
mobileCustomizations[0].clm__Object__c = 'Influence__c';
mobileCustomizations[0].clm__Values__c = 'Owns,Supply,Research,KOL influence';

newMobileCustomizations = [SELECT Name, clm__Colors__c, clm__CriteriaField__c, clm__Object__c, clm__OrgProfileId__c, clm__Values__c FROM clm__MobileCustomization__c WHERE Name = 'CTPHARMA__Activity__c'];

if(newMobileCustomizations.size() == 0){
    mobileCustomizations.add(new clm__MobileCustomization__c());
} else{
    mobileCustomizations.add(newMobileCustomizations[0]);
}
mobileCustomizations[1].Name = 'CTPHARMA__Activity__c';
mobileCustomizations[1].clm__Colors__c = 'rgb(230,230,230);rgb(245,250,0);rgb(0,255,10);rgb(255,0,0)';
mobileCustomizations[1].clm__CriteriaField__c = 'CTPHARMA__Status__c';
mobileCustomizations[1].clm__Object__c = 'CTPHARMA__Activity__c';
mobileCustomizations[1].clm__Values__c = 'Planned,In Progress,Finished,Canceled';

upsert mobileCustomizations;