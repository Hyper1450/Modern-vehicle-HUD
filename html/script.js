window.addEventListener('message', function(event) {
    if (event.data.type === "updateHud") {
        const hud = document.getElementById("vehicle-hud");
        if (event.data.show) {
            document.body.style.justifyContent = event.data.pos.horizontal;
            document.body.style.alignItems = event.data.pos.vertical;
            hud.style.display = "block";
            document.getElementById("speed").textContent = event.data.speed;
            document.getElementById("unit").textContent = event.data.unit;
            document.getElementById("gear").textContent = event.data.gear;
            document.getElementById("fuel-fill").style.width = event.data.fuel + "%";
            document.getElementById("fuel-text").textContent = event.data.fuel + "%";
        } else {
            hud.style.display = "none";
        }
    }
});
