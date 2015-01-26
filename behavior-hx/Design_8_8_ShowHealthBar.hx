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



class Design_8_8_ShowHealthBar extends ActorScript
{          	
	
public var percentYellow:Float;

public var percentGreen:Float;

public var width:Float;

public var height:Float;

public var offset:Float;

public var cachedHealth:Float;

public var maxHealth:Float;

public var remainingPercent:Float;

public var healthBarLeft:Float;

public var loadedHealth:Bool;
    public function _customEvent_tookDamage():Void
{
        cachedHealth = asNumber(asNumber(""));
propertyChanged("cachedHealth", cachedHealth);
}

    public function _customEvent_restore():Void
{
        cachedHealth = asNumber(asNumber(""));
propertyChanged("cachedHealth", cachedHealth);
}

    public function _customEvent_heal():Void
{
        cachedHealth = asNumber(asNumber(""));
propertyChanged("cachedHealth", cachedHealth);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");
nameMap.set("Show yellow if health above (%)", "percentYellow");
percentYellow = 33.0;
nameMap.set("Show green if health above (%)", "percentGreen");
percentGreen = 66.0;
nameMap.set("Width", "width");
width = 40.0;
nameMap.set("Height", "height");
height = 5.0;
nameMap.set("Distance", "offset");
offset = 3.0;
nameMap.set("cachedHealth", "cachedHealth");
cachedHealth = 0.0;
nameMap.set("maxHealth", "maxHealth");
maxHealth = 0.0;
nameMap.set("remainingPercent", "remainingPercent");
remainingPercent = 0.0;
nameMap.set("healthBarLeft", "healthBarLeft");
healthBarLeft = 0.0;
nameMap.set("loadedHealth", "loadedHealth");
loadedHealth = false;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        loadedHealth = false;
propertyChanged("loadedHealth", loadedHealth);
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(!(loadedHealth))
{
            loadedHealth = true;
propertyChanged("loadedHealth", loadedHealth);
            cachedHealth = asNumber(asNumber(""));
propertyChanged("cachedHealth", cachedHealth);
            maxHealth = asNumber(asNumber(actor.getValue("Health", "maxHealth")));
propertyChanged("maxHealth", maxHealth);
}

}
});
    
/* ========================= When Drawing ========================= */
addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        remainingPercent = asNumber((cachedHealth / maxHealth));
propertyChanged("remainingPercent", remainingPercent);
        healthBarLeft = asNumber((width * remainingPercent));
propertyChanged("healthBarLeft", healthBarLeft);
        g.fillColor = Utils.getColorRGB(0,0,0);
        g.fillRect(-1, (-(offset) - 1), (width + 2), (height + 2));
        if(((remainingPercent * 100) >= percentGreen))
{
            g.fillColor = Utils.getColorRGB(0,128,0);
}

        else
{
            if(((remainingPercent * 100) >= percentYellow))
{
                g.fillColor = Utils.getColorRGB(255,200,0);
}

            else
{
                g.fillColor = Utils.getColorRGB(255,0,0);
}

}

        g.fillRect(0, -(offset), healthBarLeft, height);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}