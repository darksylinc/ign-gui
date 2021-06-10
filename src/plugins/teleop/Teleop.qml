/*
 * Copyright (C) 2021 Open Source Robotics Foundation
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
import QtQuick.Controls 1.4
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Rectangle {
  Layout.minimumWidth: 250
  Layout.minimumHeight: 200
  anchors.fill: parent

  Label {
    id: topicLabel
    text: "Topic:"
    anchors.top: parent.top
    anchors.topMargin: 10
    anchors.left: parent.left
    anchors.leftMargin: 5
  }
  TextField {
    id: topicField
    anchors.top: parent.top
    anchors.topMargin: 5
    anchors.left: topicLabel.right
    anchors.leftMargin: 5
    anchors.right: buttonsGrid.right
    Layout.fillWidth: true
    text: "/cmd_vel"

    placeholderText: qsTr("Topic to publish...")
    onTextChanged: {
      Teleop.OnTopicSelection(text)
    }
  }

  GridLayout {
    id: buttonsGrid
    anchors.top: topicField.bottom
    anchors.topMargin: 15
    anchors.left: parent.left
    anchors.leftMargin: 5
    Layout.fillWidth: true
    columns: 4

    Button {
      id: forwardButton
      text: "Forward"
      checkable: false
      Layout.row: 0
      Layout.column: 1
      onClicked: {
        Teleop.OnForwardButton()
      }
      Material.background: Material.primary
      style: ButtonStyle {
        label: Text {
          renderType: Text.NativeRendering
          verticalAlignment: Text.AlignVCenter
          horizontalAlignment: Text.AlignHCenter
          font.family: "Helvetica"
          font.pointSize: 10
          color: "black"
          text: forwardButton.text
        }
      }
    }

    Button {
      id: leftButton
      text: "Left"
      checkable: false
      Layout.row: 1
      Layout.column: 0
      onClicked: {
        Teleop.OnLeftButton()
      }
      Material.background: Material.primary
      style: ButtonStyle {
        label: Text {
          renderType: Text.NativeRendering
          verticalAlignment: Text.AlignVCenter
          horizontalAlignment: Text.AlignHCenter
          font.family: "Helvetica"
          font.pointSize: 10
          color: "black"
          text: leftButton.text
        }
      }
    }

    Button {
      id: rightButton
      text: "Right"
      checkable: false
      Layout.row: 1
      Layout.column: 2
      onClicked: {
        Teleop.OnRightButton()
      }
      Material.background: Material.primary
      style: ButtonStyle {
        label: Text {
          renderType: Text.NativeRendering
          verticalAlignment: Text.AlignVCenter
          horizontalAlignment: Text.AlignHCenter
          font.family: "Helvetica"
          font.pointSize: 10
          color: "black"
          text: rightButton.text
        }
      }
    }

    Button {
      id: backwardButton
      text: "Backward"
      checkable: false
      Layout.row: 2
      Layout.column: 1
      onClicked: {
        Teleop.OnBackwardButton()
      }
      Material.background: Material.primary
      style: ButtonStyle {
        label: Text {
          renderType: Text.NativeRendering
          verticalAlignment: Text.AlignVCenter
          horizontalAlignment: Text.AlignHCenter
          font.family: "Helvetica"
          font.pointSize: 10
          color: "black"
          text: backwardButton.text
        }
      }
    }
  }
}
