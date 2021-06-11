Config = {}

Config['URL'] = 'https://www.youtube.com/embed/%s?autoplay=1&controls=1&disablekb=1&fs=0&rel=0&showinfo=0&iv_load_policy=3&start=%s'
 --Config['URL'] = 'https://www.youtube.com/watch?v=%s&t=%s' -- use this if you want to be able to play copyrighted stuff. please note that ads will pop up every now and again, and full screen doesn't work
Config['API'] = {
    ['URL'] = 'https://www.googleapis.com/youtube/v3/videos?id=%s&part=contentDetails&key=%s',
    ['Key'] = ''
}
Config['DurationCheck'] = false -- this will automatically delete the browser (good for ram i guess?) once the video has finished (REQUIRES YOU TO ADD AN API KEY!!!!!)

Config['Objects'] = {
    {
        ['Object'] = `prop_tv_flat_01`,
        ['Scale'] = 0.05,
        ['Offset'] = vec3(-0.925, -0.055, 1.0),
        ['Distance'] = 7.5,
    },
    {
        ['Object'] = `prop_tv_flat_michael`,
        ['Scale'] = 0.035,
        ['Offset'] = vec3(-0.675, -0.055, 0.4),
        ['Distance'] = 7.5,
    },
    {
        ['Object'] = `prop_trev_tv_01`,
        ['Scale'] = 0.012,
        ['Offset'] = vec3(-0.225, -0.01, 0.26),
        ['Distance'] = 7.5,
    },
    {
        ['Object'] = `prop_tv_flat_03b`,
        ['Scale'] = 0.62,
        ['Offset'] = vec3(-10.75, -0.00, 13.3),
        ['Distance'] = 100.0,
    },
    {
        ['Object'] = `prop_tv_flat_03`,
        ['Scale'] = 0.016,
        ['Offset'] = vec3(-0.3, -0.01, 0.4),
        ['Distance'] = 7.5,
    },
    {
        ['Object'] = `prop_tv_flat_02b`,
        ['Scale'] = 0.026,
        ['Offset'] = vec3(-0.5, -0.012, 0.525),
        ['Distance'] = 7.5,
    },
    {
        ['Object'] = `prop_tv_flat_02`,
        ['Scale'] = 0.026,
        ['Offset'] = vec3(-0.5, -0.012, 0.525),
        ['Distance'] = 7.5,
    },
    {
        ['Object'] = `prop_tv_flat_02`,
        ['Scale'] = 0.026,
        ['Offset'] = vec3(-0.5, -0.012, 0.525),
        ['Distance'] = 7.5,
    },
	{
	    ['Object'] = `xm_prop_x17_tv_flat_02`,
        ['Scale'] = 0.045,
        ['Offset'] = vec3(-0.89, -0.07, 0.95),
        ['Distance'] = 7.5,
    },
	{
	    ['Object'] = `apa_mp_h_str_avunits_01`,
        ['Scale'] = 0.049,
        ['Offset'] = vec3(-0.89, -0.3, 2.0),
        ['Distance'] = 7.5,
    },
	{
	    ['Object'] = `v_res_lest_bigscreen`,
        ['Scale'] = 0.042,
        ['Offset'] = vec3(-0.76, -0.0, -0.35),
        ['Distance'] = 7.5,
    },
	{
	    ['Object'] = `apa_mp_h_str_avunits_04`,
        ['Scale'] = 0.045,
        ['Offset'] = vec3(-0.78, -0.35, 1.855),
        ['Distance'] = 7.5,
    },
	{
	    ['Object'] = `apa_mp_h_str_avunitm_03`,
        ['Scale'] = 0.045,
        ['Offset'] = vec3(-0.84, -0.30, 2.0),
        ['Distance'] = 7.5,
    },
	{
	    ['Object'] = `apa_mp_h_str_avunitm_01`,
        ['Scale'] = 0.045,
        ['Offset'] = vec3(-0.84, -0.30, 2.0),
        ['Distance'] = 7.5,
    },
	{
	    ['Object'] = `v_res_j_tvstand`,
        ['Scale'] = 0.013,
        ['Offset'] = vec3(-0.0, -0.1675, 1.25),
        ['Distance'] = 7.5,
    },
	{
	    ['Object'] = `xm_prop_x17_tv_flat_01`,
        ['Scale'] = 0.0355,
        ['Offset'] = vec3(-0.60, -0.05, 0.90),
        ['Distance'] = 7.5,
    },
	{
	    ['Object'] = `sm_prop_smug_tv_flat_01`,
        ['Scale'] = 0.0355,
        ['Offset'] = vec3(-0.60, -0.05, 0.90),
        ['Distance'] = 7.5,
    },
	{
	    ['Object'] = `custom_exit_sign_tv.ydr`,
        ['Scale'] = 0.0355,
        ['Offset'] = vec3(-0.60, -0.05, 0.90),
        ['Distance'] = 100,
    },
	--[[{
	    ['Object'] = 122877578,  --Police station tv
        ['Scale'] = 0.0355,
        ['Offset'] = vec3(-0.00, -0.00, 0.90),
        ['Distance'] = 9.0,
    },	--]]
	{
	    ['Object'] = -925331707,  --Police station whiteboard
        ['Scale'] = 0.0605,
        ['Offset'] = vec3(-1.07, -0.05, 0.70),
        ['Distance'] = 9.0,
    },
{
	    ['Object'] = `prop_radio_01`,  --Speaker
        ['Scale'] = 0.0,
        ['Offset'] = vec3(-1.07, -0.05, 0.70),
        ['Distance'] = 57.00,
    },	
	
	
}

Strings = {
    ['VideoHelp'] = 'Type ~b~/tv ~y~youtube id~s~ to play a video.\nExample: ~b~/tv ~y~3hqjseATp4g~s~',
    ['VolumeHelp'] = 'Type ~b~/volume ~y~(0-10)~s~ to change the volume.\nExample: ~b~/volume ~y~5~s~\n\nType ~b~/tv ~y~youtube id~s~ to change the video.\nExample: ~b~/tv ~y~3hqjseATp4g~s~\n\nType ~b~/destroy~s~ to stop the video\n\n~INPUT_CONTEXT~ Sync video time',
}