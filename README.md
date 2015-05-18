This application allows an iOS device (formatted for iPhone) to record audio through the internal
microphone and then play back the audio with an applied "effect." Possible effects are:
a)  Play back at slower than normal rate (represented by the snail icon)
b)  Play back at faster than normal rate (rabbit icon)
c)  Play back in a higher voice than normal (play at a higher pitch; Chipmunk icon)
d)  Play back in a deeper voice than normal (play at a lower pitch; Darth Vader icon)

Upon entry, the app lands on the recording screen where the user is presented with a prominent
microphone icon in the center of the screen and a prompting message indicating "Tap to Record"

When the user taps the mic, recording commences and continues. The prompt message will change
to indicate that recording is in progress and a Stop button will appear.

When the user presses the Stop button, recording stops and the audio is saved to a file on the device.
At this point, control is passed to a playback screen offering icons for the 4 playback effects.

The user then taps an icon to hear the audio played back with the appropriate effect. There is also a
stop button at the bottom of the UI to allow the user to stop playback at any point.

A back button, labeled "Record" appears in the top menu to allow the user to navigate back to the
recording screen so that they can then record a new sound. Once the user returns to the Record
screen, the prior recording is lost (it is still on the device but no UI element allows the user
to return to previous audio; it's essentially zombie audio at that point).

The app is controlled by two main views and their associated controllers.
    The RecordSoundViewController is the main view displayed when the app is first opened and allows for a recording to be made.
    The PlaySoundsViewController is the playback view displayed when the user stops a recording (hits the Stop button)
