var lastmenu = null;
var lastbg = null;
var resourcename;

$( function() {
    init();

    var ofcContainer = $( "#leo" );
    var civContainer = $( "#civ" );
	var licContainer = $( "#lic" );
	var bcopContainer = $( "#btcop");
	var btpContainer = $( "#btproxm" );
	var btsContainer = $( "#btstrawm" );
	var dtsContainer = $( "#dtsm" );
	

		$("#submitinc").click(function() {$.post('http://' + resourcename + '/setvc', JSON.stringify({name: $("#tsearchv").val()}));  $(this).blur()})
		$("#submitname").click(function() {$.post('http://' + resourcename + '/setv', JSON.stringify({name: $("#tsearchp").val()}));  $(this).blur()})
		$("#refreshpolice").click(function() {$.post('http://' + resourcename + '/refreshpolice', JSON.stringify({name: $("#tsearchp").val()}));  $(this).blur()})
		$("#refreshphone").click(function() {$.post('http://' + resourcename + '/refreshphone', JSON.stringify({name: $("#tsearchp").val()}));  $(this).blur()})
		$("#refreshcad").click(function() {$.post('http://' + resourcename + '/refreshcad', JSON.stringify({name: $("#tsearchp").val()}));  $(this).blur()})
		$("#suspendlic").click(function() {$.post('http://' + resourcename + '/setflag', JSON.stringify({name: $("#tsearchp").val(),flag: 'licsuspended'}));  $(this).blur()})
		$("#revokepn").click(function() {$.post('http://' + resourcename + '/setflag', JSON.stringify({name: $("#tsearchp").val(),flag: 'revokepn'}));  $(this).blur()})
		$("#revokeweaponlic").click(function() {$.post('http://' + resourcename + '/setflag', JSON.stringify({name: $("#tsearchp").val(),flag: 'revokeweaponlic'}));  $(this).blur()})
		$("#togglestolenveh").click(function() {$.post('http://' + resourcename + '/setstolen', JSON.stringify({name: $("#tsearchv").val(),flag: 'togglestolenveh'}));  $(this).blur()})
		
		$("#flagweapons").click(function() {$.post('http://' + resourcename + '/setflag', JSON.stringify({name: $("#tsearchp").val(),flag: 'flagweapons'}));  $(this).blur()})
		$("#flagmentalhealth").click(function() {$.post('http://' + resourcename + '/setflag', JSON.stringify({name: $("#tsearchp").val(),flag: 'flagmentalhealth'}));  $(this).blur()})
		
		$("#flagviolence").click(function() {$.post('http://' + resourcename + '/setflag', JSON.stringify({name: $("#tsearchp").val(),flag: 'flagviolence'}));  $(this).blur()})
		$("#flagviolencepolice").click(function() {$.post('http://' + resourcename + '/setflag', JSON.stringify({name: $("#tsearchp").val(),flag: 'flagviolencepolice'}));  $(this).blur()})
		
		
		
		
		$("#addwarrant").click(function() {$.post('http://' + resourcename + '/setflag', JSON.stringify({name: $("#tsearchp").val(),flag: 'addwarrant', reason: $("#txtReason").val() + "\r\n\r\n REPORT: " +  $("#txtReport").val(), type: $("#typer option:selected" ).text()}));  $(this).blur()})
		$("#closecrimwarrant").click(function() {$.post('http://' + resourcename + '/setflag', JSON.stringify({name: $("#tsearchp").val(),flag: 'closecrimwarrant'}));  $(this).blur()})
		
		$("#closebail").click(function() {$.post('http://' + resourcename + '/setflag', JSON.stringify({name: $("#tsearchp").val(),flag: 'closebail'}));  $(this).blur()})
		
	$("#tsearchp").keyup(function(event) {
		if (event.keyCode === 13) {
			$("#submitname").click();
		}
	});
	
	$("#tsearchv").keyup(function(event) {
		if (event.keyCode === 13) {
			$("#submitinc").click();
		}
	});


    window.addEventListener( 'message', function( event ) {
        var item = event.data;
		
	document.onkeydown = function (data) {
		if ((data.which == 120 || data.which == 27 || data.which == 116 || data.which == 117) && lastmenu != null) { // || data.which == 8
			$.post("http://" + resourcename + "/escape");
		}
	};
        
        if ( item.showleomenu ) {
            $("div").hide();
            ofcContainer.show();
			$("#menuBg").show();
            $("#ofcinfo").show();
			lastbg = $("#menuBg");
            lastmenu = ofcContainer;
        }
		
		
		if ( item.showcadlookup ) {
            $("div").hide();
            ofcContainer.show();
			$("#menuBg").show();
            $("#cadlookup").show();
			$("#civinfo").hide();
			lastbg = $("#menuBg");

        }
		
		if ( item.showpoliceid ) {
            $("div").hide();
			$("#policeid").show();
        }
		if ( item.hidepoliceid ) {
			$("#policeid").hide();
        }
		
		if ( item.showfpoliceid ) {
            $("div").hide();
			$("#fpoliceid").show();
        }
		if ( item.hidefpoliceid ) {
			$("#fpoliceid").hide();
        }
		
		if ( item.showpsopoliceid ) {
            $("div").hide();
			$("#psopoliceid").show();
        }
		if ( item.hidepsopoliceid ) {
			$("#psopoliceid").hide();
        }
		
		
		if ( item.showsheriffid ) {
            $("div").hide();
			$("#sheriffid").show();
        }
		if ( item.hidesheriffid ) {
			$("#sheriffid").hide();
        }
		
		
		
		if ( item.showcadentry ) {
            $("div").hide();
            ofcContainer.show();
			$("#menuBg").show();
            $("#cadreport").show();
			$("#civinfo").hide();
			lastbg = $("#menuBg");

        }
        if ( item.showcivmenu ) {
            $("div").hide();
            civContainer.show();
			$("#menuBgCiv").show();
            $("#civinfo").show();
			lastbg = $("#menuBgCiv");
            lastmenu = ofcContainer;
        }

		if (item.showbtproxmenu){
			 $("div").hide();
			if (item.btcop == true){
				bcopContainer.show()
				lastmenu = bcopContainer;
			} else {
				btpContainer.show();
				lastmenu = btpContainer;
			}
            $("#btprox").show();
		}
		
		if (item.showbtmenu){
			 $("div").hide();
			if (item.btcop == true){
				bcopContainer.show()
				lastmenu = bcopContainer;
			} else {
				btsContainer.show();
				lastmenu = btsContainer;
			}
            $("#btstraw").show();
		}
		
		if (item.showdtmenu){
			 $("div").hide();
			if (item.btcop == true){
				bcopContainer.show()
				lastmenu = bcopContainer;
			} else {
				dtsContainer.show();
				lastmenu = dtsContainer;
			}
            $("#dts").show();
		}
				
        if (item.openlastmenu) {
			lastbg.show();
            lastmenu.show();
        }
        if ( item.hidemenus ) {
			lastbg.hide();
            lastmenu.hide();
        }
		if ( item.endexit ) {
	
			$("#btstraw").hide();
			$("#btstrawm").hide();
			$("#btprox").hide();
			$("#btproxm").hide();
			$("#btstraw").hide();
			$("#btstrawm").hide();
			$("#dts").hide();
			$("#dtsm").hide();
			$("#dtsm_dtsm").hide();
			$("bt").hide();
			lastbg.hide();
			lastmenu = null;
            exit();
			
			
        }
        if ( item.setname ) {
            resourcename = item.metadata;
        }
	
		if (item.displayChange){
			var l1status = $("#l1status");
			var l2reading =  $("#l2reading");
			var l3reading =  $("#l3reading");
			var ll1status = $("#ll1status");
			var ll2reading =  $("#ll2reading");
			var ll3reading =  $("#ll3reading");
			l1status.text(item.data[0]);
			l2reading.text(item.data[1]);
			l3reading.text(item.data[2]);
			ll1status.text(item.data[0]);
			ll2reading.text(item.data[1]);
			ll3reading.text(item.data[2]);
		}
		
		if (item.displayChangeDT){
			var dtcan= $("#dtcan");
			var dtmeth =  $("#dtmeth");
		
			dtcan.text(item.data[0]);
			dtmeth.text(item.data[1]);

		}
		
		//LICENCE INFORMATION
		if (item.displayLIC){
			//Licence ID
			var licinfo = item.data[0];
			var dltitle = $("#dltitle");
			var licid = $("#licid");
			var licname = $("#licname");
			var lictypec = $("#lictypec");
			var licexp = $("#licexp");
			var licaddress = $("#licaddress");
			
			dltitle.text(licinfo[0]);
			licid.text(licinfo[1]);
			licname.text(licinfo[2] + " " + licinfo[3]);
			lictypec.text(licinfo[4]);
			licexp.text(licinfo[5]);
			licaddress.text(licinfo[6]);
			
			$("div").hide();
            licContainer.show();
            $("#licinfo").show();
			lastbg = nil;
            lastmenu = licContainer;
		}
		
		//$("#submitname").click(function() {$.post('http://' + resourcename + '/setv', JSON.stringify({name: $("#tsearchp").val(),crimes: $("select#CallType").val(), type: 'bank', datetime: $("#dtime").val()}));  $(this).blur()})
	
	
		 if ( item.namecheck ) {
			 var strdata = item.data[0];
			 //$("#personcheck").val("Test Value");
			 $("#personcheck").text(strdata);
			  
			 
		 }
		 
		 if ( item.carcheck ) {
			 var strdata = item.data[0];
			 //$("#personcheck").val("Test Value");
			 $("#carcheck").text(strdata);
			  
			 
		 }
		
		if (item.pinhistory){
			 var strdata = item.data[0];
			 //$("#personcheck").val("Test Value");
			 $("#pinhistory").text(strdata);
			
		}
		
		if (item.crimhistory){
			 var strdata = item.data[0];
			 //$("#personcheck").val("Test Value");
			 $("#crimhistory").text(strdata);
			
		}
		
		if (item.reporthistory){
			 var strdata = item.data[0];
			 //$("#personcheck").val("Test Value");
			 $("#cadrhistory").text(strdata);
			
		}
		
		if (item.cadthistory){
			 var strdata = item.data[0];
			 //$("#personcheck").val("Test Value");
			 $("#cadthistory").text(strdata);
			
		}
		
		
		
		if (item.supers){
			
			 var strdata = item.data[0];
			 //$("#personcheck").val("Test Value");
			 $("#freshpolicetxt").text(strdata);
			
		}
		
		if(item.sheriffsob) {
			var strdata = item.data[0];
			 //$("#personcheck").val("Test Value");
			 $("#sheriffhistory").text(strdata);	
			
		}
		
        if ( item.pushback ) {
            // getting info arr
            var civinfo = item.data[0];
            var ofcinfo = item.data[1];
			

            // getting civ elements
            var civname = $("#civname");
			var civaddress = $("#civaddress");
            var civwarrant = $("#civwarrant");
			var civdob = $("#civdob");
			var civwhereabouts = $("#civwhereabouts");
            var civcitations = $("#civcit");
			var licstat = $("#licstat");
			var lictype = $("#lictype");
			//var bt = $("#bt");
			//var dt = $("#dt");			
					
            // getting veh elements
            var vehplate = $("#vehplate");
            var vehstolen = $("#vehstolen");
            var vehregi = $("#vehregi");
            var vehinsured = $("#vehinsured");
            // getting ofc elements
            var ofcsign = $("#ofcsign");
            var ofcstatus = $("#ofcstatus");
            var ofcass = $("#ofcass");
			
		
		            
            // setting civ stuff
            civname.text(civinfo[1] + ", " + civinfo[0]);
            civwarrant.text(civinfo[3]);
			civaddress.text(civinfo[7]);
			civdob.text(civinfo[10])
			civwhereabouts.text(civinfo[4]);
            civcitations.text(civinfo[2]);
			licstat.text(civinfo[5]);
			lictype.text(civinfo[6]);
            // setting veh stuff
            vehplate.text(civinfo[11]);
            vehstolen.text(civinfo[12]);
            vehregi.text(civinfo[13]);
            vehinsured.text(civinfo[14]);
			
			//breathtesting
			//bt.text(civinfo[11]);
			//dt.text(civinfo[12]);
			
            // setting ofc stuff
            ofcsign.text(ofcinfo[0]);
            ofcstatus.text(ofcinfo[1]);
            ofcass.text(ofcinfo[2]);
						
        }
    } );
} )

                 
			
