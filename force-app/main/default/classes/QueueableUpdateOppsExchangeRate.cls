public class QueueableUpdateOppsExchangeRate implements Queueable {
    private Double ExchangeRate;
    private List<Id> oppsIds;

    public QueueableUpdateOppsExchangeRate(List<Id> oppsIds, Double ExchangeRate) {
        this.ExchangeRate = ExchangeRate;
        this.oppsIds = oppsIds;
    }
    public void execute(QueueableContext context) {
        List<Opportunity> opps = new List<Opportunity>([ SELECT Id,AccountId,Name,Amount,StageName,OwnerId FROM Opportunity WHERE Id in :this.oppsIds ]);
          if(opps.size()>0 && !opps.isEmpty()){
              for(Opportunity opp: opps){
                opp.ExchangeRate__c = this.ExchangeRate;
              }
             update opps;
          }
        
    }
}