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



class Design_5_5_Health extends ActorScript
{          	
	
public var defaultDmg:Float;

public var cacheDmg:Float;

public var currHealth:Float;

public var maxHealth:Float;

public var initHealth:Float;

public var actorCache:Actor;

public var dieOnDepletedHealth:Bool;

public var isInvincible:Bool;

public var isTempInvulnerable:Bool;

public var tempInvulnerabilityTime:Float;

public var sameActorCollideAfter:Float;
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __amount */
public function _customBlock_damage(__amount:Float):Void
{
var __Self:Actor = actor;
        cacheDmg = asNumber(__amount);
propertyChanged("cacheDmg", cacheDmg);
        currHealth -= cacheDmg;
propertyChanged("currHealth", currHealth);
        _customEvent_tookDamage();
}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self */
public function _customBlock_restore():Void
{
var __Self:Actor = actor;
        currHealth = asNumber(maxHealth);
propertyChanged("currHealth", currHealth);
}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __amount */
public function _customBlock_heal(__amount:Float):Void
{
var __Self:Actor = actor;
        currHealth += __amount;
propertyChanged("currHealth", currHealth);
        currHealth = asNumber(Math.min(__amount, maxHealth));
propertyChanged("currHealth", currHealth);
        currHealth = asNumber(Math.max(__amount, 0));
propertyChanged("currHealth", currHealth);
}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self */
public function _customBlock_makeInvincible():Void
{
var __Self:Actor = actor;
        isInvincible = true;
propertyChanged("isInvincible", isInvincible);
}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __amount */
public function _customBlock_setHealth(__amount:Float):Void
{
var __Self:Actor = actor;
        currHealth = asNumber(Math.min(__amount, maxHealth));
propertyChanged("currHealth", currHealth);
        currHealth = asNumber(Math.max(__amount, 0));
propertyChanged("currHealth", currHealth);
}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self */
public function _customBlock_getHealth():Float
{
var __Self:Actor = actor;
        return currHealth;
}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self */
public function _customBlock_makeVulnerable():Void
{
var __Self:Actor = actor;
        isInvincible = false;
propertyChanged("isInvincible", isInvincible);
}
    public function _customEvent_tookDamage():Void
{
        if((currHealth <= 0))
{
            actor.shout("_customEvent_" + "healthDepleted");
            if(dieOnDepletedHealth)
{
                recycleActor(actor);
}

}

}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");
nameMap.set("Default Damage", "defaultDmg");
defaultDmg = 0.0;
nameMap.set("cacheDmg", "cacheDmg");
cacheDmg = 0.0;
nameMap.set("currHealth", "currHealth");
currHealth = 0.0;
nameMap.set("Max Health", "maxHealth");
maxHealth = 0.0;
nameMap.set("Initial Health", "initHealth");
initHealth = 0.0;
nameMap.set("actorCache", "actorCache");
nameMap.set("Die When Health is Depleted?", "dieOnDepletedHealth");
dieOnDepletedHealth = true;
nameMap.set("Is Invincible?", "isInvincible");
isInvincible = false;
nameMap.set("Temporarily Invulnerable?", "isTempInvulnerable");
isTempInvulnerable = false;
nameMap.set("Temporary Invulnerability Time", "tempInvulnerabilityTime");
tempInvulnerabilityTime = 0.0;
nameMap.set("Collide With Same Actor After", "sameActorCollideAfter");
sameActorCollideAfter = 0.0;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        currHealth = asNumber(initHealth);
propertyChanged("currHealth", currHealth);
    
/* ======================== Something Else ======================== */
addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(isTempInvulnerable)
{
            return;
}

        if(event.thisCollidedWithTile)
{
            return;
}

        if(isInvincible)
{
            return;
}

        if(((hasValue(actorCache) != false) && (actorCache == actor.getLastCollidedActor())))
{
            return;
}

        if(actor.getLastCollidedActor().hasBehavior("Inflicts Damage"))
{
            cacheDmg = asNumber(asNumber(actor.getLastCollidedActor().getValue("Inflicts Damage", "damage")));
propertyChanged("cacheDmg", cacheDmg);
}

        else
{
            cacheDmg = asNumber(defaultDmg);
propertyChanged("cacheDmg", cacheDmg);
}

        actorCache = actor.getLastCollidedActor();
propertyChanged("actorCache", actorCache);
        if((sameActorCollideAfter > 0))
{
            runLater(1000 * sameActorCollideAfter, function(timeTask:TimedTask):Void {
                        if(!isPrimitive(actorCache)) {actorCache = getDefaultValue(actorCache);}
}, actor);
}

        currHealth -= cacheDmg;
propertyChanged("currHealth", currHealth);
        if((cacheDmg > 0))
{
            actor.shout("_customEvent_" + "tookDamage");
}

        if((tempInvulnerabilityTime > 0))
{
            isTempInvulnerable = true;
propertyChanged("isTempInvulnerable", isTempInvulnerable);
            runLater(1000 * tempInvulnerabilityTime, function(timeTask:TimedTask):Void {
                        isTempInvulnerable = false;
propertyChanged("isTempInvulnerable", isTempInvulnerable);
}, actor);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}