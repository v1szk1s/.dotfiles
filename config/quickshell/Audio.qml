import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io

Item {
  id: root

  property int volume: 0
  property bool muted: false
  property bool popupVisible: false
  property var bar
  property color surface: "#ffffff"  // default; override from parent if needed

  implicitWidth: audioText.implicitWidth
  implicitHeight: 20

  function refresh() {
    volumeProcess.running = true
  }

  function setVolume(value) {
    var v = Math.max(0, Math.min(100, Math.round(value)))
    root.volume = v
    setVolumeProcess.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", v + "%"]
    setVolumeProcess.running = true
  }

  function icon() {
    if (muted || volume === 0) return "󰝟"
    if (volume < 35) return "󰕿"
    if (volume < 70) return "󰖀"
    return "󰕾"
  }

  // Single process to fetch volume & mute state
  Process {
    id: volumeProcess
    command: ["sh", "-lc", "wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null"]
    stdout: SplitParser {
      onRead: data => {
        // Example: "Default Audio Sink Volume: 0.45 [MUTED]"
        var volMatch = data.match(/Volume:\s*([0-9.]+)/)
        if (volMatch) {
          root.volume = Math.round(parseFloat(volMatch[1]) * 100)
        }
        root.muted = data.indexOf("MUTED") !== -1
      }
    }
  }

  Process {
    id: setVolumeProcess
    command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "0%"]
    onExited: root.refresh()
  }

  Process {
    id: toggleMuteProcess
    command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]
    onExited: root.refresh()
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: root.refresh()
  }

  Text {
    id: audioText
    anchors.centerIn: parent
    text: root.icon() + " " + root.volume + "%"
    color: root.surface
    font.family: "JetBrainsMono Nerd Font"
    font.pixelSize: 12
  }

  MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    onClicked: mouse => {
      if (mouse.button === Qt.RightButton) {
        toggleMuteProcess.running = true
      } else {
        root.popupVisible = !root.popupVisible
        if (root.popupVisible) root.refresh()
      }
    }
  }

  PopupWindow {
    id: popup
    visible: root.popupVisible
    anchor.window: root.bar
    anchor.rect.x: root.bar ? root.bar.width - implicitWidth - 120 : 0
    anchor.rect.y: root.bar ? root.bar.height + 6 : 0

    implicitWidth: 220
    implicitHeight: 76
    color: "transparent"
    grabFocus: true

    Rectangle {
      anchors.fill: parent
      radius: 10
      color: root.surface
      border.width: 1
      border.color: root.surface

      Column {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8

        Row {
          width: parent.width
          spacing: 4

          Text {
            id: label
            text: root.muted ? "Muted" : "Volume"
            color: root.surface
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 12
          }

          Item {
            id: spacer
            width: parent.width - label.implicitWidth - volLabel.implicitWidth - parent.spacing
            height: 1
          }

          Text {
            id: volLabel
            text: root.volume + "%"
            color: root.surface
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 12
          }
        }

        Slider {
          id: slider
          width: parent.width
          from: 0
          to: 100
          value: root.volume

          onPressedChanged: {
            if (!slider.pressed) {
              root.setVolume(value)
            }
          }
        }
      }
    }
  }

  Component.onCompleted: root.refresh()
}
