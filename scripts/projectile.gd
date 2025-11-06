extends CharacterBody2D

@export var deathParticle : PackedScene

#var deathParticle = preload("res://scene/explode.tscn")

var speed = 300

#make it visible above all other things
func _ready():
	set_as_top_level(true)

func _physics_process(delta: float) -> void:
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	
#this handles getting rid of objects when they go off screen
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		print('hit tile...')
		kill()
		queue_free()

func kill():
	var _particle = deathParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is TileMapLayer:
		print('hit tile...')
		kill()
		queue_free()
