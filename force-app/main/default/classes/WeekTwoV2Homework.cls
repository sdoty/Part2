public with sharing class WeekTwoV2Homework {

    /*------------------Task a----------------------------------------*/
    public static void contactsWithAccounts() {
    
    // Task a: "Query a list of contacts that pulls Account name and Industry as well"
    // Before doing that, I am going to query the database to determine how many contacts are in my org, 
    // (In case thare are 32 million... :-) THEN i would run a limit in my query...) 
    
        System.debug('Number of Contacts in my dev org: ' + [SELECT count(ID) from Contact]);


    // "Turns out there are only 20 contacts in my org, so I will run this without LIMIT"
    // Per Pat - Best Practice is to always include a limit. 
    // Q: What should that limit be?, and what if I have more contacts than that?
    
        List<Contact> conWithAccts = [SELECT ID, FirstName, LastName, Account.Name, Account.Industry
                                      FROM Contact LIMIT 1000];

            for (Contact con : conWithAccts){
                System.debug ('Contact: ' + con.FirstName + ' ' + con.LastName + ' is linked to this Account: ' + con.Account.Name);
          }
      }


    /*-------------------Task b---------------------------------------*/
    // Task b: Method that returns a list of Accounts with all of their Closed-Won  Opptys.

    public static void acctsWithWonOpptys(){
    
        List<Account> acctWithClosedOpptys = [SELECT Id, Name,
                                             (SELECT Name FROM Opportunities WHERE IsWon = TRUE)                                
                                              FROM Account];

            // Use a loop to display all of the Opptys 
            for ( Account a : acctWithClosedOpptys){
                System.debug('Account ' + a.Name + ' Has these Closed-Won Oppty(s): ' + a.Opportunities);

            }
        }
        
    /*---------------------Task c-------------------------------------*/        
    // "A method that queries for Opportunity records that returns results in a map format."   
        
    public static void opptyMap (){

            Map <ID, Opportunity> opptyMap = new Map <ID, Opportunity>(
                                                      [SELECT ID, Name, StageName 
                                                      FROM Opportunity 
                                                      WHERE StageName = 'Closed Won']);
                                                      
        // The above returns the results in a map format, but I wanted to try to loop through and display the results in consecutive lines.
        // Got my reference from this link:
        // https://developer.salesforce.com/forums/?id=906F00000008xHJIAY
       
            System.debug('These are the names/values from the maps: ');
        for (Opportunity o : opptyMap.values()) {
            System.debug(o.Name);  
            }
        }
    
     
    /*---------------------Task d-------------------------------------*/      
    // "An aggregate results query that returns an integer equal to the total number of open opportunities in your org." 
    /* 
    * Commenting out this whole block and simplifying (Tho this would be the approach for a different ag result)
    * 
    * public static void allOpenOpptys (){

         AggregateResult[] numOpenOpptys = [SELECT Count(Id) total 
                                            FROM Opportunity 
                                            WHERE (IsClosed = FALSE OR IsWon = FALSE)];

        // Just printing the results and checking if the 'total' alias worked: 
        // System.debug(numOpenOpptys); 

        // I wanted this to work, but alas... the size of the Aggregate result is ONE.
        // Integer howManyOpenOpps = numOpenOpptys.size();
        

        for (AggregateResult ag : numOpenOpptys){
            System.debug('This is the number of open opptys in the org: ' + ag.get('total'));

            }
        */
        public static void allOpenOpptys (){

            System.debug('Number of open Opportunities in my org: ' + [SELECT count(ID) from Opportunity 
                                                                       WHERE IsClosed = FALSE]);

        }
    }