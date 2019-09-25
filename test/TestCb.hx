import TestMsg;

class TestCb implements sm.SM.IState<Int> {

  @:isVar public var sm(default, default) :sm.SM;
  @:isVar public var state(default, default) :Int;
   
  public function new(s:Int, sm:sm.SM) {
      this.state = s;
      this.sm = sm;
  }
  
  public function on(event:TestMsg) {
      sm.processEvent(this, event);
  }
   
  public function action1(event:TestMsg) :Void {
  }
  
  public function action2(event:TestMsg) :Void {
  }
  
  public function action3(event:TestMsg) :Void {
  }
  
  public function action4(event:TestMsg) :Void {
  }
  
  public function actionb(event:TestMsg) :Void {
  }
  
  public function entryc() :Void {
  }

  public function exitb() :Void {
  }
  
  public function exitc() :Void {
  }
  
  public function entryd() :Void {
  }

  public function exitd() :Void {
  }
  
  public function exiti() :Void {
  }
  
  public function entryf() :Void {
  }

  public dynamic function guard1(event:TestMsg) :Bool {
    return false;
  }

  public dynamic function guard2(event:TestMsg) :Bool {
    return true;
  }

  public dynamic function guard3(event:TestMsg) :Bool {
    return false;
  }
  
  public dynamic function guard4(event:TestMsg) :Bool {
    return true;
  }
}