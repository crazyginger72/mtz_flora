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
                print("Mycena spawned at ".. minetest.pos_to_string(pos))
            end
        end
    end
})

minetest.register_abm({
    nodenames = {"default:sand"},
    interval = 300,
    chance = 300,
    action = function(pos, node)
        local name = minetest.get_node(pos).name       
        local nodedef = minetest.registered_nodes[name]
        
        if not nodedef then
            return
        end

        local pos0 = { x = pos.x-3, y = pos.y-3, z = pos.z-3 }
        local pos1 = { x = pos.x+3, y = pos.y+3, z = pos.z+3 }
        
        local count
        
        count = minetest.find_nodes_in_area(pos0, pos1, "mtz_flora:lum_sand")
        if #count == 0 then -- if waterbody not inoculated
            count = minetest.find_nodes_in_area(pos0, pos1, "default:water_source")
            if #count < 9 then -- not enough water
            --    print("not enought water: " .. #wcount)
                return
            end
        end

        for i = 1, 3 do
           if minetest.get_node({x=pos.x, y=pos.y+i, z=pos.z}).name ~= "default:water_source" then
               return
           end
        end
        if minetest.get_node({x=pos.x, y=pos.y+4, z=pos.z}).name ~= "air" then
            return
        end
        
        minetest.set_node(pos, {name = "mtz_flora:lum_sand"})
        --print("mtz_flora:lum_sand spawned at ".. minetest.pos_to_string(pos))

    end
})
--print("[MTZ-Flora] ABMs loaded")