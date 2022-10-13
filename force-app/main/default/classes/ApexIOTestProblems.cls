/* This is my soloution for https://www.apexsandbox.io/problem/18
* 
*/

public with sharing class ApexIOTestProblems {
    public Boolean isTeenager(Integer age) {

        Integer testTeen = age;
        Boolean teenResult = null;
    
        if (testTeen  <= 19 && testTeen  >= 13){
            teenResult =  true;
    
            return teenResult;
        } else {
            teenResult =  false;
    
            return teenResult;
        }
    
    }
}

/* This is Mehdi's Solution:

* public Boolean isTeenager(Integer age) {
    return age > 12 && age < 20;
}

That's it. The whole thing.  wow!
*/