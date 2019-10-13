// 备忘录模式
// 百度百科：在不破坏封闭的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态。这样以后就可将该对象恢复到原先保存的状态
// 设计模式分类：行为型模式

import Foundation
typealias Memento = Dictionary<NSObject, AnyObject>

let DPMementoKeyChapter = "com.valve.halflife.chapter"
let DPMementoKeyWeapon = "com.valve.halflife.weapon"
let DPMementoGameState = "com.valve.halflife.state"

/// 游戏状态
class GameState {
    var chapter: String = ""
    var weapon: String = ""
    
    /**
     生成游戏存档
     
     - returns: 存档
     */
    func toMemento() -> Memento {
        return [ DPMementoKeyChapter:chapter, DPMementoKeyWeapon:weapon ]
    }
    
    /**
     恢复游戏存档
     
     - parameter memento: 存档
     */
    func restoreFromMemento(memento: Memento) {
        chapter = memento[DPMementoKeyChapter] as? String ?? "n/a"
        weapon = memento[DPMementoKeyWeapon] as? String ?? "n/a"
    }
}

/**
 存档点
 */
enum CheckPoint {
    /**
     保存存档
     
     - parameter memento: 存档
     - parameter keyName: 存档名
     */
    static func saveState(memento: Memento, keyName: String = DPMementoGameState) {
//        let defaults = NSUserDefaults.standardUserDefaults()
//        defaults.setObject(memento, forKey: keyName)
//        defaults.synchronize()
        
        DB.set(keyName, obj: memento)
    }
    
    /**
     读取存档
     
     - parameter keyName: 存档名
     
     - returns: 存档
     */
    static func restorePreviousState(keyName keyName: String = DPMementoGameState) -> Memento {
//        let defaults = NSUserDefaults.standardUserDefaults()
//        
//        return defaults.objectForKey(keyName) as? Memento ?? Memento()
        
        let m = DB.get(keyName)
        return m as? Memento ?? Memento()
    }
}

class DB {
    static var dict:Dictionary<String, AnyObject> = [:]
    
    class func set(key: String, obj: AnyObject) {
        dict[key] = obj
    }
    
    class func get(key: String) -> AnyObject? {
        return dict[key]
    }
}

func printGameStateInfo(state: GameState) -> Void {
    print("当前游戏状态：[chapter = \(state.chapter), weapon = \(state.weapon)]")
}

var gameState = GameState()
gameState.restoreFromMemento(CheckPoint.restorePreviousState()) // 新游戏

printGameStateInfo(gameState)

gameState.chapter = "第一章 新手上路"
gameState.weapon = "木剑"
CheckPoint.saveState(gameState.toMemento()) // 第一个存档

printGameStateInfo(gameState)

gameState.chapter = "第二章 冒险开始"
gameState.weapon = "铜剑"
gameState.restoreFromMemento(CheckPoint.restorePreviousState()) // 恢复存档

printGameStateInfo(gameState)

gameState.chapter = "第三章 挑战魔龙"
gameState.weapon = "铁剑"
CheckPoint.saveState(gameState.toMemento(), keyName: "gameState2") // 第二个存档

printGameStateInfo(gameState)

gameState.chapter = "最后章 最终之战"
gameState.weapon = "圣剑"
CheckPoint.saveState(gameState.toMemento()) // 覆盖第一个存档

printGameStateInfo(gameState)

gameState.restoreFromMemento(CheckPoint.restorePreviousState(keyName: "gameState2")) // 加载第二个存档

printGameStateInfo(gameState)
