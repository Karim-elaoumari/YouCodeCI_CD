public class OppAttachementPdfController {
    public List<OpportunityLineItem> getopportunityProducts(){
        String opportunityId = ApexPages.currentPage().getParameters().get('opportunityId');
        List<OpportunityLineItem> opportunityProducts = new List<OpportunityLineItem>([SELECT Name, Quantity, UnitPrice, TotalPrice FROM OpportunityLineItem WHERE OpportunityId = :opportunityId]); 
        return  opportunityProducts;
    }
}