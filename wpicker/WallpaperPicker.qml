import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls

import qs
import qs.components
import qs.services
import qs.settings.components
import "../utils.js" as Utils

import "components"

PanelWindow {
    id: root;

    readonly property var theme: ColorGenService.md3;

    property string iconFontFamily: Theme.iconFontFamily;
    property string fontFamily: Theme.fontFamily;

    property color fg: theme.on_background;
    property color textFieldColor: theme.on_background;
    property color textFieldBorderColor: theme.outline;
    property color textFieldBorderActiveColor: theme.outline_variant;
    property color textFieldBackgroundColor: theme.background;

    anchors {
        top: true;
        bottom: true;
        left: true;
        right: true;
    }

    color: "transparent";
    visible: false;

    onVisibleChanged: {
        if (this.visible) {
            searchInput.forceActiveFocus();
        } else {
            searchInput.text = "";
        }
    }

    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive;

    BackgroundEffect.blurRegion: Region {
        item: root.contentItem;
    }

    IpcHandler {
        target: "wpp";

        function toggle(): void {
            root.visible = !root.visible;
        }

        function show(): void {
            root.visible = true;
        }

        function hide(): void {
            root.visible = false;
        }
    }

    MouseArea {
        anchors.fill: parent;
        acceptedButtons: Qt.NoButton;

        onWheel: event => {
            const items = 4;
            const direction = event.angleDelta.y > 0 ? -1 : 1;
            listView.contentX += direction * items * 100;
            event.accepted = true;
        };
    }

    Rectangle {
        id: rect;
        focus: true;
        implicitWidth: parent.width;
        implicitHeight: parent.height / 2;
        anchors.verticalCenter: parent.verticalCenter;
        color: "transparent";
        radius: 20;

        Keys.onPressed: event => {
            if (event.key === Qt.Key_Escape) {
                root.visible = false;
            }
        }

        ListView {
            id: listView;
            anchors.fill: parent;
            clip: true;
            spacing: 25;

            orientation: ListView.Horizontal;
            snapMode: ListView.SnapToItem;
            highlightRangeMode: ListView.StrictlyEnforceRange;
            highlightMoveDuration: 500;
            preferredHighlightBegin: (width - (1200 - 450)) / 2;
            preferredHighlightEnd: (width + 450) / 2;
            keyNavigationWraps: true;

            model: WallpaperService.filteredWallpapers;
            delegate: ColumnLayout {
                id: cl;

                required property string modelData;
                property bool currentItem: ListView.isCurrentItem;

                LoadingCard {
                    w: 450;
                    h: 450;
                    shown: imgCard.status === Image.Loading;
                    borderRadius: rect.radius;
                }

                ImageCard {
                    id: imgCard;
                    source: modelData;
                    state: currentItem ? "" : "notInFocus";
                    visible: this.status === Image.Ready;
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter;
                    Layout.maximumWidth: imgCard.width;

                    color: root.fg;
                    font.bold: true;
                    font.family: root.fontFamily;
                    visible: imgCard.status === Image.Ready;
                    maximumLineCount: 25;
                    elide: Text.ElideRight;
                    text: {
                        const parts = modelData.split("/");
                        const lastPart = parts[parts.length - 1];
                        return lastPart;
                    }
                }
            }
        }
    }

    RowLayout  {
        width: 500;
        height: 200;
        anchors.bottom: parent.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;

        StyledTextField {
            Layout.fillWidth: true;

            id: searchInput;
            onTextChanged: WallpaperService.setFilter(text);
            onAccepted: {
                const newWp = listView.model[listView.currentIndex];

                if (newWp) {
                    WallpaperService.setWp(newWp);
                    root.visible = false;
                }
            }

            Keys.onPressed: event => {
                if (event.key === Qt.Key_Escape) {
                    root.visible = false;
                } else if (event.key === Qt.Key_H && event.modifiers & Qt.ControlModifier) {
                    listView.decrementCurrentIndex();
                } else if (event.key === Qt.Key_L && event.modifiers & Qt.ControlModifier) {
                    listView.incrementCurrentIndex();
                }
            }
        }

        StyledButton {
            text: "Refresh";
            btnIcon: "refresh";

            onClicked: () => {
                WallpaperService.reload();
                searchInput.forceActiveFocus();
            }
        }
    }
}
