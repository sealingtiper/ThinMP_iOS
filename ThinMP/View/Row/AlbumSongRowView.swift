//
//  AlbumSongRowView.swift
//  ThinMP
//
//  Created by tk on 2020/01/20.
//

import SwiftUI
import MediaPlayer

struct AlbumSongRowView: View {
    @EnvironmentObject var musicState: MusicState
    var list: [MPMediaItemCollection]
    var index: Int
    var song: MPMediaItemCollection
    
    init(list: [MPMediaItemCollection], index: Int) {
        self.list = list
        self.index = index
        self.song = list[index]
    }
    
    var body: some View {
        Button(action: {
            let musicService = MusicService.sharedInstance()
            musicService.start(list: self.list, currentIndex: self.index)
            self.musicState.start(song: self.song)
        }) {
            HStack {
                PrimaryTextView(song.representativeItem?.title)
                Spacer()
            }.padding(.top, 5)
        }
    }
}
