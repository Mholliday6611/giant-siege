extends Node2D

@export var attack: PackedScene = preload("res://scenes/attack.tscn")

var attack_delay = 0.33
var can_attack = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("press") and can_attack:
		attack_handler()
		

func attack_handler() -> void:
	var attack_instance = attack.instantiate()
	attack_instance.global_position = get_global_mouse_position()
	get_parent().add_child(attack_instance)
	can_attack = false
	await get_tree().create_timer(attack_delay).timeout
	can_attack = true
