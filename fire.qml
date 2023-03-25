import QtQuick 2.0

Image {
    id: fire
    width: 10
    height: 10
    source: "qrc:/bomb.png"

    ParallelAnimation {
        running: true
        NumberAnimation { target: fire; property: "width"; to: 70; duration: 300 }
        NumberAnimation { target: fire; property: "height"; to: 70; duration: 300 }
        onStopped: {
            fire.destroy()
        }
    }
}
