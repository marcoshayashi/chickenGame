//
//  Ovo.swift
//  CocosSwift
//
//  Created by Usuário Convidado on 05/03/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import Foundation

enum TipoOvo : Int {
    case normal = 0
    case bomba = 1
    case especial = 2
}

enum TipoSprite : String{
    case ovo = "ovo.png"
}

class Ovo : CCSprite{
    
    var pontos : Int = 0
    var tipo : TipoOvo = TipoOvo.normal
    
    convenience init(tipoOvo:TipoOvo, posicaoInicial:CGPoint) {
        
        self.init()
        
        self.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height), cornerRadius: 0.0)
        self.physicsBody.type = CCPhysicsBodyType.Dynamic
        self.physicsBody.friction = 1.0
        self.physicsBody.elasticity = 0.5
        self.physicsBody.collisionCategories = ["ovo"]
        self.physicsBody.collisionMask = ["plataforma","raposa"]
        self.physicsBody.mass = 100
        
        self.texture = CCSprite(imageNamed: self.getSpriteOvo(tipoOvo)).texture
        
    }
    
    func getSpriteOvo(tipoOvo : TipoOvo) -> String{
        if(tipoOvo == .normal){
            return TipoSprite.ovo.rawValue
        }
        
        return ""
    }
    
    override init(){
        super.init()
    }

}

