//
//  Galinha.swift
//  CocosSwift
//
//  Created by Usuário Convidado on 05/03/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import Foundation

class Galinha : CCSprite{
    
    var spriteGalinha : String = "galinha.png"
    var percentualOvo : CGFloat = 30.0
    
    convenience init(posicaoInicial:CGPoint, posicaoFinal:CGPoint, velocidade:CGFloat) {
        
        self.init()
        
        self.texture = CCSprite(imageNamed: spriteGalinha).texture
        
        let tempo = getTempoDeslocamento(posicaoInicial, fim: posicaoFinal, velocidadePorSegundo: velocidade)
        
        let sequenceIdaVolta = CCActionSequence.actionOne(CCActionMoveTo.actionWithDuration(Double(tempo), position: posicaoFinal) as! CCActionFiniteTime, two: CCActionMoveTo.actionWithDuration(Double(tempo), position: posicaoInicial) as! CCActionFiniteTime) as! CCActionSequence
        
        let ovos : CCAction =
        (CCActionCallBlock.actionWithBlock({ _ in
            self.geraOvos()
        }) as! CCActionFiniteTime) as CCAction
        
        let loop = CCActionRepeatForever.actionWithAction(sequenceIdaVolta) as! CCActionRepeatForever
        
        self.runAction(loop)
        self.runAction(ovos)
        
    }
    
    func getTempoDeslocamento(inicio:CGPoint, fim:CGPoint, velocidadePorSegundo:CGFloat) -> CGFloat {
        let tempo = CGFloat(ccpDistance(inicio, fim) / velocidadePorSegundo)
        return tempo
    }
    
    func geraOvos(){
        let percentual = CGFloat(arc4random_uniform(100)) + 1
        if(percentual > percentualOvo){
            
            let tipoOvo : TipoOvo = TipoOvo(rawValue: Int(CGFloat(arc4random_uniform(3))))!
            let ovo : Ovo = Ovo(tipoOvo: tipoOvo, posicaoInicial: self.position)
            
            self.addChild(ovo)
        }
    }
    
    override init(){
        super.init()
    }

}
