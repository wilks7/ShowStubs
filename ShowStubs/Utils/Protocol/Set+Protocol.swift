////
////  Set+Protocol.swift
////  ShowStubs
////
////  Created by Michael on 6/17/23.
////
//
//import Foundation
//import SetlistFMKit
//
//protocol SetProtocol {
//    associatedtype S:SongProtocol
//    var name: String? {get}
//    var songs: [S] {get}
//}
//
//protocol SongProtocol: Equatable {
//    var name: String? {get}
//    var info: String? {get}
//}
//
//
//extension FMSet: SetProtocol {
//    typealias S = FMSong
//    
//    var songs: [S] { self.song }
//}
//extension FMSong: SongProtocol {}
