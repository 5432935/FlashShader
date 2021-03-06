package gl3d.core {
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Program3D;
	import flash.utils.ByteArray;
	import gl3d.core.renders.GL;
	/**
	 * ...
	 * @author lizhi
	 */
	public class ProgramSet 
	{
		public var vcode:ByteArray;
		public var fcode:ByteArray;
		private var invalid:Boolean = true;
		private var context:GL;
		public var program:Program3D;
		public function ProgramSet(vcode:ByteArray,fcode:ByteArray) 
		{
			this.fcode = fcode;
			this.vcode = vcode;
		}
		
		public function update(context:GL):void 
		{
			if (invalid||this.context!=context) {
				program = context.createProgram();
				try{
				program.upload(vcode, fcode);
				}catch(err:Error){
				}
				invalid = false;
				this.context = context;
			}
		}
		
	}

}