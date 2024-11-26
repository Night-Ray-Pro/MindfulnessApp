//
//  MusicPlayerTest.swift
//  MindfulnessApp
//
//  Created by Jakub Kalina on 23/11/2024.
//

import SwiftUI
import AVFoundation
import MediaPlayer
import UIKit

//var player: AVAudioPlayer!
//var isPlaying: Bool = false

let songsURL = ["MeditationMusic"]

struct MusicPlayerTest: View {
    @State private var currentTime: Double = 0
    @State private var totalTime: Double = 236
    @State private var isPlaying: Bool = false
    @State private var audioPlayer: AVAudioPlayer?
    @State private var timer: Timer?
    @State private var volume: Double = 0.5
    
    @AppStorage("currentSongIndex") var currentSongIndex: Int = 0
    
    let songURL = Bundle.main.url(forResource: "MeditationMusic", withExtension: "mp3")!
    
    var body: some View {
        Group{
            //background graphic setup
            VStack{
                //playlist graphic setup
                
//                Slider(value: $currentTime, in: 0 ... totalTime, step: 1)
//
                Slider(value:Binding(get:{
                    self.currentTime
                }, set:{ newValue in
                    self.currentTime = newValue
                    //
                    //Add Function
                    updateAudioPlayerTime(newTime: newValue)
                    //
                }), in: 0 ... totalTime, step: 1)
                .accentColor(.gray)
                
                .padding(.horizontal)

                HStack{
                    Text(formatTime(time: currentTime))
                        .font(.caption)
                        .foregroundColor(.black.opacity(0.5))
                    
                    Spacer()
                    
                    Text(formatTime(time: totalTime))
                        .font(.caption)
                        .foregroundColor(.black.opacity(0.5))
                }
                .padding(.horizontal)
                
                //button graphic setup
                HStack{
                    
                    Button(action: {
                        skipBackward()
                    }) {
                        Image(systemName: "10.arrow.trianglehead.counterclockwise")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                    }
                    
                    Button(action: {
                        withAnimation(.bouncy) {
                            skipToPreviousSong()
                        }
                    }) {
                        Image(systemName: "backward.fill")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                    }
                    
                    Button(action: {
                        togglePlayPause()
                    }) {
                        ZStack {
                            Circle()
                                .fill(.black.opacity(0.2))
                                .frame(width: 85, height: 85)
                            
                            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.black)
                                .padding()
                        }
                    }
                    
                    Button(action: {
                        skipToNextSong()
                    }) {
                        Image(systemName: "forward.fill")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                    }
                    
                    Button(action: {
                        skipForward()
                    }) {
                        Image(systemName: "10.arrow.trianglehead.clockwise")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                    }
                }
                .padding(.top, 30)
                
                HStack{
                    Image(systemName: "speaker.fill")
                    Slider(value:Binding(get:{
                        self.volume
                    }, set:{ newValue in
                        self.volume = newValue
                        //
                        //Add Function
                        updateAudioPlayerVolume(newVolume: newValue)
                        //
                    }), in: 0 ... 1, step: 0.01)
                    .accentColor(.gray)
                    Image(systemName: "speaker.wave.3.fill")
                }
                .padding()
//                Button("Test Volume"){
//                    guard let player = audioPlayer else {return}
//                    player.volume = 0.1
//                }
            }
            .padding()
        }
        .onAppear {
            setupAudioPlayer()
        }
        .onDisappear {
            stopAudio()
        }
        .onChange(of: audioPlayer?.isPlaying) {
            startTimer()
        }
    }
    
    func formatTime(time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func setupAudioPlayer() {
        guard let songURL = Bundle.main.url(forResource: songsURL[currentSongIndex], withExtension: "mp3") else {
            print("Error: Song file not found")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: songURL)
            audioPlayer?.prepareToPlay()
            totalTime = audioPlayer?.duration ?? 0
        } catch {
            print("Error loading audio file")
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            guard let player = audioPlayer else { return }
            currentTime = player.currentTime
        }
    }
    
    func togglePlayPause() {
        guard let player = audioPlayer else {return}
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
    }
    
    func skipForward() {
        guard let player = audioPlayer else {return}
        togglePlayPause()
        let newTime = min(player.currentTime + 10, totalTime)
        player.currentTime = newTime
        currentTime = newTime
        togglePlayPause()
    }
    
    func skipBackward() {
        
        guard let player = audioPlayer else {return}
        togglePlayPause()
        let newTime = max(player.currentTime - 10, 0)
        player.currentTime = newTime
        currentTime = newTime
        togglePlayPause()
    }
    
    func skipToNextSong() {
        Task {
            togglePlayPause()
            stopAudio()
            currentSongIndex = (currentSongIndex + 1) % songsURL.count
            setupAudioPlayer()
            togglePlayPause()
        }
    }
    
    func skipToPreviousSong() {
        Task {
            togglePlayPause()
            stopAudio()
            currentSongIndex = (currentSongIndex - 1 + songsURL.count) % songsURL.count
            setupAudioPlayer()
            togglePlayPause()
        }
    }
    
    func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    func updateAudioPlayerTime(newTime: Double){
        guard let player = audioPlayer else {return}
        togglePlayPause()
        player.currentTime = newTime
        togglePlayPause()
    }
    
    func updateAudioPlayerVolume(newVolume: Double){
        guard let player = audioPlayer else {return}
        player.volume = Float(newVolume)
       
    }
}

#Preview {
    MusicPlayerTest()
}
