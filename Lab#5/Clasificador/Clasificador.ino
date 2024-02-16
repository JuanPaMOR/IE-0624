#include <Arduino_LSM9DS1.h>

#include <TensorFlowLite.h>
#include <tensorflow/lite/micro/all_ops_resolver.h>
#include <tensorflow/lite/micro/tflite_bridge/micro_error_reporter.h>
#include <tensorflow/lite/micro/micro_interpreter.h>
#include <tensorflow/lite/schema/schema_generated.h>

#include "model.h"

const float accelerationThreshold = 2; 

const int numSamples = 119;

int samplesRead = numSamples;

tflite::MicroErrorReporter tflErrorReporter;

tflite::AllOpsResolver tflOpsResolver;

const tflite::Model* tflModel = nullptr;
tflite::MicroInterpreter* tflInterpreter = nullptr;
TfLiteTensor* tflInputTensor = nullptr;
TfLiteTensor* tflOutputTensor = nullptr;

constexpr int tensorArenaSize = 8 * 1024;
byte tensorArena[tensorArenaSize] __attribute__((aligned(16)));

const char* GESTURES[] = {
  "Circulo",
  "Levantar",
  "Estacionario"
};

#define NUM_GESTURES (sizeof(GESTURES) / sizeof(GESTURES[0]))

void setup() {
  Serial.begin(9600);
  while (!Serial);

  if (!IMU.begin()) {
    Serial.println("Failed to initialize IMU!");
    while (1);
  }

  Serial.print("Gyroscope sample rate = ");
  Serial.print(IMU.gyroscopeSampleRate());
  Serial.println(" Hz");
  Serial.println();

  tflModel = tflite::GetModel(model);
  if (tflModel->version() != TFLITE_SCHEMA_VERSION) {
    Serial.println("Model schema mismatch!");
    while (1);
  }

  tflInterpreter = new tflite::MicroInterpreter(tflModel, tflOpsResolver, tensorArena, tensorArenaSize);
  tflInterpreter->AllocateTensors();

  tflInputTensor = tflInterpreter->input(0);
  tflOutputTensor = tflInterpreter->output(0);
}

void loop() {
  float aX, aY, aZ, gX, gY, gZ;

  while (samplesRead == numSamples) {
    if (IMU.accelerationAvailable()) {
      
      IMU.readAcceleration(aX, aY, aZ);

      float aSum = fabs(aX) + fabs(aY) + fabs(aZ);

      if (aSum >= accelerationThreshold) {
        
        samplesRead = 0;
        break;
      }
    }
  }


  while (samplesRead < numSamples) {

    if (IMU.accelerationAvailable() && IMU.gyroscopeAvailable()) {
      IMU.readGyroscope(gX, gY, gZ);

      tflInputTensor->data.f[samplesRead * 3 + 0] = (gX + 2000.0) / 4000.0;
      tflInputTensor->data.f[samplesRead * 3 + 1] = (gY + 2000.0) / 4000.0;
      tflInputTensor->data.f[samplesRead * 3 + 2] = (gZ + 2000.0) / 4000.0;

      samplesRead++;

      if (samplesRead == numSamples) {
        for (int i = 0; i < NUM_GESTURES; i++) {
          Serial.print(GESTURES[i]);
          Serial.print(": ");
          Serial.println(tflOutputTensor->data.f[i], 3);
        }
        Serial.println();
      }
    }
  }
}