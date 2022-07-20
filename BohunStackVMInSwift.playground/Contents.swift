/*:
 
 # Bohun Stack VM in Swift
 
 _A Swift playground based on [this YouTube playlist](https://youtube.com/playlist?list=PLSiFUSQSRYAOFwfP-aMzXJlWKVyIuWfPU) by Philip Bohun_
 
 Bohun's implementation is in C++. As we follow along in the videos, we translate his code into Swift.
 
 At present our implementation is only of the first video in Bohun's playlist.
 
 Alternatively, we could begin with [this website](https://www.jmeiners.com/lc3-vm/) by Justin Meiners and Ryan Pendleton.
 It is in C. It has already been [ported to Swift by Billydubb](https://github.com/Billydubb/LC3VM), but I would not want
 to look at his port until after I have done my own.

 ## The instruction format

 * header: 2 bits
 * body: 30 bits
 * header format:
 * 0 => positive integer
 * 1 => primitive instruction
 * 2 => negative integer
 * 3 => undefined

 */

typealias i32 = UInt32
// Note: I am torn as to whether to make i32 UInt32 or Int32. Swift's
// type safety does not let you freely cast between them. For example,
// Assigning 0xc0000000 to an Int32 variable is an overflow. Since
// we are making lots of use of such constants, I went with UInt32.

class StackVM {
    var pc: i32 = 100  // program counter
    var sp: i32 = 0  // stack pointer
    var memory = [i32](repeating: 0, count: 1000000)
    var typ: i32 = 0
    var dat: i32 = 0
    var running: i32 = 1
    
    func getType(instruction: i32) -> i32 {
        let typeMask: i32 = 0xc0000000
        return (typeMask & instruction) >> 30
    }
    
    func getData(instruction: i32) -> i32 {
        let dataMask: i32 = 0x3fffffff
        return dataMask & instruction
    }
    
    func fetch() {
        pc += 1
    }
    
    func decode() {
        let instruction = memory[Int(pc)]
        typ = getType(instruction: instruction)
        dat = getData(instruction: instruction)
    }
    
    func doPrimitive() {
        switch(dat) {
        case 0: // halt
            print("halt")
            running = 0
        case 1: // add
            let operandy = memory[Int(sp) - 1]
            let operandx = memory[Int(sp)]
            print("add \(operandy) \(operandx)")
            memory[Int(sp) - 1] = UInt32(operandx + operandy)
            sp -= 1
        default: // noop
            break
        }
    }
    
    func execute() {
        if (typ == 0 || typ == 2) {
            sp += 1
            memory[Int(sp)] = dat
        } else {
            doPrimitive()
        }
    }
    
    func run() {
        pc -= 1
        while running == 1 {
            fetch()
            decode()
            execute()
            let tos = memory[Int(sp)]
            print("tos: \(tos)")
        }
    }
    
    func loadProgram(prog: [i32]) {
        var i: Int = 0
        while i < prog.count {
            memory[Int(pc) + i] = prog[i]
            i += 1
        }
    }
    
}

let vm = StackVM()
let prog: [i32] = [UInt32(3), UInt32(4), UInt32(0x40000001), UInt32(0x40000000)]
vm.loadProgram(prog: prog)
vm.run()
