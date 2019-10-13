// 策略模式
// 策略模式定义了一系列的算法，并将每一个算法封装起来，而且使它们还可以相互替换。策略模式让算法独立于使用它的客户而独立变化
// 设计模式分类：行为型模式

/**
 *  打印策略接口
 */
protocol PrintStrategy {
    func printString(string: String) -> String
}

/// 打印机类
class Printer {
    
    let strategy: PrintStrategy
    
    func printString(string: String) -> String {
        return self.strategy.printString(string)
    }
    
    init(strategy: PrintStrategy) {
        self.strategy = strategy
    }
}

/// 大写打印策略
class UpperCaseStrategy : PrintStrategy {
    func printString(string:String) -> String {
        return string.uppercaseString
    }
}

/// 小写打印策略
class LowerCaseStrategy : PrintStrategy {
    func printString(string:String) -> String {
        return string.lowercaseString
    }
}

var lower = Printer(strategy:LowerCaseStrategy())
lower.printString("O tempora, o mores!")

var upper = Printer(strategy:UpperCaseStrategy())
upper.printString("O tempora, o mores!")
