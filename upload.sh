#!/bin/bash

#git操作
git stash
git pull origin master --tags
git stash pop

confirmed="n"
NewVersionNumber=""

getNewVersion() {
    read -p "请输入新的版本号: " NewVersionNumber

    if test -z "$NewVersionNumber"; then
        getNewVersion
    fi
}

#获取版本号并显示
VersionString=`grep -E 's.version.*=' XPTheme.podspec`
VersionNumberDot=`tr -cd "[0-9.]" <<<"$VersionString"`
VersionNumber=`sed 's/^.//' <<<"$VersionNumberDot"`


echo -e "\n${Default}================================================"
echo -e " Current Version   :  ${Cyan}${VersionNumber}${Default}"
echo -e "================================================\n"

getInfomation() {
getNewVersion
#输出当前版本号
echo -e "\n${Default}================================================"
echo -e " New Version IS :  ${Cyan}${NewVersionNumber}${Default}"
echo -e "================================================\n"
}

#请求输入新的版本号
while [ "$confirmed" != "y" -a "$confirmed" != "Y" ]
do
if [ "$confirmed" == "n" -o "$confirmed" == "N" ]; then
getInfomation
fi
read -p "确定? (y/n):" confirmed
done


LineNumber=`grep -nE 's.version.*=' XPTheme.podspec | cut -d : -f1`
sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" XPTheme.podspec
echo -e "\n${Default}================================================"
echo -e "current version is ${VersionNumber}, new version is ${NewVersionNumber}"
echo -e "================================================\n"

git push && podspec push
git add .
git commit -am ${NewVersionNumber}
TAGS=$(git tag -l)
if [[ $TAGS == *${NewVersionNumber}* ]]
then
    #先删除tag
    git tag -d ${NewVersionNumber}
    git push origin :refs/tags/${NewVersionNumber}
fi
git tag ${NewVersionNumber}
git push origin master --tags

pod repo push XPSpecs XPTheme.podspec --verbose --allow-warnings --use-libraries
#pod repo push xyj-xyjpodspec【私库名】 XYJBaseUI.podspec【podspec文件】 --allow-warnings[允许警告]
#pod repo update Specs && pod repo push Specs XPTheme.podspec --verbose --allow-warnings --sources='git@git.silvrr.com:iOS/Specs.git,https://github.com/CocoaPods/Specs'
# cd ~/.cocoapods/repos/Specs && git pull origin master && cd - && pod repo push Specs XPTheme.podspec --verbose --allow-warnings --use-libraries
