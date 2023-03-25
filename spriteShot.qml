import QtQuick 2.0

Image {
    source: "qrc:/shot.png"
    width: 50
    height: 25
    visible: true
    rotation: 260
    onYChanged: {
        if(y <= 0) destroy()
        shot(this, x,y)
    }
    NumberAnimation on y {
        id: p
        to: 0
        duration: 400
    }
}
