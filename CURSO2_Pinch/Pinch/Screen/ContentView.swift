//
//  ContentView.swift
//  Pinch
//
//  Created by skynet on 5/4/22.
//  https://credo.academy
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY

    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero

    // MARK: - FUNCTION

    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }


    // MARK: - CONTENT

    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                // MARK: - IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                    .onTapGesture {
                    if imageScale == 1 {
                        withAnimation(.spring()) {
                            imageScale = 5
                        }
                    } else {
                      resetImageState()
                    }

                }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = value.translation
                                }
                            }
                            .onEnded { _ in
                                if imageScale <= 1 {
                                   resetImageState()
                                }

                            }
                    )
            }
                .navigationTitle("Pinch & zoom")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
                .overlay(
                    InfoPanelView(scale: imageScale, offset: imageOffset)
                        .padding(.horizontal)
                        .padding(.top, 30)
                    , alignment: .top
                )
        }
            .navigationViewStyle(.stack)
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 13")
    }
}