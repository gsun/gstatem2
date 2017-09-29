class TestMsg  {

    @:isVar public var sm(default, default) : String;    
    @:isVar public var event(default, default) : Int;
	
    public function new(e:Int) {
        event = e;
        sm = "umltest";     
    }
}