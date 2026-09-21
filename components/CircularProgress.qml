import QtQuick
import QtQuick.Shapes

import qs
import qs.services

Item {
    id: root;

    readonly property var theme: ColorGenService.md3;

    property real size: 40;
    property real strokeWidth: 4;
    // property color trackColor: Theme.get.selection;
    property color trackColor: theme.on_primary;
    property color spinnerColor: theme.primary;

    implicitWidth: size;
    implicitHeight: size;

    Shape {
        id: shape;
        anchors.fill: parent;
        layer.enabled: true;
        layer.samples: 4;

        ShapePath {
            fillColor: "transparent";
            strokeColor: root.trackColor;
            strokeWidth: root.strokeWidth;
            capStyle: ShapePath.RoundCap;

            PathAngleArc {
                centerX: root.width / 2;
                centerY: root.height / 2;
                radiusX: (root.width - root.strokeWidth) / 2;
                radiusY: (root.height - root.strokeWidth) / 2;
                startAngle: 0;
                sweepAngle: 360;
            }
        }

        ShapePath {
            fillColor: "transparent";
            strokeColor: root.spinnerColor;
            strokeWidth: root.strokeWidth;
            capStyle: ShapePath.RoundCap;

            PathAngleArc {
                centerX: root.width / 2;
                centerY: root.height / 2;
                radiusX: (root.width - root.strokeWidth) / 2;
                radiusY: (root.height - root.strokeWidth) / 2;
                startAngle: 0;
                sweepAngle: 90;
            }
        }

        RotationAnimation {
            target: shape;
            from: 0;
            to: 360;
            duration: 500;
            running: true;
            loops: Animation.Infinite;
        }
    }
}
