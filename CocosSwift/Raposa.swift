//
//  Raposa.swift
//  CocosSwift
//
//  Created by Usuário Convidado on 05/03/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import Foundation

class Raposa:CCSprite{
    // MARK: - Life Cycle
    override init() {
        super.init()
    }
    
    override init(CGImage image: CGImage!, key: String!) {
        super.init(CGImage: image, key: key)
    }
    
    override init(spriteFrame: CCSpriteFrame!) {
        super.init(spriteFrame: spriteFrame)
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
    
    override init(imageNamed imageName: String!) {
        super.init(imageNamed: imageName)
        
        self.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height), cornerRadius: 0.0)
        self.physicsBody.type = CCPhysicsBodyType.Kinematic
        self.physicsBody.friction = 1.0
        self.physicsBody.elasticity = 0.1
        self.physicsBody.mass = 100.0
        self.physicsBody.density = 100.0
        self.physicsBody.collisionType = "raposa"
        self.physicsBody.collisionCategories = ["raposa"]
        self.physicsBody.collisionMask = ["ovo", "bomba"]
    }
    
    override func onEnter() {
        // Chamado apos o init quando entra no director
        super.onEnter()
    }
    
    // MARK: - Private Methods
    
    // MARK: - Public Methods
    
    // MARK: - Delegates/Datasources
    
    // MARK: - Death Cycle
    deinit {
        // Chamado no momento de desalocacao
    }

    
}
