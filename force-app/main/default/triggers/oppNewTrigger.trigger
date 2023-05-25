trigger oppNewTrigger on Opportunity (after update) {
          oppTriggerHandler.mainHandle(Trigger.new,Trigger.old);
}