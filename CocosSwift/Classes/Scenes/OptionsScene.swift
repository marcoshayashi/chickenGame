//
//  OptionsScene.swift
//  CocosSwift
//
//  Created by Ricardo Silverio de Souza on 04/03/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import Foundation
class OptionsScene : CCScene {
    
    // MARK: - Private Objects
    private let screenSize:CGSize = CCDirector.sharedDirector().viewSize()
    var musicPlaying = false

    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        let background:CCSprite = CCSprite(imageNamed: "optionsBackTemp.png")
        background.anchorPoint = CGPointMake(0.5, 0.5)
        background.position = CGPointMake(screenSize.width / 2, screenSize.height / 2)
        self.addChild(background)

        
        let musicVolume = SoundPlayHelper.sharedInstance.getEffectsVolume()
        let effectsVolume = SoundPlayHelper.sharedInstance.getMusicVolume()
        
        let labelTitle:CCLabelTTF = CCLabelTTF(string: "Options", fontName: "Chalkduster", fontSize: 60)
        labelTitle.color = CCColor.redColor()
        labelTitle.position = CGPointMake(self.screenSize.width/2, self.screenSize.height - (self.screenSize.height * 0.2))
        labelTitle.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(labelTitle)

        let labelMusic:CCLabelTTF = CCLabelTTF(string: "Music", fontName: "Chalkduster", fontSize: 36)
        labelMusic.color = CCColor.blueColor()
        labelMusic.position = CGPointMake(self.screenSize.width/2 - (self.screenSize.width * 0.35), self.screenSize.height - (self.screenSize.height * 0.4))
        labelMusic.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(labelMusic)
        
        let muteSpriteMusic:CCSprite = CCSprite(imageNamed: "mute.png")
        muteSpriteMusic.anchorPoint = CGPointMake(0.5, 0.5)
        muteSpriteMusic.position = CGPointMake(self.screenSize.width/2 - (self.screenSize.width * 0.2), self.screenSize.height - (self.screenSize.height * 0.4))
        muteSpriteMusic.scale = 0.7
        self.addChild(muteSpriteMusic)
        
        let sliderMusic:CCSlider = CCSlider(background: CCSpriteFrame.frameWithImageNamed("sliderFull.png") as! CCSpriteFrame, andHandleImage: CCSpriteFrame.frameWithImageNamed("sliderNodeNormal.png") as! CCSpriteFrame)
        sliderMusic.name = "music"
        sliderMusic.setTarget(self, selector: "sliderChanged:")
        sliderMusic.anchorPoint = CGPointMake(0.5, 0.5)
        sliderMusic.position = CGPointMake(self.screenSize.width/2, self.screenSize.height - (self.screenSize.height * 0.4))
        sliderMusic.scale = 1.5
        sliderMusic.sliderValue = musicVolume
        self.addChild(sliderMusic)
        
        let speakerSpriteMusic:CCSprite = CCSprite(imageNamed: "speaker.png")
        speakerSpriteMusic.anchorPoint = CGPointMake(0.5, 0.5)
        speakerSpriteMusic.position = CGPointMake(self.screenSize.width/2 + (self.screenSize.width * 0.2), self.screenSize.height - (self.screenSize.height * 0.4))
        speakerSpriteMusic.scale = 0.7
        self.addChild(speakerSpriteMusic)
        
        
        let labelEffects:CCLabelTTF = CCLabelTTF(string: "Effects", fontName: "Chalkduster", fontSize: 36)
        labelEffects.color = CCColor.purpleColor()
        labelEffects.position = CGPointMake(self.screenSize.width/2 - (self.screenSize.width * 0.35), self.screenSize.height - (self.screenSize.height * 0.6))
        labelEffects.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(labelEffects)
        
        let muteSpriteEffects:CCSprite = CCSprite(imageNamed: "mute.png")
        muteSpriteEffects.anchorPoint = CGPointMake(0.5, 0.5)
        muteSpriteEffects.position = CGPointMake(self.screenSize.width/2 - (self.screenSize.width * 0.2), self.screenSize.height - (self.screenSize.height * 0.6))
        muteSpriteEffects.scale = 0.7
        self.addChild(muteSpriteEffects)
        
