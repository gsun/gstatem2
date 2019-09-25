package sm;

class TransitionBehavior {
    public var description : String;

    public var transit : String;
    public var entryExit: String;
    
    public var nextState : Int;
    public var nextStateStr : String;

    public function new(a, b, c, d, e) {
        this.description = a;
        this.transit = b;
        this.entryExit = c;
        this.nextState = d;
        this.nextStateStr = e;
    }
} 
 
class SmTransition {

  public var description : String;

  public var fromState : Int;

  public var eventId : Int;

  public var guard : String;
 
  public var behaviors : Array<TransitionBehavior>;

  public var toState : Int;
  
    public function new(a, b, c, d, e, f) {
        this.description = a;
        this.fromState = b;
        this.eventId = c;
        this.behaviors = d;
        this.toState = e;
        this.guard = f;
    }
}
 
class SmVertex {

  public var state : Int;

  public var pseudostate : Bool; 
  
  public var finalstate:Bool;

  public var outTransition : Array<SmTransition>;
  
    public function new(a, b, c, d) {
        this.state = a;
        this.outTransition = b;
        this.pseudostate = c;
        this.finalstate = d;
    }
}
 
class SM {

  private var name : String;

  private var vertices : Map<Int, SmVertex>;

  private static var sms : Map<String, Dynamic> = new Map(); 

  public function new(a, b) {
        this.name = a;
        this.vertices = b;
  }
  
  public static function getSM(name:String) {
        return sms.get(name);
  }
  
  public static function setSM(name:String, sm:Dynamic) {
        return sms.set(name, sm);
  }
   
  public static function listNames() {
        return sms.keys();
  }
  
  public function findTransition(state : Int, event : Int, context : Dynamic,  msg : Dynamic) : SmTransition {      
      var vertix = this.vertices.get(state);
      if (vertix == null) return null;  
      
      for (transition in vertix.outTransition) {
          if (((transition.eventId != null) && 
               (transition.eventId != event)) || 
              ((transition.guard != null) && 
               (Reflect.callMethod(context, Reflect.field(context, transition.guard), [msg]) != true))) {
              continue;
          }
          return transition;
      }
      
      return null;
  }
  
  public function isPseudoState(state: Int) : Bool {
      var vertix = this.vertices.get(state);
      
      if (vertix != null) {       
          return (vertix.pseudostate == true) ? true : false;
      }   
      
      return true;
  }
  
  public function isFinalState(state: Int) : Bool {
      var vertix = this.vertices.get(state);
      
      if (vertix != null) {       
          return (vertix.finalstate == true) ? true : false;
      }   
      
      return true;
  }
  
  
  public function processEvent (context : Dynamic,  msg : Dynamic) : Void {
      var my_stateId = Reflect.getProperty(context, "state"); //state will change during processing
      var my_eventId = Reflect.getProperty(msg, "event");  //event will change if exception
      var my_msg = msg;
      var my_orig_stateId = my_stateId;
      var my_orig_eventId = my_eventId;
      var transition = this.findTransition(my_stateId, my_eventId, context, my_msg);

      while (transition != null) {     
          trace("transition " + transition.description);
          
          for (behavior in transition.behaviors) {        
              if ((behavior.transit == null) &&
                  (behavior.nextState != my_stateId)) {
                  //get next state for loop
                  my_stateId = behavior.nextState;
                  trace("dynamic state before transition " + behavior.nextStateStr);
                  
                  //set the state for the object
                  if (this.isPseudoState(my_stateId) != true) {
                      Reflect.setProperty(context, "state", behavior.nextState);
                      trace("object state before transition " + behavior.nextStateStr);
                  }
              }               
              
              var my_excpt_msg = null;
              if (behavior.transit != null) {
                  try {
                      trace("action: " + behavior.transit);
                      Reflect.callMethod(context, Reflect.field(context, behavior.transit), [my_msg]);
                  } catch (err : Dynamic) {
                      my_excpt_msg =  err;
                  }
              } 
              else if (behavior.entryExit != null) {
                  try {
                      trace("action: " + behavior.entryExit);
                      Reflect.callMethod(context, Reflect.field(context, behavior.entryExit), []);
                  } catch (err : Dynamic) {
                      my_excpt_msg =  err;
                  }
              }
              
              if ((behavior.transit != null) &&
                  (behavior.nextState != my_stateId)) {
                  //get next state for loop
                  my_stateId = behavior.nextState;
                  trace("dynamic state after  transition " + behavior.nextStateStr);
                  
                  //set the state for the object
                  if (this.isPseudoState(my_stateId) != true) {
                      Reflect.setProperty(context, "state", behavior.nextState);
                      trace("object state after  transition " + behavior.nextStateStr);
                  }
              }
              
              if (my_excpt_msg != null) {
                 my_msg.destructor();
                 my_msg = my_excpt_msg;
                 my_eventId = Reflect.getProperty(my_excpt_msg, "event");
                 break;
              }                   
          }
          
          /*the state and event unchanged after transition, break the loop here.*/
          if ((my_stateId == my_orig_stateId) && (my_eventId == my_orig_eventId)) break;
          
          /*find next transition if my_stateId/my_eventId changed, which is used for pesudo state or exception event.*/
          transition = this.findTransition(my_stateId, my_eventId, context, my_msg);
      }

      if (isFinalState(my_stateId))
      {
          if (Reflect.hasField(context, "destructor")) {
              trace("object destruct ");
              Reflect.callMethod(context, Reflect.field(context, "destructor"), []);
          }
      }
  }
  
  public function toString(from=null, to=null, event=null) : Void {
      for (vertix in this.vertices) {
          if ((from != null) && (vertix.state != from))
              continue;
          trace("Vertix state " + vertix.state);
          for (transition in vertix.outTransition) {
              if ((to != null) && (transition.toState != to))
                  continue;
              trace("  Transition from state " + vertix.state + " to state " + transition.toState);
              for (behavior in transition.behaviors) {
                  trace("    Behavior "+ Std.string(behavior));
              }
          }
      }  
  }
  
  static inline public function err(msg:String) : Void {
      #if debug
          trace(msg);
      #end
      #if macro
          haxe.macro.Context.error(msg, haxe.macro.Context.currentPos());
      #else
          throw msg;
      #end
  }
}

