yamato = {}

--------------------------------------------------

function yamato.get_intllib_getter()
	if minetest.get_modpath("intllib") then
		return intllib.Getter()
	end

	return (function(str)
		return str
	end)
end

--------------------------------------------------

function yamato.register_cyclic_craft(itemnames)
	local len = #itemnames
	for i = 1, len - 1 do
		minetest.register_craft({
			type   = "shapeless",
			output = itemnames[i + 1],
			recipe = {itemnames[i]}
		})
	end

	minetest.register_craft({
		type   = "shapeless",
		output = itemnames[1],
		recipe = {itemnames[len]}
	})
end