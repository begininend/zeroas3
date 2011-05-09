package com.zero.campi.faq
{
	import com.greensock.TweenLite;
	import com.util.DisplayUtil;
	import com.util.HTMLColors;
	import com.util.LayoutUtil;
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author sminutoli
	 */
	public class FAQ extends Sprite 
	{
		
		public var title:TextField;
		public var titleBack:Sprite;
		public var arrow:Sprite;
		private var content:Sprite;
		private var the_mask:Shape;
		private var hidden:Boolean;
				
		public function FAQ( info:XML ) {
			
			var font:Font = new ButtonLabel();
			var format:TextFormat = new TextFormat();
			format.font = "Arial";
			format.color = HTMLColors.white;
			format.size = 11;
			format.bold;
			format.kerning = -0.5;
			
			if( !title ){
				title = new TextField();
				title.width = 400;
				title.height = 0;
				//title.embedFonts = true;
				title.wordWrap = true;
				title.autoSize = TextFieldAutoSize.LEFT;
				title.selectable = false;
				addChild(title);
											
				title.defaultTextFormat = format;
				title.mouseEnabled = false;
			}
			
			if ( !titleBack ) {
				titleBack = new TitleBack();
				titleBack.buttonMode = true;
				titleBack.alpha = 0.2;
				//titleBack.blendMode = BlendMode.MULTIPLY;
				addChildAt(titleBack, 0);
			}
									
			title.text = info.@title.toUpperCase();
			this.name = info.@title;
			
			title.height; //algo bizarro pero sino digo esto calcula mal el valor
			titleBack.height = title.textHeight + 5;
			
			content = new Sprite();
			content.y = titleBack.getBounds(this).bottom + 5;
			addChild(content);
			
			content.addChild( new FAQItem( info ) );
			LayoutUtil.layoutY( content, 2 );
						
			the_mask = new Shape();
			the_mask.graphics.beginFill( HTMLColors.magenta, 1 );
			the_mask.graphics.drawRect(0, 0, content.width, content.height );
			the_mask.y = content.y;
			addChild(the_mask);
			
			content.mask  = the_mask;
			
			
			titleBack.addEventListener(MouseEvent.CLICK, toggle );
			
			the_mask.scaleY = 0;
			the_mask.scaleX = 0;
			hidden = true;
			
			arrow = new Sprite();
			var aux:DisplayObject = new Bitmap( new ZonaItemArrow(0, 0) );
			var color:ColorTransform = aux.transform.colorTransform;
			color.color = HTMLColors.white;
			aux.transform.colorTransform = color;
			aux.x = -aux.width / 2;
			aux.y = -aux.height / 2;
			arrow.addChild( aux );
			arrow.x = arrow.width;
			arrow.y = arrow.height + 3;
			addChild(arrow);
									
			title.x = 10;
			title.y = 1;
			content.x = the_mask.x = 5;
		}
		
		public function close():void {
			if ( hidden  ) return;
			hidden = true;
			TweenLite.to( the_mask, 0.5, { scaleY: 0, scaleX: 0, onUpdate: mask_update } );
			TweenLite.to( arrow, 0.3, { rotation: 0 } );
		}
		public function open():void {
			if ( !hidden  ) return;
			hidden = false;
			TweenLite.to( the_mask, 0.5, { scaleY: 1, scaleX: 1, onUpdate: mask_update } );
			TweenLite.to( arrow, 0.3, { rotation: 90 } );
		}
		
		private function toggle(e:MouseEvent):void 
		{
			hidden = !hidden;
			TweenLite.to( the_mask, 0.5 + (content.height / 1000), { scaleY: (hidden)? 0 : 1, scaleX: (hidden) ? 0 : 1, onUpdate: mask_update } );
			TweenLite.to( arrow, 0.3, { rotation: (hidden)? 0 : 90 } );
			if ( !hidden ) {
				dispatchEvent( new Event( Event.OPEN, true ) );
			}
		}
				
		private function mask_update():void
		{
			dispatchEvent( new Event( Event.CHANGE, true ) );
		}
		
		override public function get height():Number {
			return the_mask.getBounds(this).bottom;
		}
		
	}

}