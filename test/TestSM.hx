import sm.SM;

@:build(sm.SMBuilder.buildState("umltest"))
@:enum
abstract TestState(Int) from Int to Int {}

@:build(sm.SMBuilder.buildEvent("umltest"))
@:enum
abstract TestEvent(Int) from Int to Int {}

class TestSM  extends haxe.unit.TestCase {

    public function testSimple () {
        
        var sm:SM = sm.SMBuilder.buildSM("umltest");  
        
        //StateA Event1 guard1(false) 
        var cb = new TestCb(StateA);        
        var event = new TestMsg(Event1);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateE);  
        
        //StateA Event1 guard1(true) 
        cb = new TestCb(StateA);
        cb.guard1 = function guard1(event:TestMsg) : Bool {
            return true;
        }
        var event = new TestMsg(Event1);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateB);
        
        //StateA Event7 
        cb = new TestCb(StateA);
        var event = new TestMsg(Event7);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateB);  

        //StateB Event3       
        cb = new TestCb(StateB);
        var event = new TestMsg(Event3);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateB); 
        
        //StateB Event2
        cb = new TestCb(StateB);
        var event = new TestMsg(Event2);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateA);            
 
        //StateE Event4 guard4(true)
        cb = new TestCb(StateE);
        var event = new TestMsg(Event4);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateK); 

        //StateE Event4 guard3(true)
        cb = new TestCb(StateE);
        cb.guard4 = function guard4(event:TestMsg) : Bool {
            return false;
        }
        cb.guard3 = function guard3(event:TestMsg) : Bool {
            return true;
        }
        var event = new TestMsg(Event4);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateJ); 

        //StateE Event4
        cb = new TestCb(StateE);
        cb.guard4 = function guard4(event:TestMsg) : Bool {
            return false;
        }
        var event = new TestMsg(Event4);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateF); 
        
        //StateE Event8
        cb = new TestCb(StateE);
        var event = new TestMsg(Event8);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateA);
  
        //StateF Event3
        cb = new TestCb(StateF);        
        var event = new TestMsg(Event3);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateF);  
        
        //StateF Event5
        cb = new TestCb(StateF);        
        var event = new TestMsg(Event5);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateE);  
        
        //StateF Event1 guard1(true)
        cb = new TestCb(StateF);        
        var event = new TestMsg(Event1);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateJ); 

        //StateF Event1 guard1(false)
        cb = new TestCb(StateF);      
        cb.guard2 = function guard2(event:TestMsg) : Bool {
            return false;
        }        
        var event = new TestMsg(Event1);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateK); 
        
        //StateI Event8
        cb = new TestCb(StateK);
        var event = new TestMsg(Event8);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateB);
        
        //StateK Event6
        cb = new TestCb(StateK);
        var event = new TestMsg(Event6);
        sm.processEvent(cb, event);
        assertEquals(cb.state, StateE);       

    }
}