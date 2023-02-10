var Debug = false;
var timeleft = 0;
var totaltime = 0;

window.addEventListener('message', (event) => {
    if (event.data.newStreet) {
        if (timeleft === 0) {
            $("#street").text(event.data.newStreet);
            $(".streetNotifier").css("top", "1%");
            timeleft = totaltime; countDown();
        } else {
            timeleft = totaltime;
            $("#street").text(event.data.newStreet);
        }
    } else if (event.data.Configs){
        Debug = event.data.Configs.Debug;
        $("#emoji").text(event.data.Configs.emoji);
        $("#text").text(event.data.Configs.streetTranslate);
        totaltime = event.data.Configs.TimeToShow;
    }
});

function countDown() {
    setTimeout(function () {
        if (timeleft > 0) {
            timeleft = timeleft - 1;
            if (timeleft > 0) {
                countDown();
            } else {$(".streetNotifier").css("top", "-5%");}
        }
    }, 1000);
}

function dprint(text) {if (Debug) {console.log(text);}}