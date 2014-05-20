minetest.register_abm({
	nodenames = {"default:dirt", "default:dirt_with_grass"},
	interval = 120,
	chance = 40,
	action = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]

		local pos0 = {x=above.x-4,y=above.y-4,z=above.z-4}
		local pos1 = {x=above.x+4,y=above.y+4,z=above.z+4}
		
		local flora = minetest.find_nodes_in_area(pos0, pos1, "group:flora")
		local maxmushrooms = math.random(2, 6)
		if #flora > maxmushrooms then
			return
		end
		
		if nodedef and minetest.find_node_near(above, 3, "default:jungletree") then
			if name == "air" then
				minetest.set_node(above, {name = "mtz_flora:mycena"})
				--print("mycena spawned at ".. minetest.pos_to_string(pos))
			end
		end
	end
})
--print("[MTZ-Flora] ABMs loaded")