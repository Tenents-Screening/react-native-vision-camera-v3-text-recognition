import type { CameraProps, Frame } from 'react-native-vision-camera';

export interface TextRecognitionOptions {

}

export type CameraTypes = {
  callback: (data: string) => void;
  options: TextRecognitionOptions;
} & CameraProps;

export type TextRecognitionPlugin = {
  scanText: (frame: Frame) => string;
};
