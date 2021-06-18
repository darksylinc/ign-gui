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

#ifdef _MSC_VER
#pragma warning(push, 0)
#endif
#include <ignition/msgs/twist.pb.h>
#ifdef _MSC_VER
#pragma warning(pop)
#endif

#include <string>

#include <ignition/gui/Application.hh>
#include <ignition/gui/MainWindow.hh>
#include <ignition/plugin/Register.hh>

#include "Teleop.hh"

namespace ignition
{
namespace gui
{

  struct keyPress{
    bool forward;
    bool left;
    bool right;
    bool backward;
    bool stop;
  };

  class TeleopPrivate
  {
    /// \brief Node for communication
    public: ignition::transport::Node node;

    /// \brief Topic. Set '/cmd_vel' as default.
    public: std::string topic = "/cmd_vel";

    /// \brief Publisher
    ignition::transport::Node::Publisher cmdVelPub;

    public: float linearVel = 0;
    public: float angularVel = 0;

    public: int linearDir = 0;
    public: int angularDir = 0;
    public: keyPress state;

    public: bool keyEnable = false;

  };
}
}

using namespace ignition;
using namespace gui;

/////////////////////////////////////////////////
Teleop::Teleop(): Plugin(), dataPtr(new TeleopPrivate)
{
}

/////////////////////////////////////////////////
Teleop::~Teleop()
{
}

/////////////////////////////////////////////////
void Teleop::LoadConfig(const tinyxml2::XMLElement *)
{
  if (this->title.empty())
    this->title = "Teleop";

  ignition::gui::App()->findChild
    <ignition::gui::MainWindow *>()->QuickWindow()->installEventFilter(this);
}

/////////////////////////////////////////////////
void Teleop::OnDirectionButton()
{
  ignition::msgs::Twist cmdVelMsg;

  cmdVelMsg.mutable_linear()->set_x(
      this->dataPtr->linearDir * this->dataPtr->linearVel);
  cmdVelMsg.mutable_angular()->set_z(
      this->dataPtr->angularDir * this->dataPtr->angularVel);

  this->dataPtr->cmdVelPub.Publish(cmdVelMsg);
}

/////////////////////////////////////////////////
void Teleop::OnTopicSelection(const QString& _topic)
{
  this->dataPtr->topic = _topic.toStdString();
  ignmsg << "[OnTopicSelection]: topic: " << this->dataPtr->topic << std::endl;
  this->dataPtr->cmdVelPub =
    this->dataPtr->node.Advertise<ignition::msgs::Twist>(this->dataPtr->topic);
}

/////////////////////////////////////////////////
void Teleop::OnLinearVelSelection(const QString& _velocity)
{
  this->dataPtr->linearVel = _velocity.toDouble();
  ignmsg << "[OnlinearVelSelection]: linear velocity: "
      << this->dataPtr->linearVel << std::endl;
}

/////////////////////////////////////////////////
void Teleop::OnAngularVelSelection(const QString& _velocity)
{
  this->dataPtr->angularVel = _velocity.toDouble();
  ignmsg << "[OnlinearVelSelection]: angular velocity: "
      << this->dataPtr->angularVel << std::endl;
}

/////////////////////////////////////////////////
void Teleop::OnKeySwitch(bool _checked)
{
  this->dataPtr->linearDir = 0;
  this->dataPtr->angularDir = 0;
  this->dataPtr->keyEnable = _checked;
}

/////////////////////////////////////////////////
bool Teleop::eventFilter(QObject *_obj, QEvent *_event)
{
  if(_event->type() == QEvent::KeyPress && this->dataPtr->keyEnable == true)
  {
    QKeyEvent *keyEvent = static_cast<QKeyEvent*>(_event);
    switch(keyEvent->key())
    {
      case Qt::Key_W:
        this->dataPtr->state.forward = true;
        break;
      case Qt::Key_A:
        this->dataPtr->state.left = true;
        break;
      case Qt::Key_D:
        this->dataPtr->state.right = true;
        break;
      case Qt::Key_X:
        this->dataPtr->state.backward = true;
        break;
      case Qt::Key_S:
        this->dataPtr->state.stop = true;
        break;
      default:
        ignmsg << "A non valid key was pressed" << std::endl;
        break;
    }
    setKeyDirection();
    OnDirectionButton();
  }
  if(_event->type() == QEvent::KeyRelease && this->dataPtr->keyEnable == true)
  {
    QKeyEvent *keyEvent1 = static_cast<QKeyEvent*>(_event);
    switch(keyEvent1->key())
    {
      case Qt::Key_W:
        this->dataPtr->state.forward = false;
        break;
      case Qt::Key_A:
        this->dataPtr->state.left = false;
        break;
      case Qt::Key_D:
        this->dataPtr->state.right = false;
        break;
      case Qt::Key_X:
        this->dataPtr->state.backward = false;
        break;
      case Qt::Key_S:
        this->dataPtr->state.stop = false;
        break;
      default:
        ignmsg << "A non valid key was pressed" << std::endl;
        break;
    }
    setKeyDirection();
    OnDirectionButton();
  }

  return QObject::eventFilter(_obj, _event);
}

/////////////////////////////////////////////////
void Teleop::setKeyDirection()
{
  if(this->dataPtr->state.forward)
    this->dataPtr->linearDir = 1;
  else if(this->dataPtr->state.backward)
    this->dataPtr->linearDir = -1;
  else
    this->dataPtr->linearDir = 0;

  if(this->dataPtr->state.left)
    this->dataPtr->angularDir = 1;
  else if(this->dataPtr->state.right)
    this->dataPtr->angularDir = -1;
  else
    this->dataPtr->angularDir = 0;
}

/////////////////////////////////////////////////
int Teleop::LinearDirection() const
{
  return this->dataPtr->linearDir;
}

/////////////////////////////////////////////////
void Teleop::setLinearDirection(int _linearDir)
{
  this->dataPtr->linearDir = _linearDir;
  this->LinearDirectionChanged();
}

/////////////////////////////////////////////////
int Teleop::AngularDirection() const
{
  return this->dataPtr->angularDir;
}

/////////////////////////////////////////////////
void Teleop::setAngularDirection(int _angularDir)
{
  this->dataPtr->angularDir = _angularDir;
  this->AngularDirectionChanged();
}

// Register this plugin
IGNITION_ADD_PLUGIN(ignition::gui::Teleop,
                    ignition::gui::Plugin)
