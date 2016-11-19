import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: controlBar
    property int minCell: 8
    property int maxCell: 16
    property int cellCount: Math.floor(widthSlider.value)
    signal newClicked()
    Rectangle   {
        anchors.fill: parent
        color: '#ffffff'

        Slider  {
            id: widthSlider
            anchors {
                top: parent.top
                left: parent.left
            }
            width: parent.width * 0.6
            height: parent.height
            from: minCell
            to: maxCell
            stepSize: 1
            snapMode: Slider.SnapOnRelease
        }
        Text    {
            id: widthValue
            anchors {
                top: parent.top
                left: widthSlider.right
            }
            width: parent.width * 0.2
            height: parent.height
            text: Math.floor(widthSlider.value) * Math.floor(widthSlider.value) + " " + qsTr("cases")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Button  {
            anchors {
                top: parent.top
                left: widthValue.right
            }
            width: parent.width * 0.2
            height: parent.height
            text: qsTr("new")
            onClicked: newClicked()
        }
    }
}
