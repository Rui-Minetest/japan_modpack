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

function yamato.register_cyclic_craft(itemname_prefix, max, itemname_suffix)
	itemname_suffix = itemname_suffix or ""

	local itemname = itemname_prefix .. "%d" .. itemname_suffix

	for i = 1, max - 1 do
		minetest.register_craft({
			type   = "shapeless",
			output = itemname:format(i + 1),
			recipe = {itemname:format(i)}
		})
	end

	minetest.register_craft({
		type   = "shapeless",
		output = itemname:format(1),
		recipe = {itemname:format(max)}
	})
end