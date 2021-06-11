let showCadSystem = function(){
    $('#police-cad').show();
	$('#plate-checker').hide();
    //$('#input-plate').focus();
    isCadSystemShowed = true;
}

let hideCadSystem = function(){
    $('#police-cad').hide();
    isCadSystemShowed = false;
}

document.onkeydown = function (data) {
    if ((data.which == 120 || data.which == 27) && isCadSystemShowed) { // || data.which == 8
        $.post('http://esx_dp/escape');
    }
};

$(document).on('click','.civ-back', function (ev) {
    $('.civilian-details .inputfield').empty();
    $('.civilian-details').hide(300);
    $('.resultinner').show(300);
});

var job = "unknown"
		

$(function() {
    window.addEventListener('message', function(event) {

         if (event.data.callresults){
            $('.tbody-result-calls').remove();
            $('.all-found-calls').append($('<tbody class="tbody-result-calls">'));
			
           event.data.callresults.forEach(function(call){
	
				var cancelbutton = ""
				
				if (job == 'ambulance')
				{
					cancelbutton = "<button type='submit' class='' id='button' onclick='requestpolice($(this).val())' value='" + call['id'] + "'>[P]</button><button type='submit' class='' id='button' onclick='canceljob($(this).val())' value='" + call['id'] + "'>X</button>"
				}
				else{
					cancelbutton =  "<button type='submit' class='' id='button' onclick='removeme($(this).val())' value='" + call['id'] + "'>CLR</button><button type='submit' class='' id='button' onclick='canceljob($(this).val())' value='" + call['id'] + "'>X</button>"
				}
                $('.tbody-result-calls').append($('<tr>').on('click', function(){
                    //showExtraUserData(call);  https://stackoverflow.com/questions/49488094/add-button-dynamically-to-html-table-on-row-append-to-other-table
                })
                    .append($("<td width='1px' cellpadding='0'>").text(call['id']))
					.append($('<td>').text(call['tmd']))
                    .append($('<td>').text(call['from']))
                    .append($('<td>').text(call['type']))
					.append($('<td>').text(call['location']))
                    .append($('<td>').html(call['message']))
					.append($('<td>').html(call['assignext']))
					.append("<td width='5px' cellpadding='0'><button type='submit' class='' id='button'  onclick='gps($(this).val())' value='" + call['id'] + "'>GPS</button></td>")
					.append("<td width='1px' cellpadding='0'><button type='submit' class='' id='button' onclick='statuschange_enroute($(this).val())' value='" + call['id'] + "'>ENROUTE</button></td>")
					.append("<td width='1px' cellpadding='0'><button type='submit' class='' id='button' onclick='statuschange_onscene($(this).val())' value='" + call['id'] + "'>ARRIVED</button></td>")
					.append("<td width='1px' cellpadding='0'>" + cancelbutton + "</td>")
					

										

				);

										
            })
        }
		
		if (event.data.unitlist){
			
			
			var $dropdown = $("#unlitcars");
			$dropdown.empty()
			$.each(event.data.unitlist, function(unit) {
				$dropdown.append($("<option />").val(event.data.unitlist[unit]).text(event.data.unitlist[unit]));
			});
			
		}
		
		if (event.data.job){
			job = event.data.job;
		
		}
		




        if (event.data.crresults){
           createTableCr(event.data.crresults);
        }
        if(event.data.note_deleted){
            playerid = JSON.stringify({ playerid: $('#cr-playerid').val() });
            $.post('http://esx_dp/get-note', playerid );

            noteMessage = $('.note-message');
            noteMessage.empty();
            noteMessage.text('Note deleted');
            setTimeout(function(){
                noteMessage.empty();
            },2000);


        }
        if(event.data.note_not_deleted){
            noteMessage = $('.note-message');
            noteMessage.empty();
            noteMessage.text('Note deleted failed');
            setTimeout(function(){
                noteMessage.empty();
            },2000);
        }

        if(event.data.cr_deleted){
            playerid = JSON.stringify({ playerid: $('#cr-playerid').val() });
            $.post('http://esx_dp/get-cr', playerid );

            crMessage = $('.cr-message');
            crMessage.empty();
            crMessage.text('Cr deleted');
            setTimeout(function(){
                crMessage.empty();
            },2000);


        }

        if(event.data.bolo_not_deleted){
            boloMessage = $('.error-bolo');
            boloMessage.empty();
            boloMessage.text('Bolo deleted failed');
            setTimeout(function(){
                boloMessage.empty();
            },2000);
        }

        if(event.data.bolo_deleted){
            playerid = JSON.stringify({ playerid: $('#cr-playerid').val() });
            $.post('http://esx_dp/get-bolos' );
            boloMessage = $('.bolo-message');
            boloMessage.empty();
            boloMessage.text('Bolo deleted');
            setTimeout(function(){
                boloMessage.empty();
            },2000);


        }


        if(event.data.cr_not_deleted){
            crMessage = $('.cr-message');
            crMessage.empty();
            crMessage.text('Cr deleted failed');
            setTimeout(function(){
                crMessage.empty();
            },2000);
        }

        if (event.data.noteResults){
            createNoteTable(event.data.noteResults);
        }

        if (event.data.licenseResults){
            createTableLicense(event.data.licenseResults);
        }

        if (event.data.showBolos){
            createBoloTable(event.data.showBolos);
        }

        if (event.data.plate){
            $('#plate').empty().append(event.data.plate);
            $('#model').empty().append(event.data.model);
            $('#firstname').empty().append(event.data.firstname);
            $('#lastname').empty().append(event.data.lastname);
        }
		
		
		if (event.data.emergencycalls){
            $('#plate').empty().append(event.data.plate);
            $('#model').empty().append(event.data.model);
            $('#firstname').empty().append(event.data.firstname);
            $('#lastname').empty().append(event.data.lastname);
        }

        if(event.data.showCadSystem === true){
            showCadSystem();
        }

        if(event.data.showCadSystem === false){
            hideCadSystem();
        }

    });

    document.onkeydown = function (data) {
        if ((data.which == 13)){
            searchPlate();
        }

        if ((data.which == 120 || data.which == 27) && isCadSystemShowed) { // || data.which == 8
            $.post('http://esx_dp/escape');
            hideCadSystem();
        }
    };

    $(document).on('click','#search-for-plate',function(event){
        searchPlate();
    });

    $(document).on('click','.police-cad-close',function(event){
        $.post('http://esx_dp/escape');
        hideCadSystem();
    });

    $(document).on('click','.civ-back', function (ev) {
        $('.resultinner').show(300);
    });

    $(document).on('click','.add-cr', function (ev) {
        $('.modal-add-record').show(300);
    });

    $(document).on('click','.add-bolo', function (ev) {
        $('.modal-add-bolos').show(300);
    });

    $(document).on('click','#save-criminal-record', function (ev) {
        if($('#cr-offence').val().length > 2){
            addCR();
            $('.modal-add-record').hide(400);

            playerid = JSON.stringify({ playerid: $('#cr-playerid').val() });
            $.post('http://esx_dp/get-cr', playerid );

        }else{
            $('.error-cr').text('Please fill in the fields');
        }
    });

    $(document).on('click','.add-note', function (ev) {
        $('.modal-add-note').show(300);
        ($('#note-title').val(''));
        ($('#note-content').val(''));
    });


    $(document).on('click','.delete_note' ,function () {
        note = JSON.stringify({ id:  $(this).data('id') });
        $.post('http://esx_dp/delete_note', note);
    });

    $(document).on('click','.delete_cr' ,function () {
        cr = JSON.stringify({ id:  $(this).data('id') });
        $.post('http://esx_dp/delete_cr', cr);
    });


    $(document).on('click','#save-note', function (ev) {
        if($('#note-title').val().length > 1 && $('#note-content').val().length > 1){
            addNote();
            $('.modal-add-note').hide(400);
            playerid = JSON.stringify({ playerid: $('#cr-playerid').val() });
            $.post('http://esx_dp/get-note', playerid );

        }else{
            $('.error-note').text('Please fill in the fields');
        }
    });

    $(document).on('click','#save-bolos', function (ev) {
        bolo = JSON.stringify({
            gender: $('#input-bolos-gender').val(),
            height: $('#input-bolos-height').val(),
            age: $('#input-bolos-age').val(),
            type_of_crime: $('#input-bolos-type-of-crime').val(),
            note: $('#input-bolos-note').val()
        });

        $.post('http://esx_dp/add-bolo', bolo);
        $('.modal-add-bolos').hide(300);
    });

    $(document).on('click','.delete_bolo' ,function () {
        bolo = JSON.stringify({ id:  $(this).data('id') });
        $.post('http://esx_dp/delete-bolo', bolo);
    });


    $(document).on('click','#search-for-civilian',function(event){
        searchPlayer();
    });

    function searchPlate(){
        plate = JSON.stringify({ plate: $('#input-plate').val() });
        $.post('http://esx_dp/search-plate', plate);
    }

    function addCR(){
        criminalRecord = JSON.stringify({ offence: $('#cr-offence').val(), jail: $('#cr-jail').val(), playerid: $('#cr-playerid').val() });
        $.post('http://esx_dp/add-cr', criminalRecord);
    }

    function addNote(){
        note = JSON.stringify({ content: $('#note-content').val(), title: $('#note-title').val(), playerid: $('#cr-playerid').val()});
        $.post('http://esx_dp/add-note', note);
    }

    $(document).on('click', '.police-cad-menu li', function () {
        var id = $(this).data('id');
        $('.active').removeClass('active');
        $(this).addClass('active');

        hidePlateChecker();

        if($(this).data('id') == 'plate-checker'){
           // showPlateChecker();
        }
        
        if ( id == 'bolos'){
            $.post('http://esx_dp/get-bolos');
        }

        $('.page').hide();
        $('#'+id).show();
        $('input').focus();
    });
});

