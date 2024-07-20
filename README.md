# styx-baseimage
 Docker baseimage for Styx stuff

### What is this
Based on `azul/zulu-openjdk:21.0.4-jre` (Ubuntu 22.04 with the Zulu JRE 21)

Also installs:
- [muxtools](https://github.com/Jaded-Encoding-Thaumaturgy/muxtools)/[-styx](https://github.com/Vodes/muxtools-styx)
    <br>Python package for muxing and other processing.
- [mediainfo](https://mediaarea.net)
    <br>Tool to get metadata of any media file.
- [mkvtoolnix](https://mkvtoolnix.download/)
    <br>Actually contains all the needed cli tools for mkv manipulation.
- [ffmpeg nonfree](https://github.com/Vodes/FFmpeg-Builds/releases/latest)
    <br>Nonfree build to ensure everything is available.