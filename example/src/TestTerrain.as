package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	import gl3d.Drawable3D;
	import gl3d.Material;
	import gl3d.Meshs;
	import gl3d.Node3D;
	import gl3d.shaders.TerrainPhongShader;
	import gl3d.TextureSet;
	import gl3d.View3D;
	import ui.AttribSeter;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestTerrain extends Sprite
	{
		private var view:View3D;
		private var material:Material = new Material;
		
		private var terrain:Node3D
		
		private var aui:AttribSeter = new AttribSeter;
		private var _useTexture:Boolean = true;
		private var texture:TextureSet;
		public function TestTerrain() 
		{
			view = new View3D;
			addChild(view);
			
			view.camera.z = -10;
			view.camera.y = 0;
			view.camera.recompose();
			view.camera.matrix.appendRotation(30, Vector3D.X_AXIS);
			view.camera.matrix = view.camera.matrix;
			view.light.y = 200;
			view.light.lightPower = 2;
			
			[Embed(source = "assets/unityterraintexture/0.jpg")]var c:Class;
			[Embed(source = "assets/unityterraintexture/Cliff (Layered Rock).jpg")]var c0:Class;
			[Embed(source = "assets/unityterraintexture/GoodDirt.jpg")]var c1:Class;
			[Embed(source = "assets/unityterraintexture/Grass (Hill).jpg")]var c2:Class;
			[Embed(source = "assets/unityterraintexture/Grass&Rock.jpg")]var c3:Class;
			
			
			var bmd:BitmapData = new BitmapData(128, 128, false, 0xff0000);
			bmd.perlinNoise(300, 300, 2, 1, true, true);
			texture=new TextureSet(bmd);
			material.textureSets = Vector.<TextureSet>([texture]);
			material.color = Vector.<Number>([.6, .6, .6, 1]);
			
			if (true) {// test terrain
				material.textureSets = Vector.<TextureSet>([getTerrainTexture(c), getTerrainTexture(c0), getTerrainTexture(c1), getTerrainTexture(c2), getTerrainTexture(c3)]);
				material.shader = new TerrainPhongShader();
			}
			
			terrain = new Node3D;
			terrain.material = material;
			terrain.drawable = Meshs.terrain();
			terrain.scaleX=terrain.scaleY=terrain.scaleZ=20;
			view.scene.addChild(terrain);
			
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, stage_resize);
			stage_resize();
			
			addChild(aui);
			aui.bind(view.light, "specularPower", AttribSeter.TYPE_NUM,new Point(1,100));
			aui.bind(view.light, "lightPower", AttribSeter.TYPE_NUM,new Point(.5,5));
			aui.bind(view.light, "color", AttribSeter.TYPE_VEC_COLOR);
			aui.bind(view.light, "ambient", AttribSeter.TYPE_VEC_COLOR);
			aui.bind(material, "color", AttribSeter.TYPE_VEC_COLOR);
			aui.bind(material, "alpha", AttribSeter.TYPE_NUM,new Point(.1,1));
		}
		
		private function getTerrainTexture(c:Class):TextureSet {
			var bmd:BitmapData =  (new c as Bitmap).bitmapData;
			return new TextureSet(bmd);
		}
		
		private function stage_resize(e:Event=null):void 
		{
			view.invalid = true;
			var w:Number = stage.stageWidth;
			var h:Number = stage.stageHeight;
			view.camera.perspective.perspectiveLH(w/400, h/400, 3.3, 1000);
		}
		
		private function enterFrame(e:Event):void 
		{
			//terrain.rotationY += Math.PI / 180;
			//terrain.rotationX += 2 * Math.PI / 180;
			
			//view.light.x = mouseX - stage.stageWidth / 2
			//view.light.y = stage.stageHeight / 2 - mouseY ;
			view.render();
			
			aui.update();
		}
		
		public function get useTexture():Boolean 
		{
			return _useTexture;
		}
		
		public function set useTexture(value:Boolean):void 
		{
			if (value != _useTexture) {
				_useTexture = value;
				material.invalid = true;
				material.textureSets = value?Vector.<TextureSet>([texture]):new Vector.<TextureSet>;
			}
		}
		
	}

}