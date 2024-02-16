import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import tensorflow as tf
import os


def plot_data(filename, title):
    df = pd.read_csv(filename)
    index = range(1, len(df['X']) + 1)
    plt.rcParams["figure.figsize"] = (20,10)
    plt.plot(index, df['X'], 'g.', label='x', linestyle='solid', marker=',')
    plt.plot(index, df['Y'], 'b.', label='y', linestyle='solid', marker=',')
    plt.plot(index, df['Z'], 'r.', label='z', linestyle='solid', marker=',')
    plt.title(title)
    plt.xlabel("Sample #")
    plt.ylabel("Gyroscope (deg/sec)")
    plt.legend()
    plt.show()

filename1 = "Circulo.csv"
title1 = "Circulo"
plot_data(filename1, title1)

filename2 = "Levantar.csv"
title2 = "Levantar"
plot_data(filename2, title2)

filename3 = "Estacionario.csv"
title3 = "Estacionario"
plot_data(filename3, title3)

SEED = 1337
np.random.seed(SEED)
tf.random.set_seed(SEED)

GESTURES = [
    "Circulo",
    "Levantar",
    "Estacionario"
]

SAMPLES_PER_GESTURE = 119

NUM_GESTURES = len(GESTURES)

ONE_HOT_ENCODED_GESTURES = np.eye(NUM_GESTURES)

inputs = []
outputs = []

for gesture_index in range(NUM_GESTURES):
  gesture = GESTURES[gesture_index]
  print(f"Processing index {gesture_index} for gesture '{gesture}'.")
  
  output = ONE_HOT_ENCODED_GESTURES[gesture_index]
  
  df = pd.read_csv(gesture + ".csv")
  
  num_recordings = int(df.shape[0] / SAMPLES_PER_GESTURE)
    
  for i in range(num_recordings):
    tensor = []
    for j in range(SAMPLES_PER_GESTURE):
      index = i * SAMPLES_PER_GESTURE + j
    
      tensor += [
          (df['X'][index] + 2000) / 4000,
          (df['Y'][index] + 2000) / 4000,
          (df['Z'][index] + 2000) / 4000
      ]

    inputs.append(tensor)
    outputs.append(output)

inputs = np.array(inputs)
outputs = np.array(outputs)

num_inputs = len(inputs)
randomize = np.arange(num_inputs)
np.random.shuffle(randomize)

inputs = inputs[randomize]
outputs = outputs[randomize]

TRAIN_SPLIT = int(0.6 * num_inputs)
TEST_SPLIT = int(0.2 * num_inputs + TRAIN_SPLIT)

inputs_train, inputs_test, inputs_validate = np.split(inputs, [TRAIN_SPLIT, TEST_SPLIT])
outputs_train, outputs_test, outputs_validate = np.split(outputs, [TRAIN_SPLIT, TEST_SPLIT])

model = tf.keras.Sequential()
model.add(tf.keras.layers.Dense(50, activation='relu')) # relu is used for performance
model.add(tf.keras.layers.Dense(15, activation='relu'))
model.add(tf.keras.layers.Dense(NUM_GESTURES, activation='softmax')) # softmax is used, because we only expect one gesture to occur per input
model.compile(optimizer='rmsprop', loss='mse', metrics=['mae'])
history = model.fit(inputs_train, outputs_train, epochs=600, batch_size=1, validation_data=(inputs_validate, outputs_validate))

plt.rcParams["figure.figsize"] = (20,10)

loss = history.history['loss']
val_loss = history.history['val_loss']
epochs = range(1, len(loss) + 1)
plt.plot(epochs, loss, 'g.', label='Training loss')
plt.plot(epochs, val_loss, 'b', label='Validation loss')
plt.title('Training and validation loss')
plt.xlabel('Epochs')
plt.ylabel('Loss')
plt.legend()
plt.show()

print(plt.rcParams["figure.figsize"])

converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

open("gesture_model.tflite", "wb").write(tflite_model)

