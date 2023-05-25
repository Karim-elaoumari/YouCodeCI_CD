public class oppSecondHandler{
  @future(callout=true)
  public static void mainHandler(List<Id> oppsIds){
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('http://apilayer.net/api/live?access_key=6452fd6e6bcf4b2c3bb6768508d5449c&currencies=EUR,MAD,CAD,PLN&source=USD&format=1');
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            fromJSON res = (fromJSON) JSON.deserialize(response.getBody(), fromJSON.class);
            try{
               Double exchangeRate = res.quotes.USDMAD;
               System.debug('this success');
               System.enqueueJob(new QueueableUpdateOppsExchangeRate(oppsIds,exchangeRate));
            }catch(Exception e){
                    System.debug('no return from api');
            }
            
           
     }
    public class fromJSON{
	
	public cls_quotes quotes;
    }
	class cls_quotes {
		
		public Double USDMAD;	
		
	}
}