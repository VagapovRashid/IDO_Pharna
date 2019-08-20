<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>Create Audit 1</label>
    <protected>false</protected>
    <values>
        <field>clm__Action__c</field>
        <value xsi:type="xsd:string">Create record</value>
    </values>
    <values>
        <field>clm__FieldAPIName__c</field>
        <value xsi:type="xsd:string">CTPHARMA__ProductId__c,Assortment_Line_Item__c</value>
    </values>
    <values>
        <field>clm__FieldAPINames__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>clm__FieldValue__c</field>
        <value xsi:type="xsd:string">$query.Pharma_Product__c,$query.id</value>
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
        <value xsi:type="xsd:string">CTPHARMA__Activity__c</value>
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
        <value xsi:type="xsd:string">CTPHARMA__ActivityId__c</value>
    </values>
    <values>
        <field>clm__SOQLObjectAPIName__c</field>
        <value xsi:type="xsd:string">CORE_AssortmentLineItem__c</value>
    </values>
    <values>
        <field>clm__SOQLQuery__c</field>
        <value xsi:type="xsd:string">where Account__c = $sObject.CTPHARMA__AccountId__c</value>
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
        <value xsi:type="xsd:string">Related records</value>
    </values>
    <values>
        <field>clm__Target__c</field>
        <value xsi:type="xsd:string">This record</value>
    </values>
    <values>
        <field>clm__WorkflowId__c</field>
        <value xsi:type="xsd:string">Start_Audit</value>
    </values>
    <values>
        <field>clm__sObjectRelated__c</field>
        <value xsi:type="xsd:string">CTPHARMA__ActivityData__c</value>
    </values>
</CustomMetadata>
