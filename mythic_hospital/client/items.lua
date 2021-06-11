RegisterNetEvent('64d717ac-8b91-496f-ae1e-496c92dd669e')
AddEventHandler('64d717ac-8b91-496f-ae1e-496c92dd669e', function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 3000,
        label = "Packing Wounds",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(status)
        if not status then
            TriggerEvent('e46b7b3e-aab2-48a1-9408-aefac0571071')
        end
    end)
end)

RegisterNetEvent('305ca616-48d7-46fa-9977-3d09ed316796')
AddEventHandler('305ca616-48d7-46fa-9977-3d09ed316796', function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 5000,
        label = "Using Bandage",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(status)
        if not status then
			local maxHealth = GetEntityMaxHealth(PlayerPedId())
			local health = GetEntityHealth(PlayerPedId())
			local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 16))
			SetEntityHealth(PlayerPedId(), newHealth)
        end
    end)
end)

RegisterNetEvent('f0ed6176-0a64-499a-97ef-46855b5f327d')
AddEventHandler('f0ed6176-0a64-499a-97ef-46855b5f327d', function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 10000,
        label = "Using First Aid",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_stat_pack_01"
        },
    }, function(status)
        if not status then
			local maxHealth = GetEntityMaxHealth(PlayerPedId())
			local health = GetEntityHealth(PlayerPedId())
			local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
			SetEntityHealth(PlayerPedId(), newHealth)
        end
    end)
end)

RegisterNetEvent('e6128a0f-5906-4469-bfa9-13e81b4f7db9')
AddEventHandler('e6128a0f-5906-4469-bfa9-13e81b4f7db9', function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 20000,
        label = "Using Medkit",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_ld_health_pack"
        },
    }, function(status)
        if not status then
			SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
            TriggerEvent('10d273c6-7f42-45a4-9887-4a415e802e3a')
        end
    end)
end)

RegisterNetEvent('6f7f7cf8-340e-4c18-b0cd-8c6d2ed664ee')
AddEventHandler('6f7f7cf8-340e-4c18-b0cd-8c6d2ed664ee', function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 2000,
        label = "Taking vicodin",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            TriggerEvent('df0b1adc-dc62-4617-ab40-a73314ba34f5', 1)
        end
    end)
end)

RegisterNetEvent('daf688ea-a35b-4f1e-8000-05c7443febc4')
AddEventHandler('daf688ea-a35b-4f1e-8000-05c7443febc4', function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 2000,
        label = "Taking hydrocodone",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            TriggerEvent('df0b1adc-dc62-4617-ab40-a73314ba34f5', 2)
        end
    end)
end)

RegisterNetEvent('fada9b6b-7b88-43fe-84ac-e65b1c2abd66')
AddEventHandler('fada9b6b-7b88-43fe-84ac-e65b1c2abd66', function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 2000,
        label = "Taking morphine",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            TriggerEvent('df0b1adc-dc62-4617-ab40-a73314ba34f5', 6)
        end
    end)
end)
