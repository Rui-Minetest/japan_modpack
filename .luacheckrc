std = "lua51"

color = false
unused_args = false
allow_defined_top = true

ignore = {
	"42",
	"43"
}

read_globals = {
	-- Minetest
	"minetest",
	"vector",
	"Settings",
	"ItemStack",
	"PseudoRandom",
	"VoxelManip",
	"VoxelArea",

	-- Minetest Game
	"beds",
	"bucket",
	"creative",
	"default",
	"doors",
	"dye",
	"farming",
	"fire",
	"flowers",
	"give_initial_stuff",
	"nyancat",
	"screwdriver",
	"sethome",
	"stairs",
	"tnt",
	"walls",
	"xpanes",

	-- Others
	"intllib",
}