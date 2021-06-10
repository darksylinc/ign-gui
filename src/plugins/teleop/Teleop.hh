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

#ifndef IGNITION_GUI_PLUGINS_TELEOP_HH_
#define IGNITION_GUI_PLUGINS_TELEOP_HH_

#include <ignition/gui/qt.h>

#include <memory>

#include <ignition/gui/Plugin.hh>
#include <ignition/transport/Node.hh>

namespace ignition
{
namespace gui
{
  class TeleopPrivate;

  /// \brief Publish teleop stokes to "cmd_vel" topic.
  ///
  /// ## Configuration
  /// This plugin doesn't accept any custom configuration.
  class Teleop : public ignition::gui::Plugin
  {
    Q_OBJECT

    /// \brief Constructor
    public: Teleop();

    /// \brief Destructor
    public: virtual ~Teleop();

    // Documentation inherited
    public: virtual void LoadConfig(const tinyxml2::XMLElement *) override;

    // 
    public slots: void OnForwardButton();

    public slots: void OnTopicSelection(const QString& _topic);

    /// \internal
    /// \brief Pointer to private data.
    private: std::unique_ptr<TeleopPrivate> dataPtr;
  };
}
}

#endif
