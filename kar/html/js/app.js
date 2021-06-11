$(".character-box").hover(
    function() {
        $(this).css({
            "background": "rgba(42, 125, 193, 1.0)",
            "transition": "200ms",
        });
    }, function() {
        $(this).css({
            "background": "rgba(0,0,0,0.6)",
            "transition": "200ms",
        });
    }
);

$(".character-box").click(function () {
    $(".character-box").removeClass('active-char');
    $(this).addClass('active-char');
    $(".character-buttons").css({"display":"flex"});
    if ($(this).attr("data-ischar") === "true") {
        $("#delete").css({"display":"block"});
    } else {
        $("#delete").css({"opacity": "0"});
    }
});

$("#play-char").click(function () {
    $.post("http://kar/CharacterChosen", JSON.stringify({
        charid: $('.active-char').attr("data-charid"),
        ischar: $('.active-char').attr("data-ischar"),
    }));
//    Kashacter.CloseUI();
//	Kashacter.CloseUI();
});

$("#deletechar").click(function () {
    $.post("http://kar/DeleteCharacter", JSON.stringify({
        charid: $('.active-char').attr("data-charid"),
    }));
    Kashacter.CloseUI();
	Kashacter.CloseUI();
});

(() => {
    Kashacter = {};
	var num3 = 1;
    Kashacter.ShowUI = function(data) {
        $('.main-container').css({"display":"block"});
        if(data.characters !== null) {
            $.each(data.characters, function (index, char) {
                if (char.charid !== 0) {
                    var charid = char.identifier.charAt(4);
                    $('[data-charid=' + charid + ']').html('<h3 class="character-fullname"><i class="fas fa-id-card"></i> '+char.firstname +' '+ char.lastname+'</h3><div class="character-info"><p class="character-info-work"><strong><i class="fas fa-briefcase"></i></strong><span> '+ char.job +'</span></p><p class="character-info-money"><strong><i class="fas fa-wallet"></i></strong><span> '+ char.money +'</span></p><p class="character-info-bank"><strong><i class="fas fa-credit-card"></i></strong><span> '+ char.bank +'</span></p> </div>').attr("data-ischar", "true");
                }
            });
        }
		num3 = data.pc;
		
		if (num3 == 1){
			$("#ch2").hide();
			$("#ch3").hide();
			$("#ch4").hide();
			$("#ch5").hide();
		}
		else if (num3 == 2){
			$("#ch3").hide();
			$("#ch4").hide();
			$("#ch5").hide();
		}
		else if (num3 == 3){

			$("#ch4").hide();
			$("#ch5").hide();
		}
		else if (num3 == 4){

			$("#ch5").hide();
	
		}
    };

    Kashacter.CloseUI = function() {
        $('.main-container').css({"display":"none"});
        $(".character-box").removeClass('active-char');
        $("#delete").css({"display":"none"});
		$(".character-box").html('<h3 class="character-fullname"></h3><div class="character-info"><p class="character-info-new"><i class="fas fa-plus"></i></p></div>').attr("data-ischar", "false");
        $('.main-logo').css({"display":"none"});
        $('.overlay-right').css({"display":"none"})
    };
    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            switch(event.data.action) {
                case 'openui':
					$("#bbrpl1").show();
					$("#bbrpl2").show();
                    Kashacter.ShowUI(event.data);
                    break;
				case 'closeui':
					Kashacter.CloseUI();
					Kashacter.CloseUI();
					$("#bbrpl1").hide();
					$("#bbrpl2").hide();
				case 'reload':
					location.reload();
				
            }
        })
    }

})();