function showPlateChecker(){
   // $('#plate-checker').show();
}
function hidePlateChecker(){
    $('#plate-checker').hide();
}


function createTableCr(crresults){
    $('#criminal-records tbody').html('');
    crresults.forEach(function(cr){
        $('#criminal-records tbody').append($('<tr>')
            .append($('<td>').text(cr['offence']))
            .append($('<td>').text(cr['jail'] ? 'true' : 'false'))
            .append($('<td>').text(cr['created_at']))
            .append($('<td>').append($('<span class="delete_cr" data-id="'+ cr['id'] +'">').text('X'))));
    })
}

function createNoteTable(noteResults){
    $('#notes tbody').html('');
    noteResults.forEach(function(notes){
        $('#notes tbody').append($('<tr>')
            .append($('<td>').text(notes['title']))
            .append($('<td>').text(notes['content']))
            .append($('<td>').text(notes['created_at']))
            .append($('<td>').append($('<span class="delete_note" data-id="'+ notes['id'] +'">').text('X')))

        );
    })
}

function createBoloTable(boloResults){
    $('.police-cad-bolos tbody').html('');
    boloResults.forEach(function(bolo){
        $('.police-cad-bolos tbody').append($('<tr>')
            .append($('<td>').text(bolo['gender']))
            .append($('<td>').text(bolo['height']))
            .append($('<td>').text(bolo['age']))
            .append($('<td>').text(bolo['type_of_crime']))
            .append($('<td>').text(bolo['created_at']))
            .append($('<td>').append($('<span class="delete_bolo" data-id="'+ bolo['id'] +'">').text('X')))

        );
    })
}