function back(sender) {
    var item = $(sender).parent();

    var parent = item.data("parent");

    item.hide();
    var parentMenu = $("#" + parent);
    parentMenu.show();
    lastmenu = parentMenu;
}

function exit() {
    $("div").hide();
    send("common", ['exit'])
}

function arrSkip(arr, count) {
    var data = [];

    for (var i = count; i < arr.length; i++) {
        data[i - count] = arr[i];
    }

    return data;
}

function init() {
    $(".menu").each(function(i,obj) {
        if ( $(this).attr("data-parent")) {
            $(this).append("<button class='option back' onclick='back(this)'>Back</button>");
        }
		 if ( $(this).attr("noexit")) {
            
        } else {
			$(this).append("<button class='option x' onclick='exit()'>Exit</button>");
		}
    });

    $( ".option" ).each( function( i, obj ) {

        if ( $( this ).attr( "data-action" ) ) {
            $( this ).click( function() { 
                var dataArr = $( this ).data( "action" ).split(" ");

                send( dataArr[0], arrSkip(dataArr, 1) ); 
            } )
        }

        if ( $( this ).attr( "data-sub" ) ) {
            $(this).addClass("sub");
            $( this ).click( function() {
                var menu = $( this ).data( "sub" );
                var element = $( "#" + menu ); 
                element.show();
                lastmenu = element;
                $( this ).parent().hide();  
            } )
        }
    } );
}

function send( name, data ) {
    $.post( "http://" + resourcename + "/" + name, JSON.stringify(data), function( datab ) {
        if ( datab != "OK" ) {
            console.log( datab );
        }
    } );
}


