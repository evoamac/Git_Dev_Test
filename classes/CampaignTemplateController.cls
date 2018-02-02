//***************************
//Created by :- Shivangi Mehra, Nancy
//Date :- 31st August,2016
//Purpose:- To save & search Campaign Template
//*********************************************
public class CampaignTemplateController 
{
    /*******Object Decalartion ****/
    public campaign c{get;set;}
    
    /*****List Declaration ******/    
    public List<Campaign> campList{get;set;}
    public List<Campaign> campList1{get;set;}
    public List<Campaign> camp_save_list{get;set;}
    public List<SelectOption> SelectedSubServLines{get;set;}
    public List<SelectOption> AllSubServLines{get;set;}
    
    /******Other Declaration ****/
    public pagereference ref;
    public boolean TempFlag;
    public boolean ButtonFlag;

    public CampaignTemplateController(ApexPages.StandardController controller)
    {
        TempFlag=false;
        c=new campaign();
        campList1=new List<Campaign>();
        campList1=[select name,status,Program_Name__c from campaign where Save_Campaign_as_Template__c=true];      
    }
    
   public void getSavedTemplate()
   {
       list<Campaign> campTemp=Database.query('select name,status,Program_Name__c from campaign where Save_Campaign_as_Template__c=true');
       system.debug('######'+campTemp);
   }    
    public void TemplateSelection()
    {
        campList=new List<Campaign>();
        camp_save_list=new List<Campaign>(); 
        campList=[select name,status,Program_Name__c from campaign where Save_Campaign_as_Template__c=true];
        system.debug('%%%%list of camp'+campList);
       
           for(Campaign c:campList)
           {
               system.debug('$$$$camp'+c);
               camp_save_list.add(c);              
           }
           system.debug('&&&&&& ^^^^camp_save_list' + camp_save_list);
            
    }
        
    public pagereference SaveCamp()
    {   
        // Channel and vendor changes ref data validation  
          if(c.id!=null || c.id!='')
          {
            if(CampaignWizardController.BeforeCloneValidation(c.id))//Inactive validation change 
            {  
                TempFlag=true;
                ref = new pagereference('/apex/CampaignWizard?Id='+c.id+'&flag='+TempFlag);
                system.debug('--%%%%%%%'+ref);
                ref.setredirect(true); 
            }
            else
            { 
                 return null;         
            }          
        }
        return ref;
        // Channel and vendor changes ref data validation 
    }
 
}