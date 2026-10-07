import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

Rectangle {
  id: clockIsland

  anchors {
    horizontalCenter: parent.horizontalCenter
    verticalCenter: parent.verticalCenter
  }

  width: clockText2.implicitWidth + px(16)
  height: px(22)
  radius: height / 2

  color: Qt.rgba(
    root.background.r,
    root.background.g,
    root.background.b,
    0.58
  )
  border.width: 1
  border.color: Qt.rgba(
    root.surface.r,
    root.surface.g,
    root.surface.b,
    0.75
  )

  Text {
    id: clockText2
    anchors.centerIn: parent

    color: root.text
    font.family: "JetBrainsMono Nerd Font"
    font.pixelSize: px(12)

    text: Qt.formatDateTime(
      clock.date,
      "ddd  MM-dd  HH:mm"
    )
  }

  MouseArea {
    anchors.fill: parent

    onClicked: root.exec(
      `${root.terminal} -e calcurse`
    )
  }
}
