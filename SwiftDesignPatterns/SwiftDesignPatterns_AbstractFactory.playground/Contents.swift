// 抽象工厂模式
// 百度百科：为创建一组相关或相互依赖的对象提供一个接口，而且无需指定他们的具体类
// 设计模式分类：创建型模式

import Foundation

/**
 *  抽象工厂
 */
protocol Decimal {
    func stringValue() -> String
    // 工厂方法
    static func make(string : String) -> Decimal
}

typealias NumberFactory = (String) -> Decimal

// Number implementations with factory methods
/**
 *  具体工厂
 */
struct NextStepNumber : Decimal {
    private var nextStepNumber : NSNumber
    
    func stringValue() -> String { return nextStepNumber.stringValue }
    
    // 工厂方法
    static func make(string : String) -> Decimal {
        return NextStepNumber(nextStepNumber:NSNumber(value:(string as NSString).longLongValue))
    }
}

/**
 *  具体工厂
 */
struct SwiftNumber : Decimal {
    private var swiftInt : Int
    
    func stringValue() -> String { return "\(swiftInt)" }
    
    // 工厂方法
    static func make(string : String) -> Decimal {
        return SwiftNumber(swiftInt:(string as NSString).integerValue)
    }
}

enum NumberType {
    case NextStep, Swift
}

enum NumberHelper {
    static func factoryFor(type : NumberType) -> NumberFactory {
        switch type {
        case .NextStep:
            return NextStepNumber.make
        case .Swift:
            return SwiftNumber.make
        }
    }
}

let factoryOne = NumberHelper.factoryFor(type: .NextStep)
let numberOne = factoryOne("1")
numberOne.stringValue()

let factoryTwo = NumberHelper.factoryFor(type: .Swift)
let numberTwo = factoryTwo("2")
numberTwo.stringValue()
