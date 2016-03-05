//
//  GameScene.swift
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
import Foundation

// MARK: - Class Definition
class GameScene: CCScene, CCPhysicsCollisionDelegate {
	// MARK: - Public Objects
	
	// MARK: - Private Objects
	private let screenSize:CGSize = CCDirector.sharedDirector().viewSize()
    
    var physicsWorld:CCPhysicsNode = CCPhysicsNode()
    var raposa:Raposa = Raposa(imageNamed:"raposa-ipad.png")
    var canPlay:Bool = true
    var isTouching:Bool = false
    
    
    
	// MARK: - Life Cycle
	override init() {
		super.init()
        
        // Libera o uso de toque na tela
        self.userInteractionEnabled = true
        
        // Configura os objetos na tela
        self.createSceneObjects()
        let background:CCSprite = CCSprite(imageNamed: "cenarioTemp.png")
        background.anchorPoint = CGPointMake(0.5, 0.5)
        background.position = CGPointMake(screenSize.width / 2, screenSize.height / 2)
        self.addChild(background)
/*
		// Label loading
		let label:CCLabelTTF = CCLabelTTF(string: "Game Scene", fontName: "Chalkduster", fontSize: 36.0)
		label.color = CCColor.redColor()
		label.position = CGPointMake(self.screenSize.width/2, self.screenSize.height/2)
		label.anchorPoint = CGPointMake(0.5, 0.5)
		self.addChild(label)

		// Back button
		let backButton:CCButton = CCButton(title: "[ Back ]", fontName: "Verdana-Bold", fontSize: 38.0)
		backButton.position = CGPointMake(self.screenSize.width, self.screenSize.height)
		backButton.anchorPoint = CGPointMake(1.0, 1.0)
		backButton.zoomWhenHighlighted = false
		backButton.block = {_ in StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)}
		self.addChild(backButton)
*/
	}

	override func onEnter() {
		// Chamado apos o init quando entra no director
		super.onEnter()
	}

	// Tick baseado no FPS
	override func update(delta: CCTime) {
		//...
	}

	// MARK: - Private Methods

	// MARK: - Public Methods
	
	// MARK: - Delegates/Datasources
	
	// MARK: - Death Cycle
	override func onExit() {
		// Chamado quando sai do director
		super.onExit()
	}
    
    
    func createSceneObjects() {
        // Define o mundo
        self.physicsWorld.collisionDelegate = self
        self.physicsWorld.gravity = CGPointZero
        self.addChild(self.physicsWorld, z:ObjectsLayers.Background.rawValue)
        
        // Life do player
     
        
        // Back button
        let backButton:CCButton = CCButton(title: "[ Back ]", fontName: "Verdana-Bold", fontSize: 42.0)
        backButton.position = CGPointMake(screenSize.width, screenSize.height)
        backButton.anchorPoint = CGPointMake(1.0, 1.0)
        backButton.zoomWhenHighlighted = false
        backButton.block = {_ in
            StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
        }
        self.addChild(backButton, z:ObjectsLayers.HUD.rawValue)
        
             // Configura a raposa na tela
        self.raposa.position = CGPointMake(screenSize.width/2.0, 80)
        self.raposa.scale = 0.2
        self.physicsWorld.addChild(self.raposa, z:ObjectsLayers.Player.rawValue)
    }

    
    
    
    
    // Controlando o movimento da raposa
    
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        if (self.canPlay) {
            self.isTouching = true
            let locationInView:CGPoint = CCDirector.sharedDirector().convertTouchToGL(touch)
            self.raposa.position.x = locationInView.x
        }
    }
    
    override func touchMoved(touch: UITouch!, withEvent event: UIEvent!) {
        if (self.canPlay && self.isTouching) {
            let locationInView:CGPoint = CCDirector.sharedDirector().convertTouchToGL(touch)
            self.raposa.position.x = locationInView.x
        }
    }
    
    override func touchEnded(touch: UITouch!, withEvent event: UIEvent!) {
        self.isTouching = false
    }
    
    override func touchCancelled(touch: UITouch!, withEvent event: UIEvent!) {
        self.isTouching = false
    }

    
    
    
    
    
    
    
}
