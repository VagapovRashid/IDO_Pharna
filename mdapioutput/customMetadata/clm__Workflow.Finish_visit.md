<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>Workflow on Finish Visit button</label>
    <protected>false</protected>
    <values>
        <field>clm__ButtonAPIName__c</field>
        <value xsi:type="xsd:string">CTM.Button.FinishActivity</value>
    </values>
    <values>
        <field>clm__Description__c</field>
        <value xsi:type="xsd:string">Workflow on &apos;Finish&apos; button click on the Activity object. Works only for activity record type = &apos;Visit&apos; AND activity status = In Progress</value>
    </values>
    <values>
        <field>clm__EvaluationCriteria__c</field>
        <value xsi:type="xsd:string">Any time it&apos;s edited to subsequently meet criteria</value>
    </values>
    <values>
        <field>clm__IsActive__c</field>
        <value xsi:type="xsd:boolean">true</value>
    </values>
    <values>
        <field>clm__ObjectAPIName__c</field>
        <value xsi:type="xsd:string">CTPHARMA__Activity__c</value>
    </values>
    <values>
        <field>clm__TriggerContext__c</field>
        <value xsi:type="xsd:string">On Click</value>
    </values>
    <values>
        <field>clm__TriggerCriteria__c</field>
        <value xsi:type="xsd:string">where CTPHARMA__Status__c = &apos;In Progress&apos;</value>
    </values>
</CustomMetadata>
