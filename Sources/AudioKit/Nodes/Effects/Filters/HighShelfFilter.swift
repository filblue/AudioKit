// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// AudioKit version of Apple's HighShelfFilter Audio Unit
///
open class HighShelfFilter: Node, Toggleable {

    fileprivate let effectAU = AVAudioUnitEffect(
    audioComponentDescription:
    AudioComponentDescription(appleEffect: kAudioUnitSubType_HighShelfFilter))

    /// Specification details for cutOffFrequency
    public static let cutOffFrequencyDef = NodeParameterDef(
        identifier: "cutOffFrequency",
        name: "Cut Off Frequency",
        address: 0,
        range: 10000 ... 22050,
        unit: .hertz,
        flags: .default)

    /// Cut Off Frequency (Hertz) ranges from 10000 to 22050 (Default: 10000)
    @Parameter(cutOffFrequencyDef) public var cutOffFrequency: AUValue

    /// Specification details for gain
    public static let gainDef = NodeParameterDef(
        identifier: "gain",
        name: "Gain",
        address: 1,
        range: -40 ... 40,
        unit: .decibels,
        flags: .default)

    /// Gain (decibels) ranges from -40 to 40 (Default: 0)
    @Parameter(gainDef) public var gain: AUValue

    /// Tells whether the node is processing (ie. started, playing, or active)
    public var isStarted = true

    /// Initialize the high shelf filter node
    ///
    /// - parameter input: Input node to process
    /// - parameter cutOffFrequency: Cut Off Frequency (Hertz) ranges from 10000 to 22050 (Default: 10000)
    /// - parameter gain: Gain (decibels) ranges from -40 to 40 (Default: 0)
    ///
    public init(
        _ input: Node,
        cutOffFrequency: AUValue = 10000,
        gain: AUValue = 0) {
        super.init(avAudioNode: effectAU)
        connections.append(input)

        self.$cutOffFrequency.associate(with: effectAU)
        self.$gain.associate(with: effectAU)

        self.cutOffFrequency = cutOffFrequency
        self.gain = gain
    }

    /// Function to start, play, or activate the node, all do the same thing
    public func start() {
        effectAU.bypass = false
        isStarted = true
    }

    /// Function to stop or bypass the node, both are equivalent
    public func stop() {
        effectAU.bypass = true
        isStarted = false
    }
}
