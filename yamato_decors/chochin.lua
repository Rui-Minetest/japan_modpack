local S = yamato.intllib_getter()

local intl = {
	chochin_desc = S("Chochin"),
}

local node_box = {
	type = "fixed",
	fixed = {
		{-4/16,  6/16, -4/16,  4/16,  8/16,  4/16},
		{-6/16,  5/16, -6/16,  6/16,  6/16,  6/16},
		{-7/16,  4/16, -7/16,  7/16,  5/16,  7/16},
		{-8/16, -4/16, -8/16,  8/16,  4/16,  8/16},
		{-7/16, -4/16, -6/16,  7/16, -5/16,  7/16},
		{-6/16, -5/16, -6/16,  6/16, -6/16,  6/16},
		{-4/16, -6/16, -4/16,  4/16, -8/16,  4/16},
	},
}

--------------------------------------------------

minetest.register_node("yamato_decors:chochin", {
	description = intl.chochin_desc,
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 12,

	tiles = {"yamato_chochin_top.png", "yamato_chochin_top.png", "yamato_chochin_side.png"},
	groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},

	node_box = node_box,
})

minetest.register_craft({
	output = "yamato_decors:chochin",
	recipe = {
		{"", "default:paper", ""},
		{"default:paper", "default:torch", "default:paper"},
		{"", "default:paper", ""},
	},
})
