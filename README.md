The frame processor plugin for text recognition using  Google ML Kit library for react-native-vision-camera with high performance.
# 🚨 Required Modules
react-native-vision-camera = ^4.0.0<br/>
react-native-worklets-core = ^0.5.0

## 💻 Installation

```sh

npm install react-native-vision-camera-v3-text-recognition
yarn add react-native-vision-camera-v3-text-recognition
```
## 👷Features
    Easy To Use.
    Works Just Writing few lines of Code.
    Works With React Native Vision Camera.
    Works for Both Cameras.
    Works Fast.
    Works With Android 🤖 and IOS.📱
    Writen With Kotlin and Objective-C.

## 💡 Usage
```js
import React from 'react';
import { StyleSheet } from "react-native";
import {
  Camera,
  useCameraDevice,
  useFrameProcessor,
} from "react-native-vision-camera";
import { useTextRecognition } from "react-native-vision-camera-v3-text-recognition";

function App() {
  const device = useCameraDevice('back');
  const {scanText} = useTextRecognition()
  const frameProcessor = useFrameProcessor((frame) => {
    'worklet'
    const data = scanText(frame)
	console.log(data, 'data')
  }, [])
  return (
      <>
      {!!device && (
        <Camera
          style={StyleSheet.absoluteFill}
          device={device}
          isActive
          frameProcessor={frameProcessor}
        />
      )}
      </>
  );
}
export default App;
```


---
## ⚙️ Options

|   Name   |  Type    |                 Values                 | Default |
|:--------:| :---: |:--------------------------------------:|:-------:|
| language | string | latin, chinese, devanagari, japanese, korean |  latin  |

















