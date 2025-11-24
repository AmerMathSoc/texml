crank=this.scene.nodes.getByName("manivelle-1-1");
cross=this.scene.nodes.getByName("croix-1-1");

function cntrClockWise(){dir=1; speed=lastspeed;}
function pause(){if(speed)lastspeed=speed; speed=0;}
function clockWise(){dir=-1; speed=lastspeed;}
function scaleSpeed(s){lastspeed*=s; if(speed) speed=lastspeed;}
function origSpeed(){lastspeed=1; if(speed) speed=lastspeed;}

Ocrank=new Vector3(-0.025, 0, 0);
Ocross=new Vector3(0.025, 0, 0);

axeZ=new Vector3(0,0,1);
mx4x4=new Matrix4x4();

var omega0=Math.PI; // init. angular frequency (half turn per second)
var dir=1;          // init. direction
var speed=0;        // speed multiplier
var lastspeed=1;
var alpha=0;

timeEvHnd=new TimeEventHandler();
timeEvHnd.onEvent=function(event) {
  var dalpha=dir*speed*omega0*event.deltaTime;
  if (dalpha!=0){
    mx4x4.setIdentity();
    mx4x4.rotateAboutLineInPlace(alpha,Ocrank,axeZ);
    crank.transform.set(mx4x4);
    with (Math){
      if (alpha<3*PI/2) beta=0;
      else beta=-atan(sin(alpha+PI/4)/(sqrt(2)-cos(alpha+PI/4)))+PI/4;
    }
    mx4x4.setIdentity();
    mx4x4.rotateAboutLineInPlace(beta,Ocross,axeZ);
    cross.transform.set(mx4x4);
    alpha+=dalpha+2*Math.PI;
    alpha%=2*Math.PI;
    scene.update();
  }
}

runtime.addEventHandler(timeEvHnd);
