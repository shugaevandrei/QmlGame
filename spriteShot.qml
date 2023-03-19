import QtQuick 2.0

Rectangle {
    property var root
    property var test

    width: 10
    height: 10
    visible: true
    color: "red"
    border.color: "black"
    radius: 10
    onYChanged: {
        shot(this, x,y)
//        enemyList.forEach(function(obj) {
//            if(y <= obj.y && x == obj.x)
//                obj.destroy()

//            console.log(obj.width);
//        });
//        console.log( enemyList.length)
//        if(y == 0)
//            this.destroy()

        //console.log("push.y ",push.y, "goal.y", goal.y)
//        if (push.y <= goal.y &&  push.y > 0) {
            //yyyy(10)
//            console.log("SHOT!")
//            goal.visible = false
//            push.visible =false
//            createSpriteObjects("qrc:/spriteEnemy.qml",
//                                {
//                                x: Math.floor(Math.random() * root.width) - goal.width,
//                                y: Math.floor(Math.random() * root.height) - goal.height
//                                })
//        }
    }


    NumberAnimation on y {
        id: p
        to: 0
        duration: 400
    }
}
