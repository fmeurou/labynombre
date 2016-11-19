import QtQuick 2.5
import QtQuick.Window 2.2

Window {
    id: mainWindow
    visible: true
    width: 800
    height: 600
    title: qsTr("LabyNombre")
    property int baseNumber: 60
    property int maxNumber: 60
    property int mistakes: 0
    Timer   {
        property int counter: 0
        id: gameTime
        repeat: true
        interval: 1000
        onTriggered:  {
            counter = counter + 1;
            gameBar.time = counter
        }
    }


    ControlBar  {
        id: controlBar
        minCell: 8
        maxCell: 16
        anchors {
            top: parent.top
            left: parent.left
        }
        width: parent.width
        height: 60
        onNewClicked: generateGrid()
    }
    GameBar  {
        id: gameBar
        anchors {
            top: controlBar.bottom
            left: parent.left
        }
        width: parent.width
        height: 60
        mistakes: mainWindow.mistakes
    }
    Rectangle   {
        anchors {
            top: gameBar.bottom
            left: parent.left
            bottom: parent.bottom
            right: parent.right
        }
        GridView    {
            id: nombreGrid
            width: Math.min(parent.height, parent.width) / Math.sqrt(2)
            height: Math.min(parent.height, parent.width) / Math.sqrt(2)
            anchors.centerIn: parent
            cellWidth: width / controlBar.cellCount
            cellHeight: height / controlBar.cellCount
            model: nombreModel
            rotation: 45
            delegate:   Nombre  {
                width: nombreGrid.cellWidth
                height: nombreGrid.cellHeight
                modelOp: operation
                modelValue: value
                base: baseNumber
                onMistaken: {
                    mainWindow.mistakes++
                }
            }
        }
    }


    ListModel    {
        id: nombreModel
    }

    function    generateGrid()  {
        // clear model
        mainWindow.mistakes = 0
        nombreModel.clear()
        baseNumber = Math.round(Math.random()*maxNumber)
        gameBar.numberToFind = baseNumber
        var numberGrid = initGrid(baseNumber)
        // first find a column to put the baseNumber on the first row
        var goodColumn = 0 //Math.floor(Math.random() * controlBar.cellCount)
        var currentRow = 0
        var currentCol = goodColumn
        numberGrid[0][currentCol] = {
            operation: makeOperation(maxNumber, baseNumber),
            value: baseNumber
        }
        console.log("start column", goodColumn, baseNumber)
        while(!((currentRow == controlBar.cellCount - 1) && (currentCol == controlBar.cellCount - 1)))    {
            var vertical = Math.round(Math.random()*10)
            var up = Math.round(Math.random())
            var left = Math.round(Math.random())
            if(vertical<5 && ((left && currentCol > 0) || (!left && currentCol < controlBar.cellCount - 1))) {
                if(left)    {
                    currentCol--;
                }   else    {
                    currentCol++;
                }
            }   else    {
                if(up && currentRow == controlBar.cellCount - 1)   {
                    currentRow--;
                } else {
                    if(currentRow < controlBar.cellCount - 1)  {
                        currentRow++;
                       }    else    {
                        continue;
                    }
                }
            }
            var obj = {
                operation: makeOperation(maxNumber, baseNumber),
                value: baseNumber
            }
            console.log(currentRow, currentCol, numberGrid[currentRow])
            numberGrid[currentRow][currentCol] = obj
        }
        // fill the remaining cells
        for(var i = 0; i < controlBar.cellCount; i++)   {
            for(var j = 0; j < controlBar.cellCount; j++)   {
                console.log("check value", numberGrid[i][j].value, baseNumber)
                if(numberGrid[i][j].value != baseNumber)  {
                    var otherNumber = Math.round(Math.random()*maxNumber)
                    if(otherNumber == baseNumber)   { // must be different from the base number
                        otherNumber = otherNumber + 1
                    }
                    numberGrid[i][j] = {
                        operation: makeOperation(maxNumber, otherNumber),
                        value: otherNumber
                    }
                }
                console.log(i, j, numberGrid[i][j].value)
                nombreModel.append(numberGrid[i][j])
            }
        }
        gameTime.counter=0
        gameTime.restart()

    }

    function canGoLeft(currentCol)    {
        if(currentCol > 0)  {
            return true
        }
        return false
    }

    function canGoRight(currentCol, maxWidth)    {
        if(currentCol < maxWidth - 1)  {
            return true
        }
        return false
    }

    function canGoDown(currentRow, maxHeight)    {
        if(currentRow< maxHeight - 1)  {
            return true
        }
        return false
    }

    function canGoUp(currentRow)    {
        if(currentRow > 0)  {
            return true
        }
        return false
    }




    function initGrid(base) {
        var grid = []
        for(var i = 0; i < base; i++)   {
            grid.push('')
            var row = []
            for(var j = 0; j < base; j++)   {
                row.push({operation: '', value:0})
            }
            grid[i] = row
        }
        return grid
    }

    function makeOperation(max, base)    {
        var addition = Math.round(Math.random())
        if(addition)    {
            var firstTerm = Math.round(Math.random()*max)
            var secondTerm = base - firstTerm
            return (firstTerm < 0 ? String(secondTerm)+String(firstTerm) : (secondTerm < 0 ? String(firstTerm)+String(secondTerm) : String(firstTerm) + "+" + String(secondTerm)))
        } else  {
            var firstTerm = Math.abs(Math.round(Math.random()*base) + 1)
            while(Math.round(base/firstTerm) != (base/firstTerm))  {
                firstTerm = Math.abs(Math.round(Math.random()*base) + 1)
            }
            var secondTerm = base/firstTerm
            return firstTerm + "x" + secondTerm

        }
    }
}

