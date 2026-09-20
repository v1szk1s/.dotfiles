import QtQuick
import Quickshell
import Quickshell.Io


Item {

  id: bluetoothWidget

  property bool bluetoothEnabled: false
  property int bluetoothConnected: 0

  width: bluetoothText.implicitWidth
  height: px(20)

  Text {
    id: bluetoothText
    anchors.centerIn: parent

    text: bluetoothWidget.bluetoothEnabled
    ? `󰂯${
      bluetoothWidget.bluetoothConnected > 0
      ? " " + bluetoothWidget.bluetoothConnected
      : ""
    }`
    : "󰂲"

    color: bluetoothWidget.bluetoothEnabled ? root.text : root.mutedColor
    font.family: "JetBrainsMono Nerd Font"
    font.pixelSize: px(12)
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor

    acceptedButtons: Qt.LeftButton | Qt.RightButton

    onClicked: mouse => {

      if (mouse.button === Qt.RightButton) {
        const command =
        "bluetoothctl power "
        + (bluetoothWidget.bluetoothEnabled ? "off" : "on")

        root.exec(command)

        refreshTimer.restart()
      } else {
        root.exec(`${root.terminal} -e ${root.bluetoothTui}`)
      }
    }
  }

  Process {
    id: bluetoothProcess

    command: [
      "sh", "-c",
      "powered=$(bluetoothctl show 2>/dev/null | " +
      "awk -F': ' '/Powered:/ { print $2; exit }'); " +
      "connected=$(bluetoothctl devices Connected 2>/dev/null | wc -l); " +
      "printf '%s:%s\\n' \"${powered:-no}\" \"${connected:-0}\""
    ]

    running: true

    stdout: SplitParser {
      onRead: data => {
        const fields = data.trim().split(":")

        if (fields.length < 2)
        return

        bluetoothWidget.bluetoothEnabled =
        fields[0] === "yes"

        bluetoothWidget.bluetoothConnected =
        parseInt(fields[1], 10) || 0
      }
    }
  }

  Timer {
    id: refreshTimer
    interval: 300
    repeat: false

    onTriggered: {
      bluetoothProcess.running = false
      bluetoothProcess.running = true
    }
  }

}
