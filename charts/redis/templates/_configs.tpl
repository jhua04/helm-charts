
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
