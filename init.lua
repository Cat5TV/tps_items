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
		if minetest.check_player_privs(pname, {protection_bypass=true}) then
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
})

if (minetest.get_modpath("3d_armor")) then
	armor:register_armor("tps_items:admin_badge", {
		description = "TPS Admin Badge",
		inventory_image = "tps_items_adminbadge.png",
		armor_groups = {fleshy=100},
		groups = {armor_torso=1, armor_heal=100, armor_use=0,
				not_in_creative_inventory=1},
		on_drop = function(itemstack, dropper, pos)
			return
		end,
	})
end

dofile(minetest.get_modpath("tps_items").."/crafts.lua")

print("TPS Items Loaded!")
