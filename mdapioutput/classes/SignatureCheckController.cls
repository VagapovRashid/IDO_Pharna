/**
 * Created by Rashid Vagapov on 14.06.2019.
 */

public with sharing class SignatureCheckController {
    public Contact contact { get; set; }
    public String filterType { get; set; }
    public Date transferDate { get; set; }
    public Transfer__c transfer { get; set; }
    public Date activityStartDate { get; set; }
    public Date activityEndDate { get; set; }
    public CTPHARMA__Activity__c activity { get; set; }
    public Map<Id, CTPHARMA__Activity__c> activityMap { get; set; }
    public Map<Id, CTPHARMA__Activity__c> confirmedActivityMap { get; set; }
    public String signatureType { get; set; }
    public List<AttachmentWrapper> attachments { get; set; }
    public List<List<AttachmentWrapper>> selectedAttachments { get; set; }
    public List<AttachmentWrapper> allSelectedAttachments { get; set; }
    public List<AttachmentWrapper> checkedSelectedAttachments { get; set; }
    public AttachmentWrapper checkedAttachment { get; set; }
    public AttachmentWrapper checkedSelectedAttachment { get; set; }
    public Map<String, String> colors { get; set; }
    public Map<Id, Transfer__c> transferMap { get; set; }
    private List<CTPHARMA__Activity__c> activities;
    private List<Transfer__c> transfers;

    public List<SelectOption> getFilterTypes() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Activity', 'Activity'));
        options.add(new SelectOption('Transfer', 'Transfer'));
        return options;
    }

    public List<SelectOption> getSignatureTypes() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Sample Drop', 'Sample Drop'));
        options.add(new SelectOption('Sample Delivery', 'Sample Delivery'));
        return options;
    }

    public SignatureCheckController() {
        contact = new Contact();
        System.debug(ApexPages.currentPage().getParameters().get('contact_id'));
        if(ApexPages.currentPage().getParameters().get('contact_id') != '') {
            contact.ContactId__c = ApexPages.currentPage().getParameters().get('contact_id');
        }
        System.debug('contact');
        System.debug(contact);
        System.debug(Url.getCurrentRequestUrl());
        filterType = 'Activity';
        transferDate = Date.today();
        transfer = new Transfer__c();
        activityStartDate = Date.today();
        activityEndDate = Date.today();
        activity = new CTPHARMA__Activity__c();
        attachments = new List<AttachmentWrapper>();
        selectedAttachments = new List<List<AttachmentWrapper>>();
        activities = new List<CTPHARMA__Activity__c>();
        activityMap = new Map<Id, CTPHARMA__Activity__c>();
        transfers = new List<Transfer__c>();
        transferMap = new Map<Id, Transfer__c>();
        colors = new Map<String, String>();
        colors.put('Confirmed', 'confirmed');
        colors.put('Declined', 'declined');
        colors.put('In Review', 'review');
        colors.put('Not Reviewed', 'new');
        allSelectedAttachments = new List<AttachmentWrapper>();
        checkedSelectedAttachments = new List<AttachmentWrapper>();
        checkedAttachment = new AttachmentWrapper();
        checkedSelectedAttachment = new AttachmentWrapper();
    }

    public void countSelectedAttachments(){
        allSelectedAttachments = new List<AttachmentWrapper>();
        checkedSelectedAttachments = new List<AttachmentWrapper>();
        for(AttachmentWrapper attachment : attachments){
            if(attachment.checked){
                allSelectedAttachments.add(attachment);
                checkedAttachment = attachment;
            }
        }
        for(List<AttachmentWrapper> attachments : selectedAttachments){
            for(AttachmentWrapper attachment : attachments){
                if(attachment.checked){
                    checkedSelectedAttachments.add(attachment);
                    checkedSelectedAttachment = attachment;
                }
            }
        }

    }

