import Foundation

/* This is a prototype. Leave it here and create a new package some day.
 Maybe even publish the package. It's kind of neat. */

private func significantDigitFormat(_ value: Double, digits: Int=3) -> String? {
    // Format the value to three significant digits
    let formatter = NumberFormatter()
    
    formatter.usesSignificantDigits = true
    formatter.maximumSignificantDigits = digits
    formatter.minimumSignificantDigits = digits
    if let formattedValue = formatter.string(from: NSNumber(value: value)) {
        return formattedValue
    } else {
        return nil
    }
}

public extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        
        let dateString = formatter.string(from: value)
        appendLiteral(dateString)
    }
    
    mutating func appendInterpolation(sigdig value: Double) {
        appendInterpolation(sigdig3: value)
    }
    
    mutating func appendInterpolation(sigdig2 value: Double) {
        if let formattedValue = significantDigitFormat(value, digits: 2) {
            appendLiteral(formattedValue)
        }
    }
    
    mutating func appendInterpolation(sigdig3 value: Double) {
        if let formattedValue = significantDigitFormat(value, digits: 3) {
            appendLiteral(formattedValue)
        }
    }
    
    
    mutating func appendInterpolation(sigdig4 value: Double) {
        if let formattedValue = significantDigitFormat(value, digits: 4) {
            appendLiteral(formattedValue)
        }
    }
    
    mutating func appendInterpolation(kips value: Double) {
        if let formattedValue = significantDigitFormat(value, digits: 3) {
            appendLiteral(formattedValue)
        }
    }
    
    mutating func appendInterpolation(ft value: Double) {
        if let valueSigDig = significantDigitFormat(value) {
            // Base case if formatting works
            appendLiteral("\(valueSigDig) ft")
        } else {
            // Fallback if formatting does not work
            appendLiteral("\(value) ft")
        }
    }
    
    mutating func appendInterpolation(decFt value: Double)  {
        let formattedValue = String(format: "%.3f", value)
        appendLiteral("\(formattedValue) ft")
    }
    
    mutating func appendInterpolation(kipPerFt value: Double)  {
        let formattedValue = String(format: "%.2f", value)
        appendLiteral("\(formattedValue) k/ft")
    }
    
    mutating func appendInterpolation(pcf value: Double) {
        if let valueSigDig = significantDigitFormat(value) {
            // Base case if formatting works
            appendLiteral("\(valueSigDig) pcf")
        } else {
            // Fallback if formatting does not work
            appendLiteral("\(value) pcf")
        }
    }
    
    mutating func appendInterpolation(psf value: Double) {
        if let valueSigDig = significantDigitFormat(value, digits:2) {
            // Base case if formatting works
            appendLiteral("\(valueSigDig) psf")
        } else {
            // Fallback if formatting does not work
            appendLiteral("\(value) psf")
        }
    }
    
    mutating func appendInterpolation(ksf value: Double) {
        if let valueSigDig = significantDigitFormat(value, digits:2) {
            // Base case if formatting works
            appendLiteral("\(valueSigDig) ksf")
        } else {
            // Fallback if formatting does not work
            appendLiteral("\(value) ksf")
        }
    }
    
    mutating func appendInterpolation(in value: Double) {
        if let valueSigDig = significantDigitFormat(value, digits:3) {
            // Base case if formatting works
            appendLiteral("\(valueSigDig) in")
        } else {
            // Fallback if formatting does not work
            appendLiteral("\(value) in")
        }
    }
    
    mutating func appendInterpolation(ftin value: Double) {
        let feet = Int(value)
        let inchesPerFoot = 12.0
        let fractionalFeetRemaining = abs(value - Double(feet))
        let decimalInches = fractionalFeetRemaining * inchesPerFoot
        let wholeInches = Int(decimalInches)
        let denominator = 16
        
        func simplify(_ numerator: Int, _ denominator: Int) -> (Int, Int) {
            var x = numerator
            var y = denominator
            while y != 0 {
                let temp = y
                y = x % y
                x = temp
            }
            return (numerator / x, denominator / x)
        }
        
        func formatResult(feet: Int, inches: Int, fraction: String = "") {
            if abs(feet) > 0 {
                appendLiteral("\(feet)'-\(inches)\(fraction)\"")
            } else {
                if value < 0 {
                    appendLiteral("-\(inches)\(fraction)\"")
                } else {
                    appendLiteral("\(inches)\(fraction)\"")
                }
            }
        }
        
        if decimalInches > Double(wholeInches) {
            let numerator = Int(round((decimalInches - Double(wholeInches)) * Double(denominator)))
            let (simpleNumerator, simpleDenominator) = simplify(numerator, denominator)
            
            if simpleNumerator == simpleDenominator {
                formatResult(feet: feet, inches: wholeInches + 1)
            } else {
                formatResult(feet: feet, inches: wholeInches, fraction: " \(simpleNumerator)/\(simpleDenominator)")
            }
        } else {
            formatResult(feet: feet, inches: wholeInches)
        }
    }
}
