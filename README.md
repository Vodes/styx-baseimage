# styx-baseimage
 Docker baseimage for Styx stuff

## What is this

### New latest / v2
Based on [bellsoft/liberica-runtime-container](https://hub.docker.com/r/bellsoft/liberica-runtime-container)`:jre-21-glibc`
<br>which provides a much smaller base with Bellsoft's 21 JRE and still uses glibc for static binary compatibility.

Now uses:
- [uv](https://docs.astral.sh/uv)
  <br>To manage the python install and dependencies
- [muxtools](https://github.com/Jaded-Encoding-Thaumaturgy/muxtools) 0.5.0+ / [muxtools-styx](https://github.com/Vodes/muxtools-styx) 0.3.0+
- [muxtools-managed](https://muxtools.vodes.pw/guide/binary-management) binaries for:
  - flac
  - ffmpeg/ffprobe
  - mkvtoolnix

### Old latest / v1
Based on `azul/zulu-openjdk:21.0.8-jre` (Ubuntu 22.04 with the Zulu JRE 21)

Also installs:
- [muxtools](https://github.com/Jaded-Encoding-Thaumaturgy/muxtools)/[-styx](https://github.com/Vodes/muxtools-styx)
    <br>The former pinned to `0.3.0` because of incompatibility with new versions.
- [mediainfo](https://mediaarea.net)
- [mkvtoolnix](https://mkvtoolnix.download/)
- [ffmpeg nonfree](https://github.com/Vodes/FFmpeg-Builds/releases/latest)
