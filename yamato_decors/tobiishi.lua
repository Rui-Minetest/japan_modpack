local S = yamato.intllib_getter()

local intl = {
	tobiishi_desc = S("Tobiishi"),
}

local node_box = {
	type = "fixed",
	fixed = {
		{-6/16, -8/16, -7/16,  3/16, -7/16, -1/16},
		{-3/16, -8/16,  1/16,  6/16, -7/16,  7/16}
	}
}

local selection_box = {
	type = "fixed",
	fixed = {-8/16, -8/16, -8/16, 8/16, -7/16, 8/16}
}

--------------------------------------------------

minetest.register_node("yamato_decors:tobiishi", {
	description = intl.tobiishi_desc,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,

	tiles = {"default_cobble.png"},
	groups = {snappy = 3},
	sounds = default.node_sound_stone_defaults(),

	node_box = node_box,
	selection_box = selection_box,
})

minetest.register_craft({
	type = "shapeless",
	recipe = {"stairs:slab_cobble"},
	output = "yamato_decors:tobiishi 3",
})
