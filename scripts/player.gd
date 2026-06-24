extends Node2D

@export var attack: PackedScene = preload("res://scenes/attack.tscn")
@onready var health_bar: ProgressBar = $ProgressBar
@onready var health_component: HealthComponent = $HealthComponent
@onready var grabber_box: Area2D = $GrabberBox

var attack_delay = 0.33
var can_attack = true
var held_time: float = 0
var is_grabbing = false
var is_dragging = false
var could_grab = null
var is_touching = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = health_component.health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	grabber_box.global_position = get_global_mouse_position()
	if Input.is_action_pressed("press"):
		held_time += delta
		#Check can grab logic here
		if held_time > .15 and could_grab and !is_grabbing:
			if could_grab && could_grab.has_signal("enter_grab_mode"):
				#idk if I love this
				could_grab.enter_grab_mode.emit()
				is_grabbing = true
		elif is_grabbing:
			could_grab.actor.global_position = get_global_mouse_position()
		else:
			is_dragging = true
	if Input.is_action_just_released("press"):
		print("Released")
		if is_grabbing:
			could_grab.exit_grab_mode.emit()
			could_grab = null
			is_grabbing = false
			#release
		elif held_time < .15 and can_attack:
			attack_handler()
		held_time = 0
		is_dragging = false
	if is_touching:
		held_time += delta

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		print("Screen Event")
		if event.is_pressed():
			grabber_box.global_position = event.position
			is_touching = true
		else:
			print("released")
			if held_time < .15 and can_attack:
				attack_handler()
			if is_grabbing:
				could_grab.exit_grab_mode.emit()
				could_grab = null
				is_grabbing = false
			is_touching = false
			held_time = 0
	elif event is InputEventScreenDrag:
		if held_time > .15 and could_grab and !is_grabbing:
			print("START GRAB")
			could_grab.enter_grab_mode.emit()
			is_grabbing = true
		print("screen drag")
		if is_grabbing:
			print("drag and grabbing")
			could_grab.actor.global_position = event.position
	get_viewport().set_input_as_handled()
		
func attack_handler() -> void:
	var attack_instance = attack.instantiate()
	attack_instance.global_position = get_global_mouse_position()
	get_parent().add_child(attack_instance)
	can_attack = false
	await get_tree().create_timer(attack_delay).timeout
	can_attack = true

func startGrab() -> void:
	pass

func updateGrab() -> void:
	pass

func endGrab() -> void:
	pass

func _on_health_component_damage_received() -> void:
	print("Hit")
	health_bar.value = health_component.health


func _on_health_component_died() -> void:
	print("Hit")
	health_bar.value = health_component.health
	GameManager.handle_gameover()

func _on_grabber_box_area_entered(area: Area2D) -> void:
	if !is_dragging and !is_grabbing:
		print("GRAB FIRED")
		could_grab = area


func _on_grabber_box_area_exited(area: Area2D) -> void:
	if !is_dragging and !is_grabbing:
		could_grab = null
