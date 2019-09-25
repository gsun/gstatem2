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
        var cb = new TestCb(StateA, sm);        
        var event = new TestMsg(Event1);
        cb.on(event);
        assertEquals(cb.state, StateE);  
        assertEquals(cb.path.toString(), ["entryd","entryc"].toString());
        #if debug trace("---------------------------------------"); #end
        
        //StateA Event1 guard1(true) 
        cb = new TestCb(StateA, sm);
        cb.guard1 = function guard1(event:TestMsg) : Bool {
            return true;
        }
        var event = new TestMsg(Event1);
        cb.on(event);
        assertEquals(cb.state, StateB);
        assertEquals(cb.path.toString(), [].toString());
        #if debug trace("---------------------------------------"); #end
        
        //StateA Event7 
        cb = new TestCb(StateA, sm);
        var event = new TestMsg(Event7);
        cb.on(event);
        assertEquals(cb.state, StateB);  
        assertEquals(cb.path.toString(), [].toString());
        #if debug trace("---------------------------------------"); #end

        //StateB Event3       
        cb = new TestCb(StateB, sm);
        var event = new TestMsg(Event3);
        cb.on(event);
        assertEquals(cb.state, StateB); 
        assertEquals(cb.path.toString(), ["actionb"].toString());
        #if debug trace("---------------------------------------"); #end
        
        //StateB Event2
        cb = new TestCb(StateB, sm);
        var event = new TestMsg(Event2);
        cb.on(event);
        assertEquals(cb.state, StateA);            
        assertEquals(cb.path.toString(), ["exitb"].toString());
        #if debug trace("---------------------------------------"); #end
 
        //StateE Event4 guard4(true)
        cb = new TestCb(StateE, sm);
        var event = new TestMsg(Event4);
        cb.on(event);
        assertEquals(cb.state, StateK); 
        assertEquals(cb.path.toString(), ["action4","action3"].toString());
        #if debug trace("---------------------------------------"); #end

        //StateE Event4 guard3(true)
        cb = new TestCb(StateE, sm);
        cb.guard4 = function guard4(event:TestMsg) : Bool {
            return false;
        }
        cb.guard3 = function guard3(event:TestMsg) : Bool {
            return true;
        }
        var event = new TestMsg(Event4);
        cb.on(event);
        assertEquals(cb.state, StateJ); 
        assertEquals(cb.path.toString(), ["action2"].toString());
        #if debug trace("---------------------------------------"); #end

        //StateE Event4
        cb = new TestCb(StateE, sm);
        cb.guard4 = function guard4(event:TestMsg) : Bool {
            return false;
        }
        var event = new TestMsg(Event4);
        cb.on(event);
        assertEquals(cb.state, StateF); 
        assertEquals(cb.path.toString(), ["entryf"].toString());
        #if debug trace("---------------------------------------"); #end
        
        //StateE Event8
        cb = new TestCb(StateE, sm);
        var event = new TestMsg(Event8);
        cb.on(event);
        assertEquals(cb.state, StateA);
        assertEquals(cb.path.toString(), ["exitc","exitd"].toString());
        #if debug trace("---------------------------------------"); #end
  
        //StateF Event3
        cb = new TestCb(StateF, sm);        
        var event = new TestMsg(Event3);
        cb.on(event);
        assertEquals(cb.state, StateF);  
        assertEquals(cb.path.toString(), [].toString());
        #if debug trace("---------------------------------------"); #end
        
        //StateF Event5
        cb = new TestCb(StateF, sm);        
        var event = new TestMsg(Event5);
        cb.on(event);
        assertEquals(cb.state, StateE);  
        assertEquals(cb.path.toString(), ["action1"].toString());
        #if debug trace("---------------------------------------"); #end
        
        //StateF Event1 guard1(true)
        cb = new TestCb(StateF, sm);        
        var event = new TestMsg(Event1);
        cb.on(event);
        assertEquals(cb.state, StateJ); 
        assertEquals(cb.path.toString(), ["action2"].toString());
        #if debug trace("---------------------------------------"); #end

        //StateF Event1 guard1(false)
        cb = new TestCb(StateF, sm);      
        cb.guard2 = function guard2(event:TestMsg) : Bool {
            return false;
        }        
        var event = new TestMsg(Event1);
        cb.on(event);
        assertEquals(cb.state, StateK); 
        assertEquals(cb.path.toString(), ["action3"].toString());
        #if debug trace("---------------------------------------"); #end
        
        //StateI Event8
        cb = new TestCb(StateK, sm);
        var event = new TestMsg(Event8);
        cb.on(event);
        assertEquals(cb.state, StateB);
        assertEquals(cb.path.toString(), ["exiti","exitc","exitd"].toString());
        #if debug trace("---------------------------------------"); #end
        
        //StateK Event6
        cb = new TestCb(StateK, sm);
        var event = new TestMsg(Event6);
        cb.on(event);
        assertEquals(cb.state, StateE);       
        assertEquals(cb.path.toString(), ["exiti"].toString());
        #if debug trace("---------------------------------------"); #end

    }
}