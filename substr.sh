###aa="/home/lily/sapphire/share/asrdata/CP/T4MN75.00"
aa="/home/lily/sapphire/share/asrdata/CP/T4MN75.00/ASR3601A0-WAFER_ASR3601_CP_J750_QUAD_REV109_20200929_25C_YOSEE20C01_T4MN75.00_01_CP1_RP1_20201006190229.std.gz"
##bb="/home/lily/sapphire/share/asrdata/"
bb="/home/lily/sapphire/share/asrdata"
###cc="aaaa.ntdf"
##dd=".ntdf"
###cc="aaaa.std.gz"
cc="ASR3601A0-WAFER_ASR3601_CP_J750_QUAD_REV109_20200929_25C_YOSEE20C01_T4MN75.00_01_CP1_RP1_20201006190229.std.gz"
dd=".std.gz"
#ee="/home/lily/sapphire/share/asrdata/CP/T4MN75.00/bbb.std.gz"
ee="/home/lily/sapphire/share/asrdata/CP/T4MN75.00/ASR3601A0-WAFER_ASR3601_CP_J750_QUAD_REV109_20200929_25C_YOSEE20C01_T4MN75.00_01_CP1_RP1_20201006190229.std.gz"
####${string#*substr}                #匹配从左往右第一个substr
####${string##*substr}               #匹配从左往右最后一个substr
echo "relative dir=${aa#*$bb\/}"
echo "file's prefix1=${cc%$dd*}"   ###截取指定字符串（子字符串）左边的字符
echo "file's prefix2=${cc%$dd}"   ###截取指定字符串（子字符串）左边的字符
echo "file's prefix3=${cc%.*}"  ###截取指定字符串（子字符串）左边的字符
echo "file's prefix4=${cc%%.*}"  ###截取指定字符串（子字符串）左边的字符
echo "file's suffix1=${cc#*.}"   ###截取右边,从左往右第一个点后面的的字符串
echo "file's suffix2=${cc##*.}"   ###截取右边，从左往右最后一个点后面的字符
echo "file's dir1=${ee%/*}"   ###截取从右往左第一个'/' 左边的字符
echo "file's dir2=${ee%%/*}"   ####截取从右往左最后个'/' 左边的字符
echo "file's filename=${ee##*/}"   ####截取从右往左最后个'/' 左边的字符
