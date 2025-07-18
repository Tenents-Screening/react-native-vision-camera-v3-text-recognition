import React, { useMemo } from 'react';
import { createTextRecognitionPlugin } from './scanText';
import type {
  TextRecognitionOptions,
  TextRecognitionPlugin,
} from './types';

export function useTextRecognition(
  options?: TextRecognitionOptions
): TextRecognitionPlugin {
  return useMemo(
    () => createTextRecognitionPlugin(options || {}),
    [ options ]
  );
}
