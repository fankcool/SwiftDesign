// 工厂方法模式
// 百度百科：是一种常用的对象创建型设计模式,此模式的核心精神是封装类中不变的部分，提取其中个性化善变的部分为独立类，通过依赖注入以达到解耦、复用和方便后期维护拓展的目的。它的核心结构有四个角色，分别是抽象工厂；具体工厂；抽象产品；具体产品
// 设计模式分类：创建型模式

/**
 *  抽象产品（货币）
 */
protocol Currency {
    func symbol() -> String
    func code() -> String
}

/// 具体产品（欧元）
class Euro : Currency {
    func symbol() -> String {
        return "€"
    }
    
    func code() -> String {
        return "EUR"
    }
}

/// 具体产品（美元）
class UnitedStatesDolar : Currency {
    func symbol() -> String {
        return "$"
    }
    
    func code() -> String {
        return "USD"
    }
}

/**
 国家
 
 - UnitedStates: 美国
 - Spain:        西班牙
 - UK:           英国
 - Greece:       希腊
 */
enum Country {
    case UnitedStates, Spain, UK, Greece
}

/**
 具体工厂
 */
enum CurrencyFactory {
    static func currencyForCountry(country:Country) -> Currency? {
        
        switch country {
        case .Spain, .Greece :
            return Euro()
        case .UnitedStates :
            return UnitedStatesDolar()
        default:
            return nil
        }
        
    }
}

let noCurrencyCode = "No Currency Code Available"

CurrencyFactory.currencyForCountry(.Greece)?.code() ?? noCurrencyCode
CurrencyFactory.currencyForCountry(.Spain)?.code() ?? noCurrencyCode
CurrencyFactory.currencyForCountry(.UnitedStates)?.code() ?? noCurrencyCode
CurrencyFactory.currencyForCountry(.UK)?.code() ?? noCurrencyCode