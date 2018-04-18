#!/bin/bash

# This script contains the following utilities:

# trumpetfing: Translates **kern files into trumpet **finger



trumpetfing(){
[ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
kern -x "$input" | semits | kern |
sed 's/\*\*kern/\*\*finger/g' | 
humsed -E '
# Begin tie
/^[^=]/ s/^(c|g|cc|ee|gg|ccc|eee|ggg)\[/0\[/g
/^[^=]/ s/^(B-|A#|f|b-|a#|dd|ff|bb-|aa#|ddd|fff)\[/1\[/g
/^[^=]/ s/^(B|f#|g-|b|dd#|ee-|ff#|gg-|bb|ddd#|eee-|fff#|ggg-)\[/2\[/g
/^[^=]/ s/^(A|e|a|cc#|dd-|aa|ccc#|ddd-)\[/12\[/g
/^[^=]/ s/^(G|d)\[/13\[/g
/^[^=]/ s/^(A-|G#|e-|d#|a-|g#|aa-|gg#)\[/23\[/g
/^[^=]/ s/^(F#|G-|c#|d-)_/123_/g
# Middle tie
/^[^=]/ s/^(c|g|cc|ee|gg|ccc|eee|ggg)\]/0\]/g
/^[^=]/ s/^(B-|A#|f|b-|a#|dd|ff|bb-|aa#|ddd|fff)\]/1\]/g
/^[^=]/ s/^(B|f#|g-|b|dd#|ee-|ff#|gg-|bb|ddd#|eee-|fff#|ggg-)\]/2\]/g
/^[^=]/ s/^(A|e|a|cc#|dd-|aa|ccc#|ddd-)\]/12\]/g
/^[^=]/ s/^(G|d)\]/13\]/g
/^[^=]/ s/^(A-|G#|e-|d#|a-|g#|aa-|gg#)\]/23\]/g
/^[^=]/ s/^(F#|G-|c#|d-)\]/123\]/g
# End tie
/^[^=]/ s/^(c|g|cc|ee|gg|ccc|eee|ggg)_/0_/g
/^[^=]/ s/^(B-|A#|f|b-|a#|dd|ff|bb-|aa#|ddd|fff)_/1_/g
/^[^=]/ s/^(B|f#|g-|b|dd#|ee-|ff#|gg-|bb|ddd#|eee-|fff#|ggg-)_/2_/g
/^[^=]/ s/^(A|e|a|cc#|dd-|aa|ccc#|ddd-)_/12_/g
/^[^=]/ s/^(G|d)_/13_/g
/^[^=]/ s/^(A-|G#|e-|d#|a-|g#|aa-|gg#)_/23_/g
/^[^=]/ s/^(F#|G-|c#|d-)_/123_/g
# No tie
/^[^=]/ s/^(c|g|cc|ee|gg|ccc|eee|ggg)\[/0\[/g
/^[^=]/ s/^(B-|A#|f|b-|a#|dd|ff|bb-|aa#|ddd|fff)\[/1\[/g
/^[^=]/ s/^(B|f#|g-|b|dd#|ee-|ff#|gg-|bb|ddd#|eee-|fff#|ggg-)\[/2\[/g
/^[^=]/ s/^(A|e|a|cc#|dd-|aa|ccc#|ddd-)\[/12\[/g
/^[^=]/ s/^(G|d)\[/13\[/g
/^[^=]/ s/^(A-|G#|e-|d#|a-|g#|aa-|gg#)\[/23\[/g
/^[^=]/ s/^(F#|G-|c#|d-)_/123_/g
/^[^=]/ s/^(c|g|cc|ee|gg|ccc|eee|ggg)$/0/g
/^[^=]/ s/^(B-|A#|f|b-|a#|dd|ff|bb-|aa#|ddd|fff)$/1/g
/^[^=]/ s/^(B|f#|g-|b|dd#|ee-|ff#|gg-|bb|ddd#|eee-|fff#|ggg-)$/2/g
/^[^=]/ s/^(A|e|a|cc#|dd-|aa|ccc#|ddd-)$/12/g
/^[^=]/ s/^(G|d)$/13/g
/^[^=]/ s/^(A-|G#|e-|d#|a-|g#|aa-|gg#)$/23/g
/^[^=]/ s/^(F#|G-|c#|d-)$/123/g
'
}
