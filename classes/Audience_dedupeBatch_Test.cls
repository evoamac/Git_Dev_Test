@istest
public class Audience_dedupeBatch_Test {
    
    public static testmethod void batchmethod1(){
        Database.QueryLocator QL;
        Database.BatchableContext BC;
        Campaign camp = marketingDataUtils.campforhomeaddress();
        
        
        
        CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(camp.id);
        
        
        
        CRM_AudienceReport__c  audiencereport = marketingDataUtils.createaudiencereport(camp.id,audiencejunction.id );
         
        
        
        Set<id> juncid = new Set<id>();
        juncid.add(audiencejunction.Id);
       
        
        Set<String> Wid = new Set<String>();
        Wid.add(camp.id);
        
        
         List<CRM_AudienceReport__c> uRe= new List<CRM_AudienceReport__c>();
         uRe.add(audiencereport);
        
        test.startTest();
        
        Audience_dedupeBatch dedupbat = new Audience_dedupeBatch(camp, juncid, Wid);
        dedupbat.isReset=false;
        database.executeBatch(dedupbat);
       dedupbat.execute(BC, uRe);
        
        test.stopTest();
            
    }
    
    
    public static testmethod void batchmethod2(){
        Database.QueryLocator QL;
        Database.BatchableContext BC;
        Campaign camp = marketingDataUtils.campforhomeaddress();
        camp.CRM_WundermanDuplicateCount__c=10000;
        update camp;
        
         Campaign newCampaign = new Campaign();
        newCampaign.Name='NewTestCampaign';
        newCampaign.Service_Line__c='Burn';
        newCampaign.Audience_Region__c='Texas';
        newCampaign.Channel__c='Direct Mail';
        newCampaign.Add_Member_Status__c = 'Added Members';
        newCampaign.Member_Types__c='One or more encounters - Patients';
        newCampaign.CRM_ParentSegmentedCampaign__c = camp.id;
        insert newCampaign;
        
        CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(camp.id);
          
        CRM_AudienceReport__c  audiencereport = marketingDataUtils.createaudiencereport(camp.id,audiencejunction.id );
         
        Set<id> juncid = new Set<id>();
        juncid.add(audiencejunction.Id);
        
        
        
        test.startTest();
        Audience_dedupeBatch dedupbat1 = new Audience_dedupeBatch(newCampaign, juncid);
        database.executeBatch(dedupbat1);
        test.stopTest();
            
    }
    
