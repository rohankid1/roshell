import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Effects

import qs

ClippingRectangle {
    id: root;

    readonly property alias status: img.status;
    readonly property bool inFocus: state !== "notInFocus";
    property alias source: img.source;
    property int w: 600;
    property int h: 450;
    property int r: 10;

    Behavior on implicitWidth {
        NumberAnimation { duration: 100; }
    }

    implicitWidth: w;
    implicitHeight: h;
    radius: 10;
    transform: Rotation {
        id: rotation;
        angle: 0;

        Behavior on angle {
            NumberAnimation { duration: 400; }
        }
    }

    Image {
        id: img;

        anchors.fill: parent;
        asynchronous: true;
        cache: true;
        fillMode: Image.PreserveAspectCrop;
        scale: 1.5;
        layer.enabled: true;
        layer.effect: MultiEffect {
            id: imgEffect;
            blurEnabled: true;
            blur: root.inFocus ? 0.0 : 0.7;
            blurMax: 32;
            brightness: root.inFocus ? 0.0 : -0.25;
            saturation: root.inFocus ? 0.0 : -0.2;
        }

        Behavior on opacity {
            NumberAnimation { duration: 250; }
        }

        Behavior on scale {
            NumberAnimation { duration: 250; }
        }
    }

    
    states: [
        State {
            name: "notInFocus";

            PropertyChanges {
                target: img;
                opacity: 0.8;
                scale: 1.0;

                layer {
                    effect: MultiEffect {
                        blur: 0.7;
                        brightness: -0.25;
                        saturation: -0.2;        
                    }
                }
            }

            PropertyChanges {
                target: root;
                w: 450;
            }

            PropertyChanges {
                target: rotation;
                angle: 10;
            }
        }
    ]
}
