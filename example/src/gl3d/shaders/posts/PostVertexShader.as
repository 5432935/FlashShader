package gl3d.shaders.posts 
{
	import flShader.FlShader;
	/**
	 * ...
	 * @author lizhi
	 */
	public class PostVertexShader extends FlShader
	{
		
		public function PostVertexShader() 
		{
			mov(VA(), null, op);
			mov(VA(1), null, V());
		}
		
	}

}