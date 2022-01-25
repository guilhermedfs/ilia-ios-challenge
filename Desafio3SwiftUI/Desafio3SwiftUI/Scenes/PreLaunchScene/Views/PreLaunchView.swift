//
//  PreLaunchView.swift
//  Desafio3SwiftUI
//
//  Created by Guilherme - ília on 25/01/22.
//

import SwiftUI



struct PreLaunchView: View {
    let backgroundColor = Color(red: 0.071, green: 0.306, blue: 0.471) // #124e78
    let titleColor = Color(red: 0.851, green: 0.016, blue: 0.161) // #d90429
    @State private var showMainView: Bool = false
    @State private var angle: Double = 360
    @State private var opacity: Double = 1
    @State private var scale: CGFloat = 1
    
    var body: some View {
        Group {
            if showMainView {
                InitialView()
            } else {
                ZStack {
                    navbarColor
                        .ignoresSafeArea(.all)
                    Image(systemName: "play.tv.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .foregroundColor(titleColor)
                        .rotation3DEffect(.degrees(angle), axis: (x: 1.0, y: 0.0, z: 0.0))
                        .scaleEffect(scale)
                }
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 2)) {
                angle = 0
                scale = 1
                opacity = 0
            }
            withAnimation(.linear.delay(2.30)) {
                showMainView = true
            }
        }
    }
}

struct PreLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        PreLaunchView()
    }
}
