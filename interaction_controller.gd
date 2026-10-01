class_name InteractionController 
extends Node

@export var player_camera : Camera3D
@export var interaction_ray : RayCast3D
@export var interaction_text : Label 
@export var interaction_distance : float = 5
@export var pickup_controller : PickupController

var current_targeted_interactable : Interactable

func _process(_delta):
	update_current_interactable()
	#update_interaction_text()
	check_for_interaction_input()


func update_current_interactable():
	var collider = interaction_ray.get_collider()
	current_targeted_interactable = null

	if collider == null:
		return 
	
	for child in collider.get_children():
		if child is Interactable:
			current_targeted_interactable = child
			return


func update_interaction_text():
	if current_targeted_interactable == null:
		interaction_text.hide()
		return
	interaction_text.text = current_targeted_interactable.interact_message
	interaction_text.show()


func check_for_interaction_input():
	if  Input.is_action_just_pressed("interact"):
		if current_targeted_interactable != null:
			current_targeted_interactable.interact(self)