//    public void search() {
//        if (filterType == 'Activity') {
//            activities = getActivities(new List<String>{
//                    'Not Reviewed', ''
//            });
//            activityMap = new Map<Id, CTPHARMA__Activity__c>(activities);
//            confirmedActivityMap = new Map<Id, CTPHARMA__Activity__c>([SELECT Id, Audit__c, CTPHARMA__StartDate__c, CTPHARMA__EndDate__c, Name FROM CTPHARMA__Activity__c WHERE Audit__c = 'Confirmed']);
//        } else {
//            transfers = getTransfers(new List<String>{
//                    'Not Reviewed', ''
//            });
//            transferMap = new Map<Id, Transfer__c>(transfers);
//        }
//
//        updateAttachments();
//    }

    public List<CTPHARMA__Activity__c> getActivities(List<String> states) {
        String query = 'SELECT Id, Audit__c, CTPHARMA__StartDate__c, CTPHARMA__EndDate__c, Name  FROM CTPHARMA__Activity__c WHERE';
        query += ' CTPHARMA__StartDate__c >= ' + getSoqlDate(activityStartDate);
        query += ' AND CTPHARMA__EndDate__c <= ' + getSoqlDate(activityEndDate);
        query += ' AND RecordTypeId = \'' + activity.RecordTypeId + '\'';
        query += ' AND CTPHARMA__ContactId__c = \'' + contact.ContactId__c + '\'';

        for (Integer i = 0; i < states.size(); i++) {
            if (i == 0) {
                query += ' AND (Audit__c = \'' + states[0] + '\'';
            } else {
                query += ' OR Audit__c = \'' + states[i] + '\'';
            }
            if (i == states.size() - 1) {
                query += ')';
            }
        }

        return Database.query(query);
    }

    public List<Transfer__c> getTransfers(List<String> states) {
        String query = 'SELECT Id FROM Transfer__c WHERE';
        query += ' TransferDate__c = ' + getSoqlDate(transferDate);
        query += ' AND RecordTypeId = \'' + activity.RecordTypeId + '\'';

        for (Integer i = 0; i < states.size(); i++) {
            if (i == 0) {
                query += ' AND (SignatureConfirmation__c = \'' + states[0] + '\'';
            } else {
                query += ' OR SignatureConfirmation__c = \'' + states[i] + '\'';
            }
            if (i == states.size() - 1) {
                query += ')';
            }
        }

        return Database.query(query);
    }

    public static String getSoqlDate(Date curDate) {
        return Datetime.newInstance(curDate.year(), curDate.month(), curDate.day()).format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
    }

//    public List<List<AttachmentWrapper>> getAttachmentWrappers() {
//        List<List<AttachmentWrapper>> result = new List<List<AttachmentWrapper>>();
//        List<AttachmentWrapper> bufAttachments = new List<AttachmentWrapper>();
//        Map<Id, CTPHARMA__Activity__c> confirmedActivities = new Map<Id, CTPHARMA__Activity__c>([SELECT Id, Audit__c FROM CTPHARMA__Activity__c WHERE CTPHARMA__ContactId__c = :contact.ContactId__c AND Audit__c = 'Confirmed']);
//        Map<Id, Transfer__c> confirmedTransfers = new Map<Id, Transfer__c>([SELECT Id, SignatureConfirmation__c FROM Transfer__c WHERE SignatureConfirmation__c = 'Confirmed']);
//        List<Attachment> confirmedAttachments = [SELECT Id, ParentId FROM Attachment WHERE ParentId IN :confirmedActivities.keySet()];// OR ParentId IN :confirmedTransfers.keySet()];
//        List<AttachmentWrapper> confirmedAttachmentWrappers = new List<AttachmentWrapper>();
//        for (Attachment curAttachment : confirmedAttachments) {
//            AttachmentWrapper wrapper = new AttachmentWrapper();
//            wrapper.attachment = curAttachment;
//            wrapper.checked = false;
//            wrapper.color = '';
//
//            if (confirmedActivities.get(curAttachment.ParentId) != null) {
//                String key = confirmedActivities.get(curAttachment.ParentId).Audit__c;
//                wrapper.color = colors.get(key) != null ? colors.get(key) : '';
//            }
//
//            if (confirmedTransfers.get(curAttachment.ParentId) != null) {
//                String key = confirmedTransfers.get(curAttachment.ParentId).SignatureConfirmation__c;
//                wrapper.color = colors.get(key) != null ? colors.get(key) : '';
//            }
//
//            confirmedAttachmentWrappers.add(wrapper);
//        }
//        for (AttachmentWrapper attachment : confirmedAttachmentWrappers) {
//
//            if (bufAttachments.size() < 4) {
//                bufAttachments.add(attachment);
//            } else {
//                result.add(bufAttachments);
//                bufAttachments = new List<AttachmentWrapper>();
//            }
//        }
//        if (bufAttachments.size() != 0) {
//            result.add(bufAttachments);
//        }
//
//        return result;
//    }

