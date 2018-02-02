@isTest

public class Contact_BeforeUpdate_Test 
{
    static testmethod void testContactChange() 
    {
        Contact con = new Contact();
        con.SyncToMarketo__c = false;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);
        datetime.newInstance(2014, 9, 15, 12, 30, 0);

        insert con;

        con.SyncToMarketo__c = false;
        con.Title = 'Dr.';
        con.MailingStreet = 'UpdatedStreet1';
        con.MailingState = 'UpdatedState1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'UpdatedUS';
        con.MailingCity = 'UpdatedCity1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);
        con.SyncToMarketo_LastModifiedOn__c = datetime.newInstance(2014, 9, 27, 12, 30, 0);

        Test.startTest();
        Update con;
        Test.stopTest();

    }

    static testmethod void testContactChange1() 
    {
        Contact con = new Contact();
        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);
        insert con;

        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'UpdatedStreet1';
        con.MailingState = 'UpdatedState1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'UpdatedUS';
        con.MailingCity = 'UpdatedCity1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);

        Test.startTest();
        Update con;
        Test.stopTest();

    }

    static testmethod void testContactChange2() 
    {
        Contact con = new Contact();
        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);
        insert con;

        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'UpdatedState1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'UpdatedUS';
        con.MailingCity = 'UpdatedCity1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);

        Test.startTest();
        Update con;
        Test.stopTest();

    }

    static testmethod void testContactChange3() 
    {
        Contact con = new Contact();
        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);
        insert con;

        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '5470200';
        con.MailingCountry = 'UpdatedUS';
        con.MailingCity = 'UpdatedCity1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);

        Test.startTest();
        Update con;
        Test.stopTest();

    }

    static testmethod void testContactChange4() 
    {
        Contact con = new Contact();
        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);
        insert con;

        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'UpdatedUS';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);

        Test.startTest();
        Update con;
        Test.stopTest();

    }

    static testmethod void testContactChange5() 
    {
        Contact con = new Contact();
        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);
        insert con;

        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'Updatedabc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);

        Test.startTest();
        Update con;
        Test.stopTest();

    }

    static testmethod void testContactChange6() 
    {
        Contact con = new Contact();
        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);
        insert con;

        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'UpdatedABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);

        Test.startTest();
        Update con;
        Test.stopTest();

    }

    static testmethod void testContactChange7() 
    {
        Contact con = new Contact();
        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);
        insert con;

        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'UpdatedMiddle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);

        Test.startTest();
        Update con;
        Test.stopTest();

    }

    static testmethod void testContactChange8() 
    {
        Contact con = new Contact();
        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);
        insert con;

        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'UpdatedStreet1';
        con.MailingState = 'UpdatedState1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'UpdatedUS';
        con.MailingCity = 'UpdatedCity1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Ms.';
        con.Suffix = 'Updatedsuf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);

        Test.startTest();
        Update con;
        Test.stopTest();

    }

    static testmethod void testContactChange9() 
    {
        Contact con = new Contact();
        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);
        insert con;

        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '09876542300';
        con.Email = 'dev@hotmail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);

        Test.startTest();
        Update con;
        Test.stopTest();

    }

    static testmethod void testContactChange10() 
    {
        Contact con = new Contact();
        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);
        insert con;

        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'F';
        con.Birthdate = date.newInstance(2014, 9, 15);

        Test.startTest();
        Update con;
        Test.stopTest();

    }

    static testmethod void testContactChange11() 
    {
        Contact con = new Contact();
        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);
        insert con;

        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2010, 9, 15);

        Test.startTest();
        Update con;
        Test.stopTest();
    }
    
    static testmethod void testContactChange12()
    {
        Contact con = new Contact();
        con.SyncToMarketo__c = true;
        con.Title = 'Dr.';
        con.MailingStreet = 'Street1';
        con.MailingState = 'State1';
        con.MailingPostalCode = '54702';
        con.MailingCountry = 'US';
        con.MailingCity = 'City1';
        con.LastName = 'abc12';
        con.FirstName = 'ABC';
        con.MiddleName = 'Middle';
        con.Salutation = 'Mr.';
        con.Suffix = 'suf';
        con.Phone = '098765423';
        con.Email = 'dev@mail.com';
        con.hospitalCode__c = 'SCH';
        con.Resolved_Gender_Code__c = 'M';
        con.Birthdate = date.newInstance(2014, 9, 15);
        con.Living_Well__c = 0;
        con.AML_Generations_2_0__c = 'a';
        con.Ethnicity__c = 'abc';
        con.AML_Presence_of_Elderly_Parent__c = false;
        con.AML_Presence_of_Children__c = 'N';
        insert con;

        Test.startTest();
        con.Living_Well__c = 1;
        Update con;
        
        con.AML_Generations_2_0__c = 'b';
        update con;
        
        con.Ethnicity__c = 'bcd';
        update con;
        
        con.AML_Presence_of_Elderly_Parent__c = true;
        update con;
        
        con.AML_Presence_of_Children__c = 'Y';
        update con;
        
        Test.stopTest();
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}