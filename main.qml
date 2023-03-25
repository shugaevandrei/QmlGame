import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import "scripts.js" as Scripts

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("war game")
    property var enemyList: []
    property int score: 0
    signal shot(missile: var,x: var, y: var)
    onShot:(missile, x, y)=> {
        for (var i = 0; i < enemyList.length; i++) {
            if(y <= (enemyList[i].y + enemyList[i].height/2)&&
               y >= (enemyList[i].y - enemyList[i].height/2) &&
               x >= (enemyList[i].x - enemyList[i].width/2) &&
               x <= (enemyList[i].x + enemyList[i].width/2)) {
                Scripts.createSpriteObjects("qrc:/fire.qml", window, {x: enemyList[i].x, y: enemyList[i].y})
                enemyList[i].destroy()
                enemyList.splice(i, 1)
                missile.destroy()
                score++
            }
        }
    }
    Component {
        id: start
        Image {
            id: startScene
            source: "qrc:/background.jpeg"
            anchors.fill: parent
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/newgame.png"
                MouseArea {
                    anchors.fill:parent
                    onClicked: {
                        loader.sourceComponent=scene
                    }
                }
            }
        }
    }

    Loader {
        anchors.fill: parent
        focus: true
        sourceComponent: start
        id: loader
    }

    Component {
        id: scene

        Item {
            id: root
            anchors.fill: parent
            focus: true
            property int lives: 10

            Component.onCompleted: {
                var obj = Scripts.createSpriteObjects("qrc:/spriteEnemy.qml", root)
                enemyList.push(obj)
            }
            onLivesChanged: {
                 if (root.lives == 0) {
                     gameover.visible = true
                    person.destroy()
                 }
            }

            Timer{
                interval: Math.floor(Math.random() * (3000 - 500) + 500)
                running: true
                repeat: true
                triggeredOnStart: true
                onTriggered: {
                    var obj = Scripts.createSpriteObjects("qrc:/spriteEnemy.qml", root)
                    enemyList.push(obj)
                }
            }

            Image {
                id: background
                anchors.fill: parent
                source: "qrc:/background.jpeg"
            }

            Image {
                id: gameover
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width/3
                height: parent.height/3
                visible: false
                source: "qrc:/gameover.png"
                MouseArea {
                    anchors.fill:parent
                    onClicked: {
                        parent.visible = false
                        score = 0
                        loader.sourceComponent=start
                    }
                }
            }

            Image {
                id: person
                width: 50
                height: 50
                x: root.width/2
                y: root.height - height
                source: "qrc:/person.png"
                fillMode: Image.PreserveAspectCrop

                Behavior on x {
                    NumberAnimation {
                        duration: 5
                         easing {type: Easing.Linear}
                    }
                }
                Behavior on y {
                    NumberAnimation {
                        duration: 5
                         easing {type: Easing.Linear}
                    }
                }
            }

            Keys.onPressed: (event)=> {
                switch(event.key){
                    case Qt.Key_Right:
                        event.accepted = true
                        person.x = person.x +10
                    break
                    case Qt.Key_Left:
                        event.accepted = true
                        person.x = person.x -10
                        event.accepted = true
                    break
                    case Qt.Key_Up:
                        event.accepted = true
                        person.y = person.y -10
                        event.accepted = true
                    break
                    case Qt.Key_Down:
                        event.accepted = true
                        person.y = person.y +10
                        event.accepted = true
                    break
                    case Qt.Key_Space:
                        Scripts.createSpriteObjects("qrc:/spriteShot.qml", root, {x: person.x, y: person.y})
                        event.accepted = true
                    break
                }
            }

            Label{
                id: s
                anchors.top: parent.top
                anchors.right: parent.right
                font.pixelSize: 14
                color: "deepskyblue"
                text: "score: " + score
            }
            Label{
                anchors.top: s.bottom
                anchors.right: parent.right
                font.pixelSize: 14
                color: "tomato"
                text: "lives: " + lives
            }
        }
    }
}
