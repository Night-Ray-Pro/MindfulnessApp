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


struct VolumeSliderView: UIViewRepresentable {
    func makeUIView(context: Context) -> MPVolumeView {
        let volumeView = MPVolumeView()
        volumeView.showsVolumeSlider = true
        return volumeView
    }
    
    func updateUIView(_ uiView: MPVolumeView, context: Context) {
        // No update needed
    }
}

let songsURL = ["Melodic Piano Atmosphere"]
let artists = ["Bobby Cole"]

struct MusicPlayerControlView: View {
    let length: Int
    let theme: String
    @State private var currentTime: Double = 0
    @State private var totalTime: Double = 236
    @State private var isPlaying: Bool = false
    @State private var audioPlayer: AVAudioPlayer?
    @State private var timer: Timer?
    @State private var volume: Double = 1.0
    @State private var wasPlaying: Bool = false
    @State private var musicLibrary = [String:String]()
    @AppStorage("currentSongIndexx") var currentSongIndex: Int = 0
    
    //let songURL = Bundle.main.url(forResource: "Melodic Piano Atmosphere", withExtension: "mp3")!
    
    var body: some View {

            ZStack{
                
                RoundedRectangle(cornerRadius: 33)
                    .foregroundStyle(.ultraThinMaterial)
                    .preferredColorScheme(.light)
                
                //background graphic setup
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text(songsURL[currentSongIndex])
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .padding(.bottom, 2)
//
                            Text(artists[currentSongIndex])
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                        }
                        .padding(.horizontal, 15)
                        .foregroundStyle(.white)
                        Spacer()
                    }
                    //playlist graphic setup
                    
