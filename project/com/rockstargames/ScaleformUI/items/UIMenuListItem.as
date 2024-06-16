﻿class com.rockstargames.ScaleformUI.items.UIMenuListItem extends com.rockstargames.ScaleformUI.items.BaseMenuItem
{
	var _index;
	var rightTextTF;
	var itemList = [];
	var leftArrow;
	var leftArrowPos = 262.85;
	var rightArrow;
	var stringItems;
	var arrow_loader;

	function UIMenuListItem(str, substr, parentMenu, listItems, __index, mainColor, highlightColor, textColor, textHighlightColor, _enabled, _blink)
	{
		super(parentMenu,str,substr,_enabled);
		this.itemMC = this.parentMC.attachMovie("UIMenuListItem", "listMenuItem_" + this._parentMenu.itemCount + 1, this.parentMC.getNextHighestDepth());
		this.backgroundMC = this.itemMC.bgMC;
		this.itemList = listItems.split(",");
		this.leftArrow = this.itemMC.leftArrow;
		this.rightArrow = this.itemMC.rightArrow;
		this.leftTextTF = this.itemMC.labelMC.labelTF;
		this.leftTextTF.antiAliasType = "advanced";
		this.leftTextTF.selectable = false;
		this.rightTextTF = this.itemMC.RLabelMC.labelTF;
		this.rightTextTF.antiAliasType = "advanced";
		this.rightTextTF.selectable = false;
		this.index = __index;
		this.stringItems = listItems;
		this.blinkDesc = _blink;
		leftArrow._x = (this.leftArrowPos + 5.15) - this.itemMC.RLabelMC.labelTF.textWidth;

		if (mainColor != undefined)
		{
			this._mainColor = mainColor;
		}
		if (highlightColor != undefined)
		{
			this._highlightColor = highlightColor;
		}
		if (textColor != undefined)
		{
			this._textColor = textColor;
		}
		if (textHighlightColor != undefined)
		{
			this._textHighlightColor = textHighlightColor;
		}
		com.rockstargames.ui.utils.UIText.setSizedText(this.leftTextTF,this.leftText,true,true);
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.leftTextTF,this._enabled ? (!this.highlighted ? this._textColor : this._textHighlightColor) : com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREY);
		this.initBaseMouseInterface();
		this.leftArrow.onRollOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOverLI, this.leftArrow);
		this.leftArrow.onRollOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOutLI, this.leftArrow);
		this.rightArrow.onRollOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOverLI, this.rightArrow);
		this.rightArrow.onRollOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOutLI, this.rightArrow);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.rightArrow,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.leftArrow,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK);
	}

	function mOverLI(mc)
	{
		if (mc == this.leftArrow)
		{
			this._hovered = true;
			this.hover = 0;
		}
		else if (mc == this.rightArrow)
		{
			this._hovered = true;
			this.hover = 1;
		}
	}
	function mOutLI(mc)
	{
		this._hovered = false;
		this.hover = -1;
	}

	function SetClip(targetMC, textureDict, textureName)
	{
		this.arrow_loader = new MovieClipLoader();
		this.arrow_loader.addListener(this);
		var _loc2_ = "img://" + textureDict + "/" + textureName;
		this.arrow_loader.loadClip(_loc2_,targetMC);
	}
	function onLoadInit(target_mc)
	{
		target_mc._width = 18;
		target_mc._height = 18;
		delete this.arrow_loader;
	}

	function get index()
	{
		return this._index % this.itemList.length;
	}

	function set index(val)
	{
		this._index = 100000000 - (100000000 % this.itemList.length) + val;
		this.setRightText(this.rightTextTF,this.itemList[this.index]);
		leftArrow._x = (this.leftArrowPos + 5.15) - this.itemMC.RLabelMC.labelTF.textWidth;
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.rightTextTF,this._enabled ? (!this.highlighted ? this._textColor : this._textHighlightColor) : com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREY);
	}
	function addPanel(_panel)
	{
		this.panels.push(_panel);
	}

	function addItem(item)
	{
		return this.itemList.push(item);
	}

	function removeItem(index)
	{
		return this.itemList.splice(index, 1);
	}

	function set highlighted(_h)
	{
		super.highlighted = _h;
		this.leftArrow._visible = _h;
		this.rightArrow._visible = _h;
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.leftArrow,!this._enabled ? com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREY : com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.rightArrow,!this._enabled ? com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREY : com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK);
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.rightTextTF,this._enabled ? (!this.highlighted ? this._textColor : this._textHighlightColor) : com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREY);
		if (this._enabled)
		{
			for (var _panel in this.panels)
			{
				this.panels[_panel].isVisible = _h;
			}
		}
	}
	function Select()
	{
		if (this.highlighted)
		{
			if (this.hover == 0)
			{
				this.index--;
			}
			else if (this.hover == 1)
			{
				this.index++;
			}
		}
		return this.index;
	}
}