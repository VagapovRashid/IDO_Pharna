<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>Create Store Product</label>
    <protected>false</protected>
    <values>
        <field>clm__Action__c</field>
        <value xsi:type="xsd:string">Create record</value>
    </values>
    <values>
        <field>clm__FieldAPIName__c</field>
        <value xsi:type="xsd:string">StoreProductId__c,Quantity__c</value>
    </values>
    <values>
        <field>clm__FieldAPINames__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>clm__FieldValue__c</field>
        <value xsi:type="xsd:string">$query.Id,$query.Quantity__c</value>
    </values>
    <values>
        <field>clm__FieldValues__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>clm__IsCalculateEnabled__c</field>
        <value xsi:type="xsd:boolean">true</value>
    </values>
    <values>
        <field>clm__Order__c</field>
        <value xsi:type="xsd:double">1.0</value>
    </values>
    <values>
        <field>clm__ParentObjectAPIName__c</field>
        <value xsi:type="xsd:string">Store__c</value>
    </values>
    <values>
        <field>clm__ParentObject__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>clm__RecordCriteria__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>clm__RelationshipName__c</field>
        <value xsi:type="xsd:string">ToStoreId__c</value>
    </values>
    <values>
        <field>clm__SOQLObjectAPIName__c</field>
        <value xsi:type="xsd:string">StoreProduct__c</value>
    </values>
    <values>
        <field>clm__SOQLQuery__c</field>
        <value xsi:type="xsd:string">where StoreId__c = $sObject.ToStoreId__c</value>
    </values>
    <values>
        <field>clm__SOQLRecordCriteria__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>clm__SQOLObjectAPIName__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>clm__Scope__c</field>
        <value xsi:type="xsd:string">Parent record</value>
    </values>
    <values>
        <field>clm__Target__c</field>
        <value xsi:type="xsd:string">This record</value>
    </values>
    <values>
        <field>clm__WorkflowId__c</field>
        <value xsi:type="xsd:string">ConfirmTransfer</value>
    </values>
    <values>
        <field>clm__sObjectRelated__c</field>
        <value xsi:type="xsd:string">Transfer__c</value>
    </values>
</CustomMetadata>
