aa="/home/lily/sapphire/share/asrdata/CP/T4MN75.00"
bb="/home/lily/sapphire/share/asrdata/"
cc="aaaa.ntdf"
dd=".ntdf"
####${string#*substr}                #匹配从左往右第一个substr
####${string##*substr}               #匹配从左往右最后一个substr
echo "relative dir=${aa#*$bb}"
echo "file's prefix=${cc%$dd*}"   ###截取指定字符串（子字符串）左边的字符
echo "file's prefix=${cc%.*}"  ###截取指定字符串（子字符串）左边的字符
echo "file's suffix=${cc#*.}"   ###截取指定字符串（子字符串）右边的字符
echo "file's suffix=${cc##*.}"   ###截取指定字符串（子字符串）右边的字符
