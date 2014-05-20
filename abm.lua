
minetest.register_abm({
	nodenames = {"group:flora"},
	neighbors = {"default:dirt_with_grass", "default_jungletree", "default:dirt"},
	interval = 50,
	chance = 25,
	action = function(pos, node)
		pos.y = pos.y - 1
		local under = minetest.get_node(pos)
		pos.y = pos.y + 1
		if under.name ~= "default:dirt_with_grass" and under.name ~= "default:dirt" then
			return
		end
		
		local light = minetest.get_node_light(pos)
		if not light or light < 13 then
			return
		end
		
		local pos0 = {x=pos.x-4,y=pos.y-4,z=pos.z-4}
		local pos1 = {x=pos.x+4,y=pos.y+4,z=pos.z+4}
		if #minetest.find_nodes_in_area(pos0, pos1, "group:flora_block") > 0 then
			return
		end
		
		local flowers = minetest.find_nodes_in_area(pos0, pos1, "group:flora")
		if #flowers > 3 then
			return
		end
		
		local seedling = minetest.find_nodes_in_area(pos0, pos1, {"default:dirt_with_grass", "default:dirt"})
		if #seedling > 0 then
			seedling = seedling[math.random(#seedling)]
			seedling.y = seedling.y + 1
			--light = minetest.get_node_light(seedling)
			--if light > 10 then 			-- Needs to be dark(ish)
			--	print("[MTZ-Flora] Too light for mycena")
			--	return
			--end
			if minetest.get_node(seedling).name == "air" then
				minetest.set_node(seedling, {name="mtz_flora:mycena"})
				-- print("mycena spawned at ".. minetest.pos_to_string(pos))
			end
		end
	end,
})

--print("[MTZ-Flora] ABMs loaded")