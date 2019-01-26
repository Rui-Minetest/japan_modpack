local S = yamato.intllib_getter()

local intl = {
	andon_desc = S("Andon"),
}

local node_box = {
	type = "fixed",
	fixed = {
		{-4/16, -8/16, -4/16, -3/16,  8/16, -3/16},
		{-4/16, -8/16,  3/16, -3/16,  8/16,  4/16},
		{ 3/16, -8/16, -4/16,  4/16,  8/16, -3/16},
		{ 3/16, -8/16,  3/16,  4/16,  8/16,  4/16},
		{-3/16, -4/16, -3/16,  3/16,  6/16,  3/16},
		{-4/16, -5/16, -4/16,  4/16, -4/16,  4/16},
		{-4/16,  6/16, -4/16, -3/16,  7/16,  4/16},
		{-3/16,  6/16,  3/16,  3/16,  7/16,  4/16},
		{-3/16,  6/16, -4/16,  3/16,  7/16, -3/16},
		{ 3/16,  6/16, -3/16,  4/16,  7/16,  3/16},
	},
}

local selection_box = {
	type = "fixed",
	fixed = {-4/16, -8/16, -4/16, 4/16, 7/16, 4/16},
}

local number_of_textures = 1

-----------------------------------------------

for i = 1, number_of_textures do
	local texture_of_left_and_right = "yamato_andon_side_paper.png"
		.. "^yamato_andon_side_frame.png"

	local texture_of_back_and_front = "yamato_andon_side_paper.png"
		.. "^yamato_andon_side_" .. i .. ".png"
		.. "^yamato_andon_side_frame.png"

	local tiles = {
		"yamato_andon_top.png", "yamato_andon_bottom.png",
		texture_of_left_and_right, texture_of_left_and_right,
		texture_of_back_and_front, texture_of_back_and_front,
	}

	minetest.register_node("yamato_decors:andon_" .. i, {
		description = intl.andon_desc,
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		light_source = 11,

		tiles = tiles,
		groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},

		node_box = node_box,
		selection_box = selection_box,
	})
end

minetest.register_craft({
	output = "yamato_decors:andon_1",
	recipe = {
		{"default:stick", "default:paper", "default:stick"},
		{"default:paper", "default:torch", "default:paper"},
		{"default:stick", "default:paper", "default:stick"},
	}
})

yamato.register_cyclic_craft("yamato_decors:andon_", number_of_textures)
