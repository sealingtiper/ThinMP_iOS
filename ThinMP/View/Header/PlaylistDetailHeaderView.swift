//
//  PlaylistDetailHeaderView.swift
//  ThinMP
//
//  Created by tk on 2021/04/11.
//

import MediaPlayer
import SwiftUI

struct PlaylistDetailHeaderView: View {
    @Binding var headerRect: CGRect
    let side: CGFloat
    let top: CGFloat
    let name: String?
    let artwork: MPMediaItemArtwork?

    var body: some View {
        ZStack(alignment: .bottom) {
            Image(uiImage: self.artwork?.image(at: CGSize(width: self.side, height: self.side)) ?? UIImage(imageLiteralResourceName: "Song"))
                .resizable()
                .scaledToFit()
            LinearGradient(gradient: Gradient(colors: [Color(Color.RGBColorSpace.sRGB, red: 1, green: 1, blue: 1, opacity: 0), Color(UIColor.systemBackground)]), startPoint: .top, endPoint: .bottom)
                .frame(height: 200)
            GeometryReader { primaryTextGeometry in
                self.createPrimaryTextView(primaryTextGeometry: primaryTextGeometry)
            }
            .frame(height: StyleConstant.Height.row)
            .offset(y: -40)
            self.createSecondaryTextView()
        }
        .frame(width: side, height: side)
    }

    private func createPrimaryTextView(primaryTextGeometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.headerRect = primaryTextGeometry.frame(in: .global)
        }

        return VStack {
            TitleView(self.name).opacity(textOpacity())
        }
        .frame(width: abs(side - (StyleConstant.button * 2)), height: StyleConstant.Height.row)
        .padding(.leading, StyleConstant.button)
        .padding(.trailing, StyleConstant.button)
    }

    private func createSecondaryTextView() -> some View {
        return VStack {
            SecondaryTextView("Playlist").opacity(textOpacity())
        }
        .frame(width: abs(side - (StyleConstant.button * 2)), height: 25, alignment: .center)
        .offset(y: -30)
        .animation(.easeInOut)
        .padding(.leading, StyleConstant.button)
        .padding(.trailing, StyleConstant.button)
    }

    private func textOpacity() -> Double {
        if headerRect.origin.y - top > 0 {
            return 1
        }

        return 0
    }
}
