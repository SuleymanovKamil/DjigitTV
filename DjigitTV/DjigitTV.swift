//
//  DjigitTV.swift
//  DjigitTV
//
//  Created by Камиль Сулейманов on 09.04.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct DjigitTV: View {
    @EnvironmentObject var store: Store
    @State private var play = false
    @State private var  url = "1"
    @State private var showControls = true
    
    var body: some View {
        GeometryReader { bounds in
            if play{
                ZStack (alignment: Alignment(horizontal: .trailing, vertical: .top)){
                    
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.white.opacity(0.7))
                        .frame(width: 40, height: 34)
                        .contentShape(Circle())
                        .onTapGesture {
                            withAnimation(.spring()){
                                play = false
                            }
                        }
                        .offset(x: -15, y: 25)
                        .opacity(showControls ? 1 : 0)
                        .zIndex(1)
                    
                    VideoPlayerContainerView(url: URL(string: url)!)
                        .frame(width: bounds.size.width, height: bounds.size.height)
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                showControls = false
                            }
                        }
                }
                .transition(.flipFromBottom)
                .onTapGesture {
                    showControls = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        showControls = false
                        
                    }
                }
                .background(Color.black.ignoresSafeArea())
                .zIndex(1)
            } else {
                
                ZStack (alignment: Alignment(horizontal: .leading, vertical: .top)) {
                    
                    Image("logo")
                    
                    VStack{
                        HStack {
                            Spacer()
                            Button(action: {
                                    print("tap")}, label: {
                                        Image("what")
                                            .contentShape(Circle())
                                    })
                        }
                        .padding(.top, 30)
                        .padding(.trailing, 20)
                        
                        Spacer()
                        
                        VStack {
                            
                            Spacer()
                            
                            ScrollView (.horizontal, showsIndicators: false){
                                HStack (spacing:  40){
                                    Spacer()
                                    ForEach(store.channels, id: \.self) { channel in
                                        GeometryReader { geo in
                                            
                                            let x = geo.frame(in: CoordinateSpace.global).origin.x
                                            
                                            VStack (spacing: 30){
                                                
                                                WebImage(url: URL(string: channel.img))
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth * 0.35, height: screenHeight * 0.5)
                                                    .scaleEffect( x < screenWidth * 0.6  && x > screenWidth * 0.25 ?  1.15 : 1)
                                                    .animation(.spring())
                                                    .shadow(color: Color.black.opacity(0.6), radius: 6, x: 6, y: 6)
                                                    .shadow(color: Color.black.opacity(0.4), radius: 6, x: 6, y: 6)
                                                
                                            }
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    url = channel.url
                                                    play = true
                                                }
                                            }
                                        }
                                        .frame(width: screenWidth * 0.35, height: screenHeight * 0.5)
                                        .padding(.vertical, 70)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 30)
                            }
                            .frame(height: screenHeight * 0.5)
                            
                            Spacer()
                        }
                    }
                }
                .transition(.flipFromTop)
            }
        }
    }
}

struct DjigitTV_Previews: PreviewProvider {
    static var previews: some View {
        DjigitTV()
    }
}

