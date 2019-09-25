class TestMsg implements sm.SM.IEvent<Int> {

    @:isVar public var event(default, default) : Int;
    
    public function new(e:Int) {
        event = e;
    }
}