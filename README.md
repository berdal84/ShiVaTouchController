# ShiVaTouchController
A modernized joypad emulation interface for touchscreen devices
based on the ShiVa 1.9.2 iPhoneCameraControl sample

## License
Copyright 2017 Felix Caffier

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License. 

## Quick start
1. Drop TouchController AI into your User AI stack
2. Drop TouchController HUD into your game resource tab
3. Set a name for TouchController.sTargetAIModel for event forwarding
4. Call TouchController.onEnable(true) to activate everything

## Demo
Included in a separate STE, you will find a demo that includes a sample "sTargetAIModel" AI which demonstrates the forwarding process. All output is logged to the console. When you release a real product, it is highly advised that you do not log the results of the sticks and buttons for performance reasons. To run the demo, start the game and press "1" to activate, and "0" to deactivate the touch controller.

## Readme
Please reder to the readme PDF file in the project for a detailed overview of the AIModel parameters and HUD components.
