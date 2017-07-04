-- Restore old-style Sneak glitch
-- Thanks to Shara for providing this code

minetest.register_on_joinplayer(function(player)
	player:set_physics_override({new_move = false, sneak_glitch = true})
end)
