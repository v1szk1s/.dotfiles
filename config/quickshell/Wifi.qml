import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

Item {
    id: wifiWidget

    // ---- Config ----
    property string device: ""
    property int pollIntervalMs: 5000

    // ---- State ----
    property string state: "disabled"
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
                if (wifiWidget.state === "disabled") return "󰤭"       // wifi off
                if (wifiWidget.state === "disconnected") return "󰤯"   // wifi, no connection
                if (wifiWidget.state === "connecting") return "󰤨"     // wifi, connecting
                return "󰤥"                                       // wifi, connected
            }
            color: wifiWidget.state === "connected" ? "#a6e3a1"
                 : wifiWidget.state === "connecting" ? "#f9e2af"
                 : wifiWidget.state === "disconnected" ? "#f38ba8"
                 : "#6c7086"
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        // hoverEnabled: true
        // onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: openImpala.running = true
    }

    // ---- Detect the wifi device name once (if not manually set) ----
    Process {
        id: deviceDetect
        command: ["sh", "-c", "iwctl device list | awk 'NR>4{print $2; exit}'"]
        running: wifiWidget.device === ""
        stdout: StdioCollector {
            onStreamFinished: {
                wifiWidget.detectedDevice = this.text.trim()
                statusPoll.running = true
            }
        }
    }

    // ---- Poll iwd status ----
    Process {
        id: statusPoll
        property string dev: wifiWidget.device !== "" ? wifiWidget.device : wifiWidget.detectedDevice
        command: ["sh", "-c",
            "dev=" + (wifiWidget.device !== "" ? wifiWidget.device : wifiWidget.detectedDevice) + "; " +
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
                    wifiWidget.state = "disabled"
                } else if (st === "connected" && ssid !== "") {
                    wifiWidget.state = "connected"
                    wifiWidget.ssid = ssid
                } else if (st === "connecting") {
                    wifiWidget.state = "connecting"
                } else {
                    wifiWidget.state = "disconnected"
                }
            }
        }
    }

    Timer {
        interval: wifiWidget.pollIntervalMs
        running: true
        repeat: true
        onTriggered: statusPoll.running = true
    }

    Component.onCompleted: {
        if (wifiWidget.device !== "") statusPoll.running = true
    }

    Process {
        id: openImpala
        command: [root.terminal, "-e", "impala"]
    }
}

