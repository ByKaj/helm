{{/*
Get a dictonary for the enabled services
*/}}
{{- define "app.lib.getServices" -}}
{{- $appFullname := (include "app.fullname" $) -}}
{{- $loadBalancerIP := $.Values.global.loadBalancerIP -}}
{{- $result := dict -}}
{{- range $containerKey, $container := $.Values.containers }}
  {{- range $serviceKey, $service := $container.service }}
    {{- if $service.enabled }}
      {{- $type := $service.type -}}
      {{- if not (hasKey $result $type) }}
        {{- $_ := set $result $type (dict "services" dict) -}}
      {{- end }}
      {{- $serviceName := "" -}}
      {{- if (eq $type "LoadBalancer") }}
        {{- $serviceName = printf "%s-lb-svc" $appFullname -}}
        {{- $_ := set (get $result $type) "loadBalancerIP" $loadBalancerIP -}}
      {{- else }}
        {{- $serviceName = printf "%s-svc" $appFullname -}}
      {{- end }}
      {{- $_ := set (get $result $type) "serviceName" $serviceName -}}
      {{- $_ := set (get $result $type).services $serviceKey (dict "port" $service.port "protocol" $service.protocol "ingress" (dict "enabled" $service.ingress.enabled "scheme" $service.ingress.scheme "pathPrefix" $service.ingress.pathPrefix)) -}}
    {{- end }}
  {{- end }}
{{- end }}
{{- $result | toYaml }}
{{- end }}