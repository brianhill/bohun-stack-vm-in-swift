/*:

# Bohun Stack VM in Swift
 
_A Swift playground based on [this YouTube playlist](https://youtube.com/playlist?list=PLSiFUSQSRYAOFwfP-aMzXJlWKVyIuWfPU) by Philip Bohun_

Bohun's implementation is in C++. As we follow along in the videos, we translate his code into Swift.
 
Alternatively, we could begin with [this website](https://www.jmeiners.com/lc3-vm/) by Justin Meiners. It is in C.

 */

/*
 * Instruction format
 * header: 2 bits
 * body: 30 bits
 * header format:
 * 0 => positive integer
 * 1 => primitive instruction
 * 2 => negative integer
 * 3 => undefined
 */

/* At present the implementation is complete up to the 13-minute point of the first video.
 * The next thing Bohun will do is implement getData().
 */

typealias i32 = UInt32

class StackVM {
    var pc: i32 = 100  // program counter
    var sp: i32 = 0  // stack pointer
    var memory = [i32](repeating: 0, count: 1000000)
    var typ: i32 = 0
    var dat: i32 = 0

    func getType(instruction: i32) -> i32 {
        let typeMask: i32 = 0xc0000000
        return (typeMask & instruction) >> 30
    }
    
    func getData(instruction: i32) -> i32 {
        return 0
    }
    
    func fetch() {
    }
    
    func decode() {
    }
    
    func execute() {
    }
    
    func doPrimitive() {
    }
    
    func run() {
    }
    
    func loadProgram(prog: [i32]) {
        
    }
    
}
