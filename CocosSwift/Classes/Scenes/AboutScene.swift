//
//  AboutScene.swift
//  CocosSwift
//
//  Created by Ricardo Silverio de Souza on 05/03/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import Foundation
class AboutScene : CCScene {
    
    private let screenSize:CGSize = CCDirector.sharedDirector().viewSize()
    
    override init() {
        super.init()
        
        let background:CCSprite = CCSprite(imageNamed: "optionsBackTemp.png")
        background.anchorPoint = CGPointMake(0.5, 0.5)
        background.position = CGPointMake(screenSize.width / 2, screenSize.height / 2)
        self.addChild(background)
        
        let labelTitle:CCLabelTTF = CCLabelTTF(string: "Equipe Dixavadores - 7MOB - 2016", fontName: "Chalkduster", fontSize: 36.0)
        labelTitle.color = CCColor.redColor()
        labelTitle.position = CGPointMake(self.screenSize.width/2, self.screenSize.height - (self.screenSize.height * 0.2))
        labelTitle.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(labelTitle)
        
        let dixavadores = "Bárbara Dariano Silva Suzuki\n"
            + "Joel Henrique Silva\n"
            +  "Marcos Flavio Demetrio Bacci\n"
            +  "Marcos Hayashi Ikegami\n"
            +  "Ricardo Silvério de Souza\n"
            +  "Thiago Machado Faria\n"
            +  "Thiago Missao Harada"
        
        let labelEquipe:CCLabelTTF = CCLabelTTF(string: dixavadores, fontName: "Chalkduster", fontSize: 36.0)
        labelEquipe.color = CCColor.blueColor()
        labelEquipe.position = CGPointMake(self.screenSize.width/2, self.screenSize.height - (self.screenSize.height * 0.55))
        labelEquipe.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(labelEquipe)
        
        let optionsButton:CCButton = CCButton(title: "[ Back ]", fontName: "Verdana-Bold", fontSize: 36)
        optionsButton.position = CGPointMake(self.screenSize.width/2.0, self.screenSize.height - (self.screenSize.height * 0.9))
        optionsButton.anchorPoint = CGPointMake(0.5, 0.5)
        optionsButton.color = CCColor.redColor()
        optionsButton.block = {_ in
            SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.SoundFXButtonTap)
            StateMachine.sharedInstance.changeScene(StateMachineScenes.OptionsScene, isFade:true)
        }
        self.addChild(optionsButton)
        
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
