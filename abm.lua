minetest.register_abm({
    nodenames = {"default:dirt", "default:dirt_with_grass"},
    interval = 240,
    chance = 80,
    action = function(pos, node)
        local destnode = { x = pos.x, y = pos.y+1, z = pos.z}
        local name = minetest.get_node(destnode).name       
        local nodedef = minetest.registered_nodes[name]
        
        if not nodedef then
            return
        end

        local pos0 = { x = destnode.x-4, y = destnode.y-4, z = destnode.z-4 }
        local pos1 = { x = destnode.x+4, y = destnode.y+4, z = destnode.z+4 }

        local mushcount = minetest.find_nodes_in_area(pos0, pos1, "mtz_flora:mycena")
        local maxmushrooms = math.random(1, 5)
        if #mushcount > maxmushrooms then
            return
        end

        if minetest.find_node_near(destnode, 3, "default:jungletree") then
            if name == "air" then
                minetest.set_node(destnode, {name = "mtz_flora:mycena"})
                -- print("Mycena spawned at ".. minetest.pos_to_string(pos))
            end
        end
    end
})
--print("[MTZ-Flora] ABMs loaded")