package gl3d.shaders 
{
	import as3Shader.AS3Shader;
	import flash.display3D.Context3DProgramType;
	import gl3d.core.Material;
	import gl3d.core.shaders.GLAS3Shader;
	/**
	 * ...
	 * @author lizhi
	 */
	public class SkyBoxFragmentShader extends GLAS3Shader
	{
		public function SkyBoxFragmentShader(material:Material,vs:SkyBoxVertexShader) 
		{
			super(Context3DProgramType.FRAGMENT);
			tex(vs.dir, samplerDiff(), oc,material.diffTexture.flags);
		}
		
	}

}