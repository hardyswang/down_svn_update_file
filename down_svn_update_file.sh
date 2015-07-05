#!/bin/bash
#这个脚本主要是完成svn中对应版本修改文件的下载


#SVN地址根目录
read -p "请输入版本号:" REV
if [ -z ${REV} ];then
	echo "版本不能为空"	
	exit 0
fi

echo "选择驻地"
select ADRESS in "fuzhou" "zhejiang" "quit"
do
	case ${ADRESS} in
		"fuzhou") ;;
		"zhejiang") ;;
		"quit") exit 0;;
		*) continue;;
	esac
	break
done

TAR_NAME=${3}
CURRENT_TIME=`date +%Y.%m.%d`
SVN_URL="svn://10.50.118.87/ut_epg"

DATA=`svn log  -v -r${REV}  ${SVN_URL} | grep /epg/trunk/code/ | awk -F ' ' '{print $2}'`



for LINE in ${DATA}
do
	TARGE_PATH="/Users/hardy/Desktop/work/"${ADRESS}"/"${CURRENT_TIME}"/utv2/"${LINE##*/${ADRESS}/}

	FILE=${LINE##*/}
	
	echo `svn export ${SVN_URL}${LINE} ~/Downloads/ --force`
	#创建目录
	mkdir -pv ${TARGE_PATH%/*}
	#复制到对应目录
	`cp -R ~/Downloads/${FILE} ${TARGE_PATH}`
done	
