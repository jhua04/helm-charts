
# redis_health.sh for redis cluster health check
{{- define "redis_health.sh" }}
  response=$(
    redis-cli \
    {{- if .Values.auth }}
      -a "${AUTH}" --no-auth-warning \
    {{- end }}
      -h localhost \
      -p {{ .Values.redis.port }} \
      ping
  )
  echo "response=$response"
  case $response in
    PONG|LOADING*) ;;
    *) exit 1 ;;
  esac
  exit 0
{{- end }}

## Used for init redis
{{- define "redis_init.sh" }}
  host=`eval hostname`
  index=$(echo "$host" | grep -o '[0-9]\+')
  echo "init redis $host with index $index"
  if [ $index = "0" ]; then
    echo "Do nothing"
  else
    echo "Need to setup as replica"
  fi
{{- end }}

# Redis minimum configuration
{{- define "redis.conf" }}
  port 6379
{{- end }}