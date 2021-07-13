//
//  AlbumDetailPageView.swift
//  ThinMP
//
//  Created by tk on 2020/01/12.
//

import MediaPlayer
import SwiftUI

struct AlbumDetailPageView: View {
    @StateObject private var vm = AlbumDetailViewModel()
    @State private var headerRect = CGRect.zero
    @State private var showingPopup: Bool = false
    @State private var playlistRegisterSongId = SongId(id: 0)

    let albumId: AlbumId

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    ZStack(alignment: .top) {
                        DetaiNavBarView(primaryText: vm.primaryText, side: geometry.size.width, top: geometry.safeAreaInsets.top, headerRect: self.$headerRect) {
                            MenuButtonView {
                                VStack {
                                    ShortcutButtonView(itemId: albumId.id, type: ShortcutType.ALBUM)
                                }
                            }
                        }
                        ScrollView(showsIndicators: true) {
                            VStack(alignment: .leading) {
                                AlbumDetailHeaderView(vm: vm, headerRect: self.$headerRect, side: geometry.size.width, top: geometry.safeAreaInsets.top)
                                LazyVStack(spacing: 0) {
                                    ForEach(vm.songs.indices, id: \.self) { index in
                                        PlayRowView(list: vm.songs, index: index) {
                                            MediaRowView(media: vm.songs[index])
                                        }
                                        .contextMenu {
                                            FavoriteSongButtonView(songId: vm.songs[index].songId)
                                            Button(action: {
                                                playlistRegisterSongId = vm.songs[index].songId
                                                showingPopup.toggle()
                                            }) {
                                                Text("AddPlaylist")
                                            }
                                        }
                                        Divider()
                                    }.padding(.leading, StyleConstant.Padding.medium)
                                }
                            }
                        }
                    }
                    MiniPlayerView(bottom: geometry.safeAreaInsets.bottom)
                }
                if showingPopup {
                    PopupView(showingPopup: self.$showingPopup) {
                        PlaylistRegisterView(songId: playlistRegisterSongId, height: geometry.size.height, showingPopup: self.$showingPopup)
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitle(Text(""))
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                vm.load(albumId: albumId)
            }
        }
    }
}
