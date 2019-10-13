// 命令模式
// 百度百科：一组行为抽象为对象，实现二者之间的松耦合
// 设计模式分类：行为型模式

/**
 *  命令接口
 */
protocol LightCommand {
    /**
     执行命令
     
     - returns: 结果
     */
    func execute() -> String
}

/// 打开命令
class OpenCommand : LightCommand {
    let light:String
    
    required init(light: String) {
        self.light = light
    }
    
    func execute() -> String {
        return "Opened \(light)"
    }
}

/// 关闭命令
class CloseCommand : LightCommand {
    let light:String
    
    required init(light: String) {
        self.light = light
    }
    
    func execute() -> String {
        return "Closed \(light)"
    }
}

/// 台灯类
class TableLamp {
    let openCommand: LightCommand
    let closeCommand: LightCommand
    
    init(light: String) {
        self.openCommand = OpenCommand(light:light)
        self.closeCommand = CloseCommand(light:light)
    }
    
    func close() -> String {
        return closeCommand.execute()
    }
    
    func open() -> String {
        return openCommand.execute()
    }
}

let lightName = "名叫[hello world!]的台灯"
let myTableLamp = TableLamp(light:lightName)

myTableLamp.open()
myTableLamp.close()
