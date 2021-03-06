//
//  LoadingScene.swift
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
import Foundation

// MARK: - Class Definition
class LoadingScene : CCScene {
	// MARK: - Public Objects

	// MARK: - Private Objects
	private let screenSize:CGSize = CCDirector.sharedDirector().viewSize()

	// MARK: - Life Cycle
	override init() {
		super.init()

		// Label loading
		let label:CCLabelTTF = CCLabelTTF(string: "Loading...", fontName: "Chalkduster", fontSize: 36.0)
		label.color = CCColor.redColor()
		label.position = CGPointMake(self.screenSize.width/2, self.screenSize.height/2)
		label.anchorPoint = CGPointMake(0.5, 0.5)
		self.addChild(label)
        
        if(NSUserDefaults.standardUserDefaults().valueForKey("musicVolume") == nil) {
            NSUserDefaults.standardUserDefaults().setFloat(SoundPlayHelper.sharedInstance.getMusicVolume(), forKey: "musicVolume")
        } else {
            SoundPlayHelper.sharedInstance.setMusicVolume(NSUserDefaults.standardUserDefaults().valueForKey("musicVolume") as! Float)
        }
        
        if(NSUserDefaults.standardUserDefaults().valueForKey("effectsVolume") == nil) {
            NSUserDefaults.standardUserDefaults().setFloat(SoundPlayHelper.sharedInstance.getEffectsVolume(), forKey: "effectsVolume")
        } else {
            SoundPlayHelper.sharedInstance.setEffectsVolume(NSUserDefaults.standardUserDefaults().valueForKey("effectsVolume") as! Float)
        }
        
        

		DelayHelper.sharedInstance.callBlock({ _ in
			StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
		}, withDelay: 1.0)
        
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
