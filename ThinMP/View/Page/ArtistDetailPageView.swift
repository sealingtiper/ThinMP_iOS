//
//  ArtistDetailPageView.swift
//  ThinMP
//
//  Created by tk on 2020/01/07.
//

import SwiftUI

struct ArtistDetailPageView: View {
    @ObservedObject var artistDetail: ArtistDetailViewModel
    @State private var textRect: CGRect = CGRect()

    init(artist: Artist) {
        self.artistDetail = ArtistDetailViewModel(persistentId: artist.persistentId)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                CustomNavigationBarView(persistentId: self.artistDetail.persistentId, primaryText: self.artistDetail.name, secondaryText: self.artistDetail.meta, side: geometry.size.width, top: geometry.safeAreaInsets.top, textRect: self.$textRect)
                ScrollView{
                    ArtistDetailHeaderView(artistDetail: self.artistDetail, textRect: self.$textRect, side: geometry.size.width, top: geometry.safeAreaInsets.top)
                    VStack(alignment: .leading) {
                        HeaderTextView("Albums")
                            .padding(.leading, 20)
                        ArtistAlbumListView(list: self.artistDetail.albums, width: geometry.size.width)
                            .padding(.bottom, 10)

                        HeaderTextView("Songs")
                            .padding(.leading, 20)
                        ArtistSongListView(list: self.artistDetail.songs)
                            .padding(.leading, 20)
                    }
                }
                .navigationBarHidden(true)
                .navigationBarTitle(Text(""))
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
