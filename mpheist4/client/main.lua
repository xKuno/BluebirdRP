-- Made By KrizFrost
local IslandZone = BoxZone:Create(vector3(5113.64, -5141.78, 2.25), 7500, 7500, {
    name = "island",
    heading = 0,
    debugPoly = false
})

local insideIslandZone = false


Citizen.CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local coord = GetEntityCoords(plyPed)
        insideIslandZone = IslandZone:isPointInside(coord)
        Citizen.Wait(500)
    end
end)






IslandZone:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
	
  RequestIpl("h4_mph4_terrain_lod")
  RequestIpl("h4_mph4_terrain_06_strm_0")
  RequestIpl("h4_mph4_terrain_06")
  RequestIpl("h4_mph4_terrain_05")
  RequestIpl("h4_mph4_terrain_04")
  RequestIpl("h4_mph4_terrain_03")
  RequestIpl("h4_mph4_terrain_02")
  RequestIpl("h4_mph4_terrain_01_long_0")
  RequestIpl("h4_mph4_terrain_01")
  RequestIpl("h4_islandx_terrain_props_06_c_slod")
  RequestIpl("h4_islandx_terrain_props_06_c_lod")
  RequestIpl("h4_islandx_terrain_props_06_c")
  RequestIpl("h4_islandx_terrain_props_06_b_slod")
  RequestIpl("h4_islandx_terrain_props_06_b_lod")
  RequestIpl("h4_islandx_terrain_props_06_b")
  RequestIpl("h4_islandx_terrain_props_06_a_slod")
  RequestIpl("h4_islandx_terrain_props_06_a_lod")
  RequestIpl("h4_islandx_terrain_props_06_a")
  RequestIpl("h4_islandx_terrain_props_05_f_slod")
  RequestIpl("h4_islandx_terrain_props_05_f_lod")
  RequestIpl("h4_islandx_terrain_props_05_f")
  RequestIpl("h4_islandx_terrain_props_05_e_slod")
  RequestIpl("h4_islandx_terrain_props_05_e_lod")
  RequestIpl("h4_islandx_terrain_props_05_e")
  RequestIpl("h4_islandx_terrain_props_05_d_slod")
  RequestIpl("h4_islandx_terrain_props_05_d_lod")
  RequestIpl("h4_islandx_terrain_props_05_d")
  RequestIpl("h4_islandx_terrain_props_05_c_lod")
  RequestIpl("h4_islandx_terrain_props_05_c")
  RequestIpl("h4_islandx_terrain_props_05_b_lod")
  RequestIpl("h4_islandx_terrain_props_05_b")
  RequestIpl("h4_islandx_terrain_props_05_a_lod")
  RequestIpl("h4_islandx_terrain_props_05_a")
  RequestIpl("h4_islandx_terrain_06_slod")
  RequestIpl("h4_islandx_terrain_06_lod")
  RequestIpl("h4_islandx_terrain_06")
  RequestIpl("h4_islandx_terrain_05_slod")
  RequestIpl("h4_islandx_terrain_05_lod")
  RequestIpl("h4_islandx_terrain_05")
  RequestIpl("h4_islandx_terrain_04_slod")
  RequestIpl("h4_islandx_terrain_04_lod")
  RequestIpl("h4_islandx_terrain_04")
  RequestIpl("h4_islandx_terrain_03_lod")
  RequestIpl("h4_islandx_terrain_03")
  RequestIpl("h4_islandx_terrain_02_slod")
  RequestIpl("h4_islandx_terrain_02_lod")
  RequestIpl("h4_islandx_terrain_02")
  RequestIpl("h4_islandx_terrain_01_slod")
  RequestIpl("h4_islandx_terrain_01_lod")
  RequestIpl("h4_islandx_terrain_01")

  RemoveIpl("h4_mph4_island_placement")
   RemoveIpl("h4_islandx_placement_10")
   RemoveIpl("h4_islandx_placement_09")
   RemoveIpl("h4_islandx_placement_08")
   RemoveIpl("h4_islandx_placement_07")
   RemoveIpl("h4_islandx_placement_06")
   RemoveIpl("h4_islandx_placement_05")
   RemoveIpl("h4_islandx_placement_04")
   RemoveIpl("h4_islandx_placement_03")
   RemoveIpl("h4_islandx_placement_02")
   RemoveIpl("h4_islandx_placement_01")

  RequestIpl("h4_underwater_gate_closed")
  RequestIpl("h4_sw_ipl_09_slod")
  RequestIpl("h4_sw_ipl_09_lod")
  RequestIpl("h4_sw_ipl_09")
  RequestIpl("h4_sw_ipl_08_slod")
  RequestIpl("h4_sw_ipl_08_lod")
  RequestIpl("h4_sw_ipl_08")
  RequestIpl("h4_sw_ipl_07_slod")
  RequestIpl("h4_sw_ipl_07_lod")
  RequestIpl("h4_sw_ipl_07")
  RequestIpl("h4_sw_ipl_06_slod")
  RequestIpl("h4_sw_ipl_06_lod")
  RequestIpl("h4_sw_ipl_06")
  RequestIpl("h4_sw_ipl_05_slod")
  RequestIpl("h4_sw_ipl_05_lod")
  RequestIpl("h4_sw_ipl_05")
  RequestIpl("h4_sw_ipl_04_slod")
  RequestIpl("h4_sw_ipl_04_lod")
  RequestIpl("h4_sw_ipl_04")
  RequestIpl("h4_sw_ipl_03_slod")
  RequestIpl("h4_sw_ipl_03_lod")
  RequestIpl("h4_sw_ipl_03")
  RequestIpl("h4_sw_ipl_02_slod")
  RequestIpl("h4_sw_ipl_02_lod")
  RequestIpl("h4_sw_ipl_02")
  RequestIpl("h4_sw_ipl_01_slod")
  RequestIpl("h4_sw_ipl_01_lod")
  RequestIpl("h4_sw_ipl_01")
  RequestIpl("h4_sw_ipl_00_slod")
  RequestIpl("h4_sw_ipl_00_lod")
  RequestIpl("h4_sw_ipl_00")
  RequestIpl("h4_se_ipl_09_slod")
  RequestIpl("h4_se_ipl_09_lod")
  RequestIpl("h4_se_ipl_09")
  RequestIpl("h4_se_ipl_08_slod")
  RequestIpl("h4_se_ipl_08_lod")
  RequestIpl("h4_se_ipl_08")
  RequestIpl("h4_se_ipl_07_slod")
  RequestIpl("h4_se_ipl_07_lod")
  RequestIpl("h4_se_ipl_07")
  RequestIpl("h4_se_ipl_06_slod")
  RequestIpl("h4_se_ipl_06_lod")
  RequestIpl("h4_se_ipl_06")
  RequestIpl("h4_se_ipl_05_slod")
  RequestIpl("h4_se_ipl_05_lod")
  RequestIpl("h4_se_ipl_05")
  RequestIpl("h4_se_ipl_04_slod")
  RequestIpl("h4_se_ipl_04_lod")
  RequestIpl("h4_se_ipl_04")
  RequestIpl("h4_se_ipl_03_slod")
  RequestIpl("h4_se_ipl_03_lod")
  RequestIpl("h4_se_ipl_03")
  RequestIpl("h4_se_ipl_02_slod")
  RequestIpl("h4_se_ipl_02_lod")
  RequestIpl("h4_se_ipl_02")
  RequestIpl("h4_se_ipl_01_slod")
  RequestIpl("h4_se_ipl_01_lod")
  RequestIpl("h4_se_ipl_01")
  RequestIpl("h4_se_ipl_00_slod")
  RequestIpl("h4_se_ipl_00_lod")
  RequestIpl("h4_se_ipl_00")
  RequestIpl("h4_nw_ipl_09_slod")
  RequestIpl("h4_nw_ipl_09_lod")
  RequestIpl("h4_nw_ipl_09")
  RequestIpl("h4_nw_ipl_08_slod")
  RequestIpl("h4_nw_ipl_08_lod")
  RequestIpl("h4_nw_ipl_08")
  RequestIpl("h4_nw_ipl_07_slod")
  RequestIpl("h4_nw_ipl_07_lod")
  RequestIpl("h4_nw_ipl_07")
  RequestIpl("h4_nw_ipl_06_slod")
  RequestIpl("h4_nw_ipl_06_lod")
  RequestIpl("h4_nw_ipl_06")
  RequestIpl("h4_nw_ipl_05_slod")
  RequestIpl("h4_nw_ipl_05_lod")
  RequestIpl("h4_nw_ipl_05")
  RequestIpl("h4_nw_ipl_04_slod")
  RequestIpl("h4_nw_ipl_04_lod")
  RequestIpl("h4_nw_ipl_04")
  RequestIpl("h4_nw_ipl_03_slod")
  RequestIpl("h4_nw_ipl_03_lod")
  RequestIpl("h4_nw_ipl_03")
  RequestIpl("h4_nw_ipl_02_slod")
  RequestIpl("h4_nw_ipl_02_lod")
  RequestIpl("h4_nw_ipl_02")
  RequestIpl("h4_nw_ipl_01_slod")
  RequestIpl("h4_nw_ipl_01_lod")
  RequestIpl("h4_nw_ipl_01")
  RequestIpl("h4_nw_ipl_00_slod")
  RequestIpl("h4_nw_ipl_00_lod")
  RequestIpl("h4_nw_ipl_00")
  RequestIpl("h4_ne_ipl_09_slod")
  RequestIpl("h4_ne_ipl_09_lod")
  RequestIpl("h4_ne_ipl_09")
  RequestIpl("h4_ne_ipl_08_slod")
  RequestIpl("h4_ne_ipl_08_lod")
  RequestIpl("h4_ne_ipl_08")
  RequestIpl("h4_ne_ipl_07_slod")
  RequestIpl("h4_ne_ipl_07_lod")
  RequestIpl("h4_ne_ipl_07")
  RequestIpl("h4_ne_ipl_06_slod")
  RequestIpl("h4_ne_ipl_06_lod")
  RequestIpl("h4_ne_ipl_06")
  RequestIpl("h4_ne_ipl_05_slod")
  RequestIpl("h4_ne_ipl_05_lod")
  RequestIpl("h4_ne_ipl_05")
  RequestIpl("h4_ne_ipl_04_slod")
  RequestIpl("h4_ne_ipl_04_lod")
  RequestIpl("h4_ne_ipl_04")
  RequestIpl("h4_ne_ipl_03_slod")
  RequestIpl("h4_ne_ipl_03_lod")
  RequestIpl("h4_ne_ipl_03")
  RequestIpl("h4_ne_ipl_02_slod")
  RequestIpl("h4_ne_ipl_02_lod")
  RequestIpl("h4_ne_ipl_02")
  RequestIpl("h4_ne_ipl_01_slod")
  RequestIpl("h4_ne_ipl_01_lod")
  RequestIpl("h4_ne_ipl_01")
  RequestIpl("h4_ne_ipl_00_slod")
  RequestIpl("h4_ne_ipl_00_lod")
  RequestIpl("h4_ne_ipl_00")
  RequestIpl("h4_mph4_wtowers")
  RequestIpl("h4_mph4_mansion_strm_0")
  RequestIpl("h4_mph4_mansion_b_strm_0")
  RequestIpl("h4_mph4_mansion_b")
  RequestIpl("h4_mph4_mansion")
  RequestIpl("h4_mph4_island_sw_placement")
  RequestIpl("h4_mph4_island_se_placement")
  RequestIpl("h4_mph4_island_nw_placement")
  RequestIpl("h4_mph4_island_ne_placement")
  RequestIpl("h4_mph4_island_lod")
  RequestIpl("h4_mph4_dock")
  RequestIpl("h4_mph4_beach")
  RequestIpl("h4_mph4_airstrip_interior_0_airstrip_hanger")
  RequestIpl("h4_mph4_airstrip")
  RequestIpl("h4_mansion_remains_cage")
  RequestIpl("h4_island_padlock_props")
  RequestIpl("h4_islandx_mansion_vault_lod")
  RequestIpl("h4_islandx_mansion_vault")
  RequestIpl("h4_islandx_mansion_slod")
  RequestIpl("h4_islandx_mansion_props_slod")
  RequestIpl("h4_islandx_mansion_props_lod")
  RequestIpl("h4_islandx_mansion_props")
  RequestIpl("h4_islandx_mansion_office_lod")
  RequestIpl("h4_islandx_mansion_office")
  RequestIpl("h4_islandx_mansion_lod")
  RequestIpl("h4_islandx_mansion_lockup_03_lod")
  RequestIpl("h4_islandx_mansion_lockup_03")
  RequestIpl("h4_islandx_mansion_lockup_02_lod")
  RequestIpl("h4_islandx_mansion_lockup_02")
  RequestIpl("h4_islandx_mansion_lockup_01_lod")
  RequestIpl("h4_islandx_mansion_lockup_01")
  RequestIpl("h4_islandx_mansion_lights")
  RequestIpl("h4_islandx_mansion_guardfence")
  RequestIpl("h4_islandx_mansion_entrance_fence")
  RequestIpl("h4_islandx_mansion_b_slod")
  RequestIpl("h4_islandx_mansion_b_side_fence")
  RequestIpl("h4_islandx_mansion_b_lod")
  RequestIpl("h4_islandx_mansion_b")
  RequestIpl("h4_islandx_mansion")
  RequestIpl("h4_islandx_maindock_slod")
  RequestIpl("h4_islandx_maindock_props_slod")
  RequestIpl("h4_islandx_maindock_props_lod")
  RequestIpl("h4_islandx_maindock_props_2_slod")
  RequestIpl("h4_islandx_maindock_props_2_lod")
  RequestIpl("h4_islandx_maindock_props_2")
  RequestIpl("h4_islandx_maindock_props")
  RequestIpl("h4_islandx_maindock_lod")
  RequestIpl("h4_islandx_maindock")
  RequestIpl("h4_islandx_checkpoint_props_slod")
  RequestIpl("h4_islandx_checkpoint_props_lod")
  RequestIpl("h4_islandx_checkpoint_props")
  RequestIpl("h4_islandx_checkpoint_lod")
  RequestIpl("h4_islandx_checkpoint")
  RequestIpl("h4_islandx_barrack_props_slod")
  RequestIpl("h4_islandx_barrack_props_lod")
  RequestIpl("h4_islandx_barrack_props")
  RequestIpl("h4_islandx_barrack_hatch")
  RequestIpl("h4_islandxtower_veg_slod")
  RequestIpl("h4_islandxtower_veg_lod")
  RequestIpl("h4_islandxtower_veg")
  RequestIpl("h4_islandxtower_slod")
  RequestIpl("h4_islandxtower_lod")
  RequestIpl("h4_islandxtower")
  RequestIpl("h4_islandxdock_water_hatch")
  RequestIpl("h4_islandxdock_slod")
  RequestIpl("h4_islandxdock_props_slod")
  RequestIpl("h4_islandxdock_props_lod")
  RequestIpl("h4_islandxdock_props_2_slod")
  RequestIpl("h4_islandxdock_props_2_lod")
  RequestIpl("h4_islandxdock_props_2")
  RequestIpl("h4_islandxdock_props")
  RequestIpl("h4_islandxdock_lod")
  RequestIpl("h4_islandxdock")
  RequestIpl("h4_islandxcanal_props_slod")
  RequestIpl("h4_islandxcanal_props_lod")
  RequestIpl("h4_islandxcanal_props")
  RequestIpl("h4_islandairstrip_slod")
  RequestIpl("h4_islandairstrip_props_slod")
  RequestIpl("h4_islandairstrip_props_lod")
  RequestIpl("h4_islandairstrip_propsb_slod")
  RequestIpl("h4_islandairstrip_propsb_lod")
  RequestIpl("h4_islandairstrip_propsb")
  RequestIpl("h4_islandairstrip_props")
  RequestIpl("h4_islandairstrip_lod")
  RequestIpl("h4_islandairstrip_hangar_props_slod")
  RequestIpl("h4_islandairstrip_hangar_props_lod")
  RequestIpl("h4_islandairstrip_hangar_props")
  RequestIpl("h4_islandairstrip_doorsopen_lod")
  RequestIpl("h4_islandairstrip_doorsopen")
  RequestIpl("h4_islandairstrip_doorsclosed_lod")
  RequestIpl("h4_islandairstrip_doorsclosed")
  RequestIpl("h4_islandairstrip")
  RequestIpl("h4_beach_slod")
  RequestIpl("h4_beach_props_slod")
  RequestIpl("h4_beach_props_party")
  RequestIpl("h4_beach_props_lod")
  RequestIpl("h4_beach_props")
  RequestIpl("h4_beach_party_lod")
  RequestIpl("h4_beach_party")
  RequestIpl("h4_beach_lod")
  RequestIpl("h4_beach_bar_props")
  RequestIpl("h4_beach")
  RequestIpl("h4_aa_guns_lod")
  RequestIpl("h4_aa_guns")
  
  RequestIpl("h4_int_placement_h4")
  RequestIpl("h4_int_placement_h4_interior_0_int_sub_h4_milo_")
  RequestIpl("h4_int_placement_h4_interior_1_dlc_int_02_h4_milo_")

  
  
  WaterOverrideSetStrength(0)
   SetDeepOceanScaler(0.0)
   
 
  else
  
  WaterOverrideSetStrength(0)
   
   
  RemoveIpl("h4_mph4_terrain_lod")
  RemoveIpl("h4_mph4_terrain_06_strm_0")
  RemoveIpl("h4_mph4_terrain_06")
  RemoveIpl("h4_mph4_terrain_05")
  RemoveIpl("h4_mph4_terrain_04")
  RemoveIpl("h4_mph4_terrain_03")
  RemoveIpl("h4_mph4_terrain_02")
  RemoveIpl("h4_mph4_terrain_01_long_0")
  RemoveIpl("h4_mph4_terrain_01")
  RemoveIpl("h4_islandx_terrain_props_06_c_slod")
  RemoveIpl("h4_islandx_terrain_props_06_c_lod")
  RemoveIpl("h4_islandx_terrain_props_06_c")
  RemoveIpl("h4_islandx_terrain_props_06_b_slod")
  RemoveIpl("h4_islandx_terrain_props_06_b_lod")
  RemoveIpl("h4_islandx_terrain_props_06_b")
  RemoveIpl("h4_islandx_terrain_props_06_a_slod")
  RemoveIpl("h4_islandx_terrain_props_06_a_lod")
  RemoveIpl("h4_islandx_terrain_props_06_a")
  RemoveIpl("h4_islandx_terrain_props_05_f_slod")
  RemoveIpl("h4_islandx_terrain_props_05_f_lod")
  RemoveIpl("h4_islandx_terrain_props_05_f")
  RemoveIpl("h4_islandx_terrain_props_05_e_slod")
  RemoveIpl("h4_islandx_terrain_props_05_e_lod")
  RemoveIpl("h4_islandx_terrain_props_05_e")
  RemoveIpl("h4_islandx_terrain_props_05_d_slod")
  RemoveIpl("h4_islandx_terrain_props_05_d_lod")
  RemoveIpl("h4_islandx_terrain_props_05_d")
  RemoveIpl("h4_islandx_terrain_props_05_c_lod")
  RemoveIpl("h4_islandx_terrain_props_05_c")
  RemoveIpl("h4_islandx_terrain_props_05_b_lod")
  RemoveIpl("h4_islandx_terrain_props_05_b")
  RemoveIpl("h4_islandx_terrain_props_05_a_lod")
  RemoveIpl("h4_islandx_terrain_props_05_a")
  RemoveIpl("h4_islandx_terrain_06_slod")
  RemoveIpl("h4_islandx_terrain_06_lod")
  RemoveIpl("h4_islandx_terrain_06")
  RemoveIpl("h4_islandx_terrain_05_slod")
  RemoveIpl("h4_islandx_terrain_05_lod")
  RemoveIpl("h4_islandx_terrain_05")
  RemoveIpl("h4_islandx_terrain_04_slod")
  RemoveIpl("h4_islandx_terrain_04_lod")
  RemoveIpl("h4_islandx_terrain_04")
  RemoveIpl("h4_islandx_terrain_03_lod")
  RemoveIpl("h4_islandx_terrain_03")
  RemoveIpl("h4_islandx_terrain_02_slod")
  RemoveIpl("h4_islandx_terrain_02_lod")
  RemoveIpl("h4_islandx_terrain_02")
  RemoveIpl("h4_islandx_terrain_01_slod")
  RemoveIpl("h4_islandx_terrain_01_lod")
  RemoveIpl("h4_islandx_terrain_01")

  RemoveIpl("h4_mph4_island_placement")
   RemoveIpl("h4_islandx_placement_10")
   RemoveIpl("h4_islandx_placement_09")
   RemoveIpl("h4_islandx_placement_08")
   RemoveIpl("h4_islandx_placement_07")
   RemoveIpl("h4_islandx_placement_06")
   RemoveIpl("h4_islandx_placement_05")
   RemoveIpl("h4_islandx_placement_04")
   RemoveIpl("h4_islandx_placement_03")
   RemoveIpl("h4_islandx_placement_02")
   RemoveIpl("h4_islandx_placement_01")

  RemoveIpl("h4_underwater_gate_closed")
  RemoveIpl("h4_sw_ipl_09_slod")
  RemoveIpl("h4_sw_ipl_09_lod")
  RemoveIpl("h4_sw_ipl_09")
  RemoveIpl("h4_sw_ipl_08_slod")
  RemoveIpl("h4_sw_ipl_08_lod")
  RemoveIpl("h4_sw_ipl_08")
  RemoveIpl("h4_sw_ipl_07_slod")
  RemoveIpl("h4_sw_ipl_07_lod")
  RemoveIpl("h4_sw_ipl_07")
  RemoveIpl("h4_sw_ipl_06_slod")
  RemoveIpl("h4_sw_ipl_06_lod")
  RemoveIpl("h4_sw_ipl_06")
  RemoveIpl("h4_sw_ipl_05_slod")
  RemoveIpl("h4_sw_ipl_05_lod")
  RemoveIpl("h4_sw_ipl_05")
  RemoveIpl("h4_sw_ipl_04_slod")
  RemoveIpl("h4_sw_ipl_04_lod")
  RemoveIpl("h4_sw_ipl_04")
  RemoveIpl("h4_sw_ipl_03_slod")
  RemoveIpl("h4_sw_ipl_03_lod")
  RemoveIpl("h4_sw_ipl_03")
  RemoveIpl("h4_sw_ipl_02_slod")
  RemoveIpl("h4_sw_ipl_02_lod")
  RemoveIpl("h4_sw_ipl_02")
  RemoveIpl("h4_sw_ipl_01_slod")
  RemoveIpl("h4_sw_ipl_01_lod")
  RemoveIpl("h4_sw_ipl_01")
  RemoveIpl("h4_sw_ipl_00_slod")
  RemoveIpl("h4_sw_ipl_00_lod")
  RemoveIpl("h4_sw_ipl_00")
  RemoveIpl("h4_se_ipl_09_slod")
  RemoveIpl("h4_se_ipl_09_lod")
  RemoveIpl("h4_se_ipl_09")
  RemoveIpl("h4_se_ipl_08_slod")
  RemoveIpl("h4_se_ipl_08_lod")
  RemoveIpl("h4_se_ipl_08")
  RemoveIpl("h4_se_ipl_07_slod")
  RemoveIpl("h4_se_ipl_07_lod")
  RemoveIpl("h4_se_ipl_07")
  RemoveIpl("h4_se_ipl_06_slod")
  RemoveIpl("h4_se_ipl_06_lod")
  RemoveIpl("h4_se_ipl_06")
  RemoveIpl("h4_se_ipl_05_slod")
  RemoveIpl("h4_se_ipl_05_lod")
  RemoveIpl("h4_se_ipl_05")
  RemoveIpl("h4_se_ipl_04_slod")
  RemoveIpl("h4_se_ipl_04_lod")
  RemoveIpl("h4_se_ipl_04")
  RemoveIpl("h4_se_ipl_03_slod")
  RemoveIpl("h4_se_ipl_03_lod")
  RemoveIpl("h4_se_ipl_03")
  RemoveIpl("h4_se_ipl_02_slod")
  RemoveIpl("h4_se_ipl_02_lod")
  RemoveIpl("h4_se_ipl_02")
  RemoveIpl("h4_se_ipl_01_slod")
  RemoveIpl("h4_se_ipl_01_lod")
  RemoveIpl("h4_se_ipl_01")
  RemoveIpl("h4_se_ipl_00_slod")
  RemoveIpl("h4_se_ipl_00_lod")
  RemoveIpl("h4_se_ipl_00")
  RemoveIpl("h4_nw_ipl_09_slod")
  RemoveIpl("h4_nw_ipl_09_lod")
  RemoveIpl("h4_nw_ipl_09")
  RemoveIpl("h4_nw_ipl_08_slod")
  RemoveIpl("h4_nw_ipl_08_lod")
  RemoveIpl("h4_nw_ipl_08")
  RemoveIpl("h4_nw_ipl_07_slod")
  RemoveIpl("h4_nw_ipl_07_lod")
  RemoveIpl("h4_nw_ipl_07")
  RemoveIpl("h4_nw_ipl_06_slod")
  RemoveIpl("h4_nw_ipl_06_lod")
  RemoveIpl("h4_nw_ipl_06")
  RemoveIpl("h4_nw_ipl_05_slod")
  RemoveIpl("h4_nw_ipl_05_lod")
  RemoveIpl("h4_nw_ipl_05")
  RemoveIpl("h4_nw_ipl_04_slod")
  RemoveIpl("h4_nw_ipl_04_lod")
  RemoveIpl("h4_nw_ipl_04")
  RemoveIpl("h4_nw_ipl_03_slod")
  RemoveIpl("h4_nw_ipl_03_lod")
  RemoveIpl("h4_nw_ipl_03")
  RemoveIpl("h4_nw_ipl_02_slod")
  RemoveIpl("h4_nw_ipl_02_lod")
  RemoveIpl("h4_nw_ipl_02")
  RemoveIpl("h4_nw_ipl_01_slod")
  RemoveIpl("h4_nw_ipl_01_lod")
  RemoveIpl("h4_nw_ipl_01")
  RemoveIpl("h4_nw_ipl_00_slod")
  RemoveIpl("h4_nw_ipl_00_lod")
  RemoveIpl("h4_nw_ipl_00")
  RemoveIpl("h4_ne_ipl_09_slod")
  RemoveIpl("h4_ne_ipl_09_lod")
  RemoveIpl("h4_ne_ipl_09")
  RemoveIpl("h4_ne_ipl_08_slod")
  RemoveIpl("h4_ne_ipl_08_lod")
  RemoveIpl("h4_ne_ipl_08")
  RemoveIpl("h4_ne_ipl_07_slod")
  RemoveIpl("h4_ne_ipl_07_lod")
  RemoveIpl("h4_ne_ipl_07")
  RemoveIpl("h4_ne_ipl_06_slod")
  RemoveIpl("h4_ne_ipl_06_lod")
  RemoveIpl("h4_ne_ipl_06")
  RemoveIpl("h4_ne_ipl_05_slod")
  RemoveIpl("h4_ne_ipl_05_lod")
  RemoveIpl("h4_ne_ipl_05")
  RemoveIpl("h4_ne_ipl_04_slod")
  RemoveIpl("h4_ne_ipl_04_lod")
  RemoveIpl("h4_ne_ipl_04")
  RemoveIpl("h4_ne_ipl_03_slod")
  RemoveIpl("h4_ne_ipl_03_lod")
  RemoveIpl("h4_ne_ipl_03")
  RemoveIpl("h4_ne_ipl_02_slod")
  RemoveIpl("h4_ne_ipl_02_lod")
  RemoveIpl("h4_ne_ipl_02")
  RemoveIpl("h4_ne_ipl_01_slod")
  RemoveIpl("h4_ne_ipl_01_lod")
  RemoveIpl("h4_ne_ipl_01")
  RemoveIpl("h4_ne_ipl_00_slod")
  RemoveIpl("h4_ne_ipl_00_lod")
  RemoveIpl("h4_ne_ipl_00")
  RemoveIpl("h4_mph4_wtowers")
  RemoveIpl("h4_mph4_mansion_strm_0")
  RemoveIpl("h4_mph4_mansion_b_strm_0")
  RemoveIpl("h4_mph4_mansion_b")
  RemoveIpl("h4_mph4_mansion")
  RemoveIpl("h4_mph4_island_sw_placement")
  RemoveIpl("h4_mph4_island_se_placement")
  RemoveIpl("h4_mph4_island_nw_placement")
  RemoveIpl("h4_mph4_island_ne_placement")
  RemoveIpl("h4_mph4_island_lod")
  RemoveIpl("h4_mph4_dock")
  RemoveIpl("h4_mph4_beach")
  RemoveIpl("h4_mph4_airstrip_interior_0_airstrip_hanger")
  RemoveIpl("h4_mph4_airstrip")
  RemoveIpl("h4_mansion_remains_cage")
  RemoveIpl("h4_island_padlock_props")
  RemoveIpl("h4_islandx_mansion_vault_lod")
  RemoveIpl("h4_islandx_mansion_vault")
  RemoveIpl("h4_islandx_mansion_slod")
  RemoveIpl("h4_islandx_mansion_props_slod")
  RemoveIpl("h4_islandx_mansion_props_lod")
  RemoveIpl("h4_islandx_mansion_props")
  RemoveIpl("h4_islandx_mansion_office_lod")
  RemoveIpl("h4_islandx_mansion_office")
  RemoveIpl("h4_islandx_mansion_lod")
  RemoveIpl("h4_islandx_mansion_lockup_03_lod")
  RemoveIpl("h4_islandx_mansion_lockup_03")
  RemoveIpl("h4_islandx_mansion_lockup_02_lod")
  RemoveIpl("h4_islandx_mansion_lockup_02")
  RemoveIpl("h4_islandx_mansion_lockup_01_lod")
  RemoveIpl("h4_islandx_mansion_lockup_01")
  RemoveIpl("h4_islandx_mansion_lights")
  RemoveIpl("h4_islandx_mansion_guardfence")
  RemoveIpl("h4_islandx_mansion_entrance_fence")
  RemoveIpl("h4_islandx_mansion_b_slod")
  RemoveIpl("h4_islandx_mansion_b_side_fence")
  RemoveIpl("h4_islandx_mansion_b_lod")
  RemoveIpl("h4_islandx_mansion_b")
  RemoveIpl("h4_islandx_mansion")
  RemoveIpl("h4_islandx_maindock_slod")
  RemoveIpl("h4_islandx_maindock_props_slod")
  RemoveIpl("h4_islandx_maindock_props_lod")
  RemoveIpl("h4_islandx_maindock_props_2_slod")
  RemoveIpl("h4_islandx_maindock_props_2_lod")
  RemoveIpl("h4_islandx_maindock_props_2")
  RemoveIpl("h4_islandx_maindock_props")
  RemoveIpl("h4_islandx_maindock_lod")
  RemoveIpl("h4_islandx_maindock")
  RemoveIpl("h4_islandx_checkpoint_props_slod")
  RemoveIpl("h4_islandx_checkpoint_props_lod")
  RemoveIpl("h4_islandx_checkpoint_props")
  RemoveIpl("h4_islandx_checkpoint_lod")
  RemoveIpl("h4_islandx_checkpoint")
  RemoveIpl("h4_islandx_barrack_props_slod")
  RemoveIpl("h4_islandx_barrack_props_lod")
  RemoveIpl("h4_islandx_barrack_props")
  RemoveIpl("h4_islandx_barrack_hatch")
  RemoveIpl("h4_islandxtower_veg_slod")
  RemoveIpl("h4_islandxtower_veg_lod")
  RemoveIpl("h4_islandxtower_veg")
  RemoveIpl("h4_islandxtower_slod")
  RemoveIpl("h4_islandxtower_lod")
  RemoveIpl("h4_islandxtower")
  RemoveIpl("h4_islandxdock_water_hatch")
  RemoveIpl("h4_islandxdock_slod")
  RemoveIpl("h4_islandxdock_props_slod")
  RemoveIpl("h4_islandxdock_props_lod")
  RemoveIpl("h4_islandxdock_props_2_slod")
  RemoveIpl("h4_islandxdock_props_2_lod")
  RemoveIpl("h4_islandxdock_props_2")
  RemoveIpl("h4_islandxdock_props")
  RemoveIpl("h4_islandxdock_lod")
  RemoveIpl("h4_islandxdock")
  RemoveIpl("h4_islandxcanal_props_slod")
  RemoveIpl("h4_islandxcanal_props_lod")
  RemoveIpl("h4_islandxcanal_props")
  RemoveIpl("h4_islandairstrip_slod")
  RemoveIpl("h4_islandairstrip_props_slod")
  RemoveIpl("h4_islandairstrip_props_lod")
  RemoveIpl("h4_islandairstrip_propsb_slod")
  RemoveIpl("h4_islandairstrip_propsb_lod")
  RemoveIpl("h4_islandairstrip_propsb")
  RemoveIpl("h4_islandairstrip_props")
  RemoveIpl("h4_islandairstrip_lod")
  RemoveIpl("h4_islandairstrip_hangar_props_slod")
  RemoveIpl("h4_islandairstrip_hangar_props_lod")
  RemoveIpl("h4_islandairstrip_hangar_props")
  RemoveIpl("h4_islandairstrip_doorsopen_lod")
  RemoveIpl("h4_islandairstrip_doorsopen")
  RemoveIpl("h4_islandairstrip_doorsclosed_lod")
  RemoveIpl("h4_islandairstrip_doorsclosed")
  RemoveIpl("h4_islandairstrip")
  RemoveIpl("h4_beach_slod")
  RemoveIpl("h4_beach_props_slod")
  RemoveIpl("h4_beach_props_party")
  RemoveIpl("h4_beach_props_lod")
  RemoveIpl("h4_beach_props")
  RemoveIpl("h4_beach_party_lod")
  RemoveIpl("h4_beach_party")
  RemoveIpl("h4_beach_lod")
  RemoveIpl("h4_beach_bar_props")
  RemoveIpl("h4_beach")
  RemoveIpl("h4_aa_guns_lod")
  RemoveIpl("h4_aa_guns")

  RequestIpl("h4_int_placement_h4")
  RequestIpl("h4_int_placement_h4_interior_0_int_sub_h4_milo_")
  RequestIpl("h4_int_placement_h4_interior_1_dlc_int_02_h4_milo_")

 
    
end
end)




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        SetRadarAsExteriorThisFrame()
        SetRadarAsInteriorThisFrame(GetHashKey("h4_fake_islandx"), 4700.0, -5145.0, 0, 0)
    end
end)