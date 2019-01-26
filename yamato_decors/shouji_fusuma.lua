local function register(name, def)
	local groups = {
		choppy = 2,
		oddly_breakable_by_hand = 2,
		flammable = 2,
		not_in_creative_inventory = 0,
	}

	local nodebox_type1 = {
		{-0.5, -0.5, -0.0625, 0.5, 0.5, 0.0},
	}

	local nodebox_type2 = {
		{-0.5, -0.5, 0.0, 0.5, 0.5, 0.0625},
	}

	local nodebox_type3 = {
		{-0.5, -0.5, -0.0625, 0.5, 0.5, 0.0625},
	}

	local selection_box_type1 = {
		{-0.5, -0.5, -0.0625, 0.5, 1.5, 0.0},
	}

	local selection_box_type2 = {
		{-0.5, -0.5, 0, 0.5, 1.5, 0.0625},
	}

	local selection_box_type3 = {
		{-0.5, -0.5, -0.0625, 0.5, 1.5, 0.0625},
	}

	local function calc_space(facedir, pos, base)
		-- res[1] = left bottom,  res[2] = left top
		-- res[3] = right bottom, res[4] = right top
		if base == 1 or base == 2 then
			local diff
			if facedir == 0 then
				diff = {x = 1, y = 0, z = 0}
			elseif facedir == 1 then
				diff = {x = 0, y = 0, z = -1}
			elseif facedir == 2 then
				diff = {x = -1, y = 0, z = 0}
			elseif facedir == 3 then
				diff = {x = 0, y = 0, z = 1}
			end
			local res = {}
			if base == 1 then
				res[1] = pos
				res[2] = vector.add(res[1], {x = 0, y = 1, z = 0})
			elseif base == 2 then
				res[2] = pos
				res[1] = vector.add(res[2], {x = 0, y = -1, z = 0})
			end
			res[3] = vector.add(res[1], diff)
			res[4] = vector.add(res[2], diff)
			return res
		elseif base == 3 or base == 4 then
			local diff
			if facedir == 0 then
				diff = {x = -1, y = 0, z = 0}
			elseif facedir == 1 then
				diff = {x = 0, y = 0, z = 1}
			elseif facedir == 2 then
				diff = {x = 1, y = 0, z = 0}
			elseif facedir == 3 then
				diff = {x = 0, y = 0, z = -1}
			end
			local res = {}
			if base == 3 then
				res[3] = pos
				res[4] = vector.add(res[3], {x = 0, y = 1, z = 0})
			elseif base == 4 then
				res[4] = pos
				res[3] = vector.add(res[4], {x = 0, y = -1, z = 0})
			end
			res[1] = vector.add(res[3], diff)
			res[2] = vector.add(res[4], diff)
			return res
		end
	end

	local function place_nodes(poss, category, param2)
		for i = 1, 4 do
			minetest.set_node(poss[i], {name = name.."_"..tostring(category).."_"..tostring(i), param2 = param2})
		end
	end

	local function gen_after_dig_node(base)
		return function(pos, oldnode, oldmetadata, digger)
			local poss = calc_space(oldnode.param2, pos, base)
			for i = 1, 4 do
				if poss[i] ~= pos then
					minetest.remove_node(poss[i])
				end
			end
		end
	end

	do -- left and right
		local function gen_on_rightclick(base)
			return function(pos, node, player, itemstack, pointed_thing)
				local poss = calc_space(node.param2, pos, base)
				if base == 1 or base == 2 then
					place_nodes(poss, 3, node.param2)
				elseif base == 3 or base == 4 then
					place_nodes(poss, 2, node.param2)
				end
			end
		end

		minetest.register_node(name.."_1_1", { -- "left bottom"
			drawtype = "nodebox",
			paramtype = "light",
			paramtype2 = "facedir",
			groups = groups,
			node_box = {
				type = "fixed",
				fixed = nodebox_type1,
			},
			selection_box = {
				type = "fixed",
				fixed = selection_box_type1,
			},
			tiles = {def.tiles[1], def.tiles[1], def.tiles[2], def.tiles[2], def.tiles[5], def.tiles[3]},
			drop = name,
			on_rightclick = gen_on_rightclick(1),
			after_dig_node = gen_after_dig_node(1),
		})

		minetest.register_node(name.."_1_2", { -- "left top"
			drawtype = "nodebox",
			paramtype = "light",
			paramtype2 = "facedir",
			pointable = false,
			groups = groups,
			node_box = {
				type = "fixed",
				fixed = nodebox_type1,
			},
			tiles = {def.tiles[1], def.tiles[1], def.tiles[2], def.tiles[2], def.tiles[6], def.tiles[4]},
		})

		minetest.register_node(name.."_1_3", { -- "right bottom"
			drawtype = "nodebox",
			paramtype = "light",
			paramtype2 = "facedir",
			groups = groups,
			node_box = {
				type = "fixed",
				fixed = nodebox_type2,
			},
			selection_box = {
				type = "fixed",
				fixed = selection_box_type2,
			},
			tiles = {def.tiles[1], def.tiles[1], def.tiles[2], def.tiles[2], def.tiles[3], def.tiles[5]},
			drop = name,
			on_rightclick = gen_on_rightclick(3),
			after_dig_node = gen_after_dig_node(3),
		})

		minetest.register_node(name.."_1_4", { -- "right top"
			drawtype = "nodebox",
			paramtype = "light",
			paramtype2 = "facedir",
			pointable = false,
			groups = groups,
			node_box = {
				type = "fixed",
				fixed = nodebox_type2,
			},
			tiles = {def.tiles[1], def.tiles[1], def.tiles[2], def.tiles[2], def.tiles[4], def.tiles[6]},
		})
	end

	do -- left or right
		local function gen_on_rightclick(base)
			return function(pos, node, player, itemstack, pointed_thing)
				local poss = calc_space(node.param2, pos, base)
				place_nodes(poss, 1, node.param2)
			end
		end

		do -- left only
			minetest.register_node(name.."_2_1", { -- "left bottom"
				drawtype = "nodebox",
				paramtype = "light",
				paramtype2 = "facedir",
				groups = groups,
				node_box = {
					type = "fixed",
					fixed = nodebox_type3,
				},
				selection_box = {
					type = "fixed",
					fixed = selection_box_type3,
				},
				tiles = {def.tiles[1], def.tiles[1], def.tiles[2], def.tiles[2], def.tiles[3], def.tiles[3]},
				drop = name,
				on_rightclick = gen_on_rightclick(1),
				after_dig_node = gen_after_dig_node(1),
			})

			minetest.register_node(name.."_2_2", { -- "left top"
				drawtype = "nodebox",
				paramtype = "light",
				paramtype2 = "facedir",
				pointable = false,
				groups = groups,
				node_box = {
					type = "fixed",
					fixed = nodebox_type3,
				},
				tiles = {def.tiles[1], def.tiles[1], def.tiles[2], def.tiles[2], def.tiles[4], def.tiles[4]},
			})

			minetest.register_node(name.."_2_3", { -- "right bottom"
				drawtype = "airlike",
				paramtype2 = "facedir",
				pointable = false,
				walkable = false,
				groups = groups,
			})

			minetest.register_node(name.."_2_4", { -- "right top"
				drawtype = "airlike",
				paramtype2 = "facedir",
				pointable = false,
				walkable = false,
				groups = groups,
			})
		end

		do -- right only
			minetest.register_node(name.."_3_1", { -- "left bottom"
				drawtype = "airlike",
				paramtype2 = "facedir",
				pointable = false,
				walkable = false,
				groups = groups,
			})

			minetest.register_node(name.."_3_2", {
				drawtype = "airlike",
				paramtype2 = "facedir",
				pointable = false,
				walkable = false,
				groups = groups,
			})

			minetest.register_node(name.."_3_3", {
				drawtype = "nodebox",
				paramtype = "light",
				paramtype2 = "facedir",
				groups = groups,
				node_box = {
					type = "fixed",
					fixed = nodebox_type3,
				},
				selection_box = {
					type = "fixed",
					fixed = selection_box_type3,
				},
				tiles = {def.tiles[1], def.tiles[1], def.tiles[2], def.tiles[2], def.tiles[3], def.tiles[3]},
				drop = name,
				on_rightclick = gen_on_rightclick(3),
				after_dig_node = gen_after_dig_node(3),
			})

			minetest.register_node(name.."_3_4", {
				drawtype = "nodebox",
				paramtype = "light",
				paramtype2 = "facedir",
				pointable = false,
				groups = groups,
				node_box = {
					type = "fixed",
					fixed = nodebox_type3,
				},
				tiles = {def.tiles[1], def.tiles[1], def.tiles[2], def.tiles[2], def.tiles[4], def.tiles[4]},
			})
		end
	end

	do
		local function can_place(poss)
			for i = 1, 4 do
				if minetest.get_node(poss[i]).name ~= "air" then
					return false
				end
			end
			return true
		end

		local function on_place(itemstack, placer, pointed_thing)
			local facedir = minetest.dir_to_facedir(placer:get_look_dir())
			local poss = calc_space(facedir, pointed_thing.above, 1)
			if not can_place(poss) then
				return nil
			end
			for i = 1, 4 do
				minetest.set_node(poss[i], {name = name.."_1_"..tostring(i), param2 = facedir})
			end
			itemstack:take_item()
			return itemstack
		end

		minetest.register_craftitem(name, {
			description = def.description,
			inventory_image = def.inventory_image,
			on_place = on_place,
		})
	end
