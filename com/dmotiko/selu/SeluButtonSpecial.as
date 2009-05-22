package com.dmotiko.selu {
	import com.general.*;
	import flash.display.*;
	import flash.text.*;
	import flash.geom.*;
	import flash.events.*;
	
	public class SeluButtonSpecial
	extends SeluButton {
			
		override protected function initClip():void {
			this.useHandCursor = true;
			this.buttonMode = true;
			txtLabel.mouseEnabled = false;
			
			nColor = 0xc66d41;
			txtLabel.autoSize = TextFieldAutoSize.LEFT;
			txtLabel.textColor = nColor;
			this.addEventListener( MouseEvent.ROLL_OVER, rollOver);
			this.addEventListener( MouseEvent.ROLL_OUT, rollOut);
		}
		
	}
	
}