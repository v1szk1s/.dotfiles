import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

Item {
    id: root

    // ---- Config ----
    property string terminal: "foot"      // terminal emulator used to launch impala
    property string device: ""            // leave empty to auto-detect the wifi device
    property int pollIntervalMs: 5000

    // ---- State ----
    property string state: "disabled"     // disabled | disconnected | connecting | connected
    property string ssid: ""
    property string detectedDevice: ""
    property bool hovered: false

    implicitWidth: row.implicitWidth + 12
    implicitHeight: 24

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 6

        Text {
            id: icon
            font.pixelSize: 16
            text: {
                if (root.state === "disabled") return "󰤭"       // wifi off
                if (root.state === "disconnected") return "󰤯"   // wifi, no connection
                if (root.state === "connecting") return "󰤨"     // wifi, connecting
                return "󰤥"                                       // wifi, connected
            }
            color: root.state === "connected" ? "#a6e3a1"
                 : root.state === "connecting" ? "#f9e2af"
                 : root.state === "disconnected" ? "#f38ba8"
                 : "#6c7086"
        }

        Text {
            id: ssidText
            text: root.state === "connected" ? root.ssid
                : root.state === "connecting" ? "Connecting…"
                : root.state === "disconnected" ? "Disconnected"
                : "WiFi off"
            font.pixelSize: 13
            color: "#cdd6f4"
            elide: Text.ElideRight
            visible: root.hovered
            opacity: visible ? 1 : 0
            Behavior on opacity { OpacityAnimator { duration: 120 } }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: openImpala.running = true
    }

    // ---- Detect the wifi device name once (if not manually set) ----
    Process {
        id: deviceDetect
        command: ["sh", "-c", "iwctl device list | awk 'NR>4{print $2; exit}'"]
        running: root.device === ""
        stdout: StdioCollector {
            onStreamFinished: {
                root.detectedDevice = this.text.trim()
                statusPoll.running = true
            }
        }
    }

    // ---- Poll iwd status ----
    Process {
        id: statusPoll
        property string dev: root.device !== "" ? root.device : root.detectedDevice
        command: ["sh", "-c",
            "dev=" + (root.device !== "" ? root.device : root.detectedDevice) + "; " +
            "[ -z \"$dev\" ] && exit 1; " +
            "powered=$(iwctl device list | awk -v d=$dev '$2==d {print $4}');" +
            "if [ \"$powered\" != \"on\" ]; then echo 'STATE=disabled'; exit 0; fi; " +
            "info=$(iwctl station \"$dev\" show); " +
            "st=$(echo \"$info\" | awk '/^ *State/ {print $2}'); " +
            "net=$(echo \"$info\" | awk -F'Connected network' '/Connected network/ {print $2}' | sed 's/^ *//;s/ *$//'); " +
            "echo \"STATE=$st\"; echo \"SSID=$net\""
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                var lines = this.text.trim().split("\n")
                var st = "disconnected"
                var ssid = ""
                for (var i = 0; i < lines.length; i++) {
                    var l = lines[i]
                    if (l.indexOf("STATE=") === 0) st = l.substring(6).trim()
                    if (l.indexOf("SSID=") === 0) ssid = l.substring(5).trim()
                }
                if (st === "disabled") {
                    root.state = "disabled"
                } else if (st === "connected" && ssid !== "") {
                    root.state = "connected"
                    root.ssid = ssid
                } else if (st === "connecting") {
                    root.state = "connecting"
                } else {
                    root.state = "disconnected"
                }
            }
        }
    }

    Timer {
        interval: root.pollIntervalMs
        running: true
        repeat: true
        onTriggered: statusPoll.running = true
    }

    Component.onCompleted: {
        if (root.device !== "") statusPoll.running = true
    }

    // ---- Launch impala in a terminal on click ----
    Process {
        id: openImpala
        command: [root.terminal, "-e", "impala"]
    }
}

