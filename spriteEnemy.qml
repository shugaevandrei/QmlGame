import QtQuick 2.0
Image {
    id: goal
    width: 50
    height: 50
    x: Math.floor(Math.random() * root.width) - goal.width;
    y: Math.floor(Math.random() * root.height) - goal.height;
    rotation: 180
    source: "qrc:/enemy.png"

    NumberAnimation on y {
        to: root.height
        duration: Math.floor(Math.random() * 6000);
    }
}
