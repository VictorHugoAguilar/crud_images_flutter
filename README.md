# App Productos con Imágenes

Proyecto en flutter, una app con crud de imágenes, con login, para subir imagenes, utilizando Firebase, y Cloudinary.

## Capturas de la App

![Login de la Aplicación](https://github.com/VictorHugoAguilar/crud_images_flutter/blob/main/assets/preview/previewLogin.png?raw=true)

![Agregar un producto](https://github.com/VictorHugoAguilar/crud_images_flutter/blob/main/assets/preview/previewAddProduct.png?raw=true)

![Home de los productos](https://github.com/VictorHugoAguilar/crud_images_flutter/blob/main/assets/preview/previewHomePage.png?raw=true)

![Actualizar un producto](https://github.com/VictorHugoAguilar/crud_images_flutter/blob/main/assets/preview/previewUpdateProduct.png?raw=true)

![Eliminar un producto](https://github.com/VictorHugoAguilar/crud_images_flutter/blob/main/assets/preview/previewDeleteProduct.png?raw=true)

## Dependencias utilizadas

- [rxdart](https://pub.dev/packages/rxdart):
    RxDart adds additional capabilities to Dart Streams and StreamControllers.
    Dart comes with a very decent Streams API out-of-the-box; rather than attempting to provide an alternative to this API, RxDart adds functionality from the reactive extensions specification on top of it.
    RxDart does not provide its own Observable class as a replacement for Dart Streams. Rather, it provides a number of additional Stream classes, operators (extension methods on the Stream class), and Subjects.
    If you are familiar with Observables from other languages, please see the Rx Observables vs Dart    Streams comparison chart for notable distinctions between the two.

- [http](https://pub.dev/packages/http):
    This package contains a set of high-level functions and classes that make it easy to consume HTTP resources. It's multi-platform, and supports mobile, desktop, and the browser.

- [image_picker](https://pub.dev/packages/image_picker): 
    A Flutter plugin for iOS and Android for picking images from the image library, and taking new pictures with the camera.
    
    iOS 
    Add the following keys to your Info.plist file, located in <project root>/ios/Runner/Info.plist:
    NSPhotoLibraryUsageDescription - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.
    NSCameraUsageDescription - describe why your app needs access to the camera. This is called Privacy - Camera Usage Description in the visual editor.
    NSMicrophoneUsageDescription - describe why your app needs access to the microphone, if you intend to record videos. This is called Privacy - Microphone Usage Description in the visual editor.

    Android 
    API 29+
    No configuration required - the plugin should work out of the box.

    API < 29
    Add android:requestLegacyExternalStorage="true" as an attribute to the <application> tag in AndroidManifest.xml. The attribute is false by default on apps targeting Android Q.

- [mime_type](https://pub.dev/packages/mime_type):
        Library to get MIME type from a file name or a file path and get the file extension from a MIME type. When a HTTP server sends a file to the client, MIME type of the file must be set to the Content-Type header of the response.

- [shared_preferences](https://pub.dev/packages/shared_preferences):
        Wraps platform-specific persistent storage for simple data (NSUserDefaults on iOS and macOS, SharedPreferences on Android, etc.). Data may be persisted to disk asynchronously, and there is no guarantee that writes will be persisted to disk after returning, so this plugin must not be used for storing critical data.


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

#

 ⌨️ con ❤️ por [VictorHugo](https://github.com/VictorHugoAguilar) 😊 
