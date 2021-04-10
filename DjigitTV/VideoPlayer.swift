//
//  ContentView.swift
//  AVPlayer-SwiftUI
//
//  Created by Chris Mash on 11/09/2019.
//  Copyright © 2019 Chris Mash. All rights reserved.
//

import SwiftUI
import AVFoundation


class VideoPlayerUIView: UIView {
    private let player: AVPlayer
    private let playerLayer = AVPlayerLayer()
 
    init(player: AVPlayer) {
        self.player = player
    
        super.init(frame: .zero)
        backgroundColor = .black
        playerLayer.player = player
        layer.addSublayer(playerLayer)

    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
    
        playerLayer.frame = bounds
    }
    
    func cleanUp() {
    
    }
  
}


struct VideoPlayerView: UIViewRepresentable {
    let player: AVPlayer
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoPlayerView>) {
       
    }
    
    func makeUIView(context: UIViewRepresentableContext<VideoPlayerView>) -> UIView {
        let uiView = VideoPlayerUIView(player: player)
        return uiView
    }
    
    static func dismantleUIView(_ uiView: UIView, coordinator: ()) {
        guard let playerUIView = uiView as? VideoPlayerUIView else {
            return
        }
        
        playerUIView.cleanUp()
    }
}


struct VideoPlayerContainerView : View {
    private let player: AVPlayer
    init(url: URL) {
        player = AVPlayer(url: url)
    }
  
    var body: some View {
        VStack {
            VideoPlayerView(player: player)
          
        }
        .onAppear{
            player.play()
        }
        .onDisappear {
            self.player.replaceCurrentItem(with: nil)
        }
    }
}

