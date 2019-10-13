// 适配器模式
// 百度百科：适配器模式（有时候也称包装样式或者包装）将一个类的接口适配成用户所期待的。一个适配允许通常因为接口不兼容而不能在一起工作的类工作在一起，做法是将类自己的接口包裹在一个已存在的类中
// 设计模式分类：结构型模式

/**
 *  两针插座接口
 */
protocol TwoPinPlugProtocol {
    var pin1: String { get }
    var pin2: String { get }
}

/// 现在有一个三针插座
class ThreePinPlug {
    var pin1: String {
        get {
            return "pin1 of ThreePinPlug"
        }
    }
    var pin2: String {
        get {
            return "pin2 of ThreePinPlug"
        }
    }
    var pin3: String {
        get {
            return "pin3 of ThreePinPlug"
        }
    }
}

/// 这是一个适配器， 将三针插座转化为两针插座
class TwoPinPlugAdapter: TwoPinPlugProtocol {
    let threePinPlug: ThreePinPlug!
    
    init(plug: ThreePinPlug) {
        self.threePinPlug = plug
    }
    
    var pin1: String {
        get {
            return threePinPlug.pin1
        }
    }
    var pin2: String {
        get {
            return threePinPlug.pin2
        }
    }
}

/**
 打印两针插座信息（不可以接收三针插座）
 
 - parameter plug: 两针插座
 */
func printTwoPinPlugInfo(plug: TwoPinPlugProtocol) -> Void {
    print("two pin plug info: [pin1 = \(plug.pin1), pin2 = \(plug.pin2)]")
}

let threePinPlug = ThreePinPlug() // 目前有一个三针插座
let twoPinPlugAdapter = TwoPinPlugAdapter(plug: threePinPlug) // 用适配器来包装

printTwoPinPlugInfo(twoPinPlugAdapter) // 包装后可以将三针插座放入只接收两针插座的接口中
