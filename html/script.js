// DreamBox Development | https://discord.gg/dYUyXcFVwQ

var SpawnLocation = null
var value = null

$(document).ready(function() {
    window.addEventListener('message', function(event) {
        var data = event.data;
        if (data.show == true) {
            event.preventDefault();
            $(".spawn-container").fadeIn(400)
        } else if (data.show == false) {
            event.preventDefault();
            $(".spawn-container").fadeOut(400)
        } else if (data.setup == true) {
            AppendTypes(data.locations)
        }
    })
})

$(document).on('click', '#Name', function(evt){
    evt.preventDefault();
    value = $(this).text();
    value = (value.split(" ")[1]).toLowerCase()
    if (SpawnLocation !== null) {$(SpawnLocation).css("backgroundColor", "#424242")};
    $(this).css("backgroundColor", "#17ac6e");
    $.post("https://db-spawn/Preview", JSON.stringify({location: value}));
    $("#Spawn").fadeIn(400)
    SpawnLocation = $(this)
});

$(document).on('click', '#Spawn', function(evt){
    if (SpawnLocation !== null) {
        $(".spawn-container").fadeOut(500, function () {
            $.post("https://db-spawn/Spawn", JSON.stringify({spawn: value}));
            $("#Spawn").fadeOut(400)
        });
    };
});

function AppendTypes(locations) {
    var parent = $('.spawn-list-container')
    $(parent).html("");    
    $.each(locations, function(index, location){
        $(parent).append('<div class="spawn-card"><div id="Name"><i class="'+location.icon+'"></i> '+location.label+'</div></div>')
    });
    $(parent).append('<div id="Spawn" class="spawner-card">Spawn Now!</div>');
}