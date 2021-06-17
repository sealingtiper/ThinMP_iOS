//
//  PlaylistRegisterView.swift
//  ThinMP
//
//  Created by tk on 2021/04/01.
//

import SwiftUI
import MediaPlayer

struct PlaylistRegisterView: View {
    private let CREATE_TEXT: String = "プレイリストを作成"
    private let INPUT_TEXT: String = "プレイリスト名を入力"
    private let OK_TEXT: String = "OK"
    private let CANCEL_TEXT: String = "CANCEL"
    private let headerHeight: CGFloat = 60
    private let rowHeight: CGFloat = 50
    private let outerPadding: CGFloat = 20
    private let innerPadding: CGFloat = 10
    private let dividerHeight: CGFloat = 0.5

    @StateObject var vm = PlaylistsViewModel()
    @State private var isCreate: Bool = false
    @State private var name: String = ""

    let persistentId: MPMediaEntityPersistentID
    let height: CGFloat
    @Binding var showingPopup: Bool

    func getHeight() -> CGFloat? {
        let panelHeight = headerHeight + (CGFloat(vm.playlists.count) * (rowHeight + dividerHeight)) + innerPadding

        if (panelHeight > height) {
            return height
        } else {
            return panelHeight
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            if (vm.playlists.count != 0 && !isCreate) {
                VStack(spacing: 0) {
                    HStack() {
                        Spacer()
                        Button(action: {
                            isCreate.toggle()
                        }) {
                            Text(CREATE_TEXT)
                        }
                        Spacer()
                        Button(action: {
                            showingPopup.toggle()
                        }) {
                            Text(CANCEL_TEXT)
                        }
                        Spacer()
                    }
                    .frame(height: headerHeight)
                    ScrollView() {
                        LazyVStack(spacing: 0) {
                            ForEach(vm.playlists) { playlist in
                                PlaylistAddRowView(playlistId: playlist.id, persistentId: persistentId, showingPopup: $showingPopup) {
                                    MediaRowView(media: playlist)
                                }
                                .frame(height: rowHeight)
                                Divider().frame(height: dividerHeight)
                            }
                        }
                    }
                }
                .padding(.bottom, innerPadding)
                .frame(height: getHeight())
            } else {
                VStack(spacing: 0) {
                    Text(INPUT_TEXT)
                        .frame(height: rowHeight)
                    TextField("", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    HStack {
                        Spacer()
                        Button(action: {
                            let playlistRegister = PlaylistRegister()

                            playlistRegister.create(persistentId: persistentId, name: name)
                            showingPopup.toggle()
                        }) {
                            Text(OK_TEXT)
                        }
                        Spacer()
                        Button(action: {
                            if (vm.playlists.count > 0) {
                                isCreate.toggle()
                            } else {
                                showingPopup.toggle()
                            }
                        }) {
                            Text(CANCEL_TEXT)
                        }
                        Spacer()
                    }
                    .frame(height: rowHeight)
                }
                .padding(.horizontal, innerPadding)
            }
        }
        .frame(width: .infinity)
        .padding(.horizontal, innerPadding)
        .background(Color.white)
        .cornerRadius(4)
        .padding(.horizontal, outerPadding)
        .onAppear() {
            vm.load()
        }
    }
}
