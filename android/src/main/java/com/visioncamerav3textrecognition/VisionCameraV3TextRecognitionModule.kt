package com.visioncamerav3textrecognition

import android.media.Image
import com.google.android.gms.tasks.Task
import com.google.android.gms.tasks.Tasks
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.text.Text
import com.google.mlkit.vision.text.TextRecognition
import com.google.mlkit.vision.text.TextRecognizer
import com.google.mlkit.vision.text.latin.TextRecognizerOptions
import com.mrousavy.camera.core.types.Orientation
import com.mrousavy.camera.frameprocessors.Frame
import com.mrousavy.camera.frameprocessors.FrameProcessorPlugin
import com.mrousavy.camera.frameprocessors.VisionCameraProxy


class VisionCameraV3TextRecognitionModule(proxy: VisionCameraProxy, options: Map<String, Any>?) : FrameProcessorPlugin() {
    private var recognizer: TextRecognizer = TextRecognition.getClient(TextRecognizerOptions.DEFAULT_OPTIONS)

    override fun callback(frame: Frame, arguments: Map<String, Any>?): String? {
        try {
            val mediaImage: Image = frame.image
            val orientation: Orientation = frame.orientation

            val rotationDegrees = when (orientation) {
                Orientation.PORTRAIT -> 0
                Orientation.LANDSCAPE_LEFT -> 90
                Orientation.PORTRAIT_UPSIDE_DOWN -> 180
                Orientation.LANDSCAPE_RIGHT -> 270
                else -> 0
            }

            val image = InputImage.fromMediaImage(mediaImage, rotationDegrees)
            val task: Task<Text> = recognizer.process(image)
            val result: Text? = Tasks.await(task)

            return result?.text
        } catch (e: Exception) {
            throw Exception("Error processing text recognition: $e ")
        }
    }
}

