
window.addEventListener('message', function(event) {

    let wallet = event.data.wallet;
    let blackMoney = event.data.black_money;
    let bank = event.data.bank;
    let society = event.data.society;
    let control = event.data.control;
    
    $('#wallet').text(wallet)
    $('#blackMoney').text(blackMoney)
    $('#bank').text(bank)
    if (society != null) {
        $('#societyDiv').css('display','flex')
        $('#society').text(society)
    }


    let display = false;

    if (event.data.control === 'k' && display === false) {

        display = true;
        $('#wrapperHUD').css('opacity', '1')
        window.setTimeout(function() {
            display = false; 
            $('#wrapperHUD').css('opacity', '0')
        }, 5000)
    }
});