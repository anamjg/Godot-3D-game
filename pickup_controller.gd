class_name PickupController
extends Node

@export var pickup_holder : Marker3D
@export var player_camera : Camera3D

var current_pickup : Pickupable = null

var has_pickup : bool:
	get:
		return current_pickup != null

var current_charge_time : float
var is_charging_throw : bool 

func grab_pickup(new_pickup : Pickupable):
	current_pickup = new_pickup
	current_pickup.current_user(pickup_holder)


func _process(_delta):
	check_drop_input()


func check_drop_input():
	if Input.is_action_just_pressed("drop") and has_pickup:
		current_pickup.drop(self)
		current_pickup = null


func clear_current_pickup():
	current_pickup = null