//    private void updateAttachments() {
//        Set<Id> attachmentParentIds = new Set<Id>();
//        attachments = new List<AttachmentWrapper>();
//
//        if (filterType == 'Activity') {
//            Id recordTypeId = Schema.SObjectType.SampleDrop__c.getRecordTypeInfosByName().get(signatureType).getRecordTypeId();
//            List<SampleDrop__c> sampleDrops = [SELECT Id, ActivityId__c FROM SampleDrop__c WHERE ActivityId__c IN :activities AND RecordTypeId = :recordTypeId];
//            for (SampleDrop__c sampleDrop : sampleDrops) {
//                attachmentParentIds.add(sampleDrop.ActivityId__c);
//            }
//        } else {
//            for (Transfer__c transfer : transfers) {
//                attachmentParentIds.add(transfer.Id);
//            }
//        }
//        List<Attachment> curAttachments = [SELECT Id, ParentId FROM Attachment WHERE ParentId IN :attachmentParentIds];
//
//        for (Attachment curAttachment : curAttachments) {
//            AttachmentWrapper wrapper = new AttachmentWrapper();
//            wrapper.attachment = curAttachment;
//            wrapper.checked = false;
//            wrapper.color = '';
//
//            if (activityMap.get(curAttachment.ParentId) != null) {
//                String key = activityMap.get(curAttachment.ParentId).Audit__c;
//                wrapper.color = colors.get(key) != null ? colors.get(key) : '';
//            }
//
//            if (transferMap.get(curAttachment.ParentId) != null) {
//                String key = transferMap.get(curAttachment.ParentId).SignatureConfirmation__c;
//                wrapper.color = colors.get(key) != null ? colors.get(key) : '';
//            }
//
//            attachments.add(wrapper);
//
//        }
//
//        selectedAttachments = getAttachmentWrappers();
//    }

//    public void confirm() {
//        updateChecked('Confirmed');
//    }

//    public void decline() {
//        updateChecked('Declined');
//    }

    public void doNothing(){}

//    public void updateChecked(String auditResult) {
//        if (filterType == 'Activity') {
//            List<CTPHARMA__Activity__c> activitiesToUpdate = new List<CTPHARMA__Activity__c>();
//
//            for (AttachmentWrapper attachment : attachments) {
//                if (attachment.checked) {
//                    activitiesToUpdate.add(activityMap.get(attachment.attachment.ParentId));
//                }
//            }
//
//            System.debug(attachments);
//
//            for (CTPHARMA__Activity__c activity : activitiesToUpdate) {
//                activity.Audit__c = auditResult;
//            }
//
//            List<SampleDrop__c> sampleDrops = [SELECT Id, Name, SignatureConfirmation__c FROM SampleDrop__c WHERE ActivityId__c IN :activitiesToUpdate];
//            for (SampleDrop__c sampleDrop : sampleDrops) {
//                sampleDrop.SignatureConfirmation__c = auditResult;
//            }
//
//            update sampleDrops;
//            update activitiesToUpdate;
//        } else {
//            Set<Transfer__c> transfersToUpdate = new Set<Transfer__c>();
//
//            for (AttachmentWrapper attachment : attachments) {
//                if (attachment.checked) {
//                    transfersToUpdate.add(transferMap.get(attachment.attachment.ParentId));
//                }
//            }
//
//            for (Transfer__c transfer : transfersToUpdate) {
//                transfer.SignatureConfirmation__c = auditResult;
//            }
//
//            update new List<Transfer__c>(transfersToUpdate);
//        }
//        search();
//    }

    public class AttachmentWrapper {
        public Attachment attachment { get; set; }
        public Boolean checked { get; set; }
        public String color { get; set; }
    }
}