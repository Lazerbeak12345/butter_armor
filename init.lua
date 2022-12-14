local butter_armor = {
	t = {},
	m = {
		farming_redo = minetest.get_modpath("farming") ~= nil and farming.mod == "redo",
		mobs_animal = minetest.get_modpath("mobs_animal") ~= nil,
	}
}
local default_cheese_power = .5 -- About as tough as chocolate.
local default_butter_power = default_cheese_power * .75 -- 25% less powerfull than chocolate
if butter_armor.m.farming_redo then
	butter_armor.t.cheese_vegan = {
		alias = "farming:cheese_vegan",
		description = "Vegan Cheese",
		color = "#e1bc59",  -- Sampled from the farming texture
		feeds = 1.5,
		power = default_cheese_power,
	}
end
-- "Default cheese"
if butter_armor.m.mobs_animal then
	butter_armor.t.cheese = {
		alias = "mobs:cheese",
		alias_block = "mobs:cheeseblock",
		description = "Cheese",
		color = "#e1ce59",  -- Sampled from the mobs texture
		feeds = 3.5,
		power = default_cheese_power,
	}
	-- TODO there are two cheeses in my test world right now
end
-- "Default butter"
if butter_armor.m.mobs_animal then
	butter_armor.t.butter = {
		alias = "mobs:butter",
		description = "Butter",
		color = "#fdfe00",  -- Sampled from the mobs texture
		feeds = 0.5,
		power = default_butter_power,
	}
end
for name, value in pairs(butter_armor.t) do
	local true_name = "butter_armor:" .. name -- Like in Eragon, one must reference things by their true name
	local node = minetest.registered_nodes[value.alias] or value
	instant_ores.register_metal({
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
