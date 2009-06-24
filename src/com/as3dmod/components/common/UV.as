package com.as3dmod.components.common {

	/**
	 * @author bartekd
	 */
	public class UV {
		
		public var u:Number;
		public var v:Number;
		
		public function UV(u:Number, v:Number) {
			this.u = u;
			this.v = v;
		}
		
		public function clone():UV {
			return new UV(u, v);
		}
	}
}
