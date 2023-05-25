public class oppTriggerHandler {
    public static void mainHandle(List<Opportunity> newOpps,List<Opportunity> oldOpps){
            List<Id> oppsToHandleIds = new List<Id>();
            for(Integer i =0; i<newOpps.size();i++){
                if(newOpps[i].StageName == 'Closed Won' && oldOpps[i].StageName!= 'Closed Won'){
                    oppsToHandleIds.add(newOpps[i].Id);
                }
            }
           oppSecondHandler.mainHandler(oppsToHandleIds);
    }



}