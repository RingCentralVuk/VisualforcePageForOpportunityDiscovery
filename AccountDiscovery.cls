public with sharing class AccountDiscoveryController {
    Transient List<Lead_Qualification__c> allLeadQualList{get;set;}
    public Lead_Opportunity__c leadQualificationObj{get;set;}
    public Account acct{get;set;}
    public string viewMode{get;set;}
    public String redirectUrl{get;set;}
    public AccountDiscoveryController(ApexPages.StandardController controller) {
        //property to hold parent view url to solve cross domain issue
        redirectUrl = controller.view().getUrl();
        acct = (Account)controller.getRecord();
        if(acct != null && !String.isBlank(acct.Id)) {
            allLeadQualList = new List<Lead_Qualification__c>();
            leadQualificationObj = new Lead_Qualification__c();
            allLeadQualList = [select Id, Discovery_Notes__c from Lead_Qualification__c where Opportunity__c = : opp.ID
                                ORDER BY LastModifiedDate DESC LIMIT 1];
            if(allLeadQualList.size() >0){
                  leadQualificationObj = allLeadQualList.get(0);
                  viewMode = 'read';
            }else{
                viewMode = 'edit';
            }
        }
        else{
            viewMode = 'edit';
        }
        
  //--------------methods to controll read or write mode of page
blic void showEdit(){
  view mode = 'edit';
  
blic void hideEdit(){
  view mode = 'read';
  
  //--------------override method save
blic void save(){
  //----------updating current opportunity record
  update opp;
  //---------updating or creating leadQualificaiton record
  leadQualificationObj.Opportunity__c = opp.Id;
  upsert leadQualificationObj;
  viewMode = 'read';
                  
