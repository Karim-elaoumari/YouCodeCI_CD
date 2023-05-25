public class oppSendEmails {
    @InvocableMethod(label='Send Emails to manager and related contact' description='' category='Opportunity')
    public static void sendEmails(List<Opportunity> opps){
        
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
          EmailTemplate emailTemp = [Select Id, Subject, Body From EmailTemplate Where DeveloperName = 'test_welcome'];
                    
                    Set<Id> accountIds = new Set<Id>();
                    Set<Id> ownerIds = new Set<Id>();
                    for (Opportunity opp:opps){
                        accountIds.add(opp.AccountId);
                        ownerIds.add(opp.OwnerId);
                    }
                    List<Contact> contacts = new List<Contact>([SELECT Id,Email FROM Contact WHERE AccountId IN :accountIds]);
                    List<User> users = new List<User>([SELECT Id,Email FROM User WHERE Id IN :ownerIds]);
                    for(Integer i=0;i<opps.size();i++){

                        System.debug('send mail start');
                        PageReference pageRef = Page.OppAttachmentPdf;
                        pageRef.getParameters().put('opportunityId', opps[i].Id); 
                        Blob pdfBlob = pageRef.getContentAsPDF();
                        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
                        attachment.setFileName('OpportunityProducts.pdf');
                        attachment.setBody(pdfBlob);
 
                        Messaging.SingleEmailMessage mail2 = new Messaging.SingleEmailMessage();
                        mail2.setTemplateId(emailTemp.Id);
                        mail2.setTargetObjectId(contacts[i].Id);
                        mail2.setWhatId(opps[i].Id);
                        mail2.setSaveAsActivity(false);
                        mail2.setToAddresses(new String[] {'elaoumarikarim@gmail.com'});
                        mail2.setFileAttachments(new Messaging.EmailFileAttachment[] {attachment});
                        emailList.add(mail2);
                    }
        
           if(!emailList.isEmpty()){
              Messaging.sendEmail(emailList);
               System.debug('emails sent');
           }  
        
    }    

}