extends ItemEffect

func use()->void:
	var player = PlayerManager.player
	var nearest_area = player._get_nearest_interaction_area()
	if nearest_area:
		var container = nearest_area.player
		if container:
			var message_label = PlayerManager.player.get_node_or_null("UI/MessageLabel")
			if message_label:
				
				message_label.text = "Lockpicking key works."
				message_label.visible = true
				print("Showing message_label")
				await PlayerManager.player.get_tree().create_timer(2.0).timeout
	#			message_label.visible = false
				message_label.text = ""
			else:
				print("Error: cannot show message")
	pass
