//
//  HomeScene.swift
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
import Foundation

// MARK: - Class Definition
class HomeScene : CCScene {
	// MARK: - Public Objects

	// MARK: - Private Objects
	private let screenSize:CGSize = CCDirector.sharedDirector().viewSize()

	// MARK: - Life Cycle
	override init() {
		super.init()
        
		let background:CCSprite = CCSprite(imageNamed: "cenarioTemp.png")
        background.anchorPoint = CGPointMake(0.5, 0.5)
        background.position = CGPointMake(screenSize.width / 2, screenSize.height / 2)
        self.addChild(background)
        
        let label:CCLabelTTF = CCLabelTTF(string: "Breakfast", fontName: "Chalkduster", fontSize: 60)
        label.color = CCColor.redColor()
        label.position = CGPointMake(self.screenSize.width/2, self.screenSize.height/2)
        label.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(label)

		// ToGame Button
		let toGameButton:CCButton = CCButton(title: "[ Start ]", fontName: "Verdana-Bold", fontSize: 35)
		toGameButton.position = CGPointMake(self.screenSize.width/2.0 - 150, self.screenSize.height/2.0 - 200)
		toGameButton.anchorPoint = CGPointMake(0.5, 0.5)
        toGameButton.color = CCColor.redColor()
		toGameButton.block = {_ in
            StateMachine.sharedInstance.changeScene(StateMachineScenes.GameScene, isFade:true)
        }
		self.addChild(toGameButton)
        
        let toOptionsButton:CCButton = CCButton(title: "[ Options ]", fontName: "Verdana-Bold", fontSize: 35)
        toOptionsButton.position = CGPointMake(self.screenSize.width/2.0 + 150, self.screenSize.height/2.0 - 200)
        toOptionsButton.anchorPoint = CGPointMake(0.5, 0.5)
        toOptionsButton.color = CCColor.redColor()
        toOptionsButton.block = {_ in
            StateMachine.sharedInstance.changeScene(StateMachineScenes.GameScene, isFade:true)
        }
        self.addChild(toOptionsButton)
	}

	override func onEnter() {

		super.onEnter()
	}

	override func onExit() {

		super.onExit()
	}
}
