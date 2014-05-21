mtz_flora = {}

mtz_flora.modpath = minetest.get_modpath("mtz_flora")

minetest.register_node("mtz_flora:mycena", {
	description = "Mycena sp",
	drawtype = "plantlike",
	tiles = { "mtz_fungi_Mycena_sp_single.png" },
	inventory_image = "mtz_fungi_Mycena_sp_single.png",
	wield_image = "mtz_fungi_Mycena_sp_single.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3, flammable=0, flower=0, 
		  flora=1, attached_node=1, color_green=1},
	sounds = default.node_sound_leaves_defaults(),
	light_source = 4,
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

dofile(mtz_flora.modpath.."/abm.lua")

print("[MTZ-Flora] Loaded")