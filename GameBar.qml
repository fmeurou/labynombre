import QtQuick 2.0

Item {
    id: gameBar
    property int numberToFind: 0
    property int time: 0
    property int mistakes: 0
    Rectangle   {
        anchors.fill: parent
        Text    {
            id: numberText
            anchors {
                left: parent.left
                top: parent.top
            }
            font    {
                pointSize: 20
            }
            width: parent.width / 3
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            height: parent.height
            text: qsTr("find number ") + gameBar.numberToFind
        }
        Text    {
            id: timeText
            anchors {
                left: numberText.right
                top: parent.top
            }
            font    {
                pointSize: 20
            }
            width: parent.width / 3
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: time + 's'

        }
        Text    {
            id: mistakeText
            anchors {
                left: timeText.right
                top: parent.top
            }
            font    {
                pointSize: 20
            }
            width: parent.width / 3
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            height: parent.height
            text: qsTr("mistakes ") + mistakes
        }


    }
}
