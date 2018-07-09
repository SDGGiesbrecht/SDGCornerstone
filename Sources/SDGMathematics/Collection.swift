
extension Collection where Element : Hashable {

    /// Returns the statistical modes.
    ///
    /// - Returns: The statistical modes. This may be empty if the original collection is empty.
    public func statisticalModes() -> [Element] {
        var modes: [Element] = []
        var modeCount: Int = 0
        for (element, count) in countedSet() {
            if count > modeCount {
                modeCount = count
                modes = [element]
            } else if count == modeCount {
                modes.append(element)
            }
        }
        return modes
    }

    /// Returns the number of each type of element present in the collection.
    public func countedSet() -> [Element: Int] {
        var set: [Element: Int] = [:]
        for element in self {
            set[element, default: 0] += 1
        }
        return set
    }
}

extension Collection where Element : RationalArithmetic {

    /// Returns the arithmetic mean.
    ///
    /// - Returns: The arithmetic mean or `nil` if the collection is empty.
    public func mean() -> Element? {
        guard var average = first else {
            return nil
        }
        var count: Element = 1
        for index in indices.dropFirst() {
            count += 1 as Element
            let element = self[index]
            average += (element − average) ÷ count
        }
        return average
    }

    /// Returns the median.
    ///
    /// - Returns: The median or `nil` if the collection is empty.
    public func median() -> Element? {
        if isEmpty {
            return nil
        }

        let sorted = self.sorted()
        let count = sorted.count
        let halfway = count / 2
        if count.isOdd {
            return self[index(startIndex, offsetBy: halfway + 1)]
        } else {
            let lower = index(startIndex, offsetBy: halfway)
            let upper = self.index(after: lower)
            return [self[lower], self[upper]].mean()
        }
    }
}
