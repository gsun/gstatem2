# gstatem2
The state machine for Haxe.

The steps to make a new state machie, and please check test example for reference.

1. draw the UML with WhiteStarUml, and export with xmi format.
2. define the class extend the sm.SM.Context, which holds the state.
3. define the class extend the sm.SM.Msg, which holds the event.
4. import the xmi file as resource in hxml.

Note:

1. the event will be autobuilt with sm.SMBuilder.buildEvent.
2. the state will be autobuilt with sm.SMBuilder.buildState.
3. the state machine will be autobuilt with sm.SMBuilder.buildSM.

the difference from gstatem is both event and state are abstract Int enum.

License:
this project follows the Apache V2 license.
