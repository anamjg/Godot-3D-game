class_name ButtonInteract
extends Interactable

# What the button affects to 
@export var nodes_to_affect : Array[Node]

# registrert at den har blit interacted med
func interact(_interaction_controller : InteractionController):
	for node in nodes_to_affect:
		if node and node.has_method("execute"):
			node.call("execute")
