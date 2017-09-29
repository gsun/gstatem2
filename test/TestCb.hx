import TestMsg;

class TestCb {

  @:isVar public var state(default, default) : Int;
   
  public function new(s:Int) {
      state = s;
  }
 
  public function destructor() {} 
  
  public function action1(event:TestMsg) : Void {
    return null;
  }
  
  public function action2(event:TestMsg) : Void{
    return null;
  }
  
  public function action3(event:TestMsg) : Void {
    return null;
  }
  
  public function action4(event:TestMsg) : Void{
    return null;
  }
  
  public function actionb(event:TestMsg) : Void{
    return null;
  }
  
  public function entryc() : Void{
    return null;
  }

  public function exitb() : Void {
    return null;
  }
  
  public function exitc() : Void {
    return null;
  }
  
  public function entryd() : Void{
    return null;
  }

  public function exitd() : Void {
    return null;
  }
  
  public function exiti() : Void {
    return null;
  }
  
  public function entryf() : Void{
    return null;
  }

  public dynamic function guard1(event:TestMsg) : Bool {
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