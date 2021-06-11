Config = {}

--[[
Usage:
itemName: Item Name to whitelist to or nil for job whitelist.
jobName: Job name to whitelist to or nil for item whitelist.

whitelistType:
	"job" 
	"item" 
	
clothingTypeId:
	"hats" ID:0
	"masks" ID:1
	"pants" ID:4
	"bags" ID:5
	"belts" ID:7
	"vests" ID:9
	"decals" ID:10
	"shirts" ID:11
	
clothingId: vMenu clothing number.
clothingTextureId: vMenu texture number - 1 or nil for all.	

gender:
	"m"
	"f"
	
message: Error message if user isn't whitelisted for this item of clothing.
--]]

Config.Clothing = {
	--Police
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=0, clothingId=133, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=0, clothingId=134, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=0, clothingId=124, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=0, clothingId=125, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=0, clothingId=50, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=11, clothingId=275, clothingTextureId=1, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
    {itemName=nil, jobName='police', whitelistType="job", clothingTypeId=11, clothingId=275, clothingTextureId=0, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=11, clothingId=276, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=11, clothingId=277, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=11, clothingId=278, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=11, clothingId=74, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=11, clothingId=52, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=11, clothingId=286, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=11, clothingId=287, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=11, clothingId=281, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=11, clothingId=283, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=29, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=30, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=31, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=32, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=33, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=34, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=35, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=36, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=37, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=10, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=11, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=15, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=16, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=17, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=19, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=20, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=21, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=22, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=23, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=24, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=7, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=9, clothingId=8, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=7, clothingId=5, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=7, clothingId=6, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=7, clothingId=7, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='police', whitelistType="job", clothingTypeId=7, clothingId=9, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	
	--Ambulance
	{itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=246, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=258, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=0, clothingId=11, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	--CFA
        {itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=275, clothingTextureId=3, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
        {itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=275, clothingTextureId=4, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
        {itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=275, clothingTextureId=5, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
        {itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=275, clothingTextureId=6, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
        {itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=275, clothingTextureId=7, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
        {itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=275, clothingTextureId=8, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
		{itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=4, clothingId=95, clothingTextureId=2, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."}, --CFA Pants
		{itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=4, clothingId=95, clothingTextureId=3, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."}, --CFA Rescue Pants
		{itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=85, clothingTextureId=0, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."}, -- Rescue Shirt
        {itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=275, clothingTextureId=2, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
        {itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=288, clothingTextureId=0, gender="f", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
        {itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=288, clothingTextureId=1, gender="f", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
        {itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=288, clothingTextureId=2, gender="f", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
        {itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=288, clothingTextureId=3, gender="f", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
        {itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=288, clothingTextureId=4, gender="f", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
        {itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=288, clothingTextureId=5, gender="f", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
        {itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=288, clothingTextureId=6, gender="f", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
		{itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=4, clothingId=95, clothingTextureId=2, gender="f", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."}, --CFA Pants
		{itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=4, clothingId=95, clothingTextureId=3, gender="f", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."}, --CFA Rescue Pants
		{itemName=nil, jobName='ambulance', whitelistType="job", clothingTypeId=11, clothingId=215, clothingTextureId=0, gender="f", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."}, -- Rescue Shirt

	--Wilson
	{itemName=nil, jobName='wilson', whitelistType="job", clothingTypeId=11, clothingId=208, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	
	--Biker
	{itemName=nil, jobName='biker', whitelistType="job", clothingTypeId=5, clothingId=57, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='biker', whitelistType="job", clothingTypeId=11, clothingId=160, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='biker', whitelistType="job", clothingTypeId=11, clothingId=259, clothingTextureId=17, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='biker', whitelistType="job", clothingTypeId=10, clothingId=57, clothingTextureId=0, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	
	--Biker2
	{itemName=nil, jobName='biker2', whitelistType="job", clothingTypeId=5, clothingId=59, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='biker2', whitelistType="job", clothingTypeId=10, clothingId=57, clothingTextureId=0, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	
	--Biker3
	{itemName=nil, jobName='biker3', whitelistType="job", clothingTypeId=5, clothingId=58, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='biker3', whitelistType="job", clothingTypeId=11, clothingId=204, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='biker3', whitelistType="job", clothingTypeId=11, clothingId=259, clothingTextureId=16, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='biker3', whitelistType="job", clothingTypeId=10, clothingId=57, clothingTextureId=0, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	
	--Biker4
	{itemName=nil, jobName='biker4', whitelistType="job", clothingTypeId=5, clothingId=3, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	{itemName=nil, jobName='biker4', whitelistType="job", clothingTypeId=5, clothingId=56, clothingTextureId=nil, gender="m", message="~b~Blue~w~Bird~b~RP\n~w~This outfit is restricted use only."},
	
	--Techh Supporter
	{itemName="bsvbhat", jobName=nil, whitelistType="item", clothingTypeId=0, clothingId=37, clothingTextureId=1, gender="m", message="~p~Techh ~w~Supporters ~p~Only~w~:\nThis outfit requires an item."},
	{itemName="buckethat1", jobName=nil, whitelistType="item", clothingTypeId=1, clothingId=91, clothingTextureId=nil, gender="m", message="~p~Techh ~w~Supporters ~p~Only~w~:\nThis outfit requires an item."},
	{itemName="bsmdmask", jobName=nil, whitelistType="item", clothingTypeId=1, clothingId=49, clothingTextureId=8, gender="m", message="~p~Techh ~w~Supporters ~p~Only~w~:\nThis outfit requires an item."},
	
	{itemName="bsvbhat", jobName=nil, whitelistType="item", clothingTypeId=0, clothingId=36, clothingTextureId=1, gender="f", message="~p~Techh ~w~Supporters ~p~Only~w~:\nThis outfit requires an item."},
	{itemName="buckethat1", jobName=nil, whitelistType="item", clothingTypeId=1, clothingId=91, clothingTextureId=nil, gender="f", message="~p~Techh ~w~Supporters ~p~Only~w~:\nThis outfit requires an item."},
	{itemName="bsmdmask", jobName=nil, whitelistType="item", clothingTypeId=1, clothingId=49, clothingTextureId=8, gender="f", message="~p~Techh ~w~Supporters ~p~Only~w~:\nThis outfit requires an item."},
}