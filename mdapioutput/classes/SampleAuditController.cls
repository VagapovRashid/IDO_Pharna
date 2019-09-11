public class SampleAuditController {

    public String BY_ALL { get; set; }
    public String BY_PUBLIC_GROUP { get; set; }
    public String BY_ROLE { get; set; }
    public String BY_ROLE_SUBROLE { get; set; }
    public String USER_MODE { get; set; }
    public String CSS_EXIST { get; set; }
    public String SEARCH_OBJECT_MODE { get; set; }
    public String SEARCH_CONTACT_MODE { get; set; }

    public CustomIterable tableSet { get; set; }
    public CustomIterable tableSetC { get; set; }

    public Contact con { get; set; }
    public String contactId { get; set; }
    public List<Schema.FieldSetMember> fields;

    public Date startDate { get; set; }
    public Date endDate { get; set; }
    public String status { get; set; }

    public String filterType { get; set; }
    public Date transferDate { get; set; }
    public Transfer__c transferTemplate { get; set;}

    public User[] users;
    public userWrapper relations { get; set; }
    public String search_string { get; set; }
    public String search_con_string { get; set; }
    public String search_selected { get; set; }
    public String FilterId { get; set; }
    public String FilterContactId { get; set; }

    public Map<String, String> soapResult = new Map<String, String>();
    public static Map<String, List<String>> lwFieldSet = new Map<String, List<String>>();
    public List<userWrapper> relatedUsers { get; set; }

    public String selectedGroup { get; set; }
    public String selectedRole { get; set; }
    public String selectedRoleSubrole { get; set; }
    public String selectedListView { get; set; }

    public List<String> fieldsToShow { get; set; }
    public List<String> fieldsContactToShow { get; set; }

    private List<SelectOption> searchOptions;
    private List<SelectOption> groups;
    private List<SelectOption> roles;
    private List<SelectOption> userListViewOptions;


    public List<userWrapper> wrappedUsers { get; set; }
    public List<userWrapper> wrappedContacts { get; set; }
    public List<userWrapper> showedWrappedUsers { get; set; }
    public List<userWrapper> showedWrappedContacts { get; set; }
    public Contact template { get; set; }
    public CTPHARMA__Activity__c acttemplate { get; set; }
    public List<CTPHARMA__Activity__c> visits { get; set; }
    public List<wrapper> atts { get; set; }
    public Map<Id, CTPHARMA__Activity__c> mapp { get; set; }
    public Map<Id, Transfer__c> transferMap { get; set; }
    public Map<Id, User> userMap { get; set; }
    public Map<String, User> usermapp { get; set; }
    public Map<String, Contact> contactmapp { get; set; }

    public String signature = 'Sample Drops';

    public Map<String, String> colors { get; set; }

    public List<Schema.FieldSetMember> getFields() {
        return fields;
    }
    public List<SelectOption> searchObjectOptions;

    public List<SelectOption> getSearchObjectOptions() {
        if (null == searchObjectOptions) {
            searchObjectOptions = new List<SelectOption>();
            searchObjectOptions.add(new SelectOption('USER', 'By Users'));
            searchObjectOptions.add(new SelectOption('CONTACT', 'By Contacts'));
        }

        return searchObjectOptions;
    }



    public List<SelectOption> getSearchOptions() {

        if (null == searchOptions) {
            searchOptions = new List<SelectOption>();
            searchOptions.add(new SelectOption(BY_ALL, 'All'));
            if (getGroups().size() > 0) {
                searchOptions.add(new SelectOption(BY_PUBLIC_GROUP, 'By Public Groups'));
            }
            searchOptions.add(new SelectOption(BY_ROLE, 'By Roles'));
            searchOptions.add(new SelectOption(BY_ROLE_SUBROLE, 'By Roles And Subroles'));
            searchOptions.add(new SelectOption(USER_MODE, 'By ListViews'));
            //searchOptions.addAll(listViewUser);
        }

        return searchOptions;
    }


    public List<SelectOption> getGroups() {

        if (null == groups) {
            groups = new List<SelectOption>();
            Group[] gr = [SELECT Id, Name FROM Group LIMIT 9999];
            for (Group g : gr) {
                if (g.Id != null && g.Name != null) {
                    groups.add(new SelectOption(g.Id, g.Name));
                }
            }
        }

        return groups;
    }


    public List<SelectOption> getRoles() {

        if (null == roles) {
            roles = new List<SelectOption>();
            UserRole[] ur = [SELECT Id,Name,ParentRoleId FROM UserRole LIMIT 9999];
            for (UserRole r : ur) {
                if (r.Id != null && r.Name != null) {
                    roles.add(new SelectOption(r.Id, r.Name));
                }
            }
        }

        return roles;
    }


    public List<SelectOption> searchContactOptions;

    public List<SelectOption> getSearchContactOptions() {
        if (null == searchContactOptions) {
            searchContactOptions = new List<SelectOption>();
            searchContactOptions.add(new SelectOption('ALL', 'All'));
            searchContactOptions.add(new SelectOption('BYLISTVIEW', 'By List View'));
        }

        return searchContactOptions;
    }


    public void initConstants() {
        BY_PUBLIC_GROUP = 'PUBLIC_GROUP';
        BY_ROLE = 'BY_ROLE';
        BY_ROLE_SUBROLE = 'BY_ROLE_SUBROLE';
        USER_MODE = 'LISTVIEWS';
        CSS_EXIST = 'exist';
        SEARCH_OBJECT_MODE = 'USER';
        SEARCH_CONTACT_MODE = 'ALL';
        //CSS_EXIST = 'exist';
        BY_ALL = 'BY_ALL';
    }

    public void confirm() {
        updateChecked('Confirmed');
    }

    public void decline() {
        updateChecked('Declined');
    }

    public void review() {
        updateChecked('In Review');
    }

    public void updateParent(List<CTPHARMA__Activity__c> activities){
//        if()
    }

    public void updateChecked(String auditResult) {
        List<Boolean> checkList = new List<Boolean>();
        for (wrapper item : atts) {
            if (item.checked) {
                checkList.add(true);
            } else {
                checkList.add(false);
            }
        }
        if(auditResult == 'Confirmed' || auditResult == 'Declined'){
            startInReview();
        }else {
            start();
        }
        if(filterType == 'Activity') {
            Set<CTPHARMA__Activity__c> toUpdate = new Set<CTPHARMA__Activity__c>();

            for (Integer i = 0; i < atts.size(); i++) {
                if (checkList[i]) {
                    toUpdate.add(mapp.get(atts[i].att.ParentId));
                }
            }
            if (toUpdate.size() > 0) {
                List<Id> activityIds = new List<Id>();
                for (CTPHARMA__Activity__c act : toUpdate) {
                    act.Audit__c = auditResult;
                    activityIds.add(act.Id);
                }
                List<SampleDrop__c> sampleDrops = [SELECT Id, Name, SignatureConfirmation__c FROM SampleDrop__c WHERE ActivityId__c IN :activityIds];
                for(SampleDrop__c sampleDrop : sampleDrops){
                    sampleDrop.SignatureConfirmation__c = auditResult;
                }
                update sampleDrops;
                update new List<CTPHARMA__Activity__c>(toUpdate);
            }
        }else{
            Set<Transfer__c> toUpdate = new Set<Transfer__c>();
            for (Integer i = 0; i < atts.size(); i++) {
                if (checkList[i]) {
                    toUpdate.add(transferMap.get(atts[i].att.ParentId));
                }
            }
            if (toUpdate.size() > 0) {
                for (Transfer__c transfer : toUpdate) {
                    transfer.SignatureConfirmation__c = auditResult;
                }

                update new List<Transfer__c>(toUpdate);
            }
        }

//        for(wrapper item: atts){
//            if (item.checked) toUpdate.add(mapp.get(item.att.ParentId));
//        }





        if(auditResult == 'Confirmed' || auditResult == 'Declined'){
            startInReview();
        }else {
            start();
        }
    }

    //получаем роли и подроли 
    public static Set<Id> getAllSubRoleIds(Set<Id> roleIds) {

        Set<Id> currentRoleIds = new Set<Id>();

        for (UserRole userRole : [
                SELECT Id
                FROM UserRole
                WHERE ParentRoleId
                        IN :roleIds AND ParentRoleId != NULL
        ]) {
            currentRoleIds.add(userRole.Id);
        }

        if (currentRoleIds.size() > 0) {
            currentRoleIds.addAll(getAllSubRoleIds(currentRoleIds));
        }

        return currentRoleIds;
    }


    public static Set<Id> getParentRoleId(Set<Id> roleIds) {

        Set<Id> currentRoleIds = new Set<Id>();

        for (UserRole ur : [SELECT Id, ParentRoleId FROM UserRole WHERE Id IN:roleIds]) {
            currentRoleIds.add(ur.ParentRoleId);
        }

        if (currentRoleIds.size() > 0) {
            currentRoleIds.addAll(getParentRoleId(currentRoleIds));
        }

        return currentRoleIds;
    }

    public void initContacts() {
        wrappedContacts = new List<userwrapper>();
        showedwrappedContacts = new List<userwrapper>();

        Contact[] tmpContacts;

        String conditions = ' id != null ';

        if(ApexPages.currentPage().getParameters().get('contact_id') != null){
            System.debug(ApexPages.currentPage().getParameters().get('contact_id'));
            conditions = ' id = \'' + ApexPages.currentPage().getParameters().get('contact_id') + '\'';
            search_selected = BY_ALL;
        }

        if (search_con_string != null && search_con_string != '') {
            conditions += ' and Name LIKE \'%' + String.escapeSingleQuotes(search_con_string) + '%\' ';
        }

        System.debug('search_con_string: ' + search_con_string);

        fieldsToShow = new List<String>{
                'Name'
        };

        if (search_selected == BY_ALL) {
            conditions += ' limit 9999';
            tmpContacts = makeQuery('Contact', null, conditions, true);
        } else if (search_selected == USER_MODE) {
            tmpContacts = (List<Contact>) Database.query(getQueryContacts());
        }

        System.debug('tmpContacts');
        System.debug(tmpContacts);

        if (tmpContacts != null && !tmpContacts.isEmpty()) {
            rebuildWrapper(tmpContacts);
        }

    }


    public void rebuildWrapper(Contact[] tmpContacts) {
        //создаём новый список с пользователями
        wrappedContacts = new List<userwrapper>();
        for (Contact c : tmpContacts) {
            wrappedContacts.add(new userwrapper(c));
        }
        tableSetC = new CustomIterable(wrappedContacts);
        tableSetC.setPageSize = 10;
        nextc();
    }

    public Boolean hasNextc {
        get {
            return tableSetC.hasNext();
        }
        set;
    }

    public Boolean hasPreviousc {
        get {
            return tableSetC.hasPrevious();
        }
        set;
    }

    public void nextc() {
        showedwrappedContacts = tableSetC.next();
    }

    public void previousc() {
        showedwrappedContacts = tableSetC.previous();
    }

    public void initUsers() {
        wrappedUsers = new List<userwrapper>();
        showedWrappedUsers = new List<userwrapper>();
        showedwrappedContacts = new List<userwrapper>();


        User[] tmpUsers;

        String conditions = ' isActive = true ';

        if(ApexPages.currentPage().getParameters().get('user_id') != null){
            conditions += ' id = \'' + ApexPages.currentPage().getParameters().get('user_id') + '\'';
            search_selected = BY_ALL;
        }

        if (search_string != null && search_string != '') {
            conditions += ' and Name LIKE \'%' + String.escapeSingleQuotes(search_string) + '%\' ';
        }

        System.debug('search_string: ' + search_string);

        fieldsToShow = new List<String>{
                'Name'
        };

        if (search_selected == BY_ALL) {
            conditions += ' limit 9999';
            tmpUsers = makeQuery('User', null, conditions, true);
        } else if (search_selected == BY_PUBLIC_GROUP) {
            //fieldsToShow = new Set<String>{};
            if (selectedGroup != null && selectedGroup != '') {
                selectedGroup = String.escapeSingleQuotes(selectedGroup);
                conditions += ' and id in ( select userorGroupId from groupMember ' ;
                conditions += 'where GroupId = \'' + String.escapeSingleQuotes(selectedGroup) + '\') ';
                tmpUsers = makeQuery('User', null, conditions, true);
            }
        } else if (search_selected == BY_ROLE) {
            if (selectedRole != null && selectedRole != '') {
                conditions += ' and UserRoleId = \'' + String.escapeSingleQuotes(selectedRole) + '\'';
                tmpUsers = makeQuery('User', null, conditions, true);
            }
        } else if (search_selected == BY_ROLE_SUBROLE) {
            if (selectedRoleSubrole != null && selectedRoleSubrole != '') {
                selectedRoleSubrole = String.escapeSingleQuotes(selectedRoleSubrole) ;
                fieldsToShow.add('UserRole.Name');
                Id roleId = Id.valueOf(selectedRoleSubrole);
                Set<Id> tmpSet = new Set<Id>();
                tmpSet.add(roleId);
                Set<Id> subroles = getAllSubRoleIds(tmpSet);
                subroles.add(selectedRoleSubrole);
                List<String> toQuery = new List<String>();
                if (subroles != null) {
                    for (Id sub : subroles) {
                        toQuery.add(sub);
                    }
                }
                String queryList = listToString(toQuery);

                if (queryList != null && queryList != '') {
                    conditions += ' and UserRoleId ' + queryList + '';
                } else {
                    conditions += ' and UserRoleId = \'' + String.escapeSingleQuotes(selectedRoleSubrole) + '\'';
                }
                tmpUsers = makeQuery('User', 'UserRole.Name', conditions, true);
            }
        } else if (search_selected == USER_MODE) {
            tmpUsers = (List<User>) Database.query(getQueryUsers());
            //tmpUsers = 
        }

        if (tmpUsers != null && !tmpUsers.isEmpty()) {
            rebuildWrapper(tmpUsers);
        }

    }

    public void rebuildWrapper(User[] tmpUsers) {
        //создаём новый список с пользователями
        wrappedUsers = new List<userwrapper>();
        for (User u : tmpUsers) {
            wrappedUsers.add(new userwrapper(u));
        }
        tableSet = new CustomIterable(wrappedUsers);
        tableSet.setPageSize = 10;
        next();
    }
    public Boolean hasNext {
        get {
            return tableSet.hasNext();
        }
        set;
    }

    public Boolean hasPrevious {
        get {
            return tableSet.hasPrevious();
        }
        set;
    }

    public void next() {
        showedWrappedUsers = tableSet.next();
    }

    public void previous() {
        showedWrappedUsers = tableSet.previous();
    }


    public void initTemps() {
        wrappedUsers = new List<userwrapper>();
        showedWrappedUsers = new List<userwrapper>();
        wrappedContacts = new List<userwrapper>();
        showedwrappedContacts = new List<userwrapper>();
        relatedUsers = new List<userwrapper>();
        listViewIdListFromPage = new List<String>();
        contactlistViewIdListFromPage = new List<String>();
    }
    public static String listToString(List<String> x) {
        if (x == null) return '';
        String s = '';
        Integer s1 = x.size();
        System.debug('>>>> S1: ' + s1);
        if (s1 == 0) return s;
        Integer i = 1;
        if (x[0] != null) {
            s = '\'' + String.escapeSingleQuotes(x[0]) + '\'';
        } else {
            s = '\'\'';
        }
        while (i < s1) {
            if (x[i] != null) {
                s += ',' + '\'' + String.escapeSingleQuotes(x[i]) + '\'';
            }
            i++;
        }
        if (s1 > 1) {
            return ' in (' + s + ')';
        }
        return '= ' + s;
    }

    public static String getSoqlDate(Date dt) {
        Integer d = dt.day();
        Integer mo = dt.month();
        Integer yr = dt.year();
        return Datetime.newInstance(yr, mo, d).format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
    }



    public ctpharma__Activity__c[] getVisits(){
        return getVisits(false);
    }

    public ctpharma__Activity__c[] getVisits(Boolean onlyChecked) {
        List<ctpharma__Activity__c> results = new List<ctpharma__Activity__c> ();
//        if (acttemplate.CTPHARMA__Status__c != null && acttemplate.RecordTypeId != null) {
        if (acttemplate.RecordTypeId != null) {
            String conditions = ' ctpharma__startdate__c >= ' + getSoqlDate(startDate);
            conditions += ' and ctpharma__enddate__c <=' + getSoqlDate(endDate);
//            conditions += ' and ctpharma__status__c = \'' + acttemplate.CTPHARMA__Status__c + '\' ';
            conditions += ' and RecordTypeId = \'' + acttemplate.RecordTypeId + '\'';
            if(onlyChecked){
                conditions += ' and Audit__c = \'In Review\'';
            }

            //фильтр по юзерам
            if (wrappedUsers.size() > 0) {
                for (userwrapper u : wrappedUsers) {
                    if (u.selected) {
                        usermapp.put(u.user.Id, u.user);
                    }
                }
                Set<String> userIds = usermapp.keySet();

                String queryList = listToString(new List<String>(userIds));

                if (queryList != null && queryList != '') {
                    conditions += ' and OwnerId ' + queryList + '';
                }
            } else if (wrappedContacts.size() > 0) {
                for (userwrapper u : wrappedContacts) {
                    if (u.selected) {
                        contactmapp.put(u.contact.Id, u.contact);
                    }
                }
                Set<String> conIds = contactmapp.keySet();

                String queryList = listToString(new List<String>(conIds));

                if (queryList != null && queryList != '') {
                    conditions += ' and CTPHARMA__ContactId__c ' + queryList + '';
                }
            }

            results = makeQuery('ctpharma__activity__c', null, conditions, true) ;
        }

        return results;

        /*return  [select id,Name,   CTPHARMA__Status__c, RecordTypeId, RecordType.DeveloperName, audit__c, OwnerId,
        ctpharma__startDate__c, ctpharma__enddate__c, Owner.Name from ctpharma__activity__c
                            where ctpharma__startDate__c >: startDate 
                            and ctpharma__enddate__c <: endDate 
                            and CTPHARMA__Status__c =: acttemplate.CTPHARMA__Status__c
                            and RecordTypeId =: acttemplate.RecordTypeId] ; */
    }

    private void  updateMap(){
        mapp = new Map<Id, ctpharma__Activity__c>(visits);
    }

    private void updateContactMap(){
        Set<String> ids = new Set<String>();
        for (ctpharma__Activity__c visit : visits) {
            if (visit.CTPHARMA__ContactId__c != null){
                ids.add(visit.CTPHARMA__ContactId__c);
            }
        }
        if (!ids.isEmpty()) {
            contactmapp = new Map<String, Contact>([SELECT Id, Name FROM Contact WHERE Id IN :ids]);
        }
    }

    private void updateVisits(){
        visits = getVisits();
    }

    private void updateAttachments(){
        updateAttachments(false);
    }

    private void updateAttachments(Boolean onlyChecked){
        Set<String> ids = new Set<String>();
        atts = new List<wrapper>();
        System.debug('Signature is');
        System.debug(signature);
        System.debug('Filter Type is');
        System.debug(filterType);

        if((signature == 'Sample Drop' || signature == 'Sample Delivery') && filterType == 'Activity'){
            System.debug('You are still here... Sorry');
            for (ctpharma__Activity__c visit : visits) {
                ids.add(visit.Id);
            }
            Id recordTypeId = Schema.SObjectType.SampleDrop__c.getRecordTypeInfosByName().get(signature).getRecordTypeId();
            List<SampleDrop__c> sampleDrops = [SELECT Id, ActivityId__c FROM SampleDrop__c WHERE ActivityId__c IN :ids AND RecordTypeId = :recordTypeId];
            ids = new Set<String>();
            for(SampleDrop__c sampleDrop : sampleDrops){
                ids.add(sampleDrop.ActivityId__c);
            }
        }else{
            List<Transfer__c> transfers;
            if(!onlyChecked) {
                transfers = [
                        SELECT
                                Id, ToUserId__c, TransferDate__c, SignatureConfirmation__c
                        FROM
                                Transfer__c
                        WHERE
//                        Status__c = :transferTemplate.Status__c AND
                        TransferDate__c = :transferDate AND
                        RecordTypeId = :transferTemplate.RecordTypeId
                ];
            }else{
                transfers = [
                        SELECT
                                Id, ToUserId__c, TransferDate__c, SignatureConfirmation__c
                        FROM
                                Transfer__c
                        WHERE
//                        Status__c = :transferTemplate.Status__c AND
                        TransferDate__c = :transferDate AND
                        RecordTypeId = :transferTemplate.RecordTypeId AND
                        SignatureConfirmation__c = 'In Review'
                ];
            }
            System.debug('transfers = ');
            System.debug(transfers);
            ids = new Set<String>();
            List<Id> userIds = new List<Id>();
            for(Transfer__c transfer : transfers){
                ids.add(transfer.Id);
                userIds.add(transfer.ToUserId__c);
            }
            List<User> users = [SELECT Id, Name FROM User WHERE Id IN :userIds];
            transferMap = new Map<Id, Transfer__c>(transfers);
            userMap = new Map<Id, User>(users);
        }
        List<Attachment> attachments = [SELECT Id, Body, ParentId FROM Attachment WHERE ParentId IN :ids];

        for (Attachment attachment : attachments) {
            wrapper wrapper = new wrapper();
            wrapper.att = attachment;
            wrapper.checked = false;
            wrapper.color = '';

            if (mapp.get(attachment.ParentId) != null && mapp.get(attachment.ParentId).Audit__c != null) {
                String key = mapp.get(attachment.ParentId).Audit__c;
                wrapper.color = colors.get(key) != null ? colors.get(key) : '';
            }
            if (transferMap.get(attachment.ParentId) != null && transferMap.get(attachment.ParentId).SignatureConfirmation__c != null) {
                String key = transferMap.get(attachment.ParentId).SignatureConfirmation__c;
                wrapper.color = colors.get(key) != null ? colors.get(key) : '';
            }

            atts.add(wrapper);
        }
    }

    public void startInReview(){
        usermapp = new Map<String, User>();

        visits = getVisits(true);
        updateMap();
        updateContactMap();
        updateAttachments(true);
    }

    public void start() {
        usermapp = new Map<String, User>();

        updateVisits();
        updateMap();
        updateContactMap();
        updateAttachments();
    }

    public void setlistViewIdListFromPage() {
        String tmpString = String.escapeSingleQuotes(System.currentPageReference().getParameters().get('listStr'));

        if (tmpString != null && tmpString != '') {
            for (String filterId : tmpString.split(',')) {
                if (filterId != '000000000000000' && filterId != '') listViewIdListFromPage.add(filterId);
            }
        }
    }

    public void setContactListViewIdListFromPage() {
        String tmpString = String.escapeSingleQuotes(System.currentPageReference().getParameters().get('listContactStr'));

        if (tmpString != null && tmpString != '') {
            for (String filterId : tmpString.split(',')) {
                if (filterId != '000000000000000' && filterId != '') contactlistViewIdListFromPage.add(filterId);
            }
        }
    }

    public void refreshBottomUsers() {
    }
    public void refreshUpperUsers() {

        /*for(Integer i=0; i < relatedUsers.size(); i++){
            userwrapper uw = relatedUsers.get(i);

            if (uw.selected){

            } else {
                //too сделать map
                if (tableSet != null && tableSet.getAllRecords() != null ){
                    for(userwrapper item: tableSet.getAllRecords() ){
                        if ( uw.user.Id == item.user.Id){
                            item.selected = false;
                        }
                    }
                }


                if (uw.cycleUser.id == null){ // удаляем из списка
                    relatedUsers.remove(i);
                } else {
                    uw.cycleUser.CTPHARMA__Active__c = false;
                    uw.isactive = false;
                }
            }   
 
        }*/
    }

    public void addAllUsers() {
        if (tableSet != null && tableSet.getAllRecords() != null) {

            for (userWrapper item : tableSet.getAllRecords()) {
                item.selected = true;
            }
        }

        refreshBottomUsers();
    }

    public void addAllC() {
        if (tableSetC != null && tableSetC.getAllRecords() != null) {

            for (userWrapper item : tableSetC.getAllRecords()) {
                item.selected = true;
            }
        }

        refreshBottomUsers();
    }


    public void init() {
        initConstants();
        initTemps();
        if(ApexPages.currentPage().getParameters().get('contact_id') != null){
            SEARCH_OBJECT_MODE = 'CONTACT';
            initContacts();
            addAllC();
        }else if(ApexPages.currentPage().getParameters().get('user_id') != null){
            SEARCH_OBJECT_MODE = 'USER';
            initUsers();
            addAllUsers();
        }
        filterType = 'Activity';
        transferDate = Date.today();

        mapp = new Map<Id, ctpharma__Activity__c>();
        acttemplate = new ctpharma__Activity__c();
        transferTemplate = new Transfer__c();
        atts = new List<wrapper>();

        colors = new Map<String, String>();
//        colors.put('Confirmed', 'border: 2px solid #2edc1d;border-radius: 7px'); //outline
//        colors.put('Declined', 'border: 2px solid red;border-radius: 7px');  //outline
        colors.put('Confirmed', 'confirmed'); //outline
        colors.put('Declined', 'declined');  //outline
        colors.put('In Review', 'review');  //outline

        fields = new List<Schema.FieldSetMember>();
        contactId = ApexPages.currentPage().getParameters().get('id');
        if (contactId != null) con = (Contact) makeQuery('Contact', null, 'id = \'' + contactId + '\'', true)[0];

        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe();
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get('Contact');
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.fieldSets.getMap().get('ContactInfo');
        for (Schema.FieldSetMember fsm : fieldSetObj.getFields()) {
            fields.add(fsm);
        }

        startDate = Date.today();
        endDate = Date.today();

        template = new Contact(Birthdate = Date.today());
        start();
    }

    public void Reset() {
        init();
    }

    public SampleAuditController(ApexPages.StandardController controller) {
        init();
    }

    public SampleAuditController() {
        init();
    }


    public static List<SObject> makeQuery(String sObj, String relations, String conditions, Boolean includeCalculated) {

        Schema.DescribeSObjectResult objectResult = Schema.getGlobalDescribe().get(sObj.replace('', '')).getDescribe();
        List<Schema.DescribeFieldResult> fields = new List<Schema.DescribeFieldResult>();

        Set<String> doubleCheck = new Set<String>();
        for (Schema.SObjectField sof : objectResult.fields.getMap().values()) {
            Schema.DescribeFieldResult fieldResult = sof.getDescribe();

            // Rules for excluding fields from query
            if (doubleCheck.contains(fieldResult.getName())) continue; //exclude double fields
            if (fieldResult.getName().contains('__pc')) continue; //exclude person account fields
            if (fieldResult.isCalculated() && !includeCalculated) continue; //exclude calculated fields by parameter includeCalculated


            doubleCheck.add(fieldResult.getName());
            fields.add(fieldResult);
        }

        String query = 'SELECT';
        if (fields != null) {
            String[] fieldNames = new String[0];
            for (Integer i = 0; i < fields.size(); i++) {

                Schema.DisplayType fielddataType = fields[i].getType();
                if (fielddataType != Schema.DisplayType.LOCATION) {  //  fix geolocation bug
                    fieldNames.add(fields[i].getName());
                }
            }
            query += ' ' + String.join(fieldNames, ', ');
        }

        if ((relations != null) && (relations != '')) {
            query += ', ' + relations;
        }

        query += ' FROM ' + String.escapeSingleQuotes(sObj.replace('', ''));

        if ((conditions != null) && (conditions != '') && (conditions != 'null')) {
            query += ' WHERE ' + conditions;
        }

        System.debug('>>>> CT DEBUG | QUERY STRING: ' + query);

        return Database.query(query);
    }

    public PageReference returnToContact() {
        PageReference pageRef = new PageReference('/' + con.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }


    public List<SelectOption> getSignatures() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Sample Drop', 'Sample Drop'));
        options.add(new SelectOption('Sample Delivery', 'Sample Delivery'));
        return options;
    }

    public List<SelectOption> getFilterTypes() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Activity', 'Activity'));
        options.add(new SelectOption('Transfer', 'Transfer'));
        return options;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String s) {
        this.signature = s;
    }

    public class wrapper {
        public transient Attachment att { get; set; }
        public Boolean checked { get; set; }
        public String color { get; set; }
        public wrapper() {
        }
    }


    public ApexPages.StandardSetController ContactSSetController {
        get {
            if (ContactSSetController == null) {
                ContactSSetController = new ApexPages.StandardSetController(Database.getQueryLocator(getQueryContacts()));
                ContactSSetController.setPageSize(200);
            }

            return ContactSSetController;
        }
        set;
    }

    public ApexPages.StandardSetController ContactSSetController2 {
        get {
            if (ContactSSetController2 == null) {
                ContactSSetController2 = new ApexPages.StandardSetController(Database.getQueryLocator(baseContactQuery));
            }
            return ContactSSetController2;
        }
        set;
    }

    public void onContactChangeFilter() {
        FilterContactId = String.escapeSingleQuotes(System.currentPageReference().getParameters().get('FilterConId_val'));
        System.debug('FilterConId_val: ' + FilterContactId);

        ContactSSetController = null;
    }

    //сменили листвью на users
    public void onChangeFilter() {
        FilterId = String.escapeSingleQuotes(System.currentPageReference().getParameters().get('FilterId_val'));
        System.debug('FilterId_val: ' + FilterId);

        SSetController = null;
    }


    public ApexPages.StandardSetController SSetController {
        get {
            if (SSetController == null) {
                SSetController = new ApexPages.StandardSetController(Database.getQueryLocator(getQueryUsers()));
                SSetController.setPageSize(200);
            }

            return SSetController;
        }
        set;
    }

    private String baseQuery = 'Select ID, Name, isActive FROM User where isActive = true limit 9000'; //базовый запрос, если listView нет
    private String baseContactQuery = 'select id, name from Contact limit 9000';


    public List<SelectOption> listViewContact {  // ListViews для Users
        get {
            List<SelectOption> ret = new List<SelectOption>();
            for (SelectOption SO : ContactSSetController2.getListViewOptions()) {
                SelectOption newItem = new SelectOption(SO.getValue().substring(0, 15), SO.getLabel());
                ret.add(newItem);
            }
            System.debug('ContactSSetController2.getListViewOptions(): ' + ContactSSetController2.getListViewOptions());
            System.debug('ret: ' + ret);
            return ret;
            //return ret.isEmpty() ? null : ret; 
        }
        set;
    }


    public List<SelectOption> listViewUser {  // ListViews для Users
        get {
            List<SelectOption> ret = new List<SelectOption>();
            for (SelectOption SO : SSetController2.getListViewOptions()) {
                SelectOption newItem = new SelectOption(SO.getValue().substring(0, 15), SO.getLabel());
                ret.add(newItem);
            }
            System.debug('SSetController2.getListViewOptions(): ' + SSetController2.getListViewOptions());
            System.debug('ret: ' + ret);
            return ret;
            //return ret.isEmpty() ? null : ret; 
        }
        set;
    }


    public List<User> UsersNew {
        get {
            if (SSetController != null) {

                List<User> ret = new List<User>();
                List<User> tempUsers = new List<User>();

                for (SObject sobj : SSetController.getRecords()) {
                    User u = (User) sobj;
                    if (u.IsActive == true) {
                        ret.add(u);
                    }
                }

                while (SSetController.getHasNext()) {
                    SSetController.next();
                    for (SObject sobj : SSetController.getRecords()) {
                        User u = (User) sobj;
                        if (u.IsActive == true) {
                            ret.add(u);
                        }
                    }
                }

                System.debug('UsersNewSize :  ' + ret.size() + '      ');
                return ret;
            } else {
                return null;
            }
        }
        set;
    }

    public ApexPages.StandardSetController SSetController2 {
        get {
            if (SSetController2 == null) {
                SSetController2 = new ApexPages.StandardSetController(Database.getQueryLocator(baseQuery));
            }
            return SSetController2;
        }
        set;
    }

    public List<String> ConlistViewIdList {
        get {
            List<String> ret = new List<String>();
            for (SelectOption SO : listViewContact) {
                //selectOptionWrapperlist.add(new SelectOptionWrapper(SO.getValue(), SO.getLabel()));
                ret.add(SO.getValue());
            }
            return ret.isEmpty() ? null : ret;
        }
        set;
    }

    public List<String> listViewIdList {
        get {
            List<String> ret = new List<String>();
            for (SelectOption SO : listViewUser) {
                //selectOptionWrapperlist.add(new SelectOptionWrapper(SO.getValue(), SO.getLabel()));
                ret.add(SO.getValue());
            }
            return ret.isEmpty() ? null : ret;
        }
        set;
    }

    public List<String> listViewIdListFromPage { get; set; }
    public List<String> contactlistViewIdListFromPage { get; set; }

    // return modified query string (USERS)
    public String getQueryContacts() {
        String finallyQuery;
        List <String> fieldsList = new List<String>();
        fieldsList.add('Name');
        fieldsList.add('id');

        System.debug('filterContactId : ' + FilterContactId);

        if (FilterContactId == '000000000000000') {
            finallyQuery = baseContactQuery;
        } else {
            String sObjType = 'Contact';

            try {
                String[] soapQueryList = new String[0];
                for (String s : contactlistViewIdListFromPage) {//listViewIdList
                    soapQueryList.add(s);
                    System.debug('soapQueryList: ' + soapQueryList);

                    if (soapQueryList.size() == 10) {
                        soapResult.putAll(GetListViews(sObjType, soapQueryList));
                        soapQueryList = new String[0];
                    }
                }

                soapResult.putAll(GetListViews(sObjType, soapQueryList));
            } catch (Exception ex) {
                System.debug(ex);
            }

            System.debug('soapResult: ' + soapResult);

            String query;
            if (!Test.isRunningTest()) {
                if (soapResult.containsKey(FilterContactId) && soapResult.get(FilterContactId) != null) {
                    query = soapResult.get(FilterContactId);
                } else {
                    query = 'select Id, Name from Contact ';
                }
            } else {
                query = 'select Id, Name from Contact ';
            }

            System.debug('query: ' + query);
            String endQuery = query.substringAfter(' ' + sObjType + ' '); // scope, where, order by
            String startQuery = query.substringBefore(' ' + sObjType + ' '); // scope, where, order by
            setNewContactfieldsToShow(startQuery);
            System.debug('endQuery: ' + endQuery);
            endQuery += '  limit 2000 ';
            finallyQuery = createQuery(query, startQuery, sObjType, fieldsList, endQuery); // modify selected query

            /*if (finallyQuery.containsIgnoreCase('WHERE')) finallyQuery = finallyQuery.replaceFirst(' WHERE ',' WHERE clm__DeviceToken__c !=null and ');
            else finallyQuery = finallyQuery.replaceFirst(' ORDER BY ',' WHERE clm__DeviceToken__c !=null ORDER BY ');*/

            System.debug('finallyQuery : ' + finallyQuery);
        }

        return finallyQuery;
    }


    // return modified query string (USERS)
    public String getQueryUsers() {
        String finallyQuery;
        List <String> fieldsList = new List<String>();
        fieldsList.add('Name');
        fieldsList.add('id');

        System.debug('FilterId : ' + FilterId);

        if (FilterId == '000000000000000') {
            finallyQuery = baseQuery;
        } else {
            String sObjType = 'User';

            try {
                String[] soapQueryList = new String[0];
                for (String s : listViewIdListFromPage) {//listViewIdList
                    soapQueryList.add(s);
                    System.debug('soapQueryList: ' + soapQueryList);

                    if (soapQueryList.size() == 10) {
                        soapResult.putAll(GetListViews(sObjType, soapQueryList));
                        soapQueryList = new String[0];
                    }
                }

                soapResult.putAll(GetListViews(sObjType, soapQueryList));
            } catch (Exception ex) {
                System.debug(ex);
            }

            System.debug('soapResult: ' + soapResult);

            String query;
            if (!Test.isRunningTest()) {
                if (soapResult.containsKey(FilterId) && soapResult.get(FilterId) != null) {
                    query = soapResult.get(FilterId);
                } else {
                    query = 'select Id, Name, isActive from User ';
                }
            } else {
                query = 'select Id, Name, isActive from User ';
            }

            System.debug('query: ' + query);
            String endQuery = query.substringAfter(' ' + sObjType + ' '); // scope, where, order by
            String startQuery = query.substringBefore(' ' + sObjType + ' '); // scope, where, order by
            setNewfieldsToShow(startQuery);
            System.debug('endQuery: ' + endQuery);
            endQuery += '  limit 2000 ';
            finallyQuery = createQuery(query, startQuery, sObjType, fieldsList, endQuery); // modify selected query

            /*if (finallyQuery.containsIgnoreCase('WHERE')) finallyQuery = finallyQuery.replaceFirst(' WHERE ',' WHERE clm__DeviceToken__c !=null and ');
            else finallyQuery = finallyQuery.replaceFirst(' ORDER BY ',' WHERE clm__DeviceToken__c !=null ORDER BY ');*/

            System.debug('finallyQuery : ' + finallyQuery);
        }

        return finallyQuery;
    }

    public void empty() {
    }

    public void setNewContactfieldsToShow(String startQuery) {
        startQuery = startQuery.toLowerCase().replace(' ', '').replace('select', '').replace('from', '');

        System.debug('startQuery: ' + startQuery);

        List<String> result = new List<String>();

        for (String f : startQuery.split(',')) {
            result.add(f);
        }
        if (!result.isEmpty()) {
            fieldsContactToShow = new List<String>();
            fieldsContactToShow.addAll(result);
        }

    }

    public void setNewfieldsToShow(String startQuery) {
        startQuery = startQuery.toLowerCase().replace(' ', '').replace('select', '').replace('from', '');

        System.debug('startQuery: ' + startQuery);

        List<String> result = new List<String>();

        for (String f : startQuery.split(',')) {
            result.add(f);
        }
        if (!result.isEmpty()) {
            fieldsToShow = new List<String>();
            fieldsToShow.addAll(result);
        }

    }


    //возвращает ListViews
    public static Map<String, String> GetListViews(String objType, List<String> listIds) {

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader('Content-Type', 'text/xml');
        req.setMethod('GET');
        req.setHeader('SOAPAction', 'DoSomeShit');

        String b = '<?xml version="1.0" encoding="UTF-8"?>';
        b += '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:enterprise.soap.sforce.com">';
        b += '<soapenv:Header>';
        b += '<urn:SessionHeader>';
        b += '<urn:sessionId>' + UserInfo.getSessionId() + '</urn:sessionId>';
        b += '</urn:SessionHeader>';
        b += '</soapenv:Header>';
        b += '<soapenv:Body>';
        b += '<urn:describeSoqlListViews>';
        b += '<urn:request>';

        for (String listId : listIds) {
            b += '<urn:listViewParams>';
            b += '<urn:developerNameOrId>' + listId + '</urn:developerNameOrId>';
            b += ' <urn:sobjectType>' + objType + '</urn:sobjectType>';
            b += '</urn:listViewParams>';
        }

        b += '</urn:request>';
        b += '</urn:describeSoqlListViews>';
        b += '</soapenv:Body>';
        b += '</soapenv:Envelope>';

        req.setBody(b);
        req.setCompressed(false);
        req.setEndpoint('https://' + Instance + '.salesforce.com/services/Soap/c/32.0/');
        HttpResponse resp;

        Map<String, String> result = new Map<String, String>();
        if (!Test.isRunningTest()) {
            try {
                resp = h.send(req);
                System.debug('resp.body: ' + resp.getBody());
                result = parseListViewResp(objType, resp);
            } catch (CalloutException ex) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, ex.getMessage()));
            }
        }

        return result;
    }

    public static String Instance {
        get {
            if (Instance == null) {
                List<String> parts = System.Url.getSalesforceBaseUrl().getHost().replace('-api', '').split('\\.');
                if (parts.size() == 3) {
                    Instance = parts[0];
                } else if (parts.size() == 5) {
                    Instance = parts[1];
                } else {
                    Instance = null;
                }
            }
            return Instance;
        }

        private set;
    }

    public static Map<String, String> parseListViewResp(String sobjectType, HttpResponse LVResp) {
        Map<String, String> toReturnMap = new Map<String, String>();

        try {
            Dom.Document doc = LVResp.getBodyDocument();
            Dom.XmlNode envelop = doc.getRootElement();
            String rootNamespace = envelop.getNamespace();
            Dom.XmlNode envBody = envelop.getChildElement('Body', 'http://schemas.xmlsoap.org/soap/envelope/');
            Dom.XmlNode describeSoqlListViewsResponse = envBody.getChildElement('describeSoqlListViewsResponse', 'urn:enterprise.soap.sforce.com');
            Dom.XmlNode result = describeSoqlListViewsResponse.getChildElement('result', 'urn:enterprise.soap.sforce.com');
            Dom.XmlNode[] children = result.getChildren();

            for (Dom.XmlNode item : children) {

                String IdTag = item.getChildElement('id', 'urn:enterprise.soap.sforce.com').getText();
                String query = item.getChildElement('query', 'urn:enterprise.soap.sforce.com').getText();

                List<String> visibleFields = new List<String>();
                Dom.XmlNode[] childrenOfchildren = item.getChildren();
                for (Dom.XmlNode itemOfitem : childrenOfchildren) {

                    if (itemOfitem.getName() == 'Columns') {
                        String fieldName = itemOfitem.getChildElement('fieldNameOrPath', 'urn:enterprise.soap.sforce.com').getText();
                        String isHidden = itemOfitem.getChildElement('hidden', 'urn:enterprise.soap.sforce.com').getText();
                        if (isHidden == 'false') {
                            visibleFields.add(fieldName);
                        }
                    }
                }


                if (sobjectType == 'User') lwFieldSet.put(IdTag, visibleFields);

                toReturnMap.put(IdTag, query);

            }

        } catch (Exception ex) {
            System.debug('!!!Exception : ' + ex.getTypeName() + ': ' + ex.getMessage() + ' ' + ex.getCause() + ' (' + ex.getLineNumber() + '; ' + ex.getStackTraceString());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, ex.getMessage()));
        }

        return toReturnMap;
    }


    // simple create query
    public String createQuery(String aQuery, String startQuery, String objectType, List <String> fieldsList, String endQuery) {

        String query = '';
        String tmpconditions = '';
        search_string = String.escapeSingleQuotes(search_string);

        if (search_string != null || search_string != '') {
            System.debug('search_string: ' + search_string);
            System.debug('search_string: ' + search_string);
            tmpconditions += ' where Name LIKE \'%' + String.escapeSingleQuotes(search_string) + '%\' ';
            if (aQuery.indexOf(' WHERE ') != -1) {
                System.debug('!= -1');
                tmpconditions += ' AND ';
                aQuery = aQuery.replace(' WHERE ', tmpconditions);
            } else {
                System.debug('-1');
                aQuery = aQuery.replace(' FROM User ', ' FROM User ' + tmpconditions);
                aQuery = aQuery.replace(' FROM Contact ', ' FROM Contact ' + tmpconditions);
            }
        }

        query = replaceNotSoql(aQuery);

        return query;
    }


    //метод заменяет некоторые поля (к примеру, метод describeSObjectListViews может вернуть в запросе CREATED_BY_NAME вместо CreatedBy.Name)
    public static String replaceNotSoql(String query) {
        System.debug('replaceNotSoql not modified query: ' + query);

        query = query.toUpperCase();
        query = query.replaceAll('CREATED_BY_ID', 'CreatedById');
        query = query.replaceAll('CREATED_BY_NAME', 'CreatedBy.Name');
        query = query.replaceAll('LAST_MODIFIED_BY_ID', 'LastModifiedById');
        query = query.replaceAll('UPDATEDBY_USER', 'lastmodifiedBy');
        query = query.replaceAll('LAST_MODIFIED_BY_NAME', 'lastmodifiedBy.Name');
        query = query.replaceAll('LAST_MODIFIED_DATE', 'LastModifiedDate');
        query = query.replaceAll('CORE.USERS.LAST_LOGIN', 'LastLoginDate');

        //поля, на которые заменяем, могут быть не те
        query = query.replaceAll('SU_ACCESS_EXPIRATION', 'OfflinePdaTrialExpirationDate');
        query = query.replaceAll('SU_ORG_ADMIN_EXPIRATION', 'OfflineTrialExpirationDate');
        query = query.replaceAll('MARKETING_USER', 'UserPermissionsMarketingUser');
        query = query.replaceAll('OFFLINE_USER', 'UserPermissionsOfflineUser');

        return query;
    }


    public class userWrapper {
        public User user { get; set; }
        public Contact contact { get; set; }
        public Boolean selected { get; set; }
        public CTPHARMA__MarketingCycleUser__c cycleUser { get; set; }
        public Boolean isActive { get; set; }
        public String style { get; set; }

        public userWrapper(User u) {
            user = u;
            selected = false;
            style = 'display:""';
        }

        public userWrapper(Contact c) {
            contact = c;
            selected = false;
            style = 'display:""';
        }

        public userWrapper(User u, Boolean aSelected) {
            user = u;
            selected = aSelected;
            style = 'display:none';

            if (aSelected != null && aSelected) {
                style = '';
            }
        }

        public userWrapper(User u, CTPHARMA__MarketingCycleUser__c aCycleUser) {
            user = u;
            cycleUser = aCycleUser;
            style = 'display:none';
            if (aCycleUser != null) {
                selected = aCycleUser.CTPHARMA__Active__c;
                isActive = aCycleUser.CTPHARMA__Active__c;
                if (aCycleUser.CTPHARMA__Active__c != null && aCycleUser.CTPHARMA__Active__c) {
                    style = '';
                }
            }


        }

        public String getStyles() {
            return isActive == true ? '""' : 'display:none';
        }

    }

    //  for string operations
    public static String list2QueryString(Set<String> sourceList) {
        String listString = '';
        for (String s : sourceList) {
            listString += '\'' + String.escapeSingleQuotes(s) + '\'' + ',';
        }

        if (listString.length() > 0) {
            listString = listString.substring(0, listString.length() - 1);
        }
        return listString;
    }


    // Custom paginator
    public class CustomIterable implements Iterator<List<userWrapper>> {
        List<userWrapper> InnerList { get; set; }
        List<userWrapper> ListRequested { get; set; }

        Integer i { get; set; }
        public Integer setPageSize { get; set; }

        public CustomIterable(List<userWrapper> lstAccWr) {
            InnerList = new List<userWrapper>();
            ListRequested = new List<userWrapper>();
            InnerList = lstAccWr;
            setPageSize = 10;
            i = 0;
        }

        public Boolean hasNext() {
            if (i >= InnerList.size()) {
                return false;
            } else {
                return true;
            }
        }

        public Boolean hasPrevious() {
            System.debug('I am in hasPrevious' + i);
            if (i <= setPageSize) {
                return false;
            } else {
                return true;
            }
        }

        public List<userWrapper> getAllRecords() {
            return InnerList;
        }

        public List<userWrapper > next() {
            System.debug('i value is ' + i);
            ListRequested = new List<userWrapper >();
            Integer startNumber;
            Integer size = InnerList.size();
            if (hasNext()) {
                if (size <= (i + setPageSize)) {
                    startNumber = i;
                    i = size;
                } else {
                    i = (i + setPageSize);
                    startNumber = (i - setPageSize);
                }

                System.debug('i value is =====' + i);
                System.debug('i value is 2==== ' + (i - setPageSize));

                for (Integer start = startNumber; start < i; start++) {
                    ListRequested.add(InnerList[start]);
                }
            }
            return ListRequested;
        }

        public List<userWrapper > previous() {
            ListRequested = new List<userWrapper >();
            System.debug('i value is previous before =====' + i);
            Integer size = InnerList.size();
            if (i == size) {
                if (Math.mod(size, setPageSize) > 0) {
                    i = size - Math.mod(size, setPageSize);
                } else {
                    i = (size - setPageSize);
                }
            } else {
                i = (i - setPageSize);
            }

            System.debug('i value is previous =====' + i);
            System.debug('i value is 2previous ==== ' + (i - setPageSize));
            Integer tmpStart = (i - setPageSize);
            if (tmpStart < 0) tmpStart = 0;

            for (Integer start = tmpStart; start < i; ++start) {
                ListRequested.add(InnerList[start]);
            }
            return ListRequested;
        }



    }


}