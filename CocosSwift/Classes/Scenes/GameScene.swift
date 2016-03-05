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

	private let screenSize:CGSize = CCDirector.sharedDirector().viewSize()
    
    var physicsWorld:CCPhysicsNode = CCPhysicsNode()
    var raposa:Raposa = Raposa(imageNamed:"raposa-ipad.png")
    var galinha : Galinha = Galinha()
    
    var canPlay:Bool = true
    var isTouching:Bool = false
    
    var musicVol: Float = 0
    var effectVol: Float = 0
    
    private var pontos : Int = 0
    private var canPause : Bool = true
    
    let label:CCLabelTTF = CCLabelTTF(string: "Paused", fontName: "Verdana-Bold", fontSize: 42.0)
    let labelScore:CCLabelTTF = CCLabelTTF(string: "0", fontName: "Verdana-Bold", fontSize: 42.0)
    let pauseButton:CCButton = CCButton(title: "[ Pause ]", fontName: "Verdana-Bold", fontSize: 42.0)
    let backButton:CCButton = CCButton(title: "[ Back ]", fontName: "Verdana-Bold", fontSize: 42.0)
    
    var arrOvos : [Ovo] = []
    
    private var timeToEndLabel:CCLabelTTF = CCLabelTTF(string:"Time Remaining: 60", fontName:"Verdana-Bold", fontSize:42.0)
    
    private var timeToEnd:Int = 60
    
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
        
        // Configura o timer
        
        //self.timeToEndLabel.fontColor = CCColor.whiteColor()
        
        //self.timeToEndLabel.shadowColor = CCColor.blackColor()
        
        //self.timeToEndLabel.shadowOffset = CGPointMake(-2.0, -2.0)
        
        self.timeToEndLabel.position = CGPointMake(20, self.screenSize.height-50)
        
        self.timeToEndLabel.anchorPoint = CGPointMake(0, 0.5)
        
        self.addChild(self.timeToEndLabel, z:3)
        
        
        // Registra o tick para end game
        
        DelayHelper.sharedInstance.callFunc("tickToEnd", onTarget: self, withDelay: 1.0)
        
        
       
	}

	// Tick baseado no FPS
	override func update(delta: CCTime) {
		//...\
        geraOvos()
        contaPontos()
        
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
        self.physicsWorld.gravity = CGPointMake(0, -980.665)
        self.addChild(self.physicsWorld, z:ObjectsLayers.Background.rawValue)
        
        //SoundPlayHelper.sharedInstance.playMusicWithControl(GameMusicAndSoundFx.MusicInGame, withLoop: true)
        
        // Life do player
     
        // Plataforma
        let plataforma:Plataforma = Plataforma(imageNamed: "caixa.png", tipoPlataforma: TipoPlataforma.Madeira, posicaoInicial: CGPointMake(0 + self.boundingBox().width, 200), posicaoFinal: CGPointMake(screenSize.width-self.boundingBox().width, 200), velocidade: 150)
        plataforma.scale = 0.2
        self.physicsWorld.addChild(plataforma, z:ObjectsLayers.Foes.rawValue)
        
        // Plataforma
        let plataforma2:Plataforma = Plataforma(imageNamed: "caixa.png", tipoPlataforma: TipoPlataforma.Madeira, posicaoInicial: CGPointMake(0 + self.boundingBox().width, 400), posicaoFinal: CGPointMake(screenSize.width-self.boundingBox().width, 400), velocidade: 300)
        plataforma2.scale = 0.2
        self.physicsWorld.addChild(plataforma2, z:ObjectsLayers.Foes.rawValue)
        
        // Pause button
        pauseButton.position = CGPointMake(screenSize.width - 300, self.screenSize.height - 100)
        pauseButton.anchorPoint = CGPointMake(0, 0.5)
        pauseButton.block = {(sender:AnyObject!) -> Void
            in
            SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.SoundFXButtonTap)


            
            if(self.canPause){
                CCDirector.sharedDirector().pause()
                self.musicVol = SoundPlayHelper.sharedInstance.getMusicVolume()
                self.effectVol = SoundPlayHelper.sharedInstance.getEffectsVolume()

                self.label.visible = true
                self.pauseButton.title = "[ Resume ]"
                self.canPause = false
                self.backButton.visible = false
                
                
            }else{
                SoundPlayHelper.sharedInstance.setMusicVolume(self.musicVol)
                SoundPlayHelper.sharedInstance.setEffectsVolume(self.effectVol)
                CCDirector.sharedDirector().resume()
                self.label.visible = false
                self.pauseButton.title = "[ Pause ]"
                self.canPause = true
                self.backButton.visible = true
            }
        }
        
        self.addChild(pauseButton, z:ObjectsLayers.HUD.rawValue)
        
        // Pontos
        //labelScore.color = CCColor.redColor()
        labelScore.position = CGPointMake(20, self.screenSize.height-100)
        labelScore.anchorPoint = CGPointMake(0, 0.5)
        self.addChild(labelScore, z:ObjectsLayers.HUD.rawValue)
        
        // Label
        //label.color = CCColor.redColor()
        label.position = CGPointMake(self.screenSize.width/2, self.screenSize.height/2 + 40)
        label.anchorPoint = CGPointMake(0.5, 0.5)
        label.visible = false
        self.addChild(label, z:ObjectsLayers.HUD.rawValue)
        
        // Back button
        self.backButton.position = CGPointMake(screenSize.width - 300, screenSize.height)
        self.backButton.anchorPoint = CGPointMake(0, 1.0)
        self.backButton.zoomWhenHighlighted = false
        self.backButton.block = {_ in
            
            if (CCDirector.sharedDirector().paused){
                CCDirector.sharedDirector().resume()
            }
            SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.SoundFXButtonTap)
            StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
        }
        self.addChild(backButton, z:ObjectsLayers.HUD.rawValue)
        
             // Configura a raposa na tela
        self.raposa.position = CGPointMake(screenSize.width/2.0, 80)
        self.raposa.scale = 0.2
        self.physicsWorld.addChild(self.raposa, z:ObjectsLayers.Player.rawValue)
        
        
        galinha = Galinha(imageNamed: "galinha.png",posicaoInicial: CGPointMake(0, screenSize.height-200), posicaoFinal: CGPointMake(screenSize.width, screenSize.height-200), velocidade: 100.0)
        galinha.scale = 0.2
        //galinha.texture = CCSprite(imageNamed: "caixa.png").texture
        self.addChild(galinha, z:3)
        
    }
    
    
    // Controlando o movimento da raposa
    
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        if (self.canPlay) {
            self.isTouching = true
            let locationInView:CGPoint = CCDirector.sharedDirector().convertTouchToGL(touch)
            self.raposa.position.x = locationInView.x
        }else{
            self.pauseButton.visible = true
            CCDirector.sharedDirector().resume()
            StateMachine.sharedInstance.changeScene(StateMachineScenes.GameScene, isFade:true)
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

    func geraOvos(){
        
        let percentual = CGFloat(arc4random_uniform(100)) + 1
        var tipoOvo : TipoOvo = .normal
        var ovo : Ovo = Ovo()
        
        if(percentual > 3)&&(percentual < 9){
            
            
            
            //let tipoOvo : TipoOvo = TipoOvo(rawValue: Int(CGFloat(arc4random_uniform(3))))!
             tipoOvo = TipoOvo.normal
            
            ovo = Ovo(imageNamed : "ovo.png", tipoOvo: tipoOvo, posicaoInicial: galinha.position)
            
            ovo.scale = 0.1
            
            ovo.anchorPoint = CGPointMake(0.5,0.5)
            
            self.physicsWorld.addChild(ovo, z:3)
            
        }else if(percentual > 0)&&(percentual < 3){
            
            //let tipoOvo : TipoOvo = TipoOvo(rawValue: Int(CGFloat(arc4random_uniform(3))))!
            
            tipoOvo = TipoOvo.bomba
            
            ovo = Ovo(imageNamed : "grenade.png", tipoOvo: tipoOvo, posicaoInicial: galinha.position)
            
            ovo.scale = 0.1
            
            ovo.anchorPoint = CGPointMake(0.5,0.5)
            
            self.physicsWorld.addChild(ovo, z:3)
            
        }
       
        arrOvos.append(ovo)
    }
    
    func tickToEnd() {
        
        self.timeToEnd--
        
        if (self.timeToEnd < 0) {
            
            self.gameOver()
            
        } else {
            
            self.timeToEndLabel.string = "Time Remaining: \(self.timeToEnd)"
            
            // Chama de 1 em 1 seg
            
            DelayHelper.sharedInstance.callFunc("tickToEnd", onTarget: self, withDelay: 1.0)
            
        }
        
    }
    
    
    func gameOver() {
        
        self.canPlay = false
        
        // Cancela todas as acoes na cena
        
        self.stopAllActions()
        
        // Exibe o texto para retry
        
        let label:CCLabelTTF = CCLabelTTF(string:"Game Over - Tap to restart.", fontName:"Verdana", fontSize:42.0)
        
        label.color = CCColor.redColor()
        
        label.shadowColor = CCColor.blackColor()
        
        label.shadowOffset = CGPointMake(2.0, -2.0)
        
        label.position = CGPointMake(self.screenSize.width/2, self.screenSize.height/2)
        
        label.anchorPoint = CGPointMake(0.5, 0.5)
        
        self.addChild(label, z: 4)
        
        self.pauseButton.visible = false
        
        CCDirector.sharedDirector().pause()
        
        
        
    }
    
    func contaPontos(){
        
        for ovo : Ovo in self.arrOvos{
            
            if(CGRectIntersectsRect(self.raposa.boundingBox(), ovo.boundingBox())){
                
                ovo.removeFromParentAndCleanup(true)
                
                if(ovo.tipo == .normal){
                    self.pontos++
                    SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.RaposaSound)
                    self.arrOvos.removeAtIndex(self.arrOvos.indexOf(ovo)!)

                }else{
                    SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.ExplosionFX)
                    gameOver()
                }
                
            }
        }
        
        self.labelScore.string = "Score: \(self.pontos)"
    }
    
    deinit{
        CCTextureCache.sharedTextureCache().removeAllTextures()
    }
}