end

register("yamato_decors:fusuma1", {
	description = "Fusuma Type 1",
	inventory_image = "yamato_fusuma1.png",
	tiles = {
		"yamato_fusuma_common_top_1.png",
		"yamato_fusuma_common_side_1.png",
		"yamato_fusuma1_front_bottom.png",
		"yamato_fusuma1_front_top.png",
		"yamato_fusuma1_front_bottom.png^[transformFX",
		"yamato_fusuma1_front_top.png^[transformFX",
	},
})

register("yamato_decors:fusuma2", {
	description = "Fusuma Type 2",
	inventory_image = "yamato_fusuma2.png",
	tiles = {
		"yamato_fusuma_common_top_1.png",
		"yamato_fusuma_common_side_1.png",
		"yamato_fusuma2_front_bottom.png",
		"yamato_fusuma2_front_top.png",
		"yamato_fusuma2_front_bottom.png^[transformFX",
		"yamato_fusuma2_front_top.png^[transformFX",
	},
})

register("yamato_decors:shouji1", {
	description = "Shouji Type 1",
	inventory_image = "yamato_shouji1.png",
	tiles = {
		"yamato_shouji_common_top_1.png",
		"yamato_shouji_common_side_1.png",
		"yamato_shouji1_front_bottom.png",
		"yamato_shouji1_front_top.png",
		"yamato_shouji1_front_bottom.png^[transformFX",
		"yamato_shouji1_front_top.png^[transformFX",
	},
})

minetest.register_craft({
	output = "yamato_decors:fusuma1",
	recipe = {
		{"group:wood", "default:paper", "group:wood"},
		{"group:wood", "default:paper", "group:wood"},
		{"group:wood", "default:paper", "group:wood"},
	},
})

minetest.register_craft({
	output = "yamato_decors:shouji1",
	recipe = {
		{"default:stick", "default:paper", "default:stick"},
		{"default:stick", "default:paper", "default:stick"},
		{"default:wood", "default:wood", "default:wood"},
	},
})

yamato.register_cyclic_craft("yamato_decors:fusuma", 2)
