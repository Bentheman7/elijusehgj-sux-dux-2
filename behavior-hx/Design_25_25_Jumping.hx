package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import nme.ui.Mouse;
import nme.display.Graphics;
import nme.display.BlendMode;
import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.events.TouchEvent;
import nme.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_25_25_Jumping extends ActorScript
{          	
	
public var _KeyReleased:Bool;

public var _CanJump:Bool;

public var _JumpKey:String;

public var _MaxJumpTime:Float;

public var _JumpRightAnimation:String;

public var _JumpLeftAnimation:String;

public var _PreventJumping:Bool;

public var _ElapsedJumpTime:Float;

public var _CurrentJumpTime:Float;

public var _oldY:Float;

public var _JumpingSlowdown:Float;

public var _JumpSound:Sound;

public var _JumpForce:Float;

public var _AnimationCategory:String;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");
nameMap.set("Key Released?", "_KeyReleased");
_KeyReleased = false;
nameMap.set("Can Jump?", "_CanJump");
_CanJump = false;
nameMap.set("Jump Key", "_JumpKey");
nameMap.set("Max Jump Time", "_MaxJumpTime");
_MaxJumpTime = 0.075;
nameMap.set("Jump Right Animation", "_JumpRightAnimation");
nameMap.set("Jump Left Animation", "_JumpLeftAnimation");
nameMap.set("Prevent Jumping?", "_PreventJumping");
_PreventJumping = false;
nameMap.set("Elapsed Jump Time", "_ElapsedJumpTime");
_ElapsedJumpTime = 0.0;
nameMap.set("Current Jump Time", "_CurrentJumpTime");
_CurrentJumpTime = 0.0;
nameMap.set("oldY", "_oldY");
_oldY = 0.0;
nameMap.set("Jumping Slowdown", "_JumpingSlowdown");
_JumpingSlowdown = 0.75;
nameMap.set("Jump Sound", "_JumpSound");
nameMap.set("Jump Force", "_JumpForce");
_JumpForce = 35.0;
nameMap.set("Animation Category", "_AnimationCategory");
_AnimationCategory = "Jumping";

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}