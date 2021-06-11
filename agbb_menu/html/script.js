$(function () {

    var wheelSize = document.getElementById("wheelSize");
    var wheelOpacity = document.getElementById("wheelOpacity")

    wheelSize.addEventListener('input', function () {
        $('#wheelDiv').css({'width': this.value, 'height': this.value})
        $('#bg').css({ 'width': this.value, 'height': this.value })
    });

    wheelOpacity.addEventListener('input', function () {
        opac = this.value / 100
        $('#wheelDiv').css('opacity', opac)
        $('#bg').css('opacity', opac)
    });

    console.log('Wheels created')
    window.addEventListener('message', function (event) {
        if (event.data.type == 'show') {
            $('#container').css("opacity", "1")
            $.ajax({ async: false, type: 'GET', dataType: 'json', url: 'config.json', success: function (json) { allJobs = Object.keys(json) } })
            primWheel = newWheel('primary', 0, 0.2, 270);
			
			if (event.data.c != 1) {
				if (allJobs.includes(event.data.j)) {
					job = newWheel(event.data.j, 0.275, 0.5, 0, primWheel);
				} else {
					job = newWheel('unemployed', 0.275, 0.5, 0, primWheel);
				};
			}
            if (event.data.c === 1) {
                props = newWheel('vehicle', 0.55, 0.75, 0, primWheel);

            } else {
                props = newWheel('props', 0.55, 0.75, 0, primWheel);
            }
			if (event.data.c != 1) {
            emotes = newWheel('emotes', 0.8, 1, 0, primWheel);
			}
        }
        else if (event.data.type == 'hide') {
            $('#container').css("opacity", "0")
            $('#itemname').css("display", "none")
            primWheel.removeWheel()
        }
    });

    function newWheel(c, mn, mx, na, s = false) {
        $.ajax({ async: false, type: 'GET', dataType: 'json', url: 'config.json', success: function (json) { conf = json[c] } })
        if (s === false) {
            wheel = new wheelnav('wheelDiv', null);
        }
        else {
            wheel = new wheelnav('wheelDiv', s.raphael);
        };
        var labels = Object.keys(conf['items']);
        var commands = Object.values(conf['items']);
        wheel.navAngle = na;
        wheel.clickModeRotate = false;
        wheel.selectedNavItemIndex = null;
        wheel.slicePathFunction = slicePath().DonutSlice;
        wheel.slicePathCustom = slicePath().DonutSliceCustomization();
        wheel.slicePathCustom.minRadiusPercent = mn;
        wheel.slicePathCustom.maxRadiusPercent = mx;
        wheel.animatetime = 0;

        wheel.colors = conf['colors']
        wheel.createWheel(labels);
        for (var j = 0; j < wheel.navItems.length; j++) {
            // Clear selected
            wheel.navItems[j].selected = false;
            // Add events for both navSlice and navTitle
            const execCmd = commands[j]
            wheel.navItems[j].navSlice.mouseover(function () {
                $('#itemname').css("display", "block")
                $('#itemname').text(execCmd)
            });
            wheel.navItems[j].navSlice.mousedown(function () {
                $.post('http://AGBB_menu/sliceclicked', JSON.stringify({ command: execCmd }));
                $('#itemname').css("display", "none")
            });
            wheel.navItems[j].navTitle.mousedown(function () {
                $.post('http://AGBB_menu/sliceclicked', JSON.stringify({ command: execCmd }));
                $('#itemname').css("display", "none")
            });
        }
        return wheel;
    }
});