#!/bin/bash
tmpDir="$(mktemp -d /tmp/tmp.XXXXXXXXXX)"
strUA='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.120 Safari/537.36'

function getFeed(){
 local strPath="$1"
 cat "${strPath}"|grep -o '<[^>]*rss[^>]*>\|"rssUrl":"[^"]*"'|grep -io '"http\(s\)\?://[^"]*youtu[^"]*/[^"]*"'|cut -d'"' -f2|xargs|cut -d' ' -f1
}

function getAuthor(){
 local strPath="$1"
 cat "${strPath}"|grep -oi '"ownerProfileUrl":"[^"]*"'|cut -d'"' -f4
}

function getWebData(){
 local strUrl="$1"
 2>/dev/null wget --output-file='/dev/null' --user-agent="${strUA}" "${strUrl}" -O-
}

if [ "$#" != '1' ] ;then
  >&2 echo 'Usage: '"$(basename "$0")"' <URL>
  URL is the URL to a video, user, or channel on YouTube
  The resulting output will be the URL to the rss feed of the content creator'\''s youtube channel'
  val=55
else
  strArg="$1"
  getWebData "$strArg" >> "$tmpDir"'/1.html'
  strFeedUrl="$(getFeed "$tmpDir"'/1.html')"
  #echo -e 'feed::\nlen:'"${#strFeedUrl}"'\nstr:'\'"$strFeedUrl"\'
  if [[ ${#strFeedUrl} -lt 5 ]] ;then
    strAuthorURL="$(getAuthor "$tmpDir"'/1.html')"
    #echo -e 'author::\nlen:'"${#strAuthorURL}"'\nstr:'\'"$strAuthorURL"\'
    getWebData "$strAuthorURL" >> "$tmpDir"'/2.html'
    strFeedUrl="$(getFeed "$tmpDir"'/2.html')"
  fi
echo "$strFeedUrl"
val=$?
fi
rm -r "$tmpDir"
exit 0
