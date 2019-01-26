local S = yamato.intllib_getter()

local intl = {
	tatami_desc = S("Tatami"),
	tatami_borderless_desc = S("Borderless Tatami"),
	tatami_sunburned_desc = S("Tatami (Sunburned)"),
	tatami_sunburned_borderless_desc = S("Borderless Tatami (Sunburned)"),
	tatami_antisunburn_desc = S("Tatami (Anti-Sunburn)"),
	tatami_antisunburn_borderless_desc = S("Borderless Tatami (Anti-Sunburn)"),

	half_tatami_desc = S("Half Tatami"),
	half_tatami_borderless_desc = S("Half Borderless Tatami"),
	half_tatami_sunburned_desc = S("Half Tatami (Sunburned)"),
	half_tatami_sunburned_borderless_desc = S("Half Borderless Tatami (Sunburned)"),
	half_tatami_antisunburn_desc = S("Half Tatami (Anti-Sunburn)"),
	half_tatami_antisunburn_borderless_desc = S("Half Borderless Tatami (Anti-Sunburn)"),
}

local sunburnable_group = {snappy = 3, flammable = 1, sunburnable = 1}
local unsunburnable_group = {snappy = 3, flammable = 1}
local sounds = default.node_sound_leaves_defaults()

-- 日焼けする
-- 日焼けノードの名前は最後に"_sunburned"をつける
local function sunburn(pos, node)
	local above_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
	local above_light = minetest.get_node_light(above_pos)

	if above_light == 15 then
		node.name = node.name .. "_sunburned"
		minetest.set_node(pos, node)
	end
end

local function switch_craft(node1, node2)
	minetest.register_craft({
		type = "shapeless",
		recipe = {node1},
		output = node2,
	})

	minetest.register_craft({
		type = "shapeless",
		recipe = {node2},
		output = node1,
	})
end

-- 日焼けした畳はfarming:wheatで修復できる
local function repair_craft(from, to)
	minetest.register_craft({
		type = "shapeless",
		recipe = {from, "farming:wheat"},
		output = to,
	})
end

--------------------------------------------------

minetest.register_abm({
	nodenames = "group:sunburnable",
	interval = 30,
	chance = 10,
	action = sunburn
})

minetest.register_node("yamato_decors:tatami", {
	description = intl.tatami_desc,
	paramtype2 = "facedir",

	tiles = {"yamato_tatami.png", "yamato_tatami.png", "yamato_tatami.png^[transformR90"},
	groups = sunburnable_group,
	sounds = sounds
})

minetest.register_node("yamato_decors:tatami_borderless", {
	description = intl.tatami_borderless_desc,
	paramtype2 = "facedir",

	tiles = {
		"yamato_tatami_borderless.png",
		"yamato_tatami_borderless.png",
		"yamato_tatami_borderless.png^[transformR90",
	},

	groups = sunburnable_group,
	sounds = sounds,
})

minetest.register_node("yamato_decors:tatami_sunburned", {
	description = intl.tatami_sunburned_desc,
	paramtype2 = "facedir",

	tiles = {
		"yamato_tatami_sunburned.png",
		"yamato_tatami_sunburned.png",
		"yamato_tatami_sunburned.png^[transformR90",
	},

	groups = unsunburnable_group,
	sounds = sounds,
})

minetest.register_node("yamato_decors:tatami_borderless_sunburned", {
	description = intl.tatami_sunburned_borderless_desc,
	paramtype2 = "facedir",

	tiles = {
		"yamato_tatami_borderless_sunburned.png",
		"yamato_tatami_borderless_sunburned.png",
		"yamato_tatami_borderless_sunburned.png^[transformR90",
	},

	groups = unsunburnable_group,
	sounds = sounds,
})

minetest.register_node("yamato_decors:tatami_antisunburn", {
	description = intl.tatami_antisunburn_desc,
	paramtype2 = "facedir",

	tiles = {"yamato_tatami.png", "yamato_tatami.png", "yamato_tatami.png^[transformR90"},
	groups = unsunburnable_group,
	sounds = sounds
})

minetest.register_node("yamato_decors:tatami_borderless_antisunburn", {
	description = intl.tatami_antisunburn_borderless_desc,
	paramtype2 = "facedir",

	tiles = {
		"yamato_tatami_borderless.png",
		"yamato_tatami_borderless.png",
		"yamato_tatami_borderless.png^[transformR90",
	},

	groups = unsunburnable_group,
	sounds = sounds,
})

stairs.register_slab("tatami",
	"yamato_decors:tatami",
	sunburnable_group,
	{"yamato_tatami.png"},
	intl.half_tatami_desc,
	sounds
)

stairs.register_slab("tatami_borderless",
	"yamato_decors:tatami_borderless",
	sunburnable_group,
	{"yamato_tatami_borderless.png"},
	intl.half_tatami_borderless_desc,
	sounds
)

stairs.register_slab("tatami_sunburned",
	"yamato_decors:tatami_sunburned",
	unsunburnable_group,
	{"yamato_tatami_sunburned.png"},
	intl.half_tatami_sunburned_desc,
	sounds
)

stairs.register_slab("tatami_borderless_sunburned",
	"yamato_decors:tatami_borderless_sunburned",
	unsunburnable_group,
	{"yamato_tatami_borderless_sunburned.png"},
	intl.half_tatami_sunburned_borderless_desc,
	sounds
)

stairs.register_slab("tatami_antisunburn",
	"yamato_decors:tatami_antisunburn",
	unsunburnable_group,
	{"yamato_tatami.png"},
	intl.half_tatami_antisunburn_desc,
	sounds
)

stairs.register_slab("tatami_borderless_antisunburn",
	"yamato_decors:tatami_borderless_antisunburn",
	unsunburnable_group,
	{"yamato_tatami_borderless.png"},
	intl.half_tatami_antisunburn_borderless_desc,
	sounds
)

minetest.register_craft({
	recipe = {
		{"", "farming:wheat", ""},
		{"farming:wheat", "farming:cotton", "farming:wheat"},
		{"", "farming:wheat", ""}
	},
	output = "yamato_decors:tatami",
})

minetest.register_craft({
	type = "shapeless",
	recipe = {"yamato_decors:tatami", "default:mese_crystal_fragment"},
	output = "yamato_decors:tatami_antisunburn",
})

minetest.register_craft({
	type = "shapeless",
	recipe = {"yamato_decors:tatami_borderless", "default:mese_crystal_fragment"},
	output = "yamato_decors:tatami_borderless_antisunburn",
})

switch_craft("yamato_decors:tatami", "yamato_decors:tatami_borderless")
switch_craft("yamato_decors:tatami_sunburned", "yamato_decors:tatami_borderless_sunburned")
switch_craft("yamato_decors:tatami_antisunburn", "yamato_decors:tatami_borderless_antisunburn")
switch_craft("stairs:slab_tatami", "stairs:slab_tatami_borderless")
switch_craft("stairs:slab_tatami_sunburned", "stairs:slab_tatami_borderless_sunburned")
switch_craft("stairs:slab_tatami_antisunburn", "stairs:slab_tatami_borderless_antisunburn")

repair_craft("yamato_decors:tatami_sunburned", "yamato_decors:tatami")
repair_craft("yamato_decors:tatami_borderless_sunburned", "yamato_decors:tatami_borderless")
repair_craft("stairs:slab_tatami_sunburned", "stairs:slab_tatami")
repair_craft("stairs:slab_tatami_borderless_sunburned", "stairs:slab_tatami_borderless")
