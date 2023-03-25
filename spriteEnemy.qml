import QtQuick 2.0
Image {
    id: enemy
    width: 50
    height: 50
    x: Math.floor(Math.random() * (parent.width - enemy.width*2) + enemy.width)
    y: 0
    rotation: 180
    source: "qrc:/" + Math.floor(Math.random() * 3) +".png"

    NumberAnimation on y {
        to: parent.height
        duration: Math.floor(Math.random() * (6000 - 2000 + 1) + 2000)
    }
    onYChanged: {
        if(y >= parent.height){
            parent.lives--
            destroy()
        }
    }
}
