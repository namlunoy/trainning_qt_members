function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function getColor() {
    return '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6);
}

function getRandomColor() {
    var color = getColor();

    while (isColorBlack(color)) {
        color = getColor();
    }

    return color;
}

var component;
var sprite;

function createComponent(shapePath) {
    var sprite;

    component = Qt.createComponent(shapePath);

    if (component.status === Component.Ready) {
        sprite = component.createObject(grid, {color: shape.shapeColor, insideText: shape.text});

        if (sprite === null) {
            console.log("Error: creating object failed!");
        }
    }
    else if (component.status === Component.Error) {
        console.log("Error: loading component failed!");
    }
}

function generate() {
    shape.text = getRandomInt(0, 100).toString();
    shape.shapeColor = getRandomColor();
    comboBox.currentIndex = getRandomInt(0, 2);
}

function isColorBlack(color) {
    color = color.substring(1);      // strip #
    var rgb = parseInt(color, 16);   // convert rrggbb to decimal
    var r = (rgb >> 16) & 0xff;  // extract red
    var g = (rgb >>  8) & 0xff;  // extract green
    var b = (rgb >>  0) & 0xff;  // extract blue

    var luma = 0.2126 * r + 0.7152 * g + 0.0722 * b; // per ITU-R BT.709

    if (luma < 40) {
        return true;
    }
    else {
        return false;
    }
}

function bottomView() {
    if (flick.contentHeight > 400) {
        flick.contentY = flick.contentHeight - 400;
    }
}
