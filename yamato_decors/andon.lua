-- intllib function
local S = (function()
	if minetest.get_modpath("intllib") then
		return intllib.Getter()
	end

	return (function(str)
		return str
	end)
end)()

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

minetest.register_node("yamato_decors:andon", {
	description   = S("Andon"),
	drawtype      = "nodebox",
	paramtype     = "light",
	light_source  = 11,

	tiles         = {"yamato_andon_top.png", "yamato_andon_bottom.png", "yamato_andon_side.png"},
	groups        = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},

	node_box      = node_box,
	selection_box = selection_box
})

minetest.register_craft({
	output = "yamato_decors:andon",
	recipe = {
		{"default:stick", "default:paper", "default:stick"},
		{"default:paper", "default:torch", "default:paper"},
		{"default:stick", "default:paper", "default:stick"}
	}
})