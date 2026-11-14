extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is TowerPiece:
		body.handle_body_entered(body)
		body.call_deferred("queue_free")
