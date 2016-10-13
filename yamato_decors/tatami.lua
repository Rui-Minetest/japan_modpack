-- intllib getter function
local S = yamato.get_intllib_getter()

--------------------------------------------------

local sunburnable_group   = {snappy = 3, flammable = 1, sunburnable = 1}
local unsunburnable_group = {snappy = 3, flammable = 1, sunburnable = 0}
local sounds              = default.node_sound_leaves_defaults()

local function abm_action(pos, node)
	local above_pos   = {x = pos.x, y = pos.y + 1, z = pos.z}
	local above_light = minetest.get_node_light(above_pos)

	if above_light == 15 then
		node.name = node.name .. "_sunburned"
		minetest.set_node(pos, node)
	end
end

--------------------------------------------------

minetest.register_node("yamato_decors:tatami", {
	description = S("Tatami"),
	paramtype2  = "facedir",
	
	tiles       = {"yamato_tatami.png", "yamato_tatami.png", "yamato_tatami.png^[transformR90"},
	groups      = sunburnable_group,
	sounds      = sounds
})

stairs.register_slab("tatami",
	"yamato_decors:tatami",
	sunburnable_group,
	{"yamato_tatami.png"},
	S("Half Tatami"),
	sounds
)

minetest.register_craft({
	output = "yamato_decors:tatami",
	recipe = {
		{"",              "farming:wheat",  ""             },
		{"farming:wheat", "farming:cotton", "farming:wheat"},
		{"",              "farming:wheat",  ""             }
	}
})

--------------------------------------------------

minetest.register_node("yamato_decors:tatami_borderless", {
	description = S("Borderless Tatami"),
	paramtype2  = "facedir",

	tiles       = {"yamato_tatami_borderless.png", "yamato_tatami_borderless.png", "yamato_tatami_borderless.png^[transformR90"},
	groups      = sunburnable_group,
	sounds      = sounds
})

stairs.register_slab("tatami_borderless",
	"yamato_decors:tatami_borderless",
	sunburnable_group,
	{"yamato_tatami_borderless.png"},
	S("Half Borderless Tatami"),
	sounds
)

minetest.register_craft({
	type   = "shapeless",
	output = "yamato_decors:tatami",
	recipe = {"yamato_decors:tatami_borderless"}
})

minetest.register_craft({
	type   = "shapeless",
	output = "yamato_decors:tatami_borderless",
	recipe = {"yamato_decors:tatami"}
})

minetest.register_craft({
	type   = "shapeless",
	output = "stairs:slab_tatami",
	recipe = {"stairs:slab_tatami_borderless"}
})

minetest.register_craft({
	type   = "shapeless",
	output = "stairs:slab_tatami_borderless",
	recipe = {"stairs:slab_tatami"}
})

--------------------------------------------------

minetest.register_node("yamato_decors:tatami_sunburned", {
	description = S("Sunburned Tatami"),
	paramtype2  = "facedir",

	tiles       = {"yamato_tatami_sunburned.png", "yamato_tatami_sunbuned.png", "yamato_tatami_sunburned.png^[transformR90"},
	groups      = unsunburnable_group,
	sounds      = sounds
})

stairs.register_slab("tatami_sunburned",
	"yamato_decors:tatami_sunburned",
	unsunburnable_group,
	{"yamato_tatami_sunburned.png"},
	S("Half Sunburned Tatami"),
	sounds
)

--------------------------------------------------

minetest.register_node("yamato_decors:tatami_borderless_sunburned", {
	description = S("Sunburned Borderless Tatami"),
	paramtype2  = "facedir",

	tiles       = {"yamato_tatami_borderless_sunburned.png", "yamato_tatami_borderless_sunburned.png", "yamato_tatami_borderless_sunburned.png^[transformR90"},
	groups      = unsunburnable_group,
	sounds      = sounds
})

stairs.register_slab("tatami_borderless_sunburned",
	"yamato_decors:tatami_borderless_sunburned",
	unsunburnable_group,
	{"yamato_tatami_borderless_sunburned.png"},
	S("Half Sunburned Borderless Tatami"),
	sounds
)

minetest.register_craft({
	type   = "shapeless",
	output = "yamato_decors:tatami_sunburned",
	recipe = {"yamato_decors:tatami_borderless_sunburned"}
})

minetest.register_craft({
	type   = "shapeless",
	output = "yamato_decors:tatami_borderless_sunburned",
	recipe = {"yamato_decors:tatami_sunburned"}
})

minetest.register_craft({
	type   = "shapeless",
	output = "stairs:slab_tatami_sunburned",
	recipe = {"stairs:slab_tatami_borderless_sunburned"}
})

minetest.register_craft({
	type   = "shapeless",
	output = "stairs:slab_tatami_borderless_sunburned",
	recipe = {"stairs:slab_tatami_sunburned"}
})

--------------------------------------------------

minetest.register_craft({
	type   = "shapeless",
	output = "yamato_decors:tatami",
	recipe = {"yamato_decors:tatami_sunburned", "farming:wheat"}
})

minetest.register_craft({
	type   = "shapeless",
	output = "yamato_decors:tatami_borderless",
	recipe = {"yamato_decors:tatami_borderless_sunburned", "farming:wheat"}
})

minetest.register_craft({
	type   = "shapeless",
	output = "stairs:slab_tatami",
	recipe = {"stairs:slab_tatami_sunburned", "farming:wheat"}
})

minetest.register_craft({
	type   = "shapeless",
	output = "stairs:slab_tatami_borderless",
	recipe = {"stairs:slab_tatami_borderless_sunburned", "farming:wheat"}
})

--------------------------------------------------

minetest.register_abm({
	nodenames = "group:sunburnable",
	interval  = 5,
	chance    = 2,
	action    = abm_action
})