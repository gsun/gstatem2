@:build(sm.SMBuilder.buildEvent("umltest"))
@:enum
abstract TestEvent(String) from String to String {}

class TestMsg implements sm.SM.IEvent {

    public var sm(get, never) : String;    
    private var my_sm:String; 
    
    public function get_sm() : String {
        return this.my_sm;
    }
    
    public function new(e:TestEvent) {
        event = e;
        my_sm = "umltest";     
    }
}