    public static testmethod void testmethod1(){
    Campaign camp = marketingDataUtils.campforhomeaddress();
        camp.Current_count__c=11974;
        camp.Supp_Count__c=1752;
        camp.Missing_Contact_Count__c=0;
        update camp;
         Campaign newCampaign = new Campaign();
        newCampaign.Name='NewTestCampaign';
        newCampaign.Service_Line__c='Burn';
        newCampaign.Audience_Region__c='Texas';
        newCampaign.Channel__c='Direct Mail';
        newCampaign.Add_Member_Status__c = 'Added Members';
        newCampaign.CRM_ParentSegmentedCampaign__c = camp.id;
        insert newCampaign;
         CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(camp.id);
         CRM_AudienceReport__c  audiencereport = marketingDataUtils.createaudiencereport(camp.id,audiencejunction.id );
         
                  
         Transaction__c Transtion = new Transaction__c();
           Transtion.Campaign__c = newCampaign.Id;
           Transtion.Type__c='GetOrderData';
           Transtion.Campaign_Member_Status__c='Ready to Process';
          
           Transtion.WM_List_Order_Id__c=newCampaign.List_Order_Id__c;
           Transtion.Response_Schema__c ='48190076,32961776,77365299,49804966,49779591,49226389,34399866,32780149,34088888,76045592,32597215,34439501,48258402,33893709,31754832,34518355,47411953,78790536,35030579,49335589,72875695,34485765,48998146,32817023,35018683,32140790,34219158,30576987,35486554,33970843,35541999,49657574,32185086,32119976,32409784,74656179,33580438,32175850,48035607,34358223,31968257,35235239,32441367,47935653,31970916,47921930,32546027,34040297,48173996,32442155,35429921,34402182,33093610,33570837,47208883,49665731,33830002,48240693,77183098,49909925,33701649,32485119,32192927,47455171,50076190,69156947,33977096,34848333,30577282,77143770,31050081,48682935,48264295,49513852,30560830,48683089,35179409,49041912,77370602,33004602,48672537,49537398,47849930,50015192,30535983,30782326,35259227,32861735,70694887,75448007,49197206,35542287,31062730,49110591,32087714,33866294,49014004,49918528,35018582,33000362,35137240,49659329,34125602,32285773,33027489,34486173,32732994,47651553,50059922,35319966,31727680,49031704,32153675,33046301,35208910,32616661,35318546,75616368,35874822,33483185,47525778,49430538,78175023,35014003,32502503,33181259,35934994,33474042,48738369,49820686,30762456,49409473,33227877,33594422,32876755,35276069,48328801,32713740,34187462,50066537,49206746,33177892,34750443,48190330,49548766,32689775,32531560,35820708,49050871,77768475,48817556,77510202,49126716,33916036,31904359,49522959,47817950,49081642,34846200,47593937,50213040,32191770,48268844,31844738,68564828,33967493,70433244,34717752,33160361,33021681,49826650,73601401,49085986,49813767,31065158,49304816,32886704,78029820,31524761,31217478,32141327,31293458,48086701,49320263,33269398,49372810,33360943,31607662,48973040,34713444,48936152,30488192,48966858,47270091,32630390,49289649,49180555,31703427,48121333,47502957,35194902,47508453,47260848,31968753,48543402,50136508,33698348,78142649,49372594,30521545,49810585,49831049,47375733,80032670,49015059,49683797,33826618,69308591,37386890,33841950,49550638,69160847,49078496,48814169,33852001,77056877,75862528,33384564,35053185,49395048,49098917,33850105,37378087,35515736,35325583,48254342,75238301,74855956,48323899,48273777,33375682,50025412,48930232,33877722,73981235,75841637,32169095,49039989,35070437,47816506,35306460,47634561,33910389,48498114,47613085,48206791,49661473,69248393,70692432,49615727,49780091,33011006,48581813,33208239,32276854,47261968,31560793,35240034,48358098,33319165,48505045,49056346,48921038,49665180,49163508,32865875,49163132,50017163,48755784,48472283,32626408,36022946,48231600,32223346,48266513,49070818,49777524,72631188,49848328,50019558,49431319,32234702,35859699,49447010,32939006,33824233,35333331,47298462,33376697,33778773,49893452,47920747,49867085,47876200,75768164,35274914,49418083,34575941,31294248,49064721,33993456,32245874,48320283,31954690,47816486,33832581,30811414,70137394,33920600,48973341,47648812,35234945,49713065,47383556,32540995,34409521,49192321,34675522,47870220,47991939,32140144,77155976,35025179,61077000,49250116,31996517,49538638,79936171,79563682,32221234,77339845,49516725,32917361,49197811,35332641,47368629,47415976,49867196,49672638,31948366,33909279,48763330,74901224,33581394,34229282,34637412,32444686,48600091,47655262,38897229,50000625,49064138,35429348,30878919,33128411,30769443,35095561,78467380,49397194,50155497,78315904,69242204,49763353,32041976,34278935,34282352,48724098,47602513,49436573,33781707,32936066,33367369,38921052,49682853,35868432,33966084,32142208,32158455,37257799,30490143,49866925,33655717,49924619,30694022,33666223,49496234,32090147,33973639,34019718,35219223,49424720,48302104,33297926,32820721,49912382,77372580,77137403,47702800,50011884,35557935,34496398,48284953,75905677,48374460,74059736,77070335,48955551,32055678,49682412,31011944,33298544,49112186,32663301,34347986,48613876,47750348,31011854,34256978,35415036,49051634,32173389,48249321,34126797,50039563,49554177,75239275';
            insert Transtion;
        
          Transaction__c Transtion1 = new Transaction__c();
           Transtion1.Campaign__c = newCampaign.Id;
           Transtion1.Type__c='GetOrderData';
           Transtion1.Campaign_Member_Status__c='Ready to Process';
          
           Transtion1.WM_List_Order_Id__c=newCampaign.List_Order_Id__c;
           Transtion1.Response_Schema__c ='48190076,8450244,707152,8411789,7539682,8643247,3591515,8055855,7582727,7426668,8053773,273894,3764750,8530130,8482055,6646945,7815588,7612175,1504753,8040258,8312081,8091610,8446503,4248767,8083936,8410845,8202990,4054018,7683372,7547795,7750790,4211914,5198194,2047358,7612853,7829930,8377723,2575566,7569529';
            insert Transtion1;
        
        Transaction__c Transtion2 = new Transaction__c();
           Transtion2.Campaign__c = newCampaign.Id;
           Transtion2.Type__c='GetOrderData';
           Transtion2.Campaign_Member_Status__c='Ready to Process';
          
           Transtion2.WM_List_Order_Id__c=newCampaign.List_Order_Id__c;
           Transtion2.Response_Schema__c ='7567093,8450244,707152,8411789,7539682,8643247,3591515,8055855,7582727,7426668,8053773,273894,3764750,8530130,8482055,6646945,7815588,7612175,1504753,8040258,8312081,8091610,8446503,4248767,8083936,8410845,8202990,4054018,7683372,7547795,7750790,4211914,5198194,2047358,7612853,7829930,8377723,2575566,7569529';
            insert Transtion2;
         map<id,Decimal> campIdListOrderIdMap = new map<id,Decimal>();
         campIdListOrderIdMap.put(camp.Id, camp.List_Order_Id__c);
         campaign segmentCampaign= camp;
         
         Set<id> juncid = new Set<id>();
        juncid.add(audiencejunction.Id);
         
         List<CRM_AudienceReport__c> uRe= new List<CRM_AudienceReport__c>();
         uRe.add(audiencereport);
         
        Set<String> Wid = new Set<String>();
        Wid.add('7567093');
        Wid.add('32961776');
         
        map<string,integer> wIdDuplicateCountMap = new map<string,integer>();
        wIdDuplicateCountMap.put('7567093',1);
        wIdDuplicateCountMap.put('32961776', 2);
         
         Audience_dedupeHelper.manageContactIdDeDuping(camp.Id);
         Audience_dedupeHelper.resetAuReportDuplicate(uRe, newCampaign);
         
         Audience_dedupeHelper.countDeuplicateWundermanIds(campIdListOrderIdMap);
         
         
         test.startTest();
        
    
        
        database.executeBatch(new Audience_dedupeBatch(camp, juncid, Wid),2000);
         
         test.stopTest();
         
             }
    
