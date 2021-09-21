//
//  ContentView.swift
//  HotProspects
//
//  Created by Kyle Miller on 7/5/21.
//

import SwiftUI

struct ContentView: View {
    var prospects = Prospects()
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
                }
            
            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
                }
            
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
                }
            
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
                }
        }
        .environmentObject(prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





/*
 Adding Swift package dependencies in Xcode
 https://www.hackingwithswift.com/books/ios-swiftui/adding-swift-package-dependencies-in-xcode
 
 import SwiftUI
 import SamplePackage

 struct ContentView: View {
     let possibleNumbers = Array(1...60)
     
     var results: String {
         let selected = possibleNumbers.random(7).sorted()
         let strings = selected.map(String.init)
         return strings.joined(separator: ", ")
     }
     
     var body: some View {
         Text(results)
     }
 }
 */

/*
 Scheduling local notifications
 https://www.hackingwithswift.com/books/ios-swiftui/scheduling-local-notifications
 
 import SwiftUI
 import UserNotifications

 struct ContentView: View {
     
     var body: some View {
         VStack {
             Button("Request Permission") {
                 UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                     if success {
                         print("All set!")
                     } else if let error = error {
                         print(error.localizedDescription)
                     }
                 }
             }
             
             Button("Schedule Notification") {
                 let content = UNMutableNotificationContent()
                 content.title = "Feed the cat"
                 content.subtitle = "It looks hungry"
                 content.sound = UNNotificationSound.default
                 
                 let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                 
                 let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                 
                 UNUserNotificationCenter.current().add(request)
             }
         }
     }
 }
 */

/*
 Creating context menus - Long hold on screen menu
 https://www.hackingwithswift.com/books/ios-swiftui/creating-context-menus
 
 struct ContentView: View {
     @State private var backgroundColor = Color.red
     
     var body: some View {
         VStack {
             Text("Hello, World!")
                 .padding()
                 .background(backgroundColor)
             
             Text("Change Color")
                 .padding()
                 .contextMenu {
                     Button(action: {
                         self.backgroundColor = .red
                     }) {
                         Text("Red")
                         Image(systemName: "checkmark.circle.fill")
                             .foregroundColor(.red)
                     }
                     Button(action: {
                         self.backgroundColor = .green
                     }) {
                         Text("Green")
                     }
                     Button(action: {
                         self.backgroundColor = .blue
                     }) {
                         Text("Blue")
                     }
                 }
         }
     }
 }
 */


/*
 Manually publishing ObservableObject changes
 https://www.hackingwithswift.com/books/ios-swiftui/manually-publishing-observableobject-changes
 
 class DelayedUpdater: ObservableObject {
     var value = 0 {
         willSet {
             objectWillChange.send()
         }
     }
     
     init() {
         for i in 1...10 {
             DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                 self.value += 1
             }
         }
     }
 }

 struct ContentView: View {
     @ObservedObject var updater = DelayedUpdater()
     
     var body: some View {
         Text("Value is: \(updater.value)")
     }
 }
 */


/*
 Understanding Swift’s Result type
 https://www.hackingwithswift.com/books/ios-swiftui/understanding-swifts-result-type
 
 import SwiftUI

 enum NetworkError: Error {
     case badURL, requestFailed, unknown
 }


 struct ContentView: View {

     
     var body: some View {
         Text("Hello, World!")
             .onAppear {
                 self.fetchData(from: "https://www.apple.com") { result in
                     switch result {
                     case .success(let str):
                         print(str)
                     case .failure(let error):
                         switch error {
                         case .badURL:
                             print("Bad URL")
                         case .requestFailed:
                             print("Network problems")
                         case .unknown:
                             print("Unknown error")
                         }
                     }
                 }
             }
     }
     
     func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
         // check the URL is OK, otherwise return with a failure
         guard let url = URL(string: urlString) else {
             completion(.failure(.badURL))
             return
         }
         
         URLSession.shared.dataTask(with: url) { data, response, error in
             // the task has completed – push our work back to the main thread
             DispatchQueue.main.async {
                 if let data = data {
                     // success: convert the data to a string and send it back
                     let stringData = String(decoding: data, as: UTF8.self)
                     completion(.success(stringData))
                 } else if error != nil {
                     // any sort of network failure
                     completion(.failure(.requestFailed))
                 } else {
                     // this ought not to be possible, yet here we are
                     completion(.failure(.unknown))
                 }
             }
         }.resume()
     }
     
 }
 */


/*
 Creating tabs with TabView and tabItem()
 https://www.hackingwithswift.com/books/ios-swiftui/creating-tabs-with-tabview-and-tabitem
 
 
 struct ContentView: View {
     @State private var selectedTab = 0
     
     var body: some View {
         TabView(selection: $selectedTab) {
             Text("Tab 1")
                 .onTapGesture {
                     self.selectedTab = 1
                 }
                 .tabItem {
                     Image(systemName: "star")
                     Text("One")
                 }
             Text("Tab 2")
                 .tabItem {
                     Image(systemName: "star.fill")
                     Text("Two")
                 }
                 .tag(1)
         }
     }
 }
 */


/*
 Reading custom values from the environment with @EnvironmentObject
 https://www.hackingwithswift.com/books/ios-swiftui/reading-custom-values-from-the-environment-with-environmentobject
 
 class User: ObservableObject {
     @Published var name = "Taylor Swift"
 }

 struct EditView: View {
     @EnvironmentObject var user: User
     
     var body: some View {
         TextField("Name", text: $user.name)
     }
 }

 struct DisplayView: View {
     @EnvironmentObject var user: User
     
     var body: some View {
         Text(user.name)
     }
 }

 struct ContentView: View {
     let user = User()
     
     var body: some View {
         VStack {
             EditView()
             DisplayView()
         }
         .environmentObject(user)
     }
 }
 */
