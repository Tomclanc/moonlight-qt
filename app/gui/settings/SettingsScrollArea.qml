import QtQuick 2.9
import QtQuick.Controls
import QtQuick.Window 2.2
import "../theme"

// 内容滚动区。搬运了旧 SettingsView 的焦点自动滚动逻辑，
// 手柄按 Tab 走到屏幕外的控件时把它滚进视野。
Flickable {
    id: area

    default property alias areaContent: contentHolder.data

    boundsBehavior: Flickable.OvershootBounds
    contentWidth: width
    contentHeight: contentHolder.childrenRect.height + Theme.spaceXl
    clip: true

    ScrollBar.vertical: ScrollBar {
        id: verticalBar

        policy: area.contentHeight > area.height ? ScrollBar.AsNeeded : ScrollBar.AlwaysOff
        width: 12
        padding: 2

        // 细圆角轨道，保留足够的鼠标命中宽度。
        background: Rectangle {
            implicitWidth: 12
            radius: width / 2
            color: verticalBar.hovered || verticalBar.pressed
                   ? Theme.surface2Layer : Qt.rgba(Theme.surface2.r,
                                                   Theme.surface2.g,
                                                   Theme.surface2.b, 0.45)
            border.width: 1
            border.color: Theme.line

            Behavior on color {
                ColorAnimation { duration: Theme.durFast }
            }
        }

        // 滑块始终是胶囊形，拖动和悬停时提高对比度。
        contentItem: Rectangle {
            implicitWidth: 8
            implicitHeight: 48
            radius: width / 2
            color: verticalBar.pressed ? Theme.accentDim
                                       : (verticalBar.hovered ? Theme.lineStrong
                                                              : Theme.textFaint)
            opacity: verticalBar.active || verticalBar.hovered ? 0.9 : 0.65

            Behavior on color {
                ColorAnimation { duration: Theme.durFast }
            }
            Behavior on opacity {
                NumberAnimation { duration: Theme.durFast }
            }
        }
    }

    Item {
        id: contentHolder
        width: area.width
        height: childrenRect.height
    }

    NumberAnimation on contentY {
        id: autoScrollAnimation
        duration: 100
    }

    function isChildOfFlickable(item) {
        while (item) {
            if (item.parent === contentItem) {
                return true
            }

            item = item.parent
        }
        return false
    }

    // 供页面内的快捷入口直接定位到内容末尾。目标位置由滚动区统一计算，
    // 页面组件不需要知道外层 Flickable 的可滚动范围。
    function scrollToEnd() {
        autoScrollAnimation.stop()
        autoScrollAnimation.from = contentY
        autoScrollAnimation.to = Math.max(0, contentHeight - height)
        autoScrollAnimation.start()
    }

    Window.onActiveFocusItemChanged: {
        var item = Window.activeFocusItem
        if (!item || !isChildOfFlickable(item)) {
            return
        }

        var pos = item.mapToItem(contentItem, 0, 0)
        var scrollMargin = height > 100 ? 50 : 0

        if (pos.y - scrollMargin < contentY) {
            autoScrollAnimation.from = contentY
            autoScrollAnimation.to = Math.max(pos.y - scrollMargin, 0)
            autoScrollAnimation.start()
        }
        else if (pos.y + item.height + scrollMargin > contentY + height) {
            autoScrollAnimation.from = contentY
            autoScrollAnimation.to = Math.min(pos.y + item.height + scrollMargin - height,
                                              Math.max(0, contentHeight - height))
            autoScrollAnimation.start()
        }
    }
}
