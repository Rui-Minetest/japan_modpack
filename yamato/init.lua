yamato = {}

function yamato.intllib_getter()
	if minetest.get_modpath("intllib") then
		return intllib.Getter()
	end

	return (function(str)
		return str
	end)
end

-- アイテム名が連番のものをクラフトで切り替えられるようにする
--[[
yamato.register_cyclic_craft("test:t_", 10)       -- test:t_1 ~ test:t_10
yamato.register_cyclic_craft("test:t_", {0, 11})  -- test:t_0 ~ test:t_11
yamato.register_cyclic_craft("test:t_", 10, "_t") -- test:t_1_t ~ test:t_10_t
]]
function yamato.register_cyclic_craft(itemname_prefix, range, itemname_suffix)
	itemname_suffix = itemname_suffix or ""

	-- 数字とテーブルによる範囲の両方に対応
	local first, last
	if type(range) == "table" then
		first = range[0]
		last = range[1]
	else
		first = 1
		last = range
	end

	local itemfmt = itemname_prefix .. "%d" .. itemname_suffix

	for i = first, last - 1 do
		minetest.register_craft({
			type = "shapeless",
			recipe = {itemfmt:format(i)},
			output = itemfmt:format(i + 1),
		})
	end

	minetest.register_craft({
		type = "shapeless",
		recipe = {itemfmt:format(last)},
		output = itemfmt:format(1),
	})
end
