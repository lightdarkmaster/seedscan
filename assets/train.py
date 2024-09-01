import os
import tensorflow as tf
from tensorflow.keras.preprocessing.image import ImageDataGenerator

# Define data directories
train_dir = 'D:/cornseeds/OneDrive_1_2-7-2024/data_17K/data/train'
test_dir = 'D:/cornseeds/OneDrive_1_2-7-2024/data_17K/data/validation'

# Parameters
batch_size = 32
input_shape = (150, 150, 3)  # Adjust image dimensions as needed
num_classes = len(os.listdir(train_dir))

# Data preprocessing
train_datagen = ImageDataGenerator(rescale=1./255)
test_datagen = ImageDataGenerator(rescale=1./255)

train_generator = train_datagen.flow_from_directory(
    train_dir,
    target_size=(input_shape[0], input_shape[1]),
    batch_size=batch_size,
    class_mode='categorical')

test_generator = test_datagen.flow_from_directory(
    test_dir,
    target_size=(input_shape[0], input_shape[1]),
    batch_size=batch_size,
    class_mode='categorical')

# Create labels.txt file
class_names = sorted(train_generator.class_indices.keys())
with open('labels.txt', 'w') as f:
    for class_name in class_names:
        f.write(class_name + '\n')

# Model architecture
model = tf.keras.Sequential([
    tf.keras.layers.Conv2D(32, (3, 3), activation='relu', input_shape=input_shape),
    tf.keras.layers.MaxPooling2D((2, 2)),
    tf.keras.layers.Conv2D(64, (3, 3), activation='relu'),
    tf.keras.layers.MaxPooling2D((2, 2)),
    tf.keras.layers.Conv2D(128, (3, 3), activation='relu'),
    tf.keras.layers.MaxPooling2D((2, 2)),
    tf.keras.layers.Flatten(),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(num_classes, activation='softmax')
])

# Compile the model
model.compile(optimizer='adam',
              loss='categorical_crossentropy',
              metrics=['accuracy'])

# Train the model
model.fit(train_generator,
          epochs=10,
          validation_data=test_generator)

# Convert the model to TFLite
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

# Save the TFLite model to a file
with open('model.tflite', 'wb') as f:
    f.write(tflite_model)
