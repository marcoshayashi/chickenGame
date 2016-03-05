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
    
    convenience init(imageNamed : String, tipoOvo:TipoOvo, posicaoInicial:CGPoint) {
        
        self.init(imageNamed : imageNamed)
        
        self.tipo = tipoOvo
        
        self.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height), cornerRadius: 0.0)
        self.physicsBody.type = CCPhysicsBodyType.Dynamic
        self.physicsBody.friction = 1.0
        self.physicsBody.elasticity = 0.5
        self.physicsBody.collisionCategories = ["ovo"]
        self.physicsBody.collisionMask = ["plataforma","raposa"]
        self.physicsBody.mass = 100
                
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

