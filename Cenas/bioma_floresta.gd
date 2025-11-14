extends Node
@onready var player = get_node("Lucio")
@onready var mago = get_node("MagoFloresta")
var screen_size: Vector2
var map_limits: Rect2  # 存储地图边界
	
func _physics_process(delta: float) -> void:
	if  Global.mago_vivo ==0:
		$MagoFloresta.visible = false
