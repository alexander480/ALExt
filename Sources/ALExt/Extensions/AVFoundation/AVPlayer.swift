// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// AVPlayer.swift
// Created by Alexander Lester on 7/5/20.
//

import AVFoundation

public extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
