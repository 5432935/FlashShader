package gl3d.shaders 
{
	import flShader.Var;
	import gl3d.Material;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TerrainPhongFragmentShader extends PhongFragmentShader
	{
		public function TerrainPhongFragmentShader(material:Material) 
		{
			super(material);
		}

		override public function getDiffColor():Var {
			var uv:Var = V(3);
			var scaledUV:Var = mul(V(3), 50);
			//repeat,miplinear
			var flags:Array = ["repeat","linear"/*,"miplinear"*/];
			var map:Var = tex(uv, FS(), null, flags);
			mov(sub2([1,map.x,map.y,map.z]),map.w);
			var diffColor0:Var = tex(scaledUV, FS(1),null,flags);
			var diffColor1:Var = tex(scaledUV, FS(2),null,flags);
			var diffColor2:Var = tex(scaledUV, FS(3),null,flags);
			var diffColor3:Var = tex(scaledUV, FS(4), null, flags);
			var diffColor:Var=
						add2([
							mul(diffColor0,map.x),
							mul(diffColor1,map.y),
							mul(diffColor2,map.z),
							mul(diffColor3,map.w)
						]);
			mov(1,diffColor.w);//diffColor.w = 1;
			return diffColor;
		}
	}

}