     public static testmethod void testmethod2(){
      
         Campaign camp = marketingDataUtils.campforhomeaddress();
          camp.Current_count__c=11974;
        camp.Supp_Count__c=1752;
        camp.Missing_Contact_Count__c=0;
        camp.Control_Group_Percentage__c = 5;
        update camp;
        Campaign newCampaign = new Campaign();
        newCampaign.Name='NewTestCampaign';
        newCampaign.Service_Line__c='Burn';
        newCampaign.Audience_Region__c='Texas';
        newCampaign.Channel__c='Direct Mail';
        newCampaign.Add_Member_Status__c = 'Added Members';
        newCampaign.CRM_ParentSegmentedCampaign__c = camp.id;
        insert newCampaign;
         CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(camp.id);
         CRM_AudienceReport__c  audiencereport = marketingDataUtils.createaudiencereport(camp.id,audiencejunction.id );
         
        
          
         
          Transaction__c Transtion = new Transaction__c();
           Transtion.Campaign__c = newCampaign.Id;
           Transtion.Type__c='GetOrderData';
           Transtion.Campaign_Member_Status__c='Ready to Process';
          
           Transtion.WM_List_Order_Id__c=newCampaign.List_Order_Id__c;
           Transtion.Response_Schema__c ='48190076,32961776,77365299,49804966,49779591,49226389,34399866,32780149,34088888,76045592,32597215,34439501,48258402,33893709,31754832,34518355,47411953,78790536,35030579,49335589,72875695,34485765,48998146,32817023,35018683,32140790,34219158,30576987,35486554,33970843,35541999,49657574,32185086,32119976,32409784,74656179,33580438,32175850,48035607,34358223,31968257,35235239,32441367,47935653,31970916,47921930,32546027,34040297,48173996,32442155,35429921,34402182,33093610,33570837,47208883,49665731,33830002,48240693,77183098,49909925,33701649,32485119,32192927,47455171,50076190,69156947,33977096,34848333,30577282,77143770,31050081,48682935,48264295,49513852,30560830,48683089,35179409,49041912,77370602,33004602,48672537,49537398,47849930,50015192,30535983,30782326,35259227,32861735,70694887,75448007,49197206,35542287,31062730,49110591,32087714,33866294,49014004,49918528,35018582,33000362,35137240,49659329,34125602,32285773,33027489,34486173,32732994,47651553,50059922,35319966,31727680,49031704,32153675,33046301,35208910,32616661,35318546,75616368,35874822,33483185,47525778,49430538,78175023,35014003,32502503,33181259,35934994,33474042,48738369,49820686,30762456,49409473,33227877,33594422,32876755,35276069,48328801,32713740,34187462,50066537,49206746,33177892,34750443,48190330,49548766,32689775,32531560,35820708,49050871,77768475,48817556,77510202,49126716,33916036,31904359,49522959,47817950,49081642,34846200,47593937,50213040,32191770,48268844,31844738,68564828,33967493,70433244,34717752,33160361,33021681,49826650,73601401,49085986,49813767,31065158,49304816,32886704,78029820,31524761,31217478,32141327,31293458,48086701,49320263,33269398,49372810,33360943,31607662,48973040,34713444,48936152,30488192,48966858,47270091,32630390,49289649,49180555,31703427,48121333,47502957,35194902,47508453,47260848,31968753,48543402,50136508,33698348,78142649,49372594,30521545,49810585,49831049,47375733,80032670,49015059,49683797,33826618,69308591,37386890,33841950,49550638,69160847,49078496,48814169,33852001,77056877,75862528,33384564,35053185,49395048,49098917,33850105,37378087,35515736,35325583,48254342,75238301,74855956,48323899,48273777,33375682,50025412,48930232,33877722,73981235,75841637,32169095,49039989,35070437,47816506,35306460,47634561,33910389,48498114,47613085,48206791,49661473,69248393,70692432,49615727,49780091,33011006,48581813,33208239,32276854,47261968,31560793,35240034,48358098,33319165,48505045,49056346,48921038,49665180,49163508,32865875,49163132,50017163,48755784,48472283,32626408,36022946,48231600,32223346,48266513,49070818,49777524,72631188,49848328,50019558,49431319,32234702,35859699,49447010,32939006,33824233,35333331,47298462,33376697,33778773,49893452,47920747,49867085,47876200,75768164,35274914,49418083,34575941,31294248,49064721,33993456,32245874,48320283,31954690,47816486,33832581,30811414,70137394,33920600,48973341,47648812,35234945,49713065,47383556,32540995,34409521,49192321,34675522,47870220,47991939,32140144,77155976,35025179,61077000,49250116,31996517,49538638,79936171,79563682,32221234,77339845,49516725,32917361,49197811,35332641,47368629,47415976,49867196,49672638,31948366,33909279,48763330,74901224,33581394,34229282,34637412,32444686,48600091,47655262,38897229,50000625,49064138,35429348,30878919,33128411,30769443,35095561,78467380,49397194,50155497,78315904,69242204,49763353,32041976,34278935,34282352,48724098,47602513,49436573,33781707,32936066,33367369,38921052,49682853,35868432,33966084,32142208,32158455,37257799,30490143,49866925,33655717,49924619,30694022,33666223,49496234,32090147,33973639,34019718,35219223,49424720,48302104,33297926,32820721,49912382,77372580,77137403,47702800,50011884,35557935,34496398,48284953,75905677,48374460,74059736,77070335,48955551,32055678,49682412,31011944,33298544,49112186,32663301,34347986,48613876,47750348,31011854,34256978,35415036,49051634,32173389,48249321,34126797,50039563,49554177,75239275';
            insert Transtion;
        
          Transaction__c Transtion1 = new Transaction__c();
           Transtion1.Campaign__c = newCampaign.Id;
           Transtion1.Type__c='GetOrderData';
           Transtion1.Campaign_Member_Status__c='Ready to Process';
          
           Transtion1.WM_List_Order_Id__c=newCampaign.List_Order_Id__c;
           Transtion1.Response_Schema__c ='7567093,8450244,707152,8411789,7539682,8643247,3591515,8055855,7582727,7426668,8053773,273894,3764750,8530130,8482055,6646945,7815588,7612175,1504753,8040258,8312081,8091610,8446503,4248767,8083936,8410845,8202990,4054018,7683372,7547795,7750790,4211914,5198194,2047358,7612853,7829930,8377723,2575566,7569529';
            insert Transtion1;
        
        Transaction__c Transtion2 = new Transaction__c();
           Transtion2.Campaign__c = newCampaign.Id;
           Transtion2.Type__c='GetOrderData';
           Transtion2.Campaign_Member_Status__c='Ready to Process';
          
           Transtion2.WM_List_Order_Id__c=newCampaign.List_Order_Id__c;
           Transtion2.Response_Schema__c ='7567093,8450244,707152,8411789,7539682,8643247,3591515,8055855,7582727,7426668,8053773,273894,3764750,8530130,8482055,6646945,7815588,7612175,1504753,8040258,8312081,8091610,8446503,4248767,8083936,8410845,8202990,4054018,7683372,7547795,7750790,4211914,5198194,2047358,7612853,7829930,8377723,2575566,7569529';
            insert Transtion2;
         
         
         map<id,Decimal> campIdListOrderIdMap = new map<id,Decimal>();
         campIdListOrderIdMap.put(camp.Id, camp.List_Order_Id__c);
         campaign segmentCampaign= camp;
         
 		Set<id> juncid = new Set<id>();
        juncid.add(audiencejunction.Id);
         
         List<CRM_AudienceReport__c> uRe= new List<CRM_AudienceReport__c>();
         uRe.add(audiencereport);
         
        Set<String> Wid = new Set<String>();
        Wid.add('7567093');
        Wid.add('32961776');
         
        map<string,integer> wIdDuplicateCountMap = new map<string,integer>();
        wIdDuplicateCountMap.put('7567093',1);
        wIdDuplicateCountMap.put('32961776', 2);
        
         
         Audience_dedupeHelper helper = new Audience_dedupeHelper();
         Audience_dedupeHelper.manageContactIdDeDuping2(camp.Id);
         Audience_dedupeHelper.resetAuReportDuplicateHandler(camp.id);
         Audience_dedupeHelper.manageDedupe(camp,uRe, '7567093');
         test.startTest();
         
        
        
        database.executeBatch(new Audience_dedupeBatch(camp, juncid, Wid),2000);
         
         test.stopTest();
         
             }
    
    public static testmethod void testmethod3(){
      
         Campaign camp = marketingDataUtils.campforhomeaddress();
          camp.Current_count__c=11974;
        camp.Supp_Count__c=1752;
        camp.Missing_Contact_Count__c=0;
        camp.CRM_WundermanDuplicateCount__c=5600;
        update camp;
        Campaign newCampaign = new Campaign();
        newCampaign.Name='NewTestCampaign';
        newCampaign.Service_Line__c='Burn';
        newCampaign.Audience_Region__c='Texas';
        newCampaign.Channel__c='Direct Mail';
        newCampaign.Add_Member_Status__c = 'Added Members';
        newCampaign.Member_Types__c='One or more encounters - Patients';
        newCampaign.CRM_ParentSegmentedCampaign__c = camp.id;
        insert newCampaign;
         CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(newCampaign.id);
         CRM_AudienceReport__c  audiencereport = marketingDataUtils.createaudiencereport(camp.id,audiencejunction.id );
         
        
        Set<ID> auIdSet = new Set<Id>();
        auIdSet.add(audiencejunction.id);
        
        Audience_dedupeHelper.resetAuReportDuplicateHandler(newCampaign.id);
        
        
        
    }
}