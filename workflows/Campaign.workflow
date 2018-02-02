<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>NonTargeted_WF</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Non_Targeted</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>NonTargeted WF</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Call_Center_Unique_Identifier</fullName>
        <field>Call_Center_Unique_Identifier__c</field>
        <formula>IF( 
AND(NOT(ISBLANK(Call_Center_Identifier__c)), NOT(ISBLANK(Campaign_Toll_Free_Number__c))), 
Call_Center_Identifier__c +&quot; : &quot;+Campaign_Toll_Free_Number__c, 
null 
)</formula>
        <name>Update Call Center Unique Identifier</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Targeted_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Targeted</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Targeted Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Call Center Unique Identifier</fullName>
        <actions>
            <name>Update_Call_Center_Unique_Identifier</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow rule will update the unique field on Campaign on the basis of toll free number and call center identifier</description>
        <formula>IF(  OR(     ISNEW(), 	OR( 	   PRIORVALUE(Campaign_Toll_Free_Number__c)!=Campaign_Toll_Free_Number__c, 	   PRIORVALUE(Call_Center_Identifier__c)!=Call_Center_Identifier__c 	)  ),  true,  false   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update RecordType Targeted</fullName>
        <actions>
            <name>Update_Targeted_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Campaign.boundary_criteria__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UpdateCampaignRecordTypeNonTargeted</fullName>
        <actions>
            <name>NonTargeted_WF</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Campaign.boundary_criteria__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