function createTableLicense(licenseResults){
    licenseResults.forEach(function(license){
        $('#licenses tbody').append($('<tr>')
            .append($('<td>').text(license['type'])));
    })
}

function showExtraUserData(user){
    $('#criminal-records tbody').html('');
    $('#licenses tbody').html('');
    $('.resultinner').hide(300);
    $('.civilian-details').show(300);

    $('#cr-playerid').val(user.identifier);
    $('.firstname-label').text('Firstname');
    $('.firstname').text(user.firstname);

    $('.lastname-label').text('Lastname');
    $('.lastname').text(user.lastname);

    $('.sex-label').text('Sex');
    $('.sex').text(user.sex);

    $('.dob-label').text('Date of birth');
    $('.dob').text(user.dateofbirth);

    $('.height-label').text('Height');
    $('.height').text(user.height);

    $('.phone-label').text('Phone');
    $('.phone').text(user.phone_number);

    $('.job-label').text('Job');
    $('.job').text(user.job);

    $('.jail-label').text('In jail?');
    $('.jail').text((user.jail ? 'Yes': 'No'));

    playerid = JSON.stringify({ playerid: user.identifier });
    $.post('http://esx_dp/get-cr', playerid );

    $.post('http://esx_dp/get-note', playerid );

    $.post('http://esx_dp/get-license', playerid );

}

function searchPlayer(){
    search = JSON.stringify({ search: $('#search').val() });
    $.post('http://esx_dp/search-players', search);
}


function canceljob(val)
{
	
	id = JSON.stringify({ id: val });
	$.post('http://esx_dp/canceljob', id );
}

function removeme(val)
{
	
	id = JSON.stringify({ id: val });
	$.post('http://esx_dp/removeme', id );
}



function requestpolice(val)
{
	id = JSON.stringify({ id: val });
	$.post('http://esx_dp/requestpolice', id );
}

function gps(val)
{	id = JSON.stringify({ id: val });
	$.post('http://esx_dp/gps', id );
}

function statuschange_onscene(val)
{
	id = JSON.stringify({ id: val });
	$.post('http://esx_dp/onscene', id );
}

function statuschange_enroute(val)
{
	id = JSON.stringify({ id: val });
	$.post('http://esx_dp/enroute', id );
}