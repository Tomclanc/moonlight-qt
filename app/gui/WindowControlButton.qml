import QtQuick
import QtQuick.Controls

import "theme"

AbstractButton {
    id: control

    property string controlType
    property string accessibleName
    readonly property bool destructive: controlType === "close"
    property color highlightColor: destructive ? Theme.danger : Theme.surface2
    property color pressedColor: destructive
                                 ? Qt.darker(Theme.danger, 1.14)
                                 : Theme.accentSoft

    width: 44
    height: 56
    focusPolicy: Qt.NoFocus
    hoverEnabled: true

    Accessible.name: accessibleName
    Accessible.role: Accessible.Button

    // Material's shared attached tooltip forces Material.Dark. Use a local
    // instance so the background and text can follow Moonlight's chosen theme.
    ToolTip {
        id: windowControlTip
        parent: control
        visible: control.hovered
        text: control.accessibleName
        delay: 700
        timeout: 2500
        x: (control.width - width) / 2
        y: control.height - Theme.spaceXs
        margins: Theme.spaceSm
        padding: Theme.spaceSm
        opacity: 1.0
        font.family: Theme.fontSans
        font.pointSize: Theme.fontBody

        background: Rectangle {
            radius: Theme.radiusControl
            color: Theme.isLight ? Theme.surface : Theme.surface2
            border.width: 1
            border.color: Theme.lineStrong
        }

        contentItem: Text {
            text: windowControlTip.text
            color: Theme.text
            font: windowControlTip.font
            verticalAlignment: Text.AlignVCenter
        }
    }

    background: Rectangle {
        color: control.down ? control.pressedColor
                            : (control.hovered ? control.highlightColor : "transparent")

        Rectangle {
            anchors.left: parent.left
            width: 1
            height: parent.height
            color: control.hovered
                   ? (control.destructive ? Theme.danger : Theme.lineStrong)
                   : Theme.line
        }

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: control.hovered ? 3 : 0
            color: control.destructive ? Theme.danger : Theme.accent
        }

        Behavior on color {
            ColorAnimation { duration: Theme.durFast }
        }
    }

    contentItem: Item {
        readonly property color strokeColor:
            (control.hovered || control.down)
            ? (control.destructive ? Theme.ink : Theme.text)
            : Theme.textDim

        Rectangle {
            visible: control.controlType === "minimize"
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 4
            width: 13
            height: 2
            color: parent.strokeColor
        }

        Rectangle {
            visible: control.controlType === "maximize"
            anchors.centerIn: parent
            width: 12
            height: 10
            color: "transparent"
            border.width: 2
            border.color: parent.strokeColor
        }

        Item {
            visible: control.controlType === "restore"
            anchors.centerIn: parent
            width: 15
            height: 13

            Rectangle {
                x: 4
                y: 0
                width: 11
                height: 9
                color: control.hovered ? control.highlightColor : Theme.ink
                border.width: 2
                border.color: parent.parent.strokeColor
            }

            Rectangle {
                x: 0
                y: 4
                width: 11
                height: 9
                color: control.hovered ? control.highlightColor : Theme.ink
                border.width: 2
                border.color: parent.parent.strokeColor
            }
        }

        Item {
            visible: control.controlType === "close"
            anchors.centerIn: parent
            width: 14
            height: 14

            Rectangle {
                anchors.centerIn: parent
                width: 17
                height: 2
                rotation: 45
                color: parent.parent.strokeColor
                antialiasing: true
            }

            Rectangle {
                anchors.centerIn: parent
                width: 17
                height: 2
                rotation: -45
                color: parent.parent.strokeColor
                antialiasing: true
            }
        }
    }
}
