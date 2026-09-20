import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io

Item {
  id: audioWidget

  property int volume: 0
  property bool muted: false
  property bool popupVisible: false
  property var bar

  implicitWidth: audioText.implicitWidth
  implicitHeight: 20

  function refresh() {
    volumeProcess.running = true
  }

  function setVolume(value) {
    var v = Math.max(0, Math.min(100, Math.round(value)))
    audioWidget.volume = v
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
          audioWidget.volume = Math.round(parseFloat(volMatch[1]) * 100)
        }
        audioWidget.muted = data.indexOf("MUTED") !== -1
      }
    }
  }

  Process {
    id: setVolumeProcess
    command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "0%"]
    onExited: audioWidget.refresh()
  }

  Process {
    id: toggleMuteProcess
    command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]
    onExited: audioWidget.refresh()
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: audioWidget.refresh()
  }

  Text {
    id: audioText
    anchors.centerIn: parent
    text: audioWidget.icon() + " " + audioWidget.volume + "%"
    color: root.mutedColor
    font.family: "JetBrainsMono Nerd Font"
    font.pixelSize: 12
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    onClicked: mouse => {
      if (mouse.button === Qt.RightButton) {
        toggleMuteProcess.running = true
      } else {
        audioWidget.popupVisible = !audioWidget.popupVisible
        if (audioWidget.popupVisible) audioWidget.refresh()
      }
    }
  }

  PopupWindow {
  id: popup
  visible: audioWidget.popupVisible
  anchor.window: audioWidget.bar
  anchor.rect.x: audioWidget.bar ? audioWidget.bar.width - implicitWidth - 120 : 0
  anchor.rect.y: audioWidget.bar ? audioWidget.bar.height + 6 : 0

  implicitWidth: 240
  implicitHeight: 42
  color: "transparent"
  grabFocus: true

  // Outer shadow layer
  Rectangle {
    anchors.fill: card
    anchors.margins: -8
    radius: card.radius + 8
    color: "#10000000" // very subtle shadow
    z: -1
  }

  // Main card
  Rectangle {
    id: card
    anchors.fill: parent
    radius: 14
    color: root.surface
    border.width: 1
    border.color: root.border

    Column {
      anchors.fill: parent
      anchors.margins: 12
      spacing: 10


      // Slider
      Slider {
        id: slider
        width: parent.width
        from: 0
        to: 100
        value: audioWidget.volume

        onPressedChanged: {
          if (!slider.pressed) {
            audioWidget.setVolume(value)
          }
        }

        // Handle
        handle: Rectangle {
          implicitWidth: 18
          implicitHeight: 18
          x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - implicitWidth)
          y: slider.topPadding + slider.availableHeight / 2 - implicitHeight / 2
          radius: 9

          color: root.active
          border.width: 2
          border.color: root.surface

          Rectangle {
            anchors.fill: parent
            anchors.margins: 5
            radius: 5
            color: Qt.lighter(root.active, 1.15)
            opacity: 0.4
          }
        }

        // Track
        background: Rectangle {
          x: slider.leftPadding
          y: slider.topPadding + slider.availableHeight / 2 - height / 2
          implicitWidth: 160
          implicitHeight: 6
          width: slider.availableWidth
          radius: 3

          color: root.surfaceBright
          border.width: 1
          border.color: root.border

          // Filled portion
          Rectangle {
            width: slider.visualPosition * parent.width
            height: parent.height
            radius: 3
            color: root.active
          }

          // Empty portion overlay
          Rectangle {
            anchors.fill: parent
            anchors.leftMargin: slider.visualPosition * parent.width
            radius: 3
            color: root.activeDim
            opacity: 0.25
          }
        }
      }
    }
  }
}

  Component.onCompleted: audioWidget.refresh()
}
