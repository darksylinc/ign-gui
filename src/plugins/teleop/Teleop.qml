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
  Layout.minimumHeight: 400
  anchors.fill: parent
  focus: true

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

  Label {
    id: linearVelLabel
    text: "Linear:"
    anchors.top: topicField.bottom
    anchors.topMargin: 10
    anchors.left: parent.left
    anchors.leftMargin: 5
  }
  TextField {
    id: linearVelField
    anchors.top: topicField.bottom
    anchors.topMargin: 5
    anchors.left: linearVelLabel.right//ambiar a linear label
    anchors.leftMargin: 5
    anchors.right: buttonsGrid.right
    Layout.fillWidth: true
    text: "0.0"

    placeholderText: qsTr("Linear velocity...")
    onTextChanged: {
      Teleop.OnLinearVelSelection(text)
    }
  }

  Label {
    id: angularVelLabel
    text: "Angular:"
    anchors.top: linearVelField.bottom
    anchors.topMargin: 10
    anchors.left: parent.left
    anchors.leftMargin: 5
  }
  TextField {
    id: angularVelField
    anchors.top: linearVelField.bottom
    anchors.topMargin: 5
    anchors.left: angularVelLabel.right
    anchors.leftMargin: 5
    anchors.right: buttonsGrid.right
    Layout.fillWidth: true
    text: "0.0"

    placeholderText: qsTr("Angular velocity...")
    onTextChanged: {
      Teleop.OnAngularVelSelection(text)
    }
  }

  GridLayout {
    id: buttonsGrid
    anchors.top: angularVelField.bottom
    anchors.topMargin: 15
    anchors.left: parent.left
    anchors.leftMargin: 5
    Layout.fillWidth: true
    columns: 4

    Button {
      id: forwardButton
      text: "\u25B2"
      checkable: true
      Layout.row: 0
      Layout.column: 1
      onClicked: {
        Teleop.linearDir = forwardButton.checked ? 1 : 0
        if(backwardButton.checked)
          backwardButton.checked = false
        Teleop.OnDirectionButton()
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
      text: "\u25C0"
      checkable: true
      Layout.row: 1
      Layout.column: 0
      onClicked: {
        Teleop.angularDir = leftButton.checked ? 1 : 0
        if(rightButton.checked)
          rightButton.checked = false
        Teleop.OnDirectionButton()
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
      text: "\u25B6"
      checkable: true
      Layout.row: 1
      Layout.column: 2
      onClicked: {
        Teleop.angularDir = rightButton.checked ? -1 : 0
        if(leftButton.checked)
          leftButton.checked = false
        Teleop.OnDirectionButton()
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
      text: "\u25BC"
      checkable: true
      Layout.row: 2
      Layout.column: 1
      onClicked: {
        Teleop.linearDir = backwardButton.checked ? -1 : 0
        if(forwardButton.checked)
          forwardButton.checked = false
        Teleop.OnDirectionButton()
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

    Button {
      id: stopButton
      text: "Stop"
      checkable: false
      Layout.row: 1
      Layout.column: 1
      onClicked: {
        Teleop.linearDir = 0
        Teleop.angularDir = 0
        forwardButton.checked = false
        leftButton.checked = false
        rightButton.checked = false
        backwardButton.checked = false
        Teleop.OnDirectionButton()
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
          text: stopButton.text
        }
      }
    }
  }

  Label {
    id: switchLabel
    text: "Keyboard Enable"
    anchors.top: buttonsGrid.bottom
    anchors.topMargin: 10
    anchors.left: parent.left
    anchors.leftMargin: 5
  }
  Switch {
    id: keySwitch
    anchors.top: buttonsGrid.bottom
    anchors.topMargin: 5
    anchors.left: switchLabel.right
    anchors.leftMargin: 5
    onClicked: {
      Teleop.OnKeySwitch(checked);
    }
  }
}
