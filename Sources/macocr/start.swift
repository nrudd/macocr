import ArgumentParser
import Foundation
@available(macOS 11.0, *)
@main
struct Repeat: ArgumentParser.ParsableCommand {
    @Flag(inversion: FlagInversion.prefixedNo, help: "fast")
    var fast = false

    @Argument(help: "x origin")
    var x: Int

    @Argument(help: "y origin")
    var y: Int

    @Argument(help: "width")
    var width: Int

    @Argument(help: "height")
    var height: Int

    mutating func run() throws {
        Runner.run(rect: CGRect(x: x, y: y, width: width, height: height))
    }
}
