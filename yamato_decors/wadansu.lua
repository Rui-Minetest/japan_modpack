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

local tiles = {
	"yamato_wadansu.png", "yamato_wadansu.png",
	"yamato_wadansu.png", "yamato_wadansu.png",
	"yamato_wadansu.png", "yamato_wadansu.png^yamato_wadansu_front.png"
}

local function can_dig(pos)
	local meta      = minetest.get_meta(pos)
	local inventory = meta:get_inventory()

	return inventory:is_empty("main")
end

local formspec = "size[9,10]"
	.. default.gui_bg
	.. default.gui_bg_img
	.. default.gui_slots
	.. "list[current_name;main;0,0;9,6;]"
	.. "list[current_player;main;0,6.2;8,1;]"
	.. "list[current_player;main;0,7.3;8,3;8]"
	.. "listring[current_name;main]"
	.. "listring[current_player;main]"
	.. default.get_hotbar_bg(0, 6.2)

local function on_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec", formspec)
	meta:set_string("infotext", S("Wadansu"))

	local inventory = meta:get_inventory()
	inventory:set_size("main", 54)
end

--------------------------------------------------

minetest.register_node("yamato_decors:wadansu", {
	description  = S("Wadansu"),
	paramtype2   = "facedir",

	tiles        = tiles,
	groups       = {choppy = 2, oddly_breakable_by_hand = 2},
	sounds       = default.node_sound_wood_defaults(),

	can_dig      = can_dig,
	on_construct = on_construct
})

minetest.register_craft({
	output = "yamato_decors:wadansu",
	recipe = {
		{"group:tree", "group:tree", "group:tree"},
		{"group:tree", "",           "group:tree"},
		{"group:tree", "group:tree", "group:tree"}
	}
})