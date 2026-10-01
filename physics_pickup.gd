class_name PhysicsPickup
extends Pickupable

@export var pickup_rigidbody : RigidBody3D
@export var pickup_collider : CollisionShape3D
@export var pickup_position_offset : Vector3

var interact_message : String = "Press E to pick up"

func interact(interaction_controller : InteractionController):
	grab(interaction_controller.pickup_controller)

func grab(pickup_controller : PickupController):
	if pickup_controller == null or pickup_controller.has_pickup:
		return
	pickup_controller.grab_pickup(self)
	set_physics_values(true)

func drop(pickup_controller : PickupController):
	var forward = -pickup_controller.player_camera.global_basis.z.normalized()
	pickup_rigidbody.reparent(get_tree().current_scene, true)
	pickup_rigidbody.global_position = pickup_controller.player_camera.global_position + forward * 1.0
	pickup_rigidbody.global_rotation = Vector3.ZERO
		
	set_physics_values(false)
	
	pickup_rigidbody.apply_central_impulse(forward * 1.5)

func current_user(new_parent : Node3D):
	pickup_rigidbody.reparent(new_parent)
	pickup_rigidbody.position = pickup_position_offset
	pickup_rigidbody.rotation = Vector3.ZERO

func set_physics_values(wasPickedUp : bool):
	pickup_rigidbody.freeze = wasPickedUp
	pickup_collider.disabled = wasPickedUp
	
	if not wasPickedUp:
		pickup_rigidbody.sleeping = false
