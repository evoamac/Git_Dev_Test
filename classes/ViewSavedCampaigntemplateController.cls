//***************************
//Created by :- Shivangi Mehra
//Date :- 
//Purpose:- 
//**************************


public class ViewSavedCampaigntemplateController 
{
    private integer totalRecs = 0;
    public Campaign cc{get;set;}
    public string searchString{get;set;} // search keyword
    public list<Campaign> clist{get;set;}
    public List<Campaign> results{get;set;}
    public boolean tableflag{get;set;}
   // public List<Campaign> lstcampaign {get;set;}
    
    public ViewSavedCampaigntemplateController(ApexPages.StandardController controller)
    {
        cc=new Campaign();      
        searchString=system.currentPageReference().getParameters().get('lksrch');   
        results = new List<Campaign>(); 
        runSearch(); 
    }
    
    // prepare the query and issue the search command
    private void runSearch() 
     {
    // TODO prepare query string for complex serarches & prevent injections
    results = performSearch(searchString);  
              system.debug('results========'+ results);
              if(results.isEmpty()){
              system.debug('i am in null results');
              tableflag= true;
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No such template exists !!'));
               
               }
              
    } 
    
    public List<campaign> getCamp()
    {
        list<Campaign> clist=new List<Campaign>();
        clist=[select name,status,Program_Name__c,StartDate,CreatedBy.name,CreatedDate,Channel__c from campaign where Save_Campaign_as_Template__c=true];
        system.debug('$$$$$'+clist);
        return clist;
    }
    
    // run the search and return the records found. 
 
  private List<campaign> performSearch(string searchString) 
  {

    String soql = 'select id,name,status,Program_Name__c,StartDate,CreatedBy.name,CreatedDate,Channel__c from campaign where Save_Campaign_as_Template__c=true';
    if(searchString != '' && searchString != null)
    soql = soql +  ' and name LIKE \'%' + searchString +'%\'';
    soql = soql + ' limit 50';
    System.debug(soql);
   return database.query(soql); 
   
  }


  // performs the keyword search
  public PageReference Search() 
  {
      try{
    runSearch();
      }
      catch(Exception ex) { 
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No such template exists !!'));
      }
    return null;
  }
    
    
    
  // used by the visualforce page to send the link to the right dom element
  public string getFormTag() 
  {
    return System.currentPageReference().getParameters().get('frm');
  }
    
  // used by the visualforce page to send the link to the right dom element for the text box
  public string getTextBox() 
  {
    return System.currentPageReference().getParameters().get('txt');
  }

}