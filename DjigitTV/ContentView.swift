//
//  ContentView.swift
//  DjigitTV
//
//  Created by Камиль Сулейманов on 10.02.2021.
//

import SwiftUI
import Network

struct ContentView: View {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    @State var noInternetConnection = false
    @StateObject var store = Store()
    @State private var showSplashScreen = true
    
    var body: some View { 
        VStack {
            if showSplashScreen {
                
                VStack {
                    Image("logo")
                            .scaleEffect(1.3)
                        .edgesIgnoringSafeArea(.all)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else  if noInternetConnection {
                
            ZStack {
                
                Image("back")
                    .resizable()
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                    .frame(width:screenWidth)
                    .zIndex(0)
                
                VStack (spacing: 10){
                        Text("УПС!")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .fontWeight(.thin)
                        
                        Text("Нет подключения к интернету")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .fontWeight(.thin)
                        
                        Button(action: {store.getChannels()}, label: {
                            Text("Обновить")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .fontWeight(.thin)
                                .padding(5)
                                .padding(.horizontal)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5).foregroundColor(.white))
                        })
                }
            }
            } else {
                DjigitTV()
                    .transition(.flipFromTop)
                    .animation(.spring())
            }
        }
        .background( Image("back")
                        .resizable()
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                        .frame(width:screenWidth)
                        .zIndex(0))
        .environmentObject(store)
        .onAppear{
         
                store.getChannels()
        
            monitor.start(queue: queue)
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    noInternetConnection = false
                    print("Подкючен к интернет")
                } else {
                    noInternetConnection = true
                    print("Нет связи с интернет")
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showSplashScreen = false
            }
        }
    }
    var splashScreen: some View {
          
        Image("splash")
            .resizable()
            .frame(height: screenHeight)
            .scaledToFill()
          
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
        
    }
}