                    Slider(value: $currentTime, in: 0 ... totalTime, step: 0.1){ edyting in
                        if edyting{
                            stopTimer()
                            if isPlaying{
                                wasPlaying = true
                                togglePlayPause()
                            }
                        }else{
                            updateAudioPlayerTime(newTime: currentTime)
                            startTimer()
                            if wasPlaying{
                                togglePlayPause()
                            }
                            wasPlaying = false
                            
                        }
                        print(edyting)
                    }
                    //
//                    Slider(value:Binding(get:{
//                        self.currentTime
//                    }, set:{ newValue in
//                        self.currentTime = newValue
//                        //
//                        //Add Function
//                        Task{
//                            await updateAudioPlayerTime(newTime: newValue)
//                        }
//                        //
//                    }), in: 0 ... totalTime, step: 1)
//                    .foregroundColor(.black)
                    .onAppear{
                        
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    
                    HStack{
                        Text(formatTime(time: currentTime))
                            .font(.system(size: 15, design: .rounded))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text(formatTime(time: totalTime))
                            .font(.system(size: 15, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal,20)
                    
                    //button graphic setup
                    HStack{
                        
                        Button(action: {
                            skipBackward()
                        }) {
                            Image(systemName: "10.arrow.trianglehead.counterclockwise")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                        }
                        
                        Button(action: {
                            withAnimation {
                                skipToPreviousSong()
                            }
                        }) {
                            Image(systemName: "backward.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36, height: 29)
                                .foregroundColor(.white)
                                .padding(.leading, 30)
                        }
                        
                        Button(action: {
                            togglePlayPause()
                        }) {
                            
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 29, height: 38)
                                .foregroundColor(.white)
                                .padding(.horizontal, 30)
                            
                            
                        }
                        
                        Button(action: {
                            skipToNextSong()
                        }) {
                            Image(systemName: "forward.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36, height: 29)
                                .foregroundColor(.white)
                                .padding(.trailing, 30)
                        }
                        
                        Button(action: {
                            skipForward()
                        }) {
                            Image(systemName: "10.arrow.trianglehead.clockwise")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 20)
                    
                    HStack(alignment: .center){
                        Image(systemName: "speaker.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 14)
                            .foregroundStyle(.white)
                        VolumeSliderView()
                            .frame(height: 14)
//                            .background(.red)
                            .padding(.bottom,5)
                        
//                            .background(.red)
//                            .frame(height: 50)
                        
//                        Slider(value:Binding(get:{
//                            self.volume
//                        }, set:{ newValue in
//                            self.volume = newValue
//                            //
//                            //Add Function
//                            updateAudioPlayerVolume(newVolume: newValue)
//                            //
//                        }), in: 0 ... 1, step: 0.01)
//                        .accentColor(.white)
                      
                        
                        Image(systemName: "speaker.wave.3.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 15)
                            .foregroundStyle(.white)
                    }
//                    .frame(minWidth: 12, maxWidth: .infinity)
                    .padding(.horizontal, 30)
                    .padding(.top, 30)
                    //                Button("Test Volume"){
                    //                    guard let player = audioPlayer else {return}
                    //                    player.volume = 0.1
                    //                }
                }
                //            .background(.red)
                //            .padding(.horizontal,30)
                //            .background(.blue)
            }
            
            .frame(width: 356, height: 299)
            .padding(.bottom, 19)
            .onAppear {
                setupAudioPlayer()
                togglePlayPause()
//                startTimer()
                let thumbImage = UIImage(systemName: "circle.fill")?
                    .withTintColor(.white, renderingMode: .alwaysOriginal)
                    .resized(to: CGSize(width: 18, height: 18))
               
                UISlider.appearance().setThumbImage(thumbImage, for: .normal)
                UISlider.appearance().minimumTrackTintColor = .white
                UISlider.appearance().maximumTrackTintColor = .lightGray
            }
            .onDisappear {
                stopAudio()
            }
            .onChange(of: audioPlayer?.isPlaying) {
//                startTimer()
            }
            
            
        
    }
    
    func formatTime(time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func setupAudioPlayer() {
        startTimer()
        guard let songURL = Bundle.main.url(forResource: songsURL[currentSongIndex], withExtension: "mp3") else {
            print("Error: Song file not found")
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: songURL)
            audioPlayer?.prepareToPlay()
            totalTime = audioPlayer?.duration ?? 0
        } catch {
            print("Error loading audio file")
        }
    }
    
    func startTimer() {
        print("Timer has started")
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            guard let player = audioPlayer else { return }
            currentTime = player.currentTime
        }
    }
    
    func stopTimer() {
        print("Timer has stopped")
        timer?.invalidate()
        timer = nil
    }
    
    func togglePlayPause() {
        guard let player = audioPlayer else {return}
        if isPlaying {
//            stopTimer()
            player.pause()
        } else {
//            startTimer()
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
            stopTimer()
            stopAudio()
            currentSongIndex = (currentSongIndex + 1) % songsURL.count
            setupAudioPlayer()
            togglePlayPause()
        }
    }
    
    func skipToPreviousSong() {
        Task {
            togglePlayPause()
            stopTimer()
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
//        togglePlayPause()
        player.currentTime = newTime
//        togglePlayPause()
    }
    
    func updateAudioPlayerVolume(newVolume: Double){
        guard let player = audioPlayer else {return}
        player.volume = Float(newVolume)
       
    }
    
    func setupMusicLibrary(){
        switch length{
        case 5:
            musicLibrary = theme == "relax_5" ? ["relax_5" : "a"] : ["relax_5_2" : "b"]
        case 10:
            musicLibrary = theme == "relax_10" ? ["relax_10" : "c"] : ["relax_10_2" : "d"]
        case 15:
            musicLibrary = theme == "relax_15" ? ["relax_15" : "e"] : ["relax_15_2" : "f"]
        case 20:
            musicLibrary = theme == "relax_20" ? ["relax_20" : "g"] : ["relax_20_2" : "h"]
        default:
            musicLibrary = theme == "relax_5" ? ["relax_5" : "a"] : ["relax_5_2" : "b"]
        }
    }
}

#Preview {
    MusicPlayerControlView(length: 5, theme: "relax")
}
