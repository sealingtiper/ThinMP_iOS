//
//  AlbumDetailHeaderView.swift
//  ThinMP
//
//  Created by tk on 2020/01/17.
//

import SwiftUI

struct AlbumDetailHeaderView: View {
    @ObservedObject var vm: AlbumDetailViewModel
    @Binding var textRect: CGRect
    
    let side: CGFloat
    let top: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(uiImage: self.vm.artwork?.image(at: CGSize(width: self.side, height: self.side)) ?? UIImage(imageLiteralResourceName: "Song"))
                .resizable()
                .scaledToFit()
            LinearGradient(gradient: Gradient(colors: [Color.init(Color.RGBColorSpace.sRGB, red: 1, green: 1, blue: 1, opacity: 0), Color(UIColor.systemBackground)]), startPoint: .top, endPoint: .bottom)
                .frame(height: 200)
            GeometryReader { primaryTextGeometry in
                self.createPrimaryTextView(primaryTextGeometry: primaryTextGeometry)
            }
            .frame(height: StyleConstant.height.row)
            .offset(y: -40)
            self.createSecondaryTextView()
        }
        .frame(width: side, height: side)
    }

    private func createPrimaryTextView(primaryTextGeometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.textRect = primaryTextGeometry.frame(in: .global)
        }
        
        return VStack {
            SecondaryTitleView(self.vm.primaryText).opacity(textOpacity())
        }
        .frame(width: side - (StyleConstant.button * 2), height: StyleConstant.height.row)
        .padding(.leading, StyleConstant.button)
        .padding(.trailing, StyleConstant.button)
    }
    
    private func createSecondaryTextView() -> some View {
        return VStack {
            SecondaryTextView(self.vm.secondaryText).opacity(textOpacity())
        }
        .frame(width: side - (StyleConstant.button * 2), height: 25, alignment: .center)
        .offset(y: -30)
        .animation(.easeInOut)
        .padding(.leading, StyleConstant.button)
        .padding(.trailing, StyleConstant.button)
    }
    
    private func textOpacity() -> Double {
        if (textRect.origin.y - self.top > 0) {
            return 1
        }
        
        return 0
    }
}
