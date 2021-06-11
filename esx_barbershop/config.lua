Config = {}

Config.Price = 50

Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 1.5, y = 1.5, z = 1.0}
Config.MarkerColor  = {r = 102, g = 102, b = 204}
Config.MarkerType   = 1
Config.Locale = 'en'

Config.Zones = {}

Config.Shops = {
  vector3(-814.308, -183.823, 36.568),
  vector3(136.826, -1708.373, 28.291),
  vector3( -1282.604, -1116.757, 5.990),
  vector3(1931.513, 3729.671, 31.844),
  vector3( 1212.840, -472.921, 65.208),
  vector3(-32.885, -152.319, 56.076),
  vector3(-278.077, 6228.463, 30.695),
}

for i=1, #Config.Shops, 1 do

	Config.Zones['Shop_' .. i] = {
	 	Pos   = Config.Shops[i],
	 	Size  = Config.MarkerSize,
	 	Color = Config.MarkerColor,
	 	Type  = Config.MarkerType
  }

end
