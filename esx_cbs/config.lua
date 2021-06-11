Config = {}

Config.Healing = 1 -- // If this is 0, then its disabled.. Default: 3.. That means, if a person lies in a bed, then he will get 1 health every 3 seconds.

Config.objects = {
	ButtonToSitOnChair = 23, -- // Default: G 58 -- // https://docs.fivem.net/game-references/controls/
	ButtonToLayOnBed = 38, -- // Default: E -- // https://docs.fivem.net/game-references/controls/
	ButtonToStandUp = 23, -- // Default: F -- // https://docs.fivem.net/game-references/controls/
	SitAnimation = {anim='PROP_HUMAN_SEAT_CHAIR_MP_PLAYER'},
	BedBackAnimation = {dict='anim@gangops@morgue@table@', anim='ko_front'},
	BedStomachAnimation = {anim='WORLD_HUMAN_SUNBATHE'},
	BedSitAnimation = {anim='WORLD_HUMAN_PICNIC'},
	BarSitAnimation = {anim='amb@prop_human_seat_bar@male@elbows_on_bar@idle_a'},
	
	locations = {

		{object=-289946279, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.9, direction=180.0, bed=true},
		{object=-1519439119, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.9, direction=180.0, bed=true},
		
	
		{object=-1091386327, verticalOffsetX=0.0, verticalOffsetY=0.13, verticalOffsetZ=-0.2, direction=90.0, bed=true},
		{object=`v_med_bed2`, verticalOffsetX=0.0, verticalOffsetY=0.13, verticalOffsetZ=-0.2, direction=90.0, bed=true},
		{object=`v_med_bed2`, verticalOffsetX=0.0, verticalOffsetY=0.13, verticalOffsetZ=-0.2, direction=90.0, bed=true},
		{object=`v_med_bed1`, verticalOffsetX=0.0, verticalOffsetY=0.13, verticalOffsetZ=-0.2, direction=90.0, bed=true},
		{object=`v_serv_ct_chair02`, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.0, direction=168.0, bed=false},
		
		{object=-109356459, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},  --Police Chairs
		
		
		{object=-1317098115, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.5, direction=168.0, bed=false},  --Outside Seats MTT900
		{object=1056357185, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.6, direction=168.0, bed=false},
		
		{object=-1005355458, verticalOffsetX=-0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0,  bed=false},   ----casino
		{object=-1195678770, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.7, direction=0.0,  bed=false},
		{object=161343630, verticalOffsetX=-0.8, verticalOffsetY=-0.3, verticalOffsetZ=-0.7, direction=0, bed=false}, ---slots
		
		{object=-470815620, verticalOffsetX=-0.0, verticalOffsetY=-0.0, verticalOffsetZ=0.09, direction=180.0, bed=false},  --mansion seats
		{object=-829283643, verticalOffsetX=0.11, verticalOffsetY=0.11, verticalOffsetZ=0.09, direction=180.0, bed=false},  --pink mansion big seat
		
		
		--{object=654385216, verticalOffsetX=-0.8, verticalOffsetY=-0.3, verticalOffsetZ=-0.7, direction=0,  bed=false},
		--{object=207578973, verticalOffsetX=-0.8, verticalOffsetY=-0.3, verticalOffsetZ=-0.7, direction=0,  bed=false},
		--{object=1096374064, verticalOffsetX=-0.8, verticalOffsetY=-0.3, verticalOffsetZ=-0.7, direction=0,  bed=false},
		--{object=-1932041857, verticalOffsetX=-0.8, verticalOffsetY=-0.3, verticalOffsetZ=-0.7, direction=0,  bed=false},
		--{object=-1519644200, verticalOffsetX=-0.8, verticalOffsetY=-0.3, verticalOffsetZ=-0.7, direction=0,  bed=false},
		--{object=-430989360, verticalOffsetX=-0.8, verticalOffsetY=-0.3, verticalOffsetZ=-0.7, direction=0,  bed=false},

		
		{object=`prop_off_chair_04`, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object=`prop_off_chair_03`, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object=`prop_off_chair_05`, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object=`v_club_officechair`, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object=`v_ilev_leath_chr`, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object=`v_corp_offchair`, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object=`v_med_emptybed`, verticalOffsetX=0.0, verticalOffsetY=0.13, verticalOffsetZ=-0.2, direction=90.0, bed=true},
		{object=`Prop_Off_Chair_01`, verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},

		{object=`prop_bench_01a`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_bench_01b`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_bench_01c`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_bench_02`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_bench_03`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_bench_04`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_bench_05`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_bench_06`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_bench_08`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_bench_09`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_bench_10`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_bench_11`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_fib_3b_bench`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_ld_bench01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_wait_bench_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_club_stagechair`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`hei_prop_heist_off_chair`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`hei_prop_hei_skid_chair`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		
		{object=`prop_chair_01a`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_chair_01b`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_chair_02`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_chair_03`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_chair_04a`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_chair_04b`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_chair_05`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_chair_06`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_chair_08`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_chair_09`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_chair_10`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_chateau_chair_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_clown_chair`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_cs_office_chair`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_direct_chair_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_direct_chair_02`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_gc_chair02`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_off_chair_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_off_chair_04b`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_off_chair_04_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_off_chair_05`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_old_deck_chair`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_old_wood_chair`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_rock_chair_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_skid_chair_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_skid_chair_02`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_skid_chair_03`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_sol_chair`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`p_armchair_01_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`p_clb_officechair_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`p_dinechair_01_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`p_ilev_p_easychair_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`p_soloffchair_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`p_yacht_chair_01_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_club_officechair`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_corp_bk_chair3`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_corp_cd_chair`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_corp_offchair`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_ilev_chair02_ped`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_ilev_hd_chair`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_ilev_p_easychair`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_ret_gc_chair03`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_ld_farm_chair01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_table_04_chr`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_table_05_chr`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_table_06_chr`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_ilev_leath_chr`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_table_01_chr_a`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.0, direction=180.0, bed=false},
		{object=`prop_table_01_chr_b`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_table_02_chr`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_table_03b_chr`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_table_03_chr`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_torture_ch_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_ilev_fh_dineeamesa`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_ilev_fh_kitchenstool`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_ilev_tort_stool`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`hei_prop_yah_seat_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`hei_prop_yah_seat_02`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`hei_prop_yah_seat_03`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_waiting_seat_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_hobo_seat_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_yacht_seat_02`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_yacht_seat_03`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_yacht_seat_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_rub_couch01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`miss_rub_couch_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_ld_farm_couch01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_ld_farm_couch02`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_rub_couch02`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_rub_couch03`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_rub_couch04`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`p_lev_sofa_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`p_res_sofa_l_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`p_v_med_p_sofa_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`p_yacht_sofa_01_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_ilev_m_sofa`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_res_tre_sofa_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_tre_sofa_mess_a_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_tre_sofa_mess_b_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_tre_sofa_mess_c_s`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_roller_car_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_roller_car_02`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_yacht_seat_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_yacht_seat_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`prop_yacht_seat_01`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=`v_med_cor_medstool`, verticalOffsetX=0.0, verticalOffsetY=-0.0, verticalOffsetZ=-0.7, direction=180.0, nochange = true, bed=false},
		
	}
}


--[[
		
		
--]]


-- // YOU WILL FIND ALL BUTTONS HERE FOR CODE BELOW;P
-- [[ https://docs.fivem.net/game-references/controls/ ]]

Config.Text = {
	SitOnChair = '~r~[ F ]~w~ to sit',
	SitOnBed = '~r~[ E ]~w~ to sit on the bed',
	LieOnBed = '~r~[ E ]~w~ to lay on your',
	SwitchBetween = 'Swap with ~r~Arrow left~w~ and ~r~arrow right~w~',
	Standup = '~r~[ H ]~w~ to stand up!',
}