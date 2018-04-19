function set_proxy
	set -l tmp  (string split : $argv[1] -r --max 1)
    set -l url $tmp[1] 
    set -l port $tmp[2]
    set -gx http_proxy "$argv[1]"
    set -gx https_proxy "$argv[1]"
    set -gx JAVA_OPTS "-Dhttps.proxyHost=$url -Dhttps.proxyPort=$port -Dhttp.nonProxyHosts=localhost,127.0.0.1,.volvo.com,.volvo.se,.volvo.net -Dhttp.proxyHost=$url -Dhttp.proxyPort=$port"
end
