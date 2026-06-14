class_name HealthComponent
extends Node

@export var health = 10

signal died
signal damage_received

func take_damage(amount):
	print("CALLED")
	health -= amount
	if health <= 0:
		died.emit()
		return
	damage_received.emit()
