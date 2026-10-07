import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.SystemTray

ShellRoot {
  id: root

  // ----- Tweak these -----------------------------------------------------
  property int workspaceCount: 9
  property bool smwAvailable: true
  property string terminal: "foot"
  property string networkTui: "nmtui"
  property string bluetoothTui: "bluetui"
  property string mixer: "pavucontrol"

  // Root
  property color background:   "#11111b"  // base
  property color surface:      "#1e1e2e"  // surface / elevated bg (slightly lighter than background)
  property color surfaceBright:"#313244"  // bright surface / input bg

  property color active:       "#89b4fa"  // primary accent (blue)
  property color activeDim:    "#5876a8"  // dimmed version of active for tracks/borders
  property color text:         "#cdd6f4"  // main text
  property color mutedColor:   "#9399b2"  // secondary text / subtle UI
  property color border:       "#45475a"  // generic border / divider

  property color warning:      "#f9e2af"  // yellow
  property color critical:     "#f38ba8"  // red

  property string batteryPercent: ""
  property string batteryState: ""
  property string keyboardLayout: ""


  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar

      required property var modelData
      screen: modelData
      // 4K laptop panels usually report a larger device pixel ratio.
      // 1.0 on ordinary displays; at least 1.25 on high-DPI panels.
      readonly property real displayScale: Math.max(
        1.0,
        Math.min(1.25, screen.devicePixelRatio)
      )

      function px(value) {
        return Math.round(value * displayScale)
      }

      anchors {
        top: true
        left: true
        right: true
      }

      // The actual panel is transparent. Widgets float in compact islands.
      implicitHeight: px(28)
      exclusiveZone: px(25)
      color: "transparent"
      exclusionMode: ExclusionMode.Normal

      Workspace {
        id: workspaceIsland
      }

      Clock {
        id: clockIsland
      }

      // Status island -------------------------------------------------------
      Rectangle {
        id: statusIsland

        anchors.right: parent.right
        anchors.rightMargin: px(8)
        anchors.verticalCenter: parent.verticalCenter

        width: rightSection.implicitWidth + px(16)
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

        Row {
          id: rightSection

          anchors.centerIn: parent
          spacing: 9


          Wifi {
            id: wifiWidget
          }

          Bluetooth {
            id: bluetoothWidget
          }

          Audio {
            id: audioWidget
            bar: bar
          }

          Item {
            // visible: root.batteryPercent >= 0
            width: visible ? batteryText.implicitWidth : 0
            height: px(20)

            Text {
              id: batteryText
              anchors.centerIn: parent

              text: `${root.batteryPercent}`
              color: root.batteryColor()
              font.family: "JetBrainsMono Nerd Font"
              font.pixelSize: px(12)
            }

            MouseArea {
              anchors.fill: parent

              onClicked: root.exec(
                `${root.terminal} -e upower -d | less`
              )
            }
          }

          // Keyboard layout.
          Item {
            width: keyboardText.implicitWidth
            height: px(20)

            Text {
              id: keyboardText
              anchors.centerIn: parent

              text: root.keyboardLayout.length > 0
              ? `󰌌 ${root.keyboardLayout}`
              : "󰌌"

              color: root.text
              font.family: "JetBrainsMono Nerd Font"
              font.pixelSize: px(12)
            }

            MouseArea {
              anchors.fill: parent

              onClicked: root.exec(
                "hyprctl switchxkblayout current next"
              )
            }
          }

          // System tray.
          Row {
            id: trayRow
            spacing: 4

            Repeater {
              model: SystemTray.items

              delegate: Item {
                id: trayDelegate

                required property var modelData
                readonly property var trayItem: modelData

                width: 17
                height: 17

                Image {
                  anchors.centerIn: parent
                  anchors.verticalCenterOffset: 3
                  width: 14
                  height: 14

                  source: trayDelegate.trayItem.icon
                  fillMode: Image.PreserveAspectFit
                  smooth: true
                }

                MouseArea {
                  anchors.fill: parent
                  acceptedButtons: Qt.LeftButton
                  | Qt.MiddleButton
                  | Qt.RightButton

                  onClicked: mouse => {
                    if (mouse.button === Qt.RightButton) {
                      if (trayDelegate.trayItem.hasMenu) {
                        trayDelegate.trayItem.display(
                          bar,
                          trayDelegate.x,
                          trayDelegate.y + trayDelegate.height
                        )
                      }
                    } else if (mouse.button === Qt.MiddleButton) {
                      trayDelegate.trayItem.secondaryActivate()
                    } else if (trayDelegate.trayItem.onlyMenu) {
                      if (trayDelegate.trayItem.hasMenu) {
                        trayDelegate.trayItem.display(
                          bar,
                          trayDelegate.x,
                          trayDelegate.y + trayDelegate.height
                        )
                      }
                    } else {
                      trayDelegate.trayItem.activate()
                    }
                  }

                  onWheel: wheel => {
                    trayDelegate.trayItem.scroll(
                      wheel.angleDelta.y,
                      false
                    )
                  }
                }
              }
            }
          }
        }
      }


      Timer {
        id: clock
        property date date: new Date()

        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: date = new Date()
      }
    }
  }

  function exec(command) {
    Quickshell.execDetached(["sh", "-lc", command])
  }

  function batteryColor() {
    if (batteryPercent >= 0 && batteryPercent <= 10)
    return critical
    if (batteryPercent >= 0 && batteryPercent <= 25)
    return warning
    return text
  }

  // UPower DisplayDevice works on most laptops. It harmlessly results in
  // no shown battery widget on a desktop without a battery.
  Process {
    id: batteryProcess
    command: [
      "sh", "-lc",
      "/home/mumu/.dotfiles/bin/battery"
    ]

    stdout: SplitParser {
      onRead: data => {
        root.batteryPercent = data
      }
    }
  }

  // Gets the active keymap from Hyprland JSON output.
  Process {
    id: keyboardProcess
    command: [
      "sh", "-lc",
      "hyprctl devices -j 2>/dev/null | jq -r "
      + "'[.keyboards[] | select(.main == true)][0].active_keymap "
      + "// .keyboards[0].active_keymap // \"\"'"
    ]

    stdout: SplitParser {
      onRead: data => {
        root.keyboardLayout = data.trim()
      }
    }
  }

  Timer {
    interval: 3000
    running: true
    repeat: true
    triggeredOnStart: true

    onTriggered: {
      batteryProcess.running = true
      keyboardProcess.running = true
    }
  }
}
