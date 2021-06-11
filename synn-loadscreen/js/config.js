var config =
{    
    /*
        Do we want to show the image?
        Note that imageSize still affects the size of the image and where the progressbars are located.
    */
    enableImage: true,
 
    /*
        Relative path the the logo we want to display.
    */
    image: "img/logo.png",

    /*
        Cursor image
    */
    cursorImage: "img/cursor3.png",
 
    /*
        How big should the logo be?
        The values are: [width, height].
        Recommended to use square images less than 1024px.
    */
    imageSize: [400, 400],
 
    /*
        Define the progressbar type
            0 = Single progressbar
            1 = Multiple progressbars
            2 = Collapsed progressbars
     */
    progressBarType: 0,
 
    /*
        Here you can disable some of progressbars.
        Only applys if `singleProgressbar` is false.
    */
    progressBars:
    {
        "INIT_CORE": {
            enabled: false, //NOTE: Disabled because INIT_CORE seems to not get called properly. (race condition).
        },
 
        "INIT_BEFORE_MAP_LOADED": {
            enabled: true,
        },
 
        "MAP": {
            enabled: true,
        },
 
        "INIT_AFTER_MAP_LOADED": {
            enabled: true,
        },
 
        "INIT_SESSION": {
            enabled: true,
        }
    },
 
    /*
        Loading messages will be randomly picked from the array.
        The message is located on the left side above the progressbar.
        The text will slowly fade in and out, each time with another message.
        You can use UTF-8 emoticons inside loading messages!
    */
    loadingMessages:
    [
		"<span class='p'>BlueBirdRP </span>Celebrating PRIDE Month June 2021",
		"<span class='p'>Did you know? </span> We are an inclusive community, everyone is welcome.",
		"<span class='p'>Did you know? </span> BlueBird as diverse as the city its based in.",
		"<span class='p'>We're PROUD you're here! </span> We hope you have fun!",
    ],
 
    /*
        Rotate the loading message every 5000 milliseconds (default value).
    */
    loadingMessageSpeed: 7 * 1000,
 
    /*
        Array of music id's to play in the loadscreen.
        Enter your youtube video id's here. In order to obtain the video ID
        Take whats after the watch?v= on a youtube link.
        https://www.youtube.com/watch?v=<videoid>
        Do not include the playlist id or anything, it should be a 11 digit code.
       
        Do not use videos that:
            - Do not allow embedding.
            - Copyrighted music (youtube actively blocks this).
			
			
    */
    music:
    [
       //"F-uQNfQKsA4","ypMnYkTnxG4","GY73iraX53k","Tv6WImqSuxA","cTlshvPrIZo","ux8-EbW6DUI","K4DyBUG242c","n4tK7LYFxI0","1hxGuyfAErQ","p7ZsBPK656s",
	   "xMCXZj5zwBE","ULo95Mm_s20","n4tK7LYFxI0","p7ZsBPK656s","S19UcWdOA-I","85UQsB9odZQ","bdE_SyHad90","HdOCXC8ZwAw","__CRWE-L45k","J2X5mJ3HDYE","AOeY-nDp7hI"
	   
	   //"6cDdvFQIAfM","_t9pS8UJPEw","lpsL8Yv6W_E","Lq2UrnDsI_s","IIrCDAV3EgI","4lXBHD5C8do"
	   //"xJkTdzolo00","vtHGESuQ22s","PTpZqMpq6w8","2Hip-Sdtbck","3nQNiWdeH2Q","Tv6WImqSuxA","6ukEy6FOxZE","_bipJ2xFNoY","KzQiRABVARk"
    ],

 
    /*
        Set to false if you do not want any music.
    */
    enableMusic: true,
 
    /*
        Default volume for the player. Please keep this under 50%, to not blowout someones eardrums x)
     */
    musicVolume: 3,
 
    /*
        Should the background change images?
        True: it will not change backgrounds.
        False: it will change backgrounds.
    */
    staticBackground: false,
   
    /*
        Array of images you'd like to display as the background.
        Provide a path to a local image, using images via url is not recommended.
    */
    background:
    [
	
	'img/bbrp.jpg',
    'img/bbrp2.jpg',
	'img/bbrp3.jpg',
	'img/bbrp4.jpg',
	'img/bbrp5.jpg',
	'img/bbrp6.jpg',
	'img/bbrp7.jpg',
	'img/bbrp8.jpg',
	'img/bbrp9.jpg',
	'img/bbrp10.jpg',
	'img/bbrp11.jpg',
	'img/bbrp12.jpg',
	'img/bbrp13.jpg',
	'img/bbrp14.jpg',
	'img/bbrp15.jpg',
	'img/bbrp16.jpg',
	'img/bbrp17.jpg',
	'img/bbrp18.jpg',
	'img/bbrp19.jpg',
	'img/bbrp20.jpg',
	'img/bbrp21.jpg',
	'img/bbrp22.jpg',
    'img/bbrp23.jpg',
	'img/bbrp24.jpg',
	'img/bbrp25.jpg',
	'img/bbrp26.jpg'
    ],
 
    /*
        Time in milliseconds on how fast the background
        should swap images.
     */
    backgroundSpeed: 2.5 * 1000,

    /*
        Which style of animation should the background transition be?
        zoom = background zooms in and out.
        slide = transtion backgrounds from sliding right and back again.
        fade = fade the background out and back in.
    */
    backgroundStyle: "fade",

    /*
        Should the log be visible? Handy for debugging!
    */
    enableLog: false,
}
