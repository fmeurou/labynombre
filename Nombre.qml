import QtQuick 2.0

Item {
    id: nombre
    property string modelOp: ""
    property int modelValue: 0
    property int base: 0
    signal mistaken()
    Rectangle   {
        id: currentCell
        color: '#999999'
        border  {
            color: '#333333'
        }
        anchors.fill: parent
        Text    {
            anchors.centerIn: parent
            text: modelOp
            rotation: -45
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(modelValue == base) {
                    currentCell.color = "#123456"
                }   else    {
                    currentCell.color = "#654321"
                    mistaken()
                }
            }
        }
    }
}
