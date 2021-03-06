--[[
TPS Custom Items
For The Pixel Shadow servers
By Robbie Ferguson (My First Minetest Mod)
--]]

--[[
 Great Resources:

 https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L671
 https://forum.minetest.net/viewtopic.php?id=3386

 max usage is 65535, uses is what is takes from that number each time it's used... so higher the usage the quicker is degrades - TenPlus1
 (65535/100) = USES
 though this seems not to be the case.
 
--]]

-- Privs

-- Do not grant this. It is automatically added when the player puts on the admin badge and revoked when they remove it.
minetest.register_privilege("tps_admin", {description = "TPS Admin", give_to_singleplayer=false})


-- Tools

minetest.register_tool("tps_items:pick_founder", {
	description = "TPS Founder Pickaxe",
	inventory_image = "tps_items_power_pick.png",
	groups = {not_in_creative_inventory=1},
	tool_capabilities = {
		full_punch_interval = 1.0,
		stack_max=1,
		range = 14.0,
		groupcaps={
			crumbly={times={[1]=0.3, [2]=0.2, [3]=0.1}, uses=1000, maxlevel=3},
			cracky={times={[1]=1, [2]=0.6, [3]=0.2}, uses=500, maxlevel=3},
			snappy={times={[1]=0.6, [2]=0.3, [3]=0.2}, uses=1000, maxlevel=3},
			choppy={times={[1]=0.9, [2]=0.5, [3]=0.3}, uses=1000, maxlevel=3},
			fleshy={times={[1]=4, [2]=3, [3]=2}, uses=200, maxlevel=3},
			explody={times={[1]=3, [2]=3, [3]=3}, uses=10, maxlevel=3}
		},
		damage_groups = {fleshy=10},
	},
})

minetest.register_tool("tps_items:pick_power", {
	description = "TPS Power Pickaxe",
	inventory_image = "tps_items_power_pick.png",
	groups = {not_in_creative_inventory=1},
	tool_capabilities = {
		full_punch_interval = 1.0,
		stack_max=1,
		range = 14.0,
		groupcaps={
			crumbly={times={[1]=0.3, [2]=0.2, [3]=0.1}, uses=5000, maxlevel=3},
			cracky={times={[1]=1, [2]=0.6, [3]=0.2}, uses=500, maxlevel=3},
			snappy={times={[1]=0.6, [2]=0.3, [3]=0.2}, uses=2000, maxlevel=3},
			choppy={times={[1]=0.9, [2]=0.5, [3]=0.3}, uses=1000, maxlevel=3},
			fleshy={times={[1]=4, [2]=3, [3]=2}, uses=200, maxlevel=3},
			explody={times={[1]=3, [2]=3, [3]=3}, uses=10, maxlevel=3}
		},
		damage_groups = {fleshy=10},
	},
})


minetest.register_craftitem("tps_items:admin_stick", {
	description = "TPS Admin Stick",
	inventory_image = "tps_items_adminstick.png",
	groups = {not_in_creative_inventory=1},
	on_use = function(item, user, pointed_thing)
		local pname = user:get_player_name()
		if minetest.check_player_privs(pname, {tps_admin=true}) then
			if pointed_thing.type == "node" then
				minetest.env:remove_node(pointed_thing.under)
			elseif pointed_thing.type == "object" then
				obj = pointed_thing.ref
				if obj ~= nil then
					if obj:get_player_name() ~= nil then
						-- Player
						obj:set_hp(-1)
					else
						-- Mob or other entity
						obj:remove()
					end
				end
			end	
		end
	end,
	stack_max = 1,
	liquids_pointable = true,
	on_drop = function(itemstack, dropper, pos)
		return
	end,
	minetest.register_alias("adminstick","tps_items:admin_stick")
})

if (minetest.get_modpath("3d_armor")) then
	minetest.register_tool("tps_items:admin_badge", {
		description = "TPS Admin Badge",
		inventory_image = "tps_items_admin_badge_icon.png",
		armor_groups = {fleshy=100},
		groups = {armor_torso=1000, armor_heal=1000, armor_use=0, not_in_creative_inventory=1},

		on_drop = function(itemstack, dropper, pos)
			return
		end,

		on_equip = function(player)
			local name = player:get_player_name()
			local privs = minetest.get_player_privs(name)
			privs.no_knockback = true
			privs.tps_admin = true
			privs.protection_bypass = true
			minetest.set_player_privs(name, privs)
		end,

		on_unequip = function(player)
			local name = player:get_player_name()
			local privs = minetest.get_player_privs(name)
			privs.no_knockback = false
			privs.tps_admin = false
			privs.protection_bypass = false
			minetest.set_player_privs(name, privs)
		end,

		on_destroy = function(player)
			local name = player:get_player_name()
			local privs = minetest.get_player_privs(name)
			privs.no_knockback = false
			privs.tps_admin = false
			privs.protection_bypass = false
			minetest.set_player_privs(name, privs)
		end,
	})
	minetest.register_alias("adminbadge","tps_items:admin_badge")

	-- Same functionality, just different visual
	minetest.register_tool("tps_items:moderator_badge", {
		description = "TPS Moderator Badge",
		inventory_image = "tps_items_moderator_badge_icon.png",
		armor_groups = {fleshy=100},
		groups = {armor_torso=1000, armor_heal=1000, armor_use=0, not_in_creative_inventory=1},

		on_drop = function(itemstack, dropper, pos)
			return
		end,

		on_equip = function(player)
			local name = player:get_player_name()
			local privs = minetest.get_player_privs(name)
			privs.no_knockback = true
			privs.tps_admin = true
			privs.protection_bypass = true
			minetest.set_player_privs(name, privs)
		end,

		on_unequip = function(player)
			local name = player:get_player_name()
			local privs = minetest.get_player_privs(name)
			privs.no_knockback = false
			privs.tps_admin = false
			privs.protection_bypass = false
			minetest.set_player_privs(name, privs)
		end,

		on_destroy = function(player)
			local name = player:get_player_name()
			local privs = minetest.get_player_privs(name)
			privs.no_knockback = false
			privs.tps_admin = false
			privs.protection_bypass = false
			minetest.set_player_privs(name, privs)
		end,
	})
	minetest.register_alias("modbadge","tps_items:moderator_badge")

	-- Just cosmetic to show user as a helper
	minetest.register_tool("tps_items:helper_badge", {
		description = "TPS Helper Badge",
		inventory_image = "tps_items_helper_badge_icon.png",
		groups = {armor_torso=20, armor_heal=12, armor_use=50, armor_fire=1, not_in_creative_inventory=1},
		armor_groups = {fleshy=20, cracky=15, snappy=20, choppy=20, crumbly=20},
		on_drop = function(itemstack, dropper, pos)
			return
		end,
		
		on_equip = function(player)
			local name = player:get_player_name()
			local privs = minetest.get_player_privs(name)
			privs.no_knockback = true
			minetest.set_player_privs(name, privs)
		end,

		on_unequip = function(player)
			local name = player:get_player_name()
			local privs = minetest.get_player_privs(name)
			privs.no_knockback = false
			minetest.set_player_privs(name, privs)
		end,

		on_destroy = function(player)
			local name = player:get_player_name()
			local privs = minetest.get_player_privs(name)
			privs.no_knockback = false
			minetest.set_player_privs(name, privs)
		end,
	})
	minetest.register_alias("helperbadge","tps_items:helper_badge")

end

dofile(minetest.get_modpath("tps_items").."/crafts.lua")
dofile(minetest.get_modpath("tps_items").."/overrides.lua")

print("TPS Items Loaded!")
