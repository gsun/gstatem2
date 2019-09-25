import TestMsg;

class TestCb implements sm.SM.IState<Int> {

  @:isVar public var sm(default, default) :sm.SM;
  @:isVar public var state(default, default) :Int;
  public var path :Array<String>;
   
  public function new(s:Int, sm:sm.SM) {
      this.state = s;
      this.sm = sm;
      this.path = new Array();
  }
  
  public function on(event:TestMsg) {
      sm.processEvent(this, event);
  }
   
  public function action1(event:TestMsg) :Void {
      path.push("action1");
  }
  
  public function action2(event:TestMsg) :Void {
      path.push("action2");
  }
  
  public function action3(event:TestMsg) :Void {
      path.push("action3");
  }
  
  public function action4(event:TestMsg) :Void {
      path.push("action4");
  }
  
  public function actionb(event:TestMsg) :Void {
      path.push("actionb");
  }
  
  public function entryc() :Void {
      path.push("entryc");
  }

  public function exitb() :Void {
      path.push("exitb");
  }
  
  public function exitc() :Void {
      path.push("exitc");
  }
  
  public function entryd() :Void {
      path.push("entryd");
  }

  public function exitd() :Void {
      path.push("exitd");
  }
  
  public function exiti() :Void {
      path.push("exiti");
  }
  
  public function entryf() :Void {
      path.push("entryf");
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