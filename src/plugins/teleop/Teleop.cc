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

/// \brief Publisher
ignition::transport::Node::Publisher cmdVelPub;

namespace ignition
{
namespace gui
{
  class TeleopPrivate
  {
    /// \brief Node for communication
    public: ignition::transport::Node node;

    /// \brief Topic
    public: std::string topic = "cmd_vel";
  };
}
}

using namespace ignition;
using namespace gui;

/////////////////////////////////////////////////
Teleop::Teleop(): Plugin(), dataPtr(new TeleopPrivate)
{
  // Advertise publisher node
  cmdVelPub = this->dataPtr->node.Advertise<ignition::msgs::Twist>
    (this->dataPtr->topic);
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
void Teleop::OnForward(int _x)
{
  ignition::msgs::Twist cmdVelMsg;
  cmdVelMsg.mutable_linear()->set_x(1.0);
  cmdVelMsg.mutable_angular()->set_z(1.0);

  cmdVelPub.Publish(cmdVelMsg);

}


// Register this plugin
IGNITION_ADD_PLUGIN(ignition::gui::Teleop,
                    ignition::gui::Plugin)
