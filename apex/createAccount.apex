List<Account> accounts = [SELECT Name, AccountNumber, Site, AccountSource, PHARMA_Account_Status__c, PHARMA_Annual_admissions__c, AnnualRevenue, PHARMA_Beds__c, BillingStreet, BillingState, BillingPostalCode, BillingLongitude, BillingLatitude, BillingGeocodeAccuracy, BillingCountry, BillingCity, PHARMA_Call_Frequency__c, PHARMA_Customer_Account__c, PHARMA_CY_Actual__c, PHARMA_CY_Plan__c, PHARMA_CY_SR_Forecast__c, Jigsaw, Description, CTPHARMA__DivisionAlphaCategory__c, CTPHARMA__DivisionAlphaTargetCheck__c, CTPHARMA__DivisionBetaCategory__c, CTPHARMA__DivisionBetaTargetCheck__c, NumberOfEmployees, PHARMA_Facility_Speciality__c, Fax, PHARMA_Geolocation__c, CTPHARMA__HasChildAccounts__c, PHARMA_Identified_for_My_Targets__c, Industry, CTPHARMA__IsAutoTargetCheck__c, PHARMA_Occupancy_Rate__c, PHARMA_Open_Optt_Value__c, Ownership, PHARMA_Phisicians__c, Phone, PHARMA_Projected_Sales_This_Year__c, PHARMA_Projected_Units_this_Year__c, Rating, PHARMA_Region__c, PHARMA_Sales_to_Projected__c, PHARMA_Sales_LTD__c, PHARMA_Sales_Order_Trend__c, Sic, SicDesc, CTPHARMA__TargetUserIds__c, TickerSymbol, Type, PHARMA_Units_to_Projected__c, PHARMA_Units_YTD__c, Website, PHARMA_Y_1_Actual__c, PHARMA_Y_1_Plan__c FROM Account WHERE Name = '*United Facility Network'];

Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Hospital').getRecordTypeId();
Account account = accounts[0];

account.Name = '*United Facility Network';
account.RecordTypeId = recordTypeId;
account.Site = 'San Francisco';
account.PHARMA_Account_Status__c = 'Growth';
account.PHARMA_Annual_admissions__c = 25000;
account.AnnualRevenue = 200000000;
account.PHARMA_Beds__c = 500;
account.BillingStreet = '1 Market St';
account.BillingState = 'CA';
account.BillingPostalCode = '94104';
account.BillingCountry = 'United States';
account.BillingCity = 'San Francisco';
account.PHARMA_Call_Frequency__c = 'Weekly';
account.PHARMA_Customer_Account__c = 200000002;
account.PHARMA_CY_Actual__c = 60000;
account.PHARMA_CY_Plan__c = 100000;
account.CTPHARMA__DivisionAlphaCategory__c = 'Category A';
account.CTPHARMA__DivisionAlphaTargetCheck__c = true;
account.CTPHARMA__DivisionBetaCategory__c = 'Category B';
account.CTPHARMA__DivisionBetaTargetCheck__c = false;
account.NumberOfEmployees = 2100;
account.PHARMA_Facility_Speciality__c = 'Urology';
account.CTPHARMA__HasChildAccounts__c = false;
account.PHARMA_Identified_for_My_Targets__c = true;
account.Industry = 'Healthcare';
account.CTPHARMA__IsAutoTargetCheck__c = false;
account.PHARMA_Occupancy_Rate__c = 68;
account.PHARMA_Open_Optt_Value__c = 270124;
account.PHARMA_Phisicians__c = 110;
account.Phone = '(800) 667-6389';
account.PHARMA_Projected_Sales_This_Year__c = 500000;
account.PHARMA_Projected_Units_this_Year__c = 400;
account.PHARMA_Region__c = 'Central';
account.PHARMA_Sales_to_Projected__c = 64;
account.PHARMA_Sales_LTD__c = 317984;
account.PHARMA_Sales_Order_Trend__c = 'Decrease';
account.CTPHARMA__TargetUserIds__c = 'GVABl';
account.Type = 'national chains';
account.PHARMA_Units_to_Projected__c = 78;
account.PHARMA_Units_YTD__c = 310;
account.Website = 'www.united.org';
account.PHARMA_Geolocation__Latitude__s = 37.791013;
account.PHARMA_Geolocation__Longitude__s = -122.400219;

Account account2 = new Account();


account2.Name = '*United Medical West';
account2.PHARMA_Geolocation__Latitude__s = 37.764271;
account2.PHARMA_Geolocation__Longitude__s = -122.427066;


update account;
insert account2;