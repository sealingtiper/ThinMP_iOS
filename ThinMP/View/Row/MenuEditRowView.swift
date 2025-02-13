//
//  MenuEditRowView.swift
//  ThinMP
//
//  Created by tk on 2021/06/12.
//

import MediaPlayer
import SwiftUI

struct MenuEditRowView: View {
    private let size: CGFloat = 40

    @ObservedObject var menu: MenuModel

    init(menu: MenuModel) {
        self.menu = menu
    }

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                CheckboxButton().renderingMode(.original)
                MenuRowView(text: menu.primaryText)
                Spacer()
            }
            .onTapGesture {
                menu.toggleVisibility()
            }
        }
    }

    private func CheckboxButton() -> Image {
        if menu.visibility {
            return Image("CheckboxOn")
        } else {
            return Image("CheckboxOff")
        }
    }
}
