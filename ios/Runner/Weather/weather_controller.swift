import Flutter

class WeatherController: NSObject {
    private var eventSink: FlutterEventSink?
    private var timer: Timer?
    
    
    // This function will send data to the flutter every 4 seconds
    func startSendingData(eventSink: @escaping FlutterEventSink){
        
        self.eventSink = eventSink
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true){
            _ in
            let weatherModel = WeatherModel(
                temperature: Double.random(in: 20...35), humidity: Double.random(in: 40...60)
            )
            
            // here data will set to json and send to the flutter
            
            if let jsonData = try? JSONEncoder().encode(weatherModel),
               let jsonString = String(data: jsonData, encoding: .utf8){
                eventSink(jsonString)
            }
        }
        
    }
    
    func stopSendingData(){
        timer?.invalidate()
        eventSink?("Stopped Sending Data")
    }
    
}

