#!/bin/bash

# This script contains the following utilities:

# addkey: Estimates key using `key` and adds key and keysig info to output
# trumpetfing: Translates **kern files into trumpet **finger


addkey(){
keyoutput=$(key "$1")
givenkey=$(echo "$keyoutput" | awk -F$'\t' '{ print  $1 }' | sed 's/Estimated key: //g')
corr=$(echo "$keyoutput" | awk -F$'\t' '{ print  $2 }')
conf=$(echo "$keyoutput" | awk -F$'\t' '{ print  $4 }')
case "$givenkey" in
 	"C major") 	key='*C:' ; keysig='*k[]' ;;
 	"F major") 	key='*F:' ; keysig='*k[b-]' ;;
	"B-flat major")	key='*B-:' ; keysig='*[b-e-]' ;;
	"E-flat major")	key='*E-:' ; keysig='*k[b-e-a-]' ;;
	"A-flat major")	key='*A-:' ; keysig='*k[b-e-a-d-]' ;;
	"D-flat major") key='*D-:' ; keysig='*k[b-e-a-d-g-]' ;;
	"G-flat major") key='*G-:' ; keysig='*k[b-e-a-d-g-c-]' ;;
	"C-flat major")	key='*C-:' ; keysig='*k[b-e-a-d-g-c-f-]' ;;
	"C-sharp major")key='*C#:' ; keysig='*k[f#c#g#d#a#e#b#]' ;;
	"F-sharp major")key='*F#:' ; keysig='*k[f#c#g#d#a#e#]' ;;
	"B major")	key='*B:' ; keysig='*k[f#c#g#d#a#]' ;;
	"E major")	key='*E:' ; keysig='*k[f#c#g#d#]' ;;
	"A major")	key='*A:' ; keysig='*k[f#c#g#]' ;;
	"D major")	key='*D:' ; keysig='*k[f#c#]' ;;
       	"G major") 	key='*G:' ; keysig='*k[f#]' ;;
	"A minor")	key='*a:' ; keysig='*k[]' ;;	
	"D minor")	key='*d:' ; keysig='*k[b-]' ;;
	"G minor")	key='*g:' ; keysig='*k[b-e-]' ;;
	"C minor")	key='*c:' ; keysig='*k[b-e-a-]' ;;
	"F minor")	key='*f:' ; keysig='*k[b-e-a-d-]' ;;
	"B-flat minor") key='*b-:' ; keysig='*k[b-e-a-d-g-]' ;;
	"E-flat minor") key='*e-:' ; keysig='*k[b-e-a-d-g-c-]' ;;
	"A-flat minor") key='*a-:' ; keysig='*k[b-e-a-d-g-c-f-]' ;;
	"A-sharp minor")key='*a#:' ; keysig='*k[f#c#g#d#a#e#b#]' ;;
	"D-sharp minor")key='*d#:' ; keysig='*k[f#c#g#d#a#e#]' ;;
	"G-sharp minor")key='*g#:' ; keysig='*k[f#c#d#a#]' ;;
	"C-sharp minor")key='c#:' ; keysig='*k[f#c#g#d#]' ;;
	"F-sharp minor")key='*f#' ; keysig='*k[f#c#g#]' ;;
	"B-sharp minor")key='*b#' ; keysig='*k[f#c#]' ;;
	"E minor")	key='*e:' ; keysig='*k[f#]' ;;
        *)  echo unknown ;;
esac
grep -v "\*k\[" "$1" | grep -v "\*[A-Ga-g][#-]*:" | sed '/clef/a\
\'"$key"' \
' | sed '/'"$key"'/a\
\'"$keysig"' \
'
echo '!!'"Key estimated using the 'key' command $corr. Confidence: $conf."
}



trumpetfing(){
kern -x "$1" | semits | kern |
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
# End tie
/^[^=]/ s/^(c|g|cc|ee|gg|ccc|eee|ggg)\]/0\]/g
/^[^=]/ s/^(B-|A#|f|b-|a#|dd|ff|bb-|aa#|ddd|fff)\]/1\]/g
/^[^=]/ s/^(B|f#|g-|b|dd#|ee-|ff#|gg-|bb|ddd#|eee-|fff#|ggg-)\]/2\]/g
/^[^=]/ s/^(A|e|a|cc#|dd-|aa|ccc#|ddd-)\]/12\]/g
/^[^=]/ s/^(G|d)\]/13\]/g
/^[^=]/ s/^(A-|G#|e-|d#|a-|g#|aa-|gg#)\]/23\]/g
/^[^=]/ s/^(F#|G-|c#|d-)\]/123\]/g
# Middle tie
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
