//
//  API.swift
//  DjigitTV
//
//  Created by Камиль Сулейманов on 09.04.2021.
//

import SwiftUI

class Store: ObservableObject{
    @Published var channels: [channel] = []
    
    func getChannels() {
        guard let url = URL(string: "https://djigit-tv.ru/playlist.php") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data =  try? Data(contentsOf: url){
                let decoder = JSONDecoder()
                
                if let jsonChannels = try? decoder.decode([channel].self, from: data){
                
                DispatchQueue.main.async {
                    self.channels = jsonChannels
                    print("Получил данные с API")
                }
            }
            }
        }
        .resume()
    }
}


