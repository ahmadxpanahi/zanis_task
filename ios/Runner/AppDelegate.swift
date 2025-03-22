import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    let weatherController = WeatherController()
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
    let controller: FlutterViewController = window?.rootViewController as!
    FlutterViewController
    let eventChannel = FlutterEventChannel(
    name: "ZANIS-CHANNEL", binaryMessenger: controller.binaryMessenger
    );
      
    // self: extension that i created for Flutter Stream Handler
    eventChannel.setStreamHandler(self)

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

extension AppDelegate: FlutterStreamHandler{
    
    // it will cancel sending data
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        weatherController.stopSendingData()
        return nil
    }
    
    // it will start sending data
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        weatherController.startSendingData(eventSink: events)
        return nil
    }
    
}
