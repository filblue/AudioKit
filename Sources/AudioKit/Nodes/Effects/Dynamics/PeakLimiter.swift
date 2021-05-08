// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// AudioKit version of Apple's PeakLimiter Audio Unit
///
open class PeakLimiter: Node, Toggleable {

    fileprivate let effectAU = AVAudioUnitEffect(
    audioComponentDescription:
    AudioComponentDescription(appleEffect: kAudioUnitSubType_PeakLimiter))

    /// Specification details for attackTime
    public static let attackTimeDef = NodeParameterDef(
        identifier: "attackTime",
        name: "Attack Time",
        address: 0,
        range: 0.001 ... 0.03,
        unit: .seconds,
        flags: .default)

    /// Attack Time (seconds) ranges from 0.001 to 0.03 (Default: 0.012)
    @Parameter(attackTimeDef) public var attackTime: AUValue

    /// Specification details for decayTime
    public static let decayTimeDef = NodeParameterDef(
        identifier: "decayTime",
        name: "Decay Time",
        address: 1,
        range: 0.001 ... 0.06,
        unit: .seconds,
        flags: .default)

    /// Decay Time (seconds) ranges from 0.001 to 0.06 (Default: 0.024)
    @Parameter(decayTimeDef) public var decayTime: AUValue

    /// Specification details for preGain
    public static let preGainDef = NodeParameterDef(
        identifier: "preGain",
        name: "Pre Gain",
        address: 2,
        range: -40 ... 40,
        unit: .decibels,
        flags: .default)

    /// Pre Gain (decibels) ranges from -40 to 40 (Default: 0)
    @Parameter(preGainDef) public var preGain: AUValue

    /// Tells whether the node is processing (ie. started, playing, or active)
    public var isStarted = true

    /// Initialize the peak limiter node
    ///
    /// - parameter input: Input node to process
    /// - parameter attackTime: Attack Time (seconds) ranges from 0.001 to 0.03 (Default: 0.012)
    /// - parameter decayTime: Decay Time (seconds) ranges from 0.001 to 0.06 (Default: 0.024)
    /// - parameter preGain: Pre Gain (decibels) ranges from -40 to 40 (Default: 0)
    ///
    public init(
        _ input: Node,
        attackTime: AUValue = 0.012,
        decayTime: AUValue = 0.024,
        preGain: AUValue = 0) {
        super.init(avAudioNode: effectAU)
        connections.append(input)

        self.$attackTime.associate(with: effectAU)
        self.$decayTime.associate(with: effectAU)
        self.$preGain.associate(with: effectAU)

        self.attackTime = attackTime
        self.decayTime = decayTime
        self.preGain = preGain
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
