//
//  Plataforma.swift
//  CocosSwift
//
//  Created by Ricardo Silverio de Souza on 03/03/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

enum TipoPlataforma {
    case Elastica
    case Madeira
}

import Foundation
class Plataforma : CCSprite {
    
    /*

        Efeito elastico: elasticity 2, friction 1.2
        Efeito tabua: elasticity 1.2, friction 6

    */
    
    
    convenience init(imageNamed imageName:String, tipoPlataforma:TipoPlataforma, posicaoInicial:CGPoint, posicaoFinal:CGPoint, velocidade:CGFloat) {
        self.init(imageNamed: imageName)
        
        self.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 0, self.boundingBox().width, self.boundingBox().height), cornerRadius: 0)
        self.physicsBody.type = .Kinematic
        self.position = posicaoInicial
        
        if(tipoPlataforma == .Elastica) {
            self.physicsBody.friction = 1.2
            self.physicsBody.elasticity = 2
        } else {
            self.physicsBody.friction = 6
            self.physicsBody.elasticity = 1.2
        }

        self.physicsBody.collisionCategories = ["plataforma"]
        self.physicsBody.collisionMask = ["ovo"]
        
        let tempo = getTempoDeslocamento(posicaoInicial, fim: posicaoFinal, velocidadePorSegundo: velocidade)
        let sequenceIdaVolta = CCActionSequence.actionOne(CCActionMoveTo.actionWithDuration(Double(tempo), position: posicaoFinal) as! CCActionFiniteTime, two: CCActionMoveTo.actionWithDuration(Double(tempo), position: posicaoInicial) as! CCActionFiniteTime) as! CCActionSequence
        let loop = CCActionRepeatForever.actionWithAction(sequenceIdaVolta) as! CCActionRepeatForever
        
        self.runAction(loop)
    }
    
    func getTempoDeslocamento(inicio:CGPoint, fim:CGPoint, velocidadePorSegundo:CGFloat) -> CGFloat {
        let tempo = CGFloat(ccpDistance(inicio, fim) / velocidadePorSegundo)
        return tempo
    }
    
    override init(imageNamed imageName: String!) {
        super.init(imageNamed: imageName)
    }
    
    override init(spriteFrame: CCSpriteFrame!) {
        super.init(spriteFrame: spriteFrame)
    }
    
    override init(CGImage image: CGImage!, key: String!) {
        super.init(CGImage: image, key: key)
    }
    
    override init(texture: CCTexture!) {
        super.init(texture: texture)
    }
    
    override init(texture: CCTexture!, rect: CGRect) {
        super.init(texture: texture, rect: rect)
    }
    
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) {
        super.init(texture: texture, rect: rect, rotated: rotated)
    }

    
    
}
