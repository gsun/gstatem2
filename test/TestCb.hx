import TestMsg;

class TestCb {

  @:isVar public var state(default, default) : Int;
   
  public function new(s:Int) {
      state = s;
  }
   
  public function action1(event:TestMsg) : Void {
  }
  
  public function action2(event:TestMsg) : Void{
  }
  
  public function action3(event:TestMsg) : Void {
  }
  
  public function action4(event:TestMsg) : Void{
  }
  
  public function actionb(event:TestMsg) : Void{
  }
  
  public function entryc() : Void{
  }

  public function exitb() : Void {
  }
  
  public function exitc() : Void {
  }
  
  public function entryd() : Void{
  }

  public function exitd() : Void {
  }
  
  public function exiti() : Void {
  }
  
  public function entryf() : Void{
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