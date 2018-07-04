local Recipe = {}

Recipe.ID = 1

Recipe.Name = "Wood Fence"
Recipe.Category = "Props"

Recipe.Components = {{["ID"] = 4, ["Quantity"] = 8}}

Recipe.ItemID = {["ID"] = 5, ["Quantity"] = 1}

GM:LoadRecipe(Recipe)

local Recipe = {}

Recipe.ID = 2

Recipe.Name = "Half Wood Fence X 2"
Recipe.Category = "Props"

Recipe.Components = {{["ID"] = 5, ["Quantity"] = 1}}

Recipe.ItemID = {["ID"] = 6, ["Quantity"] = 2}

GM:LoadRecipe(Recipe)

local Recipe = {}

Recipe.ID = 3

Recipe.Name = "Combine Half Wood Fence"
Recipe.Category = "Props"

Recipe.Components = {{["ID"] = 6, ["Quantity"] = 2}}

Recipe.ItemID = {["ID"] = 5, ["Quantity"] = 1}

GM:LoadRecipe(Recipe)

local Recipe = {}

Recipe.ID = 4

Recipe.Name = "Half Wood Fence"
Recipe.Category = "Props"

Recipe.Components = {{["ID"] = 4, ["Quantity"] = 4}}

Recipe.ItemID = {["ID"] = 6, ["Quantity"] = 1}

GM:LoadRecipe(Recipe)