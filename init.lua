local butter_armor = {}
butter_armor.t = {}
local temp_color = "#FFFF00"
local defalut_cheese_power = .5 -- About as tough as chocolate.
local defalut_butter_power = defalut_cheese_power * .75 -- 25% less powerfull than chocolate
if minetest.get_modpath("farming") ~= nil and farming.mod == "redo" then
	butter_armor.t.cheese_vegan = {
		alias = "farming:cheese_vegan",
		description = "Vegan Cheese",
		color = "#e1bc59",  -- Sampled from the farming texture
		feeds = 1.5,
		power = defalut_cheese_power,
	}
end
if minetest.get_modpath("mobs") ~= nil then
	butter_armor.t.cheese = {
		alias = "mobs:cheese",
		alias_block = "mobs:cheeseblock",
		description = "Cheese",
		color = "#e1ce59",  -- Sampled from the mobs texture
		feeds = 3.5,
		power = defalut_cheese_power,
	}
	-- TODO there are two cheeses in my test world right now
	butter_armor.t.butter = {
		alias = "mobs:butter",
		description = "Butter",
		color = "#fdfe00",  -- Sampled from the mobs texture
		feeds = 0.5,
		power = defalut_butter_power,
	}
--elseif minetest.get_modpath("" then
end
for name, value in pairs(butter_armor.t) do
	minetest.log("error", name)
	local true_name = "butter_armor:" .. name -- Like in Eragon, one must reference things by their true name
	local node = minetest.registered_nodes[value.alias] or value
	instant_ores.register_metal({ -- cuz eating your armor is so metal
		name = true_name,
		description = node.description,
		artificial = true,  -- Provided by dependancies. (Last I checked, dairy products don't come from the earth)
		power = value.power, -- My power is beyond your understanding
		color = value.color,
	})
	if value.tools then
		value.tools = ediblestuff.make_tools_edible("butter_armor",name,value.feeds)
	end
	value.armor_types = ediblestuff.make_armor_edible_while_wearing("butter_armor",name,value.feeds)
	if value.alias then
		minetest.register_alias_force(true_name .. "_ingot", value.alias)
	end
	if value.alias_block then
		minetest.register_alias_force(true_name .. "block", value.alias_block)
	end
end
-- TODO mods that add cheese:
-- - mcl_morefood
-- - The cheese mod (with block?)
-- - mobs_animal (with block)
-- TODO mods that add butter
-- - The cheese mod (with block?)
-- - mobs_animal
