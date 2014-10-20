package gl3d.shaders 
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.geom.Vector3D;
	import flShader.FlShader;
	import gl3d.Camera3D;
	import gl3d.Material;
	import gl3d.Node3D;
	import gl3d.ProgramSet;
	import gl3d.TextureSet;
	import gl3d.VertexBufferSet;
	import gl3d.View3D;
	/**
	 * ...
	 * @author lizhi
	 */
	public class GLShader 
	{
		public var invalid:Boolean = true;
		public var vs:FlShader;
		public var fs:FlShader;
		public var programSet:ProgramSet;
		public var textureSets:Vector.<TextureSet>;
		public var buffSets:Vector.<VertexBufferSet>;
		public function GLShader() 
		{
			
		}
		
		public function getProgram():ProgramSet {
			vs = getVertexShader();
			fs = getFragmentShader(); 
			programSet = new ProgramSet(vs.code, fs.code);
			return programSet;
		}
		
		public function getVertexShader():FlShader {
			return null;
		}
		
		public function getFragmentShader():FlShader {
			return null;
		}
		
		public function preUpdate(material:Material):void {
			var context:Context3D = material.view.context;
			for (var i:int = 0; i < 8;i++ ) {
				context.setTextureAt(i, null);
				context.setVertexBufferAt(i, null);
			}
		}
		
		public function update(material:Material):void 
		{
			if (invalid) {
				programSet = getProgram();
			}
			
			if(textureSets)
			for (var i:int = 0; i < textureSets.length;i++ ) {
				var textureSet:TextureSet = textureSets[i];
				if (textureSet) textureSet.bind(material.view.context, i);
			}
			if(buffSets)
			for (i = 0; i < buffSets.length;i++ ) {
				var buffSet:VertexBufferSet = buffSets[i];
				if (buffSet) buffSet.bind(material.view.context, i);
			}
		}
	}

}