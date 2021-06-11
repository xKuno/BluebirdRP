$(document).ready(function () {

	var documentWidth = document.documentElement.clientWidth;
	var documentHeight = document.documentElement.clientHeight;

	// Retrieval form vars
	var rData 	= null;
	var rReason = document.getElementById('r-reason');
	var holdBy = document.getElementById('hold-by');

	var rules = null;

	window.addEventListener('message', function (event) {

		var data = event.data;
		rules = event.data.rules;

		if (data.action === "open") {


			if (data.form === "impound") {
				$('#impound-form').css('display', 'block');
				setupImpoundForm(data);
			}

			if (data.form === "retrieve") {
				$('#retrieve-form').css('display', 'block');
				setupRetrievalForm(data);
			}

			if (data.form === "admin") {
				$('#admin-terminal').css('display', 'block');
				setupAdminTerminal(data);
			}
		}

		if (data.action == "close") {
			$('#impound-form').css('display', 'none');
			$('#retrieve-form').css('display', 'none');
			$('#admin-terminal').css('display', 'none');
		}
	});

	// On 'Esc' call close method
	document.onkeyup = function (data) {
		if (data.which == 27 ) {
			$.post('http://esx_impound/escape', JSON.stringify({}));
		}
	};

	function setupImpoundForm(data) {

		if (data.officer) {
			$('#officer').val(data.officer).prop('disabled', true);
		}

		if (data.mechanic) {
			$('#mechanic').val(data.mechanic).prop('disabled', true);
		}

		$('#owner').text(data.vehicle.owner);
		$('#plate').text(data.vehicle.plate);

		$('#weeks').attr("placeholder", `0 - ${rules.maxWeeks} Weeks`);
		$('#days').attr("placeholder", `0 - ${rules.maxDays} Days`);
		$('#hours').attr("placeholder", `0 - ${rules.maxHours} Hours`);
		$('#fee').attr("placeholder", `${rules.minFee} - ${rules.maxFee}`);
		$('#reason').attr("placeholder", `Enter a detailed description of ${rules.minReasonLength} characters or more`)
	}


	$('#impound').click(function (event) {
		var releaseDate = new Date();
		var weeks 		= $('#weeks').val();
		var days 		= $('#days').val();
		var hours 		= $('#hours').val();
		var totalDays   = (parseInt(weeks) * 7 * 24) + (parseInt(days)*24) + (parseInt(hours));

		if(validateImpoundForm()) {
			$.post('http://esx_impound/impound', JSON.stringify({
				plate: $('#plate').text(),
				officer: $('#officer').val() || null,
				mechanic: $('#mechanic').val() || null,
				releasedate: totalDays,
				fee: $('#fee').val(),
				reason: $('#reason').val(),
				notes: $('#notes').val() || null,
				hold_o: $('#hold_o').find('input').prop("checked") ? 1: 0,
				hold_m: $('#hold_m').find('input').prop("checked") ? 1: 0
			}));
		}
	});

	function validateImpoundForm () {
		var success = true;
		var errors = $('#errors')
		errors.empty();

		var weeks = $('#weeks').val();
		var days = $('#days').val();
		var hours = $('#hours').val();
		var fee = $('#fee').val();
		var reason = $('#reason').val();

		if(weeks.isNaN || String(weeks).length < 1 || parseInt(weeks) < 0 || parseInt(weeks) > 41 || days.isNaN || String(days).length < 1 || parseInt(days) < 0 || parseInt(days) > 6) {
			errors.append(`<small>&#9679; Weeks have to be 0 or less than 41, days either 0 or less than 7.</small>`);
			success = false;
		}
		
		if(fee.isNaN || String(fee).length < 1 || parseInt(fee) < 250 || parseInt(fee) > 1000000) {
			errors.append(`<small>&#9679; Fee cannot be less than 250 or more than 1.000.000</small>`);
			success = false;
		}
		
		if(reason.length < 25 || reason.length > 10000) {
			errors.append(`<small>&#9679; Reason for impoundment cannot be less that 25 characters long.</small>`);
			success = false;
		}

		return success;
	}

	function setupRetrievalForm(data) {
		var vehicleHtml = "";
		rData = data;

		for(var i = 0; i < data.vehicles.length; i++) {

			var officer = "";

			var releasedate = data.vehicles[i].releasedate;
			var canrelease = data.vehicles[i].canrelease
			var currentdate = new Date();
			var hoursremain = data.vehicles[i].HoursRemaining
			var tmoney = parseInt(data.money)


			if(data.vehicles[i].officer) {
				var t = data.vehicles[i].officer.split(" ");
				officer = t[0].charAt(0) + '. ' + t[1];
			}

			var row = `<tr>
				<td id="plate">${data.vehicles[i].plate}</td>
				<td id="date">${releasedate.toString(undefined, { hour12: false })}</td>
				<td id="price">$ ${data.vehicles[i].fee}.00</td>
				<td id="officer">${officer}</td>`

			if(canrelease == "0") {
				button = `<td>
					<button class="btn info mr" id="info${i}">Info</button>
					<button class="btn pay success" id="pay${i}" disabled>Not due out</button>
				</td></tr>`
			}
			else if ( tmoney < data.vehicles[i].fee){
				button = `<td>
					<button class="btn info mr" id="info${i}">Info</button>
					<button class="btn pay success" id="pay${i}" disabled>Insufficent Cash</button>
				</td></tr>`
			
			} else {
				button = `<td>
					<button class="btn info mr" id="info${i}">Info</button>
					<button class="btn pay success" id="${i}">Pay</button>
				</td></tr>`
			}

			row = row + button;
			vehicleHtml = vehicleHtml + row;
		}

		$(rReason).text(rData.vehicles[0].reasont);
		if(rData.vehicles[0].hold_o) {
			$(holdBy).text(`This vehicle must be unlocked by an officer`);
		} else if (rData.vehicles[0].hold_m) {
			$(holdBy).text(`This vehicle must be unlocked by a mechanic`);
		} else {
			$(holdBy).text(``);
		}
		$('#impounded-vehicles').html(vehicleHtml);
	}

	function setupAdminTerminal (data) {
		var vehicleHtml = "";
		rData = data;

		for(var i = 0; i < data.vehicles.length; i++) {

			var officer = "";

			if(data.vehicles[i].officer) {
				var t = data.vehicles[i].officer.split(" ");
				officer = t[0].charAt(0) + '. ' + t[1];
			}

			var releasedate = new Date(data.vehicles[i].releasedate);

			var row = `<tr>
				<td id="plate">${data.vehicles[i].plate}</td>
				<td id="date">${releasedate.toLocaleDateString()} ${releasedate.toLocaleTimeString()}</td>
				<td id="price">$ ${data.vehicles[i].fee}.00</td>
				<td id="officer">${officer}</td>`;

			if((data.job.name == "police" && data.vehicles[i].hold_o) || (data.job.name == "mecano" && data.vehicles[i].hold_m)) {
				var button = `<td>
					<button class="btn info mr" id="info${i}">Info</button>
					<button class="btn unlock success" id="${i}">Unlock</button>
				</td></tr>`
				} else if (!data.vehicles[i].hold_o && !data.vehicles[i].hold_m && data.job.name == "police") {
				var button = `<td>
				<button class="btn info mr" id="info${i}">Info</button>
				<button class="btn release success" id="${i}">Release</button>	
				</td></tr>`	
			
			} else if (!data.vehicles[i].hold_o && !data.vehicles[i].hold_m) {
				var button = `<td>
				<button class="btn info mr" id="info${i}">Info</button>
				</td></tr>`
			} else {
				var button = `<td>
				<button class="btn info mr" id="info${i}">Info</button>
				<button class="btn unlock success" id="${i}" disabled>Unlock</button>
				</td></tr>`
			}

			$("admin-reason").text(rData.vehicles[0].reason);

			row = row + button;
			vehicleHtml = vehicleHtml + row;
		}

		$('#admin-reason').text(rData.vehicles[0].reason);
		$('#admin-impounded-vehicles').html(vehicleHtml);
	}

	$('table').on('click', '.pay', function () {
		var plate = $(this).parent().parent().find('#plate').text();
		$.post('http://esx_impound/unimpound', JSON.stringify(plate));
	});
	$('table').on('click', '.release', function () {
		var plate = $(this).parent().parent().find('#plate').text();
		$.post('http://esx_impound/unimpoundp', JSON.stringify(plate));
	});

	$('table').on('click', '.unlock', function () {
		var plate = $(this).parent().parent().find('#plate').text();
		$.post('http://esx_impound/unlock', JSON.stringify(plate));
	});

	$('table').on('click', '.info', function () {
		var index = $(this).attr('id');
		index = index.replace("info", "");
		$('#admin-reason').text(rData.vehicles[parseInt(index)].reasont);

		if(rData.vehicles[parseInt(index)].hold_o) {
			$(holdBy).text(`This vehicle must be unlocked by an officer`);
		} else if (rData.vehicles[parseInt(index)].hold_m) {
			$(holdBy).text(`This vehicle must be unlocked by a mechanic`);
		} else {
			$(holdBy).text(``);
		}
		$(rReason).text(rData.vehicles[parseInt(index)].reasont);

	});


	$('#cancel, #exit').click(function (event) {
		$.post('http://esx_impound/escape', null);
	});

	// Date + months edge case handling:
	Date.isLeapYear = function (year) {
		return (((year % 4 === 0) && (year % 100 !== 0)) || (year % 400 === 0));
	};

	Date.getDaysInMonth = function (year, month) {
		return [31, (Date.isLeapYear(year) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month];
	};

	Date.prototype.isLeapYear = function () {
		return Date.isLeapYear(this.getFullYear());
	};

	Date.prototype.getDaysInMonth = function () {
		return Date.getDaysInMonth(this.getFullYear(), this.getMonth());
	};

	Date.prototype.addMonths = function (value) {
		var n = this.getDate();
		this.setDate(1);
		this.setMonth(this.getMonth() + value);
		this.setDate(Math.min(n, this.getDaysInMonth()));
		return this;
	};

	String.prototype.replaceAt=function(index, replacement) {
		return this.substr(0, index) + replacement+ this.substr(index + replacement.length);
	}

	function DateStringToUTCDate(datestring) {
		console.log(datestring);
		datestring = datestring.replaceAt(10, "T");
		datestring = datestring.replaceAt(datestring.length + 1,"Z");
		console.log("DATESTRING");
		console.log(datestring);
		return new Date(datestring); 
	}
});
