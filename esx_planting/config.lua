Config = {}
Config.Locale = "pl"
--You can add here buttons like inventory menu button. When player click this button, then action will be cancel.
Config.cancel_buttons = {289, 170, 168, 56}

options =
{
  ['seed_weed'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
		end_object_zoffset = 0.0,
        fail_msg = 'Sorry, your plant has died! ',
        success_msg = 'Congratulations, youve made a harvest from the plant!',
        start_msg = 'We start the cultivation of the buds ',
        success_item = 'weed',
        cops = 0,
        first_step = 2.35,
        steps = 7,
        cords = {
          {x = -427.05, y = 1575.25, z = 357, distance = 30.25},
          {x = 2213.05, y = 5576.25, z = 53, distance = 30.25},
          {x = 1198.05, y = -215.25, z = 55, distance = 30.25},
          {x = 706.05, y = 1269.25, z = 358, distance = 30.25},
        },
        animations_start = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '2500'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim = 'idle_a', timeout = '2500'},
        },
        animations_end = {
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '2500'},
          {lib = 'amb@world_human_cop_idles@male@idle_a', anim ='idle_a', timeout = '2500'},
        },
        animations_step = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '2500'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim ='idle_a', timeout = '18500'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '2500'},
        },
        grow = {
          2.24, 1.95, 1.65, 1.45, 1.20, 1.00
        },
        questions = {
            {
                title = 'You see that your plant sprouts, what are you doing?',
				steps = {
                    {label = 'Watering the Plant', value = 1},
                    {label = 'I fertilize plant', value = 2},
                    {label = 'Waiting', value = 3}
                },
                correct = 1
            },

			{
                title = 'Yellow dots appeared on your plant, what are you doing?',
                steps = {
                    {label = 'Watering the Plant', value = 1},
                    {label = 'I fertilize plant', value = 2},
                    {label = 'Waiting', value = 3},
                },
                correct = 2
            },
            {
                title = 'Blue dust has appeared on the leaves of your plant, what are you doing?',
                steps = {
                    {label = 'Breaking individual leaves', value = 1},
                    {label = 'Sprinkle the leaf with fertilizer', value = 2},
                    {label = 'Waiting', value = 3},
                },
                correct = 3
            },
            {
                title = 'Your first plant has appeared in your plant, what are you doing?',
                steps = {
                    {label = 'Watering the Plant', value = 1},
                    {label = 'I break them out immediately', value = 2},
                    {label = 'Fertilize the plant', value = 3},
                },
                correct = 1
            },
			{
                title = 'After watering your plant, strange leaves began to appear, what are you doing?',
                steps = {
                    {label = 'Watering the Plant', value = 1},
                    {label = 'I fertilize plant', value = 2},
                    {label = 'Waiting', value = 3},
                },
                correct = 2
            },
            {
                title = 'Your plant is almost ready to be cut, what are you doing?',
                steps = {
                    {label = 'Watering the Plant', value = 1},
                    {label = 'I fertilize plant', value = 2},
                    {label = 'Waiting', value = 3},
                },
                correct = 1
            },
            {
                title = 'Your plant is ready for harvest, what are you doing?',
                steps = {
                    {label = 'Collect using scissors', value = 1, min = 5, max = 25},
                    {label = 'Collect with hands', value = 1, min = 10, max = 15},
                    {label = 'Cut the pruning shears', value = 1, min = 2, max = 40}
                },
                correct = 1
            }
        },
      },
	  
	  
	  ['seed_opium'] = {
        object = 'prop_plant_paradise_b',
        end_object = 'prop_plant_paradise',
		end_object_zoffset = 0.0,
        fail_msg = 'Sorry, your plant has died! ',
        success_msg = 'Congratulations, youve made a harvest from the plant!',
        start_msg = 'We start the cultivation of the opium buds ',
        success_item = 'opium',
        cops = 0,
        first_step = 2.35,
        steps = 7,
        cords = {
			{x = 2345.3620605469, y = 2581.0632324219, z = 46.650886535645, distance = 50.25}, -- PostCode 959
			{x = -109.9, y = 1282.9, z = 301.18, distance = 50.25},  -- 713 - 717
			{x = 1510.3089599609, y = -2139.901, z = 76.7345, distance = 20.25}, --Post Code 54
			{x = -2088.4619, y = 2660.135, z = 2.839850, distance = 20.25}, --Post Code 1003
        },
        animations_start = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '2500'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim = 'idle_a', timeout = '2500'},
        },
        animations_end = {
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '2500'},
          {lib = 'amb@world_human_cop_idles@male@idle_a', anim ='idle_a', timeout = '2500'},
        },
        animations_step = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '2500'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim ='idle_a', timeout = '18500'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '2500'},
        },
        grow = {
          0.8, 0.7, 0.6, 0.5, 0.4, 0.30
        },
        questions = {
            {
                title = 'You see that your plant sprouts, what are you doing?',
				steps = {
                    {label = 'Watering the Plant', value = 1},
                    {label = 'I fertilize plant', value = 2},
                    {label = 'Waiting', value = 3}
                },
                correct = 1
            },

			{
                title = 'Yellow dots appeared on your plant, what are you doing?',
                steps = {
                    {label = 'Watering the Plant', value = 1},
                    {label = 'I fertilize plant', value = 2},
                    {label = 'Waiting', value = 3},
                },
                correct = 2
            },
            {
                title = 'Blue dust has appeared on the leaves of your plant, what are you doing?',
                steps = {
                    {label = 'Breaking individual leaves', value = 1},
                    {label = 'Sprinkle the leaf with fertilizer', value = 2},
                    {label = 'Waiting', value = 3},
                },
                correct = 3
            },
            {
                title = 'Your first plant has appeared in your plant, what are you doing?',
                steps = {
                    {label = 'Watering the Plant', value = 1},
                    {label = 'I break them out immediately', value = 2},
                    {label = 'Fertilize the plant', value = 3},
                },
                correct = 1
            },
			{
                title = 'After watering your plant, strange leaves began to appear, what are you doing?',
                steps = {
                    {label = 'Watering the Plant', value = 1},
                    {label = 'I fertilize plant', value = 2},
                    {label = 'Waiting', value = 3},
                },
                correct = 2
            },
            {
                title = 'Your plant is almost ready to be cut, what are you doing?',
                steps = {
                    {label = 'Watering the Plant', value = 1},
                    {label = 'I fertilize plant', value = 2},
                    {label = 'Waiting', value = 3},
                },
                correct = 1
            },
            {
                title = 'Your plant is ready for harvest, what are you doing?',
                steps = {
                    {label = 'Collect using scissors', value = 1, min = 8, max = 25},
                    {label = 'Collect with hands', value = 1, min = 13, max = 15},
                    {label = 'Cut the pruning shears', value = 1, min = 2, max = 40}
                },
                correct = 1
            }
        },
      },
}
