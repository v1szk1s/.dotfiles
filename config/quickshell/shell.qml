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
  property string bluetoothTui: "bluetuith"
  property string mixer: "pavucontrol"

  property color background: "#11111b"
  property color surface: "#313244"
  property color active: "#89b4fa"
  property color text: "#cdd6f4"
  property color mutedColor: "#a6adc8"
  property color warning: "#f9e2af"
  property color critical: "#f38ba8"

  // property color background: "#1e1e2e"
  // property color surface: "#313244"
  // property color active: "#89b4fa"
  // property color text: "#cdd6f4"
  // property color mutedColor: "#a6adc8"
  // property color warning: "#f9e2af"
  // property color critical: "#f38ba8"

  // Data populated by lightweight commands.
  property string wifiName: ""
  property bool wifiConnected: false
  property bool wifiEnabled: false

  property bool bluetoothEnabled: false
  property int bluetoothConnected: 0

  property int volume: 0
  property bool muted: false

  property string batteryPercent: ""
  property string batteryState: ""
  property string keyboardLayout: ""

  function exec(command) {
    Quickshell.execDetached(["sh", "-lc", command])
  }

  function switchWorkspace(number) {
    if (smwAvailable) {
      Hyprland.dispatch(
        `require("plugins.split-monitor-workspaces").workspace("${number}")`
      )
    } else if (Hyprland.usingLua) {
      Hyprland.dispatch(
        `hl.dsp.focus({ workspace = "${number}" })`
      )
    } else {
      Hyprland.dispatch(`workspace ${number}`)
    }
  }

  function moveToWorkspace(number, silent) {
    if (smwAvailable) {
      const method = silent
      ? "move_to_workspace_silent"
      : "move_to_workspace"

      Hyprland.dispatch(
        `require("plugins.split-monitor-workspaces").${method}("${number}")`
      )
    } else if (Hyprland.usingLua) {
      Hyprland.dispatch(
        `hl.dsp.window.move({ workspace = "${number}", follow = ${silent ? "false" : "true"} })`
      )
    } else {
      Hyprland.dispatch(
        `${silent ? "movetoworkspacesilent" : "movetoworkspace"} ${number}`
      )
    }
  }

  function globalWorkspaceIdFor(number) {
    if (!Hyprland.focusedMonitor)
      return number

    const mon = Hyprland.focusedMonitor

    const isSecondary =
      mon.name !== "eDP-1"

    return isSecondary ? (number + 9) : number
  }

  function workspaceActive(number) {
    if (!Hyprland.focusedWorkspace)
      return false

    const expectedId = root.globalWorkspaceIdFor(number)
    const actualId   = Hyprland.focusedWorkspace.id

    return actualId === expectedId
  }

  function volumeIcon() {
    if (muted)
    return "󰖁"
    if (volume <= 0)
    return "󰖀"
    if (volume < 35)
    return "󰕿"
    if (volume < 70)
    return "󰖀"
    return "󰕾"
  }

  function batteryColor() {
    if (batteryPercent >= 0 && batteryPercent <= 10)
    return critical
    if (batteryPercent >= 0 && batteryPercent <= 25)
    return warning
    return text
  }

  function wifiIcon() {
    if (!wifiEnabled)
    return "󰖪"
    if (!wifiConnected)
    return "󰖩"
    return "󰖩"
  }

  // NetworkManager: state + active Wi-Fi connection name.
  Process {
    id: wifiProcess
    command: [
      "sh", "-lc",
      "enabled=$(nmcli -t -f WIFI general 2>/dev/null); "
      + "ssid=$(nmcli -t -f ACTIVE,SSID dev wifi 2>/dev/null "
      + "| awk -F: '$1==\"yes\" {print substr($0,5); exit}'); "
      + "printf '%s\\n%s\\n' \"$enabled\" \"$ssid\""
    ]

    stdout: SplitParser {
      onRead: data => {
        const lines = data.trim().split("\n")
        root.wifiEnabled = lines[0] === "enabled"
        root.wifiName = lines.length > 1 ? lines[1] : ""
        root.wifiConnected = root.wifiName.length > 0
      }
    }
  }

  // BlueZ: adapter power and count of currently connected devices.
  Process {
    id: bluetoothProcess
    command: [
      "sh", "-lc",
      "powered=$(bluetoothctl show 2>/dev/null "
      + "| awk -F': ' '/Powered:/ {print $2; exit}'); "
      + "connected=$(bluetoothctl devices Connected 2>/dev/null | wc -l); "
      + "printf '%s\\n%s\\n' \"$powered\" \"$connected\""
    ]

    stdout: SplitParser {
      onRead: data => {
        const lines = data.trim().split("\n")
        root.bluetoothEnabled = lines[0] === "yes"
        root.bluetoothConnected = Number(lines[1] || 0)
      }
    }
  }

  // PipeWire/WirePlumber command-line interface.
  Process {
    id: volumeProcess
    command: [
      "sh", "-lc",
      "wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null"
    ]

    stdout: SplitParser {
      onRead: data => {
        const match = data.match(/Volume:\s*([0-9.]+)(\s+\[MUTED\])?/)
        if (!match)
        return

        root.volume = Math.round(Number(match[1]) * 100)
        root.muted = Boolean(match[2])
      }
    }
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
      wifiProcess.running = true
      bluetoothProcess.running = true
      volumeProcess.running = true
      batteryProcess.running = true
      keyboardProcess.running = true
    }
  }

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
        Math.min(1.20, screen.devicePixelRatio)
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
      exclusiveZone: px(23)
      color: "transparent"
      exclusionMode: ExclusionMode.Normal

      // Workspace island ----------------------------------------------------
      Rectangle {
        id: workspaceIsland

        anchors.left: parent.left
        anchors.leftMargin: px(8)
        anchors.verticalCenter: parent.verticalCenter

        width: leftSection.implicitWidth + px(14)
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
          id: leftSection

          anchors.centerIn: parent
          spacing: 6

          Repeater {
            model: root.workspaceCount

            delegate: Item {
              required property int index

              readonly property int number: index + 1
              readonly property bool activeWorkspace:
              root.workspaceActive(number)

              width: dot.width
              height: px(16)

              Rectangle {
                id: dot

                anchors.verticalCenter: parent.verticalCenter

                width: parent.activeWorkspace ? px(15) : px(7)
                height: parent.activeWorkspace ? px(7) : px(7)
                radius: height / 2

                color: parent.activeWorkspace
                ? root.active
                : Qt.rgba(
                  root.mutedColor.r,
                  root.mutedColor.g,
                  root.mutedColor.b,
                  workspaceMouse.containsMouse ? 0.90 : 0.45
                )

                Behavior on width {
                  NumberAnimation {
                    duration: 170
                    easing.type: Easing.OutCubic
                  }
                }

                Behavior on color {
                  ColorAnimation {
                    duration: 150
                  }
                }

                Rectangle {
                  anchors.centerIn: parent
                  visible: parent.parent.activeWorkspace

                  width: px(3)
                  height: px(3)
                  radius: 2

                  color: Qt.rgba(
                    root.background.r,
                    root.background.g,
                    root.background.b,
                    0.85
                  )
                }
              }

              MouseArea {
                id: workspaceMouse

                anchors {
                  fill: parent
                  margins: -px(4)
                }

                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: mouse => {
                  if (mouse.button === Qt.RightButton) {
                    root.moveToWorkspace(parent.number, true)
                  } else if (mouse.modifiers & Qt.ShiftModifier) {
                    root.moveToWorkspace(parent.number, false)
                  } else {
                    root.switchWorkspace(parent.number)
                  }
                }
              }
            }
          }
        }
      }

      // Center island: clock only
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

            // terminal: root.terminal
            // networkTui: root.networkTui

            // textColor: root.text
            // mutedColor: root.mutedColor
          }

          // Bluetooth.
          Item {
            width: bluetoothText.implicitWidth
            height: px(20)

            Text {
              id: bluetoothText
              anchors.centerIn: parent

              text: root.bluetoothEnabled
              ? `󰂯${
                root.bluetoothConnected > 0
                ? " " + root.bluetoothConnected
                : ""
              }`
              : "󰂲"

              color: root.bluetoothEnabled ? root.text : root.mutedColor
              font.family: "JetBrainsMono Nerd Font"
              font.pixelSize: px(12)
            }

            MouseArea {
              anchors.fill: parent
              acceptedButtons: Qt.LeftButton | Qt.RightButton

              onClicked: mouse => {
                if (mouse.button === Qt.RightButton) {
                  root.exec(
                    "bluetoothctl power "
                    + (root.bluetoothEnabled ? "off" : "on")
                  )
                } else {
                  root.exec(`${root.terminal} -e ${root.bluetoothTui}`)
                }
              }
            }
          }

          // Audio: scroll volume; left opens mixer; right toggles mute.
          Item {
            width: volumeText.implicitWidth
            height: px(20)

            Text {
              id: volumeText
              anchors.centerIn: parent

              text: `${root.volumeIcon()} ${root.volume}%`

              // Fixed: the original expression always picked mutedColor.
              color: root.muted ? root.mutedColor : root.text
              font.family: "JetBrainsMono Nerd Font"
              font.pixelSize: px(12)
            }

            MouseArea {
              anchors.fill: parent
              acceptedButtons: Qt.LeftButton | Qt.RightButton

              onClicked: mouse => {
                if (mouse.button === Qt.RightButton) {
                  root.exec(
                    "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                  )
                } else {
                  root.exec(root.mixer)
                }
              }

              onWheel: wheel => {
                root.exec(
                  wheel.angleDelta.y > 0
                  ? "wpctl set-volume -l 1.5 "
                  + "@DEFAULT_AUDIO_SINK@ 5%+"
                  : "wpctl set-volume "
                  + "@DEFAULT_AUDIO_SINK@ 5%-"
                )
              }
            }
          }

          // Battery remains hidden when no battery is detected.
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
                  width: 15
                  height: 15

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
}
