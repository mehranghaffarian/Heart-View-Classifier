class DLModelModel {
  String name;
  String summary;
  String description;
  String inputSize;
  double accuracy;

  DLModelModel({required this.name, required this.summary, required this.description, required this.inputSize, required this.accuracy});
}

class ModelsList {
  static List<DLModelModel> list = [ // mock data
    DLModelModel(
      name: "EfficientNet",
      summary: "A lightweight and high-accuracy model optimized for mobile and edge devices.",
      description:
      "EfficientNet is a scalable convolutional neural network architecture that balances depth, width, and resolution using a compound scaling method. This model family is known for achieving state-of-the-art accuracy on benchmark datasets like ImageNet while using significantly fewer parameters and FLOPs than other models. EfficientNet's compact size and computational efficiency make it ideal for deployment in mobile health applications such as echocardiography view classification, where both performance and resource usage matter.",
      inputSize: "224x224",
      accuracy: 95.6,
    ),
    DLModelModel(
      name: "ResNet50",
      summary: "A deep residual network model widely used in image classification tasks.",
      description:
      "ResNet50 is a 50-layer deep convolutional neural network that introduced the concept of residual learning. By using shortcut connections (skip connections), it allows the network to learn identity mappings, solving the vanishing gradient problem and enabling the training of much deeper networks. It's commonly used as a strong baseline for various visual recognition tasks, including medical image analysis, and can be fine-tuned for specific applications such as detecting anatomical structures in echocardiographic images.",
      inputSize: "224x224",
      accuracy: 93.2,
    ),
    DLModelModel(
      name: "MobileNetV2",
      summary: "Mobile-friendly CNN with an efficient structure for real-time inference.",
      description:
      "MobileNetV2 is designed for real-time image recognition on devices with limited computational power. It introduces inverted residuals and linear bottlenecks to reduce the number of operations while maintaining high accuracy. This makes it especially useful for applications in mobile healthcare, such as portable ultrasound devices. When applied to echocardiographic view classification, it can provide quick feedback with relatively low latency, even on resource-constrained hardware.",
      inputSize: "224x224",
      accuracy: 91.4,
    ),
    DLModelModel(
      name: "InceptionV3",
      summary: "A multi-path architecture that captures different spatial features efficiently.",
      description:
      "InceptionV3 is a deep convolutional neural network architecture that improves computational efficiency and accuracy through carefully designed modules that allow multiple convolutional operations at various scales to be performed in parallel. It incorporates techniques like factorized convolutions and auxiliary classifiers, making it effective for recognizing complex patterns. In the context of echocardiography, its wide receptive field and rich feature extraction capabilities make it suitable for classifying subtle differences between heart views.",
      inputSize: "299x299",
      accuracy: 94.1,
    ),
    DLModelModel(
      name: "CustomCNN",
      summary: "A handcrafted CNN architecture designed for echocardiogram view classification.",
      description:
      "This custom convolutional neural network was specifically designed and trained for the classification of heart views in echocardiographic images. Unlike general-purpose models, it has been optimized for recognizing the unique anatomical structures present in cardiac ultrasound data. Its architecture was developed with domain-specific knowledge, allowing it to achieve high performance on clinical data while remaining interpretable and suitable for integration into specialized healthcare tools and diagnostic systems.",
      inputSize: "128x128",
      accuracy: 89.7,
    ),
  ];
}
