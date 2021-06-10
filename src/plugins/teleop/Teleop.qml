/*
 * Copyright (C) 2020 Open Source Robotics Foundation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
*/

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ToolBar {
  Layout.minimumWidth: 200
  Layout.minimumHeight: 200

  background: Rectangle {
      color: "transparent"
  }

  GridLayout {
      columns: 4   

      Label {
        text: "Topic"
        Layout.column: 0
      }
      TextField {
        id: topicField
        text: Publisher.topic
        Layout.row: 0
        Layout.column: 1
        selectByMouse: true
      }

      Button{
          id: forward_control
          Layout.row: 1
          Layout.column: 1
          contentItem: Text {
          text: qsTr("Forward")
          font: control.font
          color: control.down ? "#17a81a" : "#21be2b"
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          elide: Text.ElideRight
          }

          background: Rectangle {
          implicitWidth: 100
          implicitHeight: 40
          opacity: enabled ? 1 : 0.3
          border.color: control.down ? "#17a81a" : "#21be2b"
          border.width: 1
          radius: 2
          }
          onClicked: {
          Teleop.OnForward(1)
          }
      }

      Button{
          id: left_control
          Layout.row: 2
          Layout.column: 0
          contentItem: Text {
          text: qsTr("Left")
          font: control.font
          color: control.down ? "#17a81a" : "#21be2b"
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          elide: Text.ElideRight
          }
          background: Rectangle {
          implicitWidth: 100
          implicitHeight: 40
          opacity: enabled ? 1 : 0.3
          border.color: control.down ? "#17a81a" : "#21be2b"
          border.width: 1
          radius: 2
          }
      }

      Button{
          id: right_control
          Layout.row: 2
          Layout.column: 2
          contentItem: Text {
          text: qsTr("Right")
          font: control.font
          color: control.down ? "#17a81a" : "#21be2b"
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          elide: Text.ElideRight
          }
          background: Rectangle {
          implicitWidth: 100
          implicitHeight: 40
          opacity: enabled ? 1 : 0.3
          border.color: control.down ? "#17a81a" : "#21be2b"
          border.width: 1
          radius: 2
          }
      }

      Button{
          id: backward_control
          Layout.row: 3
          Layout.column: 1
          contentItem: Text {
          text: qsTr("Backward")
          font: control.font
          color: control.down ? "#17a81a" : "#21be2b"
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          elide: Text.ElideRight
          }

          background: Rectangle {
          implicitWidth: 100
          implicitHeight: 40
          opacity: enabled ? 1 : 0.3
          border.color: control.down ? "#17a81a" : "#21be2b"
          border.width: 1
          radius: 2
          }
      }
  
  }

}
