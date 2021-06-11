var nightclubBahamasaudioPlayer = null;
var nightclubgalaxyaudioPlayer = null;
var nightclubteqilaudioPlayer = null;
var nightclubunicornaudioPlayer = null;

window.addEventListener('message', function(e) {

    if (e.data.dancefloor == 'nightclubBahamas') {
		//console.log(JSON.stringify(e))
		
		if (e.data.musiccommand == 'playsonglink') {
			  
		  if (audioPlayer != null) {
			nightclubBahamasaudioPlayer.pause();
			nightclubBahamasaudioPlayer.currentTime = 0;
		  }
		  

			nightclubBahamasaudioPlayer = new Audio(e.data.songname);
			nightclubBahamasaudioPlayer.volume = 0.0;
			nightclubBahamasaudioPlayer.play();
		} else if (e.data.setvolume !== undefined && nightclubteqilaudioPlayer != null) {
			if (e.data.setvolume >= 0.0 && e.data.setvolume <= 1.0) {
				// console.log(e.data.setvolume);
				nightclubBahamasaudioPlayer.volume = e.data.setvolume;
			}
		}
		else if (e.data.musiccommand == 'playsong') {
			
		  if (nightclubBahamasplayer != null) {
			jQuery("#nightclubBahamasplayer").tubeplayer("pause");
			jQuery("#nightclubBahamasplayer").tubeplayer("seek", 0);
		  }
		  
		  //console.log(e.data.songname);
		  	jQuery("#nightclubBahamasplayer").tubeplayer("cue", e.data.songname);
	  
			jQuery("#nightclubBahamasplayer").tubeplayer("play");
			jQuery("#nightclubBahamasplayer").tubeplayer("volume", 0);
		} else if (e.data.musiccommand == 'pause') {
			jQuery("#nightclubBahamasplayer").tubeplayer("pause");
			nightclubBahamasaudioPlayer.pause();
		} else if (e.data.musiccommand == 'stop') {
			jQuery("#nightclubBahamasplayer").tubeplayer("stop");
			    nightclubBahamasaudioPlayer.pause();
				nightclubBahamasaudioPlayer.currentTime = 0;
		} else if (e.data.musiccommand == 'play') {
			jQuery("#nightclubBahamasplayer").tubeplayer("play");
		} else if (e.data.setvolume !== undefined) {
		  if (e.data.setvolume >= 0.0 && e.data.setvolume <= 1.0) {
			var vol = e.data.setvolume;
			var corrigir = vol.toFixed(2);
			var resultado = (corrigir).replace('.','');
			var menosum = (resultado).substr(1);
			jQuery("#nightclubBahamasplayer").tubeplayer("volume", menosum);
			}
		}
	
	} else if(e.data.dancefloor == 'nightclubunderground') {
		//console.log(JSON.stringify(e))
		if (e.data.musiccommand == 'playsong') {
			
		  if (playernightclubunderground != null) {
			jQuery("#playernightclubunderground").tubeplayer("pause");
			jQuery("#playernightclubunderground").tubeplayer("seek", 0);
		  }
		  
		  //console.log(e.data.songname);
		  	jQuery("#playernightclubunderground").tubeplayer("cue", e.data.songname);
	  
			jQuery("#playernightclubunderground").tubeplayer("play");
			jQuery("#playernightclubunderground").tubeplayer("volume", 0);
		} else if (e.data.musiccommand == 'pause') {
			jQuery("#playernightclubunderground").tubeplayer("pause");
		} else if (e.data.musiccommand == 'stop') {
			jQuery("#playernightclubunderground").tubeplayer("stop");

		} else if (e.data.musiccommand == 'play') {
			jQuery("#playernightclubunderground").tubeplayer("play");
		} else if (e.data.setvolume !== undefined) {
		  if (e.data.setvolume >= 0.0 && e.data.setvolume <= 1.0) {
			var vol = e.data.setvolume;
			var corrigir = vol.toFixed(2);
			var resultado = (corrigir).replace('.','');
			var menosum = (resultado).substr(1);
			jQuery("#playernightclubunderground").tubeplayer("volume", menosum);
			}
		}
	
	} else if(e.data.dancefloor == 'nightclubteqil') {

		if (e.data.musiccommand == 'playsonglink') {
			  
		  if (nightclubteqilaudioPlayer != null) {
			nightclubteqilaudioPlayer.pause();
			nightclubteqilaudioPlayer.currentTime = 0;
		  }
		  
		  if (playernightclubteqil != null) {
			  	jQuery("#playernightclubteqil").tubeplayer("pause");

		  }
		  
		  
			nightclubteqilaudioPlayer = new Audio(e.data.songname);
			nightclubteqilaudioPlayer.volume = 0.0;
			nightclubteqilaudioPlayer.play();
		} else if (e.data.setvolume !== undefined && nightclubteqilaudioPlayer != null) {
			if (e.data.setvolume >= 0.0 && e.data.setvolume <= 1.0) {
            // console.log(e.data.setvolume);
				nightclubteqilaudioPlayer.volume = e.data.setvolume;
			}
		}
		else if (e.data.musiccommand == 'playsong') {
			if (nightclubteqilaudioPlayer != null){
				nightclubteqilaudioPlayer.pause();
				nightclubteqilaudioPlayer = null
			}
		  if (playernightclubteqil != null) {
			jQuery("#playernightclubteqil").tubeplayer("pause");
			jQuery("#playernightclubteqil").tubeplayer("seek", 0);

		  }
		  
		  //console.log(e.data.songname);
		  	jQuery("#playernightclubteqil").tubeplayer("cue", e.data.songname);
	  
			jQuery("#playernightclubteqil").tubeplayer("play");
			jQuery("#playernightclubteqil").tubeplayer("volume", 0);
		} else if (e.data.musiccommand == 'pause') {
			jQuery("#playernightclubteqil").tubeplayer("pause");
			if (nightclubteqilaudioPlayer != null) {
				nightclubteqilaudioPlayer.pause();
			}
		} else if (e.data.musiccommand == 'stop') {
			jQuery("#playernightclubteqil").tubeplayer("stop");
			if (nightclubteqilaudioPlayer != null) {
				nightclubteqilaudioPlayer.pause();
			}
		} else if (e.data.musiccommand == 'play') {
			jQuery("#playernightclubteqil").tubeplayer("play");
		} else if (e.data.setvolume !== undefined) {
		  if (e.data.setvolume >= 0.0 && e.data.setvolume <= 1.0) {
			var vol = e.data.setvolume;
			var corrigir = vol.toFixed(2);
			var resultado = (corrigir).replace('.','');
			var menosum = (resultado).substr(1);
			jQuery("#playernightclubteqil").tubeplayer("volume", menosum);
			}
		}
	} 
	else if(e.data.dancefloor == 'nightclubgalaxy') {

		if (e.data.musiccommand == 'playsonglink') {
			  
		  if (nightclubgalaxyaudioPlayer != null) {
			nightclubgalaxyaudioPlayer.pause();
			nightclubgalaxyaudioPlayer.currentTime = 0;
		  }
		  
		  if (playernightclubgalaxy != null) {
			  	jQuery("#playernightclubgalaxy").tubeplayer("pause");
				jQuery("#playernightclubgalaxy").tubeplayer("seek", 0);
		  }
		  
			nightclubgalaxyaudioPlayer = new Audio(e.data.songname);
			nightclubgalaxyaudioPlayer.volume = 0.0;
			nightclubgalaxyaudioPlayer.play();
		} else if (e.data.setvolume !== undefined && nightclubgalaxyaudioPlayer != null) {
			if (e.data.setvolume >= 0.0 && e.data.setvolume <= 1.0) {
            // console.log(e.data.setvolume);
				nightclubgalaxyaudioPlayer.volume = e.data.setvolume;
			}
		}
		else if (e.data.musiccommand == 'playsong') {
			if (nightclubgalaxyaudioPlayer != null){
				nightclubgalaxyaudioPlayer.pause();
				nightclubgalaxyaudioPlayer = null
			}

		  if (playernightclubgalaxy != null) {
			jQuery("#playernightclubgalaxy").tubeplayer("pause");

			if (nightclubgalaxyaudioPlayer != null){
				nightclubgalaxyaudioPlayer.pause();
			}
		  }
		  
		  //console.log(e.data.songname);
		  	jQuery("#playernightclubgalaxy").tubeplayer("cue", e.data.songname);
	  
			jQuery("#playernightclubgalaxy").tubeplayer("play");
			jQuery("#playernightclubgalaxy").tubeplayer("volume", 0);
		} else if (e.data.musiccommand == 'pause') {
			jQuery("#playernightclubgalaxy").tubeplayer("pause");
			if (nightclubgalaxyaudioPlayer != null){
				nightclubgalaxyaudioPlayer.pause();
			}
		} else if (e.data.musiccommand == 'stop') {
			jQuery("#playernightclubgalaxy").tubeplayer("stop");
			if (nightclubgalaxyaudioPlayer != null){
				nightclubgalaxyaudioPlayer.pause();
			}
		} else if (e.data.musiccommand == 'play') {
			jQuery("#playernightclubgalaxy").tubeplayer("play");
		} else if (e.data.setvolume !== undefined) {
		  if (e.data.setvolume >= 0.0 && e.data.setvolume <= 1.0) {
			var vol = e.data.setvolume;
			var corrigir = vol.toFixed(2);
			var resultado = (corrigir).replace('.','');
			var menosum = (resultado).substr(1);
			jQuery("#playernightclubgalaxy").tubeplayer("volume", menosum);
			}
		}
	}	
	else if(e.data.dancefloor == 'nightclubunicorn') {

		if (e.data.musiccommand == 'playsonglink') {
			  
		  if (nightclubunicornaudioPlayer != null) {
			nightclubunicornaudioPlayer.pause();
			nightclubunicornaudioPlayer.currentTime = 0;
		  }
		  
			nightclubunicornaudioPlayer = new Audio(e.data.songname);
			nightclubunicornaudioPlayer.volume = 0.0;
			nightclubunicornaudioPlayer.play();
		} else if (e.data.setvolume !== undefined && nightclubunicornaudioPlayer != null) {
			if (e.data.setvolume >= 0.0 && e.data.setvolume <= 1.0) {
            // console.log(e.data.setvolume);
				nightclubunicornaudioPlayer.volume = e.data.setvolume;
			}
		}
		else if (e.data.musiccommand == 'playsong') {
			if (nightclubunicornaudioPlayer != null){
				nightclubunicornaudioPlayer.pause();
				nightclubunicornaudioPlayer = null
			}
		  if (playernightclubunicorn != null) {
		    jQuery("#playernightclubunicorn").tubeplayer();
			jQuery("#playernightclubunicorn").tubeplayer("pause");
			jQuery("#playernightclubunicorn").tubeplayer("seek", 0);

		  }
		  
		  //console.log(e.data.songname);
		  	jQuery("#playernightclubunicorn").tubeplayer("cue", e.data.songname);
	  
			jQuery("#playernightclubunicorn").tubeplayer("play");
			jQuery("#playernightclubunicorn").tubeplayer("volume", 0);
		} else if (e.data.musiccommand == 'pause') {
			jQuery("#playernightclubunicorn").tubeplayer("pause");
			if (nightclubunicornaudioPlayer != null){
				nightclubunicornaudioPlayer.pause();
			}
		} else if (e.data.musiccommand == 'stop') {
			jQuery("#playernightclubunicorn").tubeplayer("stop");
			if (nightclubunicornaudioPlayer != null){
				nightclubunicornaudioPlayer.pause();
			}
		} else if (e.data.musiccommand == 'play') {
			jQuery("#playernightclubunicorn").tubeplayer("play");
		} else if (e.data.setvolume !== undefined) {
		  if (e.data.setvolume >= 0.0 && e.data.setvolume <= 1.0) {
			var vol = e.data.setvolume;
			var corrigir = vol.toFixed(2);
			var resultado = (corrigir).replace('.','');
			var menosum = (resultado).substr(1);
			jQuery("#playernightclubunicorn").tubeplayer("volume", menosum);
			}
		}
	}
});