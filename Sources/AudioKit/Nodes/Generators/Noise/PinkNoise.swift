// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// Faust-based pink noise generator
public class PinkNoise: Node, AudioUnitContainer, Toggleable {

    /// Unique four-letter identifier "pink"
    public static let ComponentDescription = AudioComponentDescription(generator: "pink")

    /// Internal type of audio unit for this node
    public typealias AudioUnitType = AudioUnitBase

    /// Internal audio unit 
    public private(set) var internalAU: AudioUnitType?

    // MARK: - Parameters

    /// Specification details for amplitude
    public static let amplitudeDef = NodeParameterDef(
        identifier: "amplitude",
        name: "Amplitude",
        address: akGetParameterAddress("PinkNoiseParameterAmplitude"),
        range: 0.0 ... 1.0,
        unit: .generic,
        flags: .default)

    /// Amplitude. (Value between 0-1).
    @Parameter2(amplitudeDef) public var amplitude: AUValue

    // MARK: - Initialization

    /// Initialize this noise node
    ///
    /// - Parameters:
    ///   - amplitude: Amplitude. (Value between 0-1).
    ///
    public init(
        amplitude: AUValue = 1.0
    ) {
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit("PinkNoiseDSP") { avAudioUnit in
            self.avAudioUnit = avAudioUnit
            self.avAudioNode = avAudioUnit

            guard let audioUnit = avAudioUnit.auAudioUnit as? AudioUnitType else {
                fatalError("Couldn't create audio unit")
            }
            self.internalAU = audioUnit
            self.stop()

            self.amplitude = amplitude
        }
    }
}
