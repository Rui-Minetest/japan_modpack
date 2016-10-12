-- intllib getter function
local S = yamato.get_intllib_getter()

-- A number of the textures
local number_of_textures = 1

--------------------------------------------------

local node_box = {
	type  = "fixed",
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
		{ 3/16,  6/16, -3/16,  4/16,  7/16,  3/16}
	}
}

local selection_box = {
	type  = "fixed",
	fixed = {-4/16, -8/16, -4/16, 4/16, 7/16, 4/16}
}

--------------------------------------------------

for i = 1, number_of_textures do
	local texture = "yamato_andon_side_paper.png"
		.. "^yamato_andon_side" .. i
		.. "^yamato_andon_side_frame"

	local tiles = {
		"yamato_andon_top.png",  "yamato_andon_bottom.png",
		"yamato_andon_side.png", "yamato_andon_side.png",
		texture,                 texture
	}

	minetest.register_node("yamato_decors:andon_" .. i, {
		description   = S("Andon"),
		drawtype      = "nodebox",
		paramtype     = "light",
		paramtype2    = "facedir",
		light_source  = 11,

		tiles         = tiles,
		groups        = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},

		node_box      = node_box,
		selection_box = selection_box
	})
end

minetest.register_craft({
	output = "yamato_decors:andon_1",
	recipe = {
		{"default:stick", "default:paper", "default:stick"},
		{"default:paper", "default:torch", "default:paper"},
		{"default:stick", "default:paper", "default:stick"}
	}
})

-- [[
local nodenames = (function()
	local nodenames = {}

	for i = 1, number_of_textures do
		local nodename = "yamato_decors:andon_" .. i
		table.insert(nodenames, nodename)
	end

	return nodenames
end)()

yamato.register_cyclic_craft(nodenames)
-- ]]