        let sliderEffects:CCSlider = CCSlider(background: CCSpriteFrame.frameWithImageNamed("sliderFull.png") as! CCSpriteFrame, andHandleImage: CCSpriteFrame.frameWithImageNamed("sliderNodeNormal.png") as! CCSpriteFrame)
        sliderEffects.name = "effects"
        sliderEffects.setTarget(self, selector: "sliderChanged:")
        sliderEffects.anchorPoint = CGPointMake(0.5, 0.5)
        sliderEffects.position = CGPointMake(self.screenSize.width/2, self.screenSize.height - (self.screenSize.height * 0.6))
        sliderEffects.scale = 1.5
        sliderEffects.sliderValue = effectsVolume
        self.addChild(sliderEffects)
        
        let speakerSpriteEffect:CCSprite = CCSprite(imageNamed: "speaker.png")
        speakerSpriteEffect.anchorPoint = CGPointMake(0.5, 0.5)
        speakerSpriteEffect.position = CGPointMake(self.screenSize.width/2 + (self.screenSize.width * 0.2), self.screenSize.height - (self.screenSize.height * 0.6))
        speakerSpriteEffect.scale = 0.7
        self.addChild(speakerSpriteEffect)
        
        let homeButton:CCButton = CCButton(title: "[ Home ]", fontName: "Verdana-Bold", fontSize: 36)
        homeButton.position = CGPointMake(self.screenSize.width/2.0 - (self.screenSize.width * 0.1), self.screenSize.height - (self.screenSize.height * 0.9))
        homeButton.anchorPoint = CGPointMake(0.5, 0.5)
        homeButton.color = CCColor.redColor()
        homeButton.block = {_ in
            SoundPlayHelper.sharedInstance.stopAllSounds()
            StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
        }
        self.addChild(homeButton)
        
        let aboutButton:CCButton = CCButton(title: "[ About ]", fontName: "Verdana-Bold", fontSize: 36)
        aboutButton.position = CGPointMake(self.screenSize.width/2.0 + (self.screenSize.width * 0.1), self.screenSize.height - (self.screenSize.height * 0.9))
        aboutButton.anchorPoint = CGPointMake(0.5, 0.5)
        aboutButton.color = CCColor.redColor()
        aboutButton.block = {_ in
            SoundPlayHelper.sharedInstance.stopAllSounds()
            StateMachine.sharedInstance.changeScene(StateMachineScenes.AboutScene, isFade:true)
        }
        self.addChild(aboutButton)
        
        self.userInteractionEnabled = true

    }
    
    func sliderChanged(sender:CCSlider) {
        
        if(sender.name == "music") {
            SoundPlayHelper.sharedInstance.setMusicVolume(sender.sliderValue)
            if(!musicPlaying) {
                SoundPlayHelper.sharedInstance.playMusicWithControl(GameMusicAndSoundFx.MusicInGame, withLoop: false)
                DelayHelper.sharedInstance.callBlock({ () -> Void in
                    self.musicPlaying = false
                    SoundPlayHelper.sharedInstance.stopAllSounds()
                }, withDelay: 15)
            }
            musicPlaying = true
            
        } else {
            if(musicPlaying) {
                SoundPlayHelper.sharedInstance.stopAllSounds()
                musicPlaying = false
            }
            SoundPlayHelper.sharedInstance.setEffectsVolume(sender.sliderValue)
            SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.SoundFXButtonTap)
        }
        
    }
    
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        if(musicPlaying) {
            SoundPlayHelper.sharedInstance.stopAllSounds()
            musicPlaying = false
        }
    }
    
    override func onEnter() {
        // Chamado apos o init quando entra no director
        super.onEnter()
    }
    
    override func onExit() {
        // Chamado quando sai do director
        super.onExit()
    }

    
}