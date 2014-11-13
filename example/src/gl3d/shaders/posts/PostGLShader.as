package gl3d.shaders.posts 
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flShader.FlShader;
	import gl3d.Camera3D;
	import gl3d.Material;
	import gl3d.Node3D;
	import gl3d.shaders.GLShader;
	import gl3d.shaders.PhongFragmentShader;
	import gl3d.shaders.PhongVertexShader;
	import gl3d.View3D;
	/**
	 * ...
	 * @author lizhi
	 */
	public class PostGLShader extends GLShader
	{
		private var vshader:FlShader;
		private var fshader:FlShader;
		
		public function PostGLShader(vshader:FlShader=null,fshader:FlShader=null) 
		{
			this.fshader = fshader;
			this.vshader = vshader;
			
		}
		
		override public function getVertexShader(material:Material):FlShader {
			vshader=vshader||new PostVertexShader();
			return vshader;
		}
		
		override public function getFragmentShader(material:Material):FlShader {
			fshader=fshader||new PostFragmentShader();
			return fshader;
		}
		
		override public function preUpdate(material:Material):void {
			super.preUpdate(material);
			textureSets= material.textureSets;
			buffSets.length = 0;
			buffSets[0] = material.node.drawable.pos;
			buffSets[1] =textureSets.length?material.node.drawable.uv:null;
		}
		
		override public function update(material:Material):void 
		{
			super.update(material);
			var context:Context3D = material.view.context;
			if (programSet) {
				var node:Node3D = material.node;
				context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, Vector.<Number>([material.view.time,0,0,0]));
				context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, vshader.constMemLen, Vector.<Number>(vshader.constPool));
				context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, fshader.constMemLen, Vector.<Number>(fshader.constPool));
				context.drawTriangles(node.drawable.index.buff);
			}
		}
		
	}

}