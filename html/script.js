
function convertPosition(pos) {
    const map = {
        left: 'flex-start',
        center: 'center',
        right: 'flex-end',
        top: 'flex-start',
        middle: 'center',
        bottom: 'flex-end'
    };

    pos = pos || { horizontal: 'center', vertical: 'bottom' };

    return {
        horizontal: map[pos.horizontal] || 'center',
        vertical: map[pos.vertical] || 'flex-end'
    };
}
window.addEventListener('message', function(event) {
    if (event.data.type === "updateHud") {
        const hud = document.getElementById("vehicle-hud");
        if (event.data.show) {
            const pos = event.data.pos || { horizontal: 'center', vertical: 'bottom' };
            document.body.style.justifyContent = pos.horizontal;
            document.body.style.alignItems = pos.vertical;
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
