import Foundation

// Ask which file to open
print("Which file do you want to open? (1, 2, or 3): ", terminator: "")
let userInput = readLine()

// Build file name (like input1.txt, input2.txt, etc.)
let fileName = "input\(userInput ?? "").txt"

// Try opening file
guard let input = FileHandle(forReadingAtPath: fileName) else {
    print("Error: Cannot open file \(fileName)")
    exit(1)
}

// Read file contents
let inputData = input.readDataToEndOfFile()
guard let fileString = String(data: inputData, encoding: .utf8) else {
    print("Error: Cannot read file as text")
    exit(1)
}

// Split lines into array
let lines = fileString.split(separator: "\n")
var numbers: [Int] = []

// Convert each line into an Int
for line in lines {
    if let num = Int(line.trimmingCharacters(in: .whitespacesAndNewlines)) {
        numbers.append(num)
    } else {
        print("Error: File contains non-number data")
        exit(1)
    }
}

// Check if file is empty
if numbers.isEmpty {
    print("Error: File is empty")
    exit(1)
}

// Function to find mean
func getMean(_ nums: [Int]) -> Double {
    var total = 0
    for n in nums {
        total += n
    }
    return Double(total) / Double(nums.count)
}

// Function to find median
func getMedian(_ nums: [Int]) -> Double {
    let sorted = nums.sorted()
    let count = sorted.count
    if count % 2 == 1 {
        // odd
        return Double(sorted[count / 2])
    } else {
        // even
        let mid1 = sorted[count / 2 - 1]
        let mid2 = sorted[count / 2]
        return Double(mid1 + mid2) / 2.0
    }
}

// Calculate mean and median
let mean = getMean(numbers)
let median = getMedian(numbers)

// Print results
print("\n--- Results for \(fileName) ---")
print("Total numbers read: \(numbers.count)")
print(String(format: "Mean: %.2f", mean))
print(String(format: "Median: %.2f", median))

// Close file
input.closeFile()
