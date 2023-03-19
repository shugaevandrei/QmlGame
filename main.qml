import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
//import Sprite 1.0
//import "../"

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("war game")
    property var enemyList: []
    property int score: 0
    signal shot(missile: var,x: var, y: var)
    onShot:(missile, x, y)=> {
               console.log("y x ", y, x)
        for (var i = 0; i < enemyList.length; i++) {

            //console.log("enemyList[i].y = ", enemyList[i].y)
            //console.log("enemyList[i].x = ", enemyList[i].x)
            //console.log("enemyList[i].x + w = ", enemyList[i].x + enemyList[i].width)

            if(y <= enemyList[i].y &&
               x >= enemyList[i].x &&
               x <= (enemyList[i].x + enemyList[i].width)){
                enemyList[i].destroy()
                missile.destroy()
                       score++
                //console.log("obj.y = ", enemyList.length)

                 //      console.log("missile = ", missile.x)
                //console.log("ВСЕ")
            }
                   if(enemyList[i].y <= 0)
                        enemyList[i].destroy()

        }
               if (y <= 0)
                    missile.destroy()

               console.log( enemyList.length)

    }


    Item {
        id: root
        anchors.fill: parent
        focus: true

        Component.onCompleted: {
            var obj = createSpriteObjects("qrc:/spriteEnemy.qml")
            enemyList.push(obj)
        }
        Timer{
            interval: 1000//Math.floor(Math.random() * 2500);
            running: true
            repeat: true
            //triggeredOnStart: true
            onTriggered: {
                var obj = createSpriteObjects("qrc:/spriteEnemy.qml")
                enemyList.push(obj)
            }
        }

        Image {
            id: background
            anchors.fill: parent
            source: "qrc:/background.jpeg"
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
                    createSpriteObjects("qrc:/spriteShot.qml",
                                        {
                                            root: root,
                                            x: person.x + person.width/2,
                                            y: person.y
                                        }
                                        )

                    event.accepted = true
                break
            }
        }
        Label{
            anchors.top: parent.top
            anchors.right: parent.right
            font.pixelSize: 14
            //font.family: fixedFont.name
            color: "deepskyblue"
            text: "score: " + score
        }

    }


function createSpriteObjects(obj, behavior = 0) {
    var component;
    var sprite;
        component = Qt.createComponent(obj);
        if (behavior)
            sprite = component.createObject(root, behavior);
        else
            sprite = component.createObject(root);

        if (sprite == null) {
            console.log("Error creating object");
        }
         return sprite
    }
}
