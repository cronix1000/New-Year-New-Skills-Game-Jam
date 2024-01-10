extends CharacterBody2D


var is_holding_key = false:
	set(_value):
		is_holding_key = _value
		if is_holding_key:
			$Key.visible = true
		else:
			$Key.visible = false


