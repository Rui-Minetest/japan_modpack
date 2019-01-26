local S = yamato.intllib_getter()

local intl = {
	wadansu_desc = S("Wadansu"),
}

local tiles = {
	"yamato_wadansu.png", "yamato_wadansu.png",
	"yamato_wadansu.png", "yamato_wadansu.png",
	"yamato_wadansu.png", "yamato_wadansu.png^yamato_wadansu_front.png"
}

local formspec = "size[9,10]"
	.. "list[current_name;main;0,0;9,6;]"
	.. "list[current_player;main;0,6.2;8,1;]"
	.. "list[current_player;main;0,7.3;8,3;8]"
	.. "listring[current_name;main]"
	.. "listring[current_player;main]"
	.. default.get_hotbar_bg(0, 6.2)

local function can_dig(pos)
	return minetest.get_meta(pos):get_inventory():is_empty("main")
end

local function on_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec", formspec)
	meta:set_string("infotext", intl.wadansu_desc)
	meta:get_inventory():set_size("main", 54)
end

--------------------------------------------------

minetest.register_node("yamato_decors:wadansu", {
	description = intl.wadansu_desc,
	paramtype2 = "facedir",

	tiles = tiles,
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_wood_defaults(),

	can_dig = can_dig,
	on_construct = on_construct
})

minetest.register_craft({
	recipe = {
		{"group:tree", "group:tree", "group:tree"},
		{"group:tree", "", "group:tree"},
		{"group:tree", "group:tree", "group:tree"},
	},
	output = "yamato_decors:wadansu",
})
