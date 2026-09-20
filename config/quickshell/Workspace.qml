import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io


Rectangle {
  id: workspaceIsland

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

    const expectedId = workspaceIsland.globalWorkspaceIdFor(number)
    const actualId   = Hyprland.focusedWorkspace.id

    return actualId === expectedId
  }

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
        workspaceIsland.workspaceActive(number)

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
              workspaceIsland.moveToWorkspace(parent.number, true)
            } else if (mouse.modifiers & Qt.ShiftModifier) {
              workspaceIsland.moveToWorkspace(parent.number, false)
            } else {
              workspaceIsland.switchWorkspace(parent.number)
            }
          }
        }
      }
    }
  